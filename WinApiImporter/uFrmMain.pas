unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uTFile, strutils, uSharedGlobals, IOUtils, System.Generics.Collections;

type
  TProto = record
//    DLL: string[16];
//    ReturnType: string[16];
//    FunctionName: string[64];
//    Parameters: array[0..512] of ansichar;
    DLL: string;
    ReturnType: string;
    FunctionName: string;
    Parameters: string;
  end;

  TfrmMain = class(TForm)
    Label1: TLabel;
    txtFile: TEdit;
    btnImport: TButton;
    memResult: TMemo;
    Label2: TLabel;
    lblTotalLines: TLabel;
    Label3: TLabel;
    lblImported: TLabel;
    lstProcessedFiles: TListBox;
    memDelphiSource: TMemo;
    btnImportEQU: TButton;
    btnCreateWinAPIFile: TButton;
    memParams: TMemo;
    memProto: TMemo;
    memFiles: TMemo;
    btnImportApis: TButton;
    procedure btnImportClick(Sender: TObject);
    procedure btnImportEQUClick(Sender: TObject);
    procedure btnCreateWinAPIFileClick(Sender: TObject);
    procedure btnImportApisClick(Sender: TObject);
  private
    files: TStringList;
    procedure ImportWindowsHeaderFiles;
    procedure ImportMASM32Files;
    procedure MergeStrings(Dest, Source: TStringList);
    function CountOccurences( const SubText: string; const Text: string): integer;
  public
    { Public declarations }
  end;

function GetFiles(const StartDir: String; const List: TStrings): Boolean;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

function GetFiles(const StartDir: String; const List: TStrings): Boolean;
var
  SRec: TSearchRec;
  Res: Integer;
begin
  if not Assigned(List) then
  begin
    Result := False;
    Exit;
  end;
  Res := FindFirst(StartDir + '*.*', faAnyfile, SRec );
  if Res = 0 then
  try
    while res = 0 do
    begin
      if (SRec.Attr and faDirectory <> faDirectory) then
        // If you want filename only, remove "StartDir +"
        // from next line
        List.Add( StartDir + SRec.Name );
      Res := FindNext(SRec);
    end;
  finally
    FindClose(SRec)
  end;
  Result := (List.Count > 0);
end;

procedure TfrmMain.btnImportApisClick(Sender: TObject);
var
  lines,target,paramList,paramListToFile: TStringlist;
  i,x,openParentPos,commaPos,numOfCommas,spacePos,index: Integer;
  line,dll,param,newParam: string;
  gotMilk: boolean;
  proto: TProto;
  protos: TList<TProto>;
