unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uTFile, strutils, uSharedGlobals;

type
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
    procedure btnImportClick(Sender: TObject);
    procedure btnImportEQUClick(Sender: TObject);
    procedure btnCreateWinAPIFileClick(Sender: TObject);
  private
    procedure ImportWindowsHeaderFiles;
    procedure ImportMASM32Files;
    procedure MergeStrings(Dest, Source: TStringList);
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

procedure TfrmMain.btnImportClick(Sender: TObject);
begin
  //ImportWindowsHeaderFiles;
  ImportMASM32Files;
end;

procedure TfrmMain.ImportWindowsHeaderFiles;
var
  tmp,fileContent: string;
  contentList: TStringList;
  importedList: TStringList;
  fileIndex,i,x,imported,matchPos: integer;
  files: TStringList;
  delphiSource: TStringList;
  test: integer;
begin
  files := TStringlist.Create;
  // C:\Program Files\Microsoft SDKs\Windows\v7.1\Include\
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
  files: TStringList;
  delphiSource: TStringList;
  actualListed: integer;
  dummy: integer;
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

  //for fileIndex:=0 to files.Count-1 do
  //for fileIndex:=0 to 50 do
  //begin
  //  contentList.LoadFromFile(files.Strings[fileIndex]);
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
  //end;

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
//    str := '    Add(''\color{clNavy}equ \color{clBlack}\column{}\style{+B}' +
//      leftside+'\style{-B}';
//    if length(str+'('+rightside+')'');')>254 then
//      delphiSource.Add(str+''');')
//    else
//      delphiSource.Add(str+'('+rightside+')'');');
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
  //importedList.SaveToFile('WinAPIInsertList.txt');
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
