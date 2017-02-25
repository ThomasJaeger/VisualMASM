unit uVisualMASMOptions;

interface

uses
  SysUtils, Classes, uDomainObject, uSharedGlobals, uVisualMASMFile, uML,
  Forms, JsonDataObjects, httpapp, uTFile, System.Generics.Collections,
  Windows;

type
  PVisualMASMOptions = ^TVisualMASMOptions;
  TVisualMASMOptions = class(TDomainObject)
    private
      FAppFolder: string;

      FVersion: integer;
      FShowWelcomePage: boolean;
      FDoNotShowToolTips: boolean;
      FLasFilesUsedMax: integer;
      FLastFilesUsed: TList<TVisualMASMFile>;
      FML32: TML;
      FML64: TML;
      FML16: TML;
      FOpenLastProjectUsed: boolean;
      FMainFormHeight: integer;
      FMainFormLeft: integer;
      FMainFormTop: integer;
      FMainFormWidth: integer;
      FMainFormMaximized: boolean;
      FMainFormPanRightWidth: integer;
      FMainFormPanBottomHeight: integer;
      FTheme: string;
      FThemeCodeEditor: string;
      FThemeExtendedBorders: boolean;
      FTemplatesFolder: string;
      procedure Initialize;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
      procedure SaveFile;
      procedure LoadFile;
    published
      property Version: integer read FVersion write FVersion;
      property ShowWelcomePage: boolean read FShowWelcomePage write FShowWelcomePage;
      property DoNotShowToolTips: boolean read FDoNotShowToolTips write FDoNotShowToolTips;
      property OpenLastProjectUsed: boolean read FOpenLastProjectUsed write FOpenLastProjectUsed;
      property LastFilesUsed: TList<TVisualMASMFile> read FLastFilesUsed write FLastFilesUsed;
      property LasFilesUsedMax: integer read FLasFilesUsedMax write FLasFilesUsedMax;
      property ML32: TML read FML32 write FML32;
      property ML64: TML read FML64 write FML64;
      property ML16: TML read FML16 write FML16;
      property MainFormHeight: integer read FMainFormHeight write FMainFormHeight;
      property MainFormLeft: integer read FMainFormLeft write FMainFormLeft;
      property MainFormTop: integer read FMainFormTop write FMainFormTop;
      property MainFormWidth: integer read FMainFormWidth write FMainFormWidth;
      property MainFormMaximized: boolean read FMainFormMaximized write FMainFormMaximized;
      property MainFormPanRightWidth: integer read FMainFormPanRightWidth write FMainFormPanRightWidth;
      property MainFormPanBottomHeight: integer read FMainFormPanBottomHeight write FMainFormPanBottomHeight;
      property Theme: string read FTheme write FTheme;
      property ThemeCodeEditor: string read FThemeCodeEditor write FThemeCodeEditor;
      property ThemeExtendedBorders: boolean read FThemeExtendedBorders write FThemeExtendedBorders;
      property AppFolder: string read FAppFolder write FAppFolder;
      property TemplatesFolder: string read FTemplatesFolder write FTemplatesFolder;
  end;

implementation

uses
  uFrmMain;

procedure TVisualMASMOptions.Initialize;
begin
  FAppFolder := ExtractFilePath(Application.ExeName);
  FTemplatesFolder := AppFolder+TEMPLATES_FOLDER;

  FShowWelcomePage := true;
  FVersion := VISUALMASM_FILE_VERSION;
  LasFilesUsedMax := LAST_FILES_USED_MAX;
  FLastFilesUsed := TList<TVisualMASMFile>.Create;
  FML32 := TML.Create;
  FML64 := TML.Create;
  FML16 := TML.Create;
  FOpenLastProjectUsed := true;
end;

constructor TVisualMASMOptions.Create;
begin
  inherited Create;
  Initialize;
end;

constructor TVisualMASMOptions.Create(name: string);
begin
  inherited Create(name);
  Initialize;
end;

procedure TVisualMASMOptions.SaveFile;
var
  fileName: string;
  json: TJSONObject;
  fileContent: TStringList;
  i: Integer;