//  dataFile: file of TProto;
begin
  protos := TList<TProto>.Create;
  paramListToFile := TStringList.Create;
  lines := TStringList.Create;
  lines.LoadFromFile('apis.txt');

  target := TStringList.Create;
  target.StrictDelimiter := true;
  target.Delimiter := #9;

  paramList := TStringList.Create;
  paramList.StrictDelimiter := true;
  paramList.Delimiter := ',';

  for i := 0 to lines.Count-1 do
  begin
    line := trim(lines[i]);
    if length(line)>0 then
    begin
      gotMilk := (pos('(',line)>0) and (pos(')',line)>0);
      if pos('.dll',lowercase(line))>0 then
        dll := line
      else if gotMilk then
      begin
        target.Clear;
        target.DelimitedText := line;
        proto.DLL := dll;
        proto.ReturnType := lowercase(target[1]);
        openParentPos := pos('(',target[2])-1;
        proto.FunctionName := leftstr(target[2],openParentPos);
        proto.Parameters := copy(target[2], openParentPos+2);
        proto.Parameters := copy(proto.Parameters, 1, length(proto.Parameters)-1);
        proto.Parameters := StringReplace(proto.Parameters,'_In_opt_', '',[rfReplaceAll, rfIgnoreCase]);
        proto.Parameters := StringReplace(proto.Parameters,'_In_', '',[rfReplaceAll, rfIgnoreCase]);
        proto.Parameters := StringReplace(proto.Parameters,'_Inout_opt_', '',[rfReplaceAll, rfIgnoreCase]);
        proto.Parameters := StringReplace(proto.Parameters,'_Inout_', '',[rfReplaceAll, rfIgnoreCase]);
        proto.Parameters := StringReplace(proto.Parameters,'_Out_opt_', '',[rfReplaceAll, rfIgnoreCase]);
        proto.Parameters := StringReplace(proto.Parameters,'_Out_', '',[rfReplaceAll, rfIgnoreCase]);
        proto.Parameters := StringReplace(proto.Parameters,'*', '',[rfReplaceAll, rfIgnoreCase]);
        proto.Parameters := trim(StringReplace(proto.Parameters,'_opt_', '',[rfReplaceAll, rfIgnoreCase]));

        paramList.Clear;
        paramList.DelimitedText := proto.Parameters;
        newParam := '';
        for x := 0 to paramList.Count-1 do
        begin
          param := trim(paramList[x]);
          spacePos := pos(' ',param);
          if spacePos>0 then
            param := copy(param,spacePos+1);
          spacePos := pos(' ',param);
          if spacePos>0 then
            param := copy(param,spacePos+1);
          spacePos := pos(' ',param);
          if spacePos>0 then
            param := copy(param,spacePos+1);
          if paramList.Count=1 then
            newParam := param
          else begin
            if x = 0 then
              newParam := param
            else
              newParam := newParam + ', ' + param;
          end;
        end;
        proto.Parameters := newParam;
        protos.Add(proto);
        paramListToFile.Add(proto.FunctionName+', '+proto.Parameters);
      end;
    end;
  end;

  paramListToFile.SaveToFile('params.txt');

//  AssignFile(dataFile,'apis.dat');
//  ReWrite(dataFile);
//  for x := 0 to protos.Count-1 do
//  begin
//    Write(dataFile,protos.ToArray[x]);
//  end;
//  CloseFile(dataFile);
end;

function TfrmMain.CountOccurences( const SubText: string; const Text: string): integer;
begin
  if (SubText = '') OR (Text = '') OR (Pos(SubText, Text) = 0) then
    Result := 0
  else
    Result := (Length(Text) - Length(StringReplace(Text, SubText, '', [rfReplaceAll]))) div  Length(subtext);
end;

procedure TfrmMain.btnImportClick(Sender: TObject);
begin
  //ImportWindowsHeaderFiles;

  // C:\Program Files\Microsoft SDKs\Windows\v7.1\Include\
  // C:\masm32\include
  files := TStringlist.Create;
  GetFiles(txtFile.Text, files);
  files.Sort;
  files.SaveToFile('IncludeFiles.txt');
  memFiles.Text := files.Text;

  ImportMASM32Files;
end;

procedure TfrmMain.ImportWindowsHeaderFiles;
var
  tmp,fileContent: string;
  contentList: TStringList;
  importedList: TStringList;
  fileIndex,i,x,imported,matchPos: integer;
  delphiSource: TStringList;
  test: integer;
