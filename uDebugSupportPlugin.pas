unit uDebugSupportPlugin;

interface

uses
  SysUtils, Classes, uSharedGlobals, uProjectFile, SynEdit, SynMemo,
  Graphics, Types, System.Generics.Collections;

type
  TDebugSupportPlugin = class(TSynEditPlugin)
  protected
    FFile: TProjectFile;
    procedure AfterPaint(ACanvas: TCanvas; const AClip: TRect;
      FirstLine, LastLine: integer); override;
    procedure LinesInserted(FirstLine, Count: integer); override;
    procedure LinesDeleted(FirstLine, Count: integer); override;
  public
    constructor Create(aMemo: TSynMemo; projectFile: TProjectFile);
    procedure UpdateAssemblyErrors(assemblyErrors: TList<TAssemblyError>);
    property ProjectFile: TProjectFile read FFile write FFile;
  end;

implementation

constructor TDebugSupportPlugin.Create(aMemo: TSynMemo; projectFile: TProjectFile);
begin
  inherited Create(aMemo);
  FFile := projectFile;
//  fForm := AForm;
end;

procedure TDebugSupportPlugin.AfterPaint(ACanvas: TCanvas; const AClip: TRect;
  FirstLine, LastLine: integer);
//var
//  mark: TSynEditMark;
begin
//  fForm.PaintGutterGlyphs(ACanvas, AClip, FirstLine, LastLine);

//  Editor.Marks.ClearLine(FirstLine);
//        mark := TSynEditMark.Create(memo);
//        Mark.Line := Line;
//        Mark.ImageIndex := 11;
//        Mark.Visible := TRUE;
//        Mark.InternalImage := memo.BookMarkOptions.BookMarkImages = nil;
//        memo.Marks.Place(Mark);
end;

procedure TDebugSupportPlugin.LinesInserted(FirstLine, Count: integer);
var
  i: integer;
begin
//  if FFile.AssemblyErrors <> nil then
//    if FFile.AssemblyErrors.Count > 0 then
//      for i:=0 to FFile.AssemblyErrors.Count-1 do
//        inc(FFile.AssemblyErrors[i].LineNumber,Count);
end;

procedure TDebugSupportPlugin.LinesDeleted(FirstLine, Count: integer);
var
  i: integer;
begin
//  if FFile.AssemblyErrors <> nil then
//    if FFile.AssemblyErrors.Count > 0 then
//      for i:=0 to FFile.AssemblyErrors.Count-1 do
//        dec(FFile.AssemblyErrors[i].LineNumber,Count);
end;

procedure TDebugSupportPlugin.UpdateAssemblyErrors(assemblyErrors: TList<TAssemblyError>);
begin
  FFile.AssemblyErrors := assemblyErrors;
end;

end.