begin
  FMainFormHeight := frmMain.Height;
  FMainFormLeft := frmMain.Left;
  FMainFormTop := frmMain.Top;
  FMainFormWidth := frmMain.Width;
  FMainFormMaximized := (frmMain.WindowState = wsMaximized);
  FMainFormPanRightWidth := frmMain.panRight.Width;
  FMainFormPanBottomHeight := frmMain.pagBottom.Height;

  json := TJSONObject.Create();
  json.I['Version'] := VISUALMASM_FILE_VERSION;
  json.B['ShowWelcomePage'] := FShowWelcomePage;
  json.B['DoNotShowToolTips'] := FDoNotShowToolTips;
  json.B['OpenLastProjectUsed'] := FOpenLastProjectUsed;
  json.I['LasFilesUsedMax'] := FLasFilesUsedMax;
  json.I['MainFormHeight'] := FMainFormHeight;
  json.I['MainFormLeft'] := FMainFormLeft;
  json.I['MainFormTop'] := FMainFormTop;
  json.I['MainFormWidth'] := FMainFormWidth;
  json.B['MainFormMaximized'] := FMainFormMaximized;
  json.I['MainFormPanRightWidth'] := FMainFormPanRightWidth;
  json.I['MainFormPanBottomHeight'] := FMainFormPanBottomHeight;
  json.S['Theme'] := FTheme;
  json.S['ThemeCodeEditor'] := FThemeCodeEditor;
  json.B['ThemeExtendedBorders'] := FThemeExtendedBorders;
  json.S['AppFolder'] := FAppFolder;
  json.S['TemplatesFolder'] := FTemplatesFolder;

  for i := 0 to FLastFilesUsed.Count-1 do
  begin
    json.A['LastFilesUsed'].Add(FLastFilesUsed[i].FileName);
  end;

  fileName := FAppFolder+VISUAL_MASM_FILE;
  fileContent := TStringList.Create;
  fileContent.Text := json.ToJSON(false);
  fileContent.SaveToFile(fileName);
end;

procedure TVisualMASMOptions.LoadFile;
var
  fileName: string;
  json: TJSONObject;
  i: Integer;
  f: TVisualMASMFile;
begin
  frmMain.pagBottom.ActivePageIndex := 0;

  fileName := FAppFolder+VISUAL_MASM_FILE;
  if not FileExists(fileName) then exit;

  json := TJSONObject.ParseFromFile(fileName) as TJsonObject;
  FShowWelcomePage := json.B['ShowWelcomePage'];
  FDoNotShowToolTips := json.B['DoNotShowToolTips'];
  FOpenLastProjectUsed := json.B['OpenLastProjectUsed'];
  FLasFilesUsedMax := json.I['LasFilesUsedMax'];
  FMainFormHeight := json.I['MainFormHeight'];
  FMainFormLeft := json.I['MainFormLeft'];
  FMainFormTop := json.I['MainFormTop'];
  FMainFormWidth := json.I['MainFormWidth'];
  FMainFormMaximized := json.B['MainFormMaximized'];
  FMainFormPanRightWidth := json.I['MainFormPanRightWidth'];
  FMainFormPanBottomHeight := json.I['MainFormPanBottomHeight'];
  FTheme := json.S['Theme'];
  FThemeCodeEditor := json.S['ThemeCodeEditor'];
  FThemeExtendedBorders := json.B['ThemeExtendedBorders'];
  FAppFolder := json.S['AppFolder'];
  FTemplatesFolder := json.S['TemplatesFolder'];

  for i := 0 to json.A['LastFilesUsed'].Count-1 do
  begin
    f := TVisualMASMFile.Create;
    f.FileName := json.A['LastFilesUsed'].Items[i].Value;
    FLastFilesUsed.Insert(0, f);
  end;

  frmMain.Height := FMainFormHeight;
  frmMain.Left := FMainFormLeft;
  frmMain.Top := FMainFormTop;
  frmMain.Width := FMainFormWidth;
  if FMainFormMaximized then
    frmMain.WindowState := wsMaximized;
  frmMain.panRight.Width := FMainFormPanRightWidth;
  frmMain.pagBottom.Height := FMainFormPanBottomHeight;
end;

end.