begin
  importedList := TStringList.Create;
  contentList := TStringList.Create;
  delphiSource := TStringList.Create;

  for fileIndex:=0 to files.Count-1 do
  begin
    contentList.LoadFromFile(files.Strings[fileIndex]);

    lblTotalLines.Caption := inttostr(contentList.Count);

    for i:=0 to contentList.Count-1 do
    begin
      if UpperCase(contentList.Strings[i]) = 'WINAPI' then
      begin
        // Look for the first '(' to get the line with the API Function Name
        for x:=1 to 100 do   // We should find one within the next 100 lines down
        begin
          if i+x <= contentList.Count-1 then
          begin
            matchPos := pos('(',contentList.Strings[i+x]);
            if matchPos>0 then
            begin
              tmp := lowercase(trim(leftstr(contentList.Strings[i+x],matchPos-1)));
              if (length(tmp) > 0) and (importedList.IndexOf(tmp)=-1) then
              begin
                inc(imported);
                importedList.Add(tmp);
                break;
              end;
            end;
          end;
        end;
      end;
    end;

    lstProcessedFiles.Items.Add(files.Strings[fileIndex]);
    lblImported.Caption := inttostr(imported);
    Application.ProcessMessages;
  end;

  importedList.Sort;
  memResult.Text := importedList.Text;
  Application.ProcessMessages;

  // Create Delphi source
  for i:=0 to importedList.Count-1 do
  begin
    if length(tmp+importedList.Strings[i]) < 80 then begin
      if tmp[length(tmp)]<>',' then
        tmp := tmp + ',' + importedList.Strings[i]+ ','
      else
        tmp := tmp + importedList.Strings[i]+ ',';
    end else begin
      delphiSource.Add('    ' + '''' + tmp + ''''+ '+');
      tmp := importedList.Strings[i];
    end;
  end;

  memDelphiSource.Text := delphiSource.Text;
end;

procedure TfrmMain.ImportMASM32Files;
var
  tmp,fileContent: string;
  contentList: TStringList;
  importedList: TStringList;
  fileIndex,i,x,imported,matchPos: integer;
  delphiSource: TStringList;
  actualListed: integer;
  dummy: integer;
begin
  importedList := TStringList.Create;
  contentList := TStringList.Create;
  delphiSource := TStringList.Create;

  for fileIndex:=0 to files.Count-1 do
  begin
    contentList.LoadFromFile(files.Strings[fileIndex]);

    lblTotalLines.Caption := inttostr(contentList.Count);

    for i:=0 to contentList.Count-1 do
    begin
      matchPos := pos(' PROTO ',contentList.Strings[i]);
      if matchPos>0 then
      begin
        tmp := lowercase(trim(leftstr(contentList.Strings[i],matchPos-1)));

        // c_msvcrt typedef
        matchPos := pos('equ <typedef',tmp);
        if matchPos>0 then
          inc(dummy);

        if (length(tmp) > 0) and (importedList.IndexOf(tmp)=-1) and (tmp[1]<>';') then
        begin
          inc(imported);
          importedList.Add(tmp);
        end;
      end;
      matchPos := pos('IFDEF __UNICODE__',contentList.Strings[i]);
      if matchPos>0 then
      begin
        matchPos := pos(' equ <',contentList.Strings[i+1]);
        if matchPos>0 then begin
          tmp := lowercase(trim(leftstr(contentList.Strings[i+1],matchPos-1)));

          matchPos := pos('equ <typedef',tmp);
          if matchPos>0 then
            inc(dummy);

          if (length(tmp) > 0) and (importedList.IndexOf(tmp)=-1) and (tmp[1]<>';') then
          begin
            inc(imported);
            importedList.Add(tmp);
          end;
        end;
      end;
    end;

    lstProcessedFiles.Items.Add(files.Strings[fileIndex]);
    lblImported.Caption := inttostr(imported);
    Application.ProcessMessages;
  end;

  lblTotalLines.Caption := inttostr(dummy);

  importedList.Sort;
  memResult.Text := importedList.Text;
  Application.ProcessMessages;

  // Create Delphi source
  for i:=0 to importedList.Count-1 do
  begin
    if length(tmp+importedList.Strings[i]) < 80 then begin
      if tmp[length(tmp)]<>',' then
        tmp := tmp + ',' + importedList.Strings[i]+ ','
      else
        tmp := tmp + importedList.Strings[i]+ ',';
    end else begin
      delphiSource.Add('    ' + '''' + tmp + ''''+ '+');
      tmp := importedList.Strings[i];
    end;
  end;

  memDelphiSource.Text := delphiSource.Text;
end;

procedure TfrmMain.btnImportEQUClick(Sender: TObject);
var
  tmp,fileContent: string;
  contentList: TStringList;
  importedList: TStringList;
  fileIndex,i,x,imported,matchPos: integer;
  files: TStringList;
  delphiSource: TStringList;
  actualListed: integer;
  dummy: integer;
  str,leftside,rightside: string;
begin
  files := TStringlist.Create;
  // C:\masm32\include
  GetFiles(txtFile.Text, files);

  importedList := TStringList.Create;
  contentList := TStringList.Create;
  delphiSource := TStringList.Create;
  contentList.LoadFromFile('C:\masm32\include\windows.inc');
  lblTotalLines.Caption := inttostr(contentList.Count);

  for i:=0 to contentList.Count-1 do
  begin
    matchPos := pos(' EQU ',uppercase(contentList.Strings[i]));
    if matchPos>0 then
    begin
      tmp := trim(leftstr(contentList.Strings[i],matchPos-1));
      tmp := tmp+'|'+rightstr(contentList.Strings[i],length(contentList.Strings[i])-(matchPos+4));

      if (length(tmp) > 0) and (importedList.IndexOf(tmp)=-1) and (tmp[1]<>';') then
      begin
        inc(imported);
        importedList.Add(tmp);
      end;
    end;
  end;

  lstProcessedFiles.Items.Add(files.Strings[fileIndex]);
  lblImported.Caption := inttostr(imported);
  Application.ProcessMessages;

  lblTotalLines.Caption := inttostr(dummy);

  importedList.Sort;
  memResult.Text := importedList.Text;
  Application.ProcessMessages;

  // Create Delphi source

  for i:=0 to importedList.Count-1 do
  begin
    matchPos := pos('|',importedList.Strings[i]);
    leftside := leftstr(importedList.Strings[i],matchPos-1);
    delphiSource.Add(leftside);
  end;

  for i:=0 to files.Count-1 do
  begin
    delphiSource.Add(files[i]);
  end;

  delphiSource.SaveToFile('CodeCompletionInsertList.txt');
  delphiSource.Clear;

  for i:=0 to importedList.Count-1 do
  begin
    // Add('\color{clNavy}constructor \color{clBlack}\column{}\style{+B}Create\style{-B}(AOwner: TCustomSynEdit)');
    matchPos := pos('|',importedList.Strings[i]);
    leftside := leftstr(importedList.Strings[i],matchPos-1);
    rightside := rightstr(importedList.Strings[i],length(importedList.Strings[i])-matchPos);
    str := '\color{clNavy}equ \color{clBlack}\column{}\style{+B}' +
      leftside+'\style{-B}';
    if length(str+'  ('+rightside+')')>254 then
      delphiSource.Add(str)
    else
      delphiSource.Add(str+'  ('+rightside+')');
  end;

  for i:=0 to files.Count-1 do
  begin
    delphiSource.Add('\color{clNavy}include \color{clBlack}\column{}\style{+B}' +
      stringreplace(files[i],'\','\\',[rfReplaceAll, rfIgnoreCase])+'\style{-B}');
  end;

  delphiSource.SaveToFile('CodeCompletionList.txt');

  memDelphiSource.Text := delphiSource.Text;
end;

procedure TfrmMain.btnCreateWinAPIFileClick(Sender: TObject);
var
  tmp,fileContent: string;
  contentList: TStringList;
  importedList: TStringList;
  fileIndex,i,x,imported,matchPos: integer;
  files: TStringList;
  delphiSource: TStringList;
  actualListed: integer;
  dummy: integer;
  codeComplInsertList: TStringList;
  codeComplImplList: TStringList;
  winApiInsertList: TStringList;
  winApiImplList: TStringList;
begin
  files := TStringlist.Create;
  // C:\masm32\include
  GetFiles(txtFile.Text, files);

  importedList := TStringList.Create;
  contentList := TStringList.Create;
  delphiSource := TStringList.Create;

  for fileIndex:=0 to files.Count-1 do
  begin
    contentList.LoadFromFile(files.Strings[fileIndex]);

    lblTotalLines.Caption := inttostr(contentList.Count);

    for i:=0 to contentList.Count-1 do
    begin
      matchPos := pos(' PROTO ',contentList.Strings[i]);
      if matchPos>0 then
      begin
        tmp := lowercase(trim(leftstr(contentList.Strings[i],matchPos-1)));

        // c_msvcrt typedef
        matchPos := pos('equ <typedef',tmp);
        if (matchPos>0) or (pos('winapi                      typedef',tmp)>0) or
          (pos('callback                    typedef',tmp)>0) or
          (pos('c_msvcrt typedef',tmp)>0) then begin
          inc(dummy);
        end else begin
          if (length(tmp) > 0) and (importedList.IndexOf(tmp)=-1) and (tmp[1]<>';') then
          begin
            inc(imported);
            //importedList.Add(#9+#9+#9+#9+''''+tmp+''''+',');
            //importedList.Add(#9+#9+#9+#9+#9+#9+'"'+tmp+'"'+',');
            importedList.Add(tmp);
          end;
        end;
      end;
      matchPos := pos('IFDEF __UNICODE__',contentList.Strings[i]);
      if matchPos>0 then
      begin
        matchPos := pos(' equ <',lowercase(contentList.Strings[i+1]));
        if matchPos>0 then begin
          tmp := lowercase(trim(leftstr(contentList.Strings[i+1],matchPos-1)));

          matchPos := pos('equ <typedef',tmp);
          if matchPos>0 then
            inc(dummy);

          if (length(tmp) > 0) and (importedList.IndexOf(tmp)=-1) and (tmp[1]<>';') then
          begin
            inc(imported);
            //importedList.Add(#9+#9+#9+#9+''''+tmp+''''+',');
            //importedList.Add(#9+#9+#9+#9+#9+#9+'"'+tmp+'"'+',');
            importedList.Add(tmp);
          end;
        end;
      end;
    end;

    lstProcessedFiles.Items.Add(files.Strings[fileIndex]);
    lblImported.Caption := inttostr(imported);
    Application.ProcessMessages;
  end;

  lblTotalLines.Caption := inttostr(dummy);

  importedList.Sort;
  memResult.Text := importedList.Text;
  Application.ProcessMessages;
  importedList.Delimiter := ',';
  TFile.WriteAllText('WinAPIInsertList.txt', importedList.DelimitedText);

  for i:=0 to importedList.Count-1 do
  begin
    delphiSource.Add('\color{clNavy}WinAPI \color{clBlack}\column{}\style{+B}'+
      importedList.Strings[i]+'\style{-B}');
  end;
  delphiSource.SaveToFile('WinAPIList.txt');

  // Merge all files
  codeComplInsertList := TStringList.Create;
  codeComplInsertList.LoadFromFile('CodeCompletionInsertList.txt');

  codeComplImplList := TStringList.Create;
  codeComplImplList.LoadFromFile('CodeCompletionList.txt');

//  winApiInsertList := TStringList.Create;
//  winApiInsertList.LoadFromFile('WinAPIInsertList.txt');
//
//  winApiImplList := TStringList.Create;
//  winApiImplList.LoadFromFile('WinAPIList.txt');

  MergeStrings(codeComplInsertList,importedList);
  codeComplInsertList.SaveToFile('CodeComplInsertListFinal.txt');
  codeComplInsertList.Sort;

  MergeStrings(codeComplImplList,delphiSource);
  codeComplImplList.SaveToFile('CodeComplImplListFinal.txt');
end;

procedure TfrmMain.MergeStrings(Dest, Source: TStringList);
var
  i: integer;
begin
   for i:=0 to Source.Count-1 do
   begin
     //if Dest.IndexOf(Source[i]) = -1 then
       Dest.Add(Source[i]);
   end;
end;

end.

