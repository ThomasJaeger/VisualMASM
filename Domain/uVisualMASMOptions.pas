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
      FFunctionListWidth: integer;
      FFunctionListFuncCol: integer;
      FFunctionListLabelCol: integer;
      FLabelsListWidth: integer;
      FLabelsListFuncCol: integer;
      FLabelsListLabelCol: integer;
      FFunctionsLabelsHeight: integer;
      FMainPanelWidth: integer;
      FProjectExplorerNameCol: integer;
      FProjectExplorerSizeCol: integer;
      FMSSDKIncludePath: string;
      FContextHelpHeight: integer;
      FContextHelp: boolean;
      FContextHelpFontName: string;
      FContextHelpFontSize: integer;
      FOutputFontName: string;
      FOutputFontSize: integer;
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
      property FunctionListWidth: integer read FFunctionListWidth write FFunctionListWidth;
      property FunctionListFuncCol: integer read FFunctionListFuncCol write FFunctionListFuncCol;
      property FunctionListLabelCol: integer read FFunctionListLabelCol write FFunctionListLabelCol;
      property LabelsListWidth: integer read FLabelsListWidth write FLabelsListWidth;
      property LabelsListFuncCol: integer read FLabelsListFuncCol write FLabelsListFuncCol;
      property LabelsListLabelCol: integer read FLabelsListLabelCol write FLabelsListLabelCol;
      property FunctionsLabelsHeight: integer read FFunctionsLabelsHeight write FFunctionsLabelsHeight;
      property MainPanelWidth: integer read FMainPanelWidth write FMainPanelWidth;
      property ProjectExplorerNameCol: integer read FProjectExplorerNameCol write FProjectExplorerNameCol;
      property ProjectExplorerSizeCol: integer read FProjectExplorerSizeCol write FProjectExplorerSizeCol;
      property MSSDKIncludePath: string read FMSSDKIncludePath write FMSSDKIncludePath;
      property ContextHelpHeight: integer read FContextHelpHeight write FContextHelpHeight;
      property ContextHelp: boolean read FContextHelp write FContextHelp;
      property ContextHelpFontName: string read FContextHelpFontName write FContextHelpFontName;
      property ContextHelpFontSize: integer read FContextHelpFontSize write FContextHelpFontSize;
      property OutputFontName: string read FOutputFontName write FOutputFontName;
      property OutputFontSize: integer read FOutputFontSize write FOutputFontSize;
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
  FMSSDKIncludePath := '';
  FContextHelpHeight := 250;
  FContextHelp := true;
  FContextHelpFontName := 'Tahoma';
  FContextHelpFontSize := 10;
  FOutputFontName := 'Courier New';
  FOutputFontSize := 8;
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
  json, jML32, jML64, jML16: TJSONObject;
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
  FFunctionListWidth := frmMain.panFunctions.Width;
  FLabelsListWidth := frmMain.panLabels.Width;
  FFunctionListFuncCol := frmMain.vstFunctions.Header.Columns[0].Width;
  FFunctionListLabelCol := frmMain.vstFunctions.Header.Columns[1].Width;
  FLabelsListFuncCol := frmMain.vstLabels.Header.Columns[0].Width;
  FLabelsListLabelCol := frmMain.vstLabels.Header.Columns[1].Width;
  FFunctionsLabelsHeight := frmMain.panFunctionsLabels.Height;
  FMainPanelWidth := frmMain.panMain.Width;
  FProjectExplorerNameCol := frmMain.vstProject.Header.Columns[0].Width;
  FProjectExplorerSizeCol := frmMain.vstProject.Header.Columns[1].Width;
  FContextHelpHeight := frmMain.panHelp.Height;
  if FContextHelpHeight < 50 then
    FContextHelpHeight := 50;

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
  json.S['MSSDKIncludePath'] := ExcludeTrailingPathDelimiter(FMSSDKIncludePath);
  json.S['TemplatesFolder'] := FTemplatesFolder;
  json.I['FunctionListWidth'] := FFunctionListWidth;
  json.I['FunctionListFuncCol'] := FFunctionListFuncCol;
  json.I['FunctionListLabelCol'] := FFunctionListLabelCol;
  json.I['LabelsListWidth'] := FLabelsListWidth;
  json.I['LabelsListFuncCol'] := FLabelsListFuncCol;
  json.I['LabelsListLabelCol'] := FLabelsListLabelCol;
  json.I['FunctionsLabelsHeight'] := FFunctionsLabelsHeight;
  json.I['MainPanelWidth'] := FMainPanelWidth;
  json.I['ProjectExplorerNameCol'] := FProjectExplorerNameCol;
  json.I['ProjectExplorerSizeCol'] := FProjectExplorerSizeCol;
  json.I['ContextHelpHeight'] := FContextHelpHeight;
  json.B['ContextHelp'] := FContextHelp;
  json.S['ContextHelpFontName'] := FContextHelpFontName;
  json.I['ContextHelpFontSize'] := FContextHelpFontSize;
  json.S['OutputFontName'] := FOutputFontName;
  json.I['OutputFontSize'] := FOutputFontSize;

  for i := 0 to FLastFilesUsed.Count-1 do
  begin
    json.A['LastFilesUsed'].Add(FLastFilesUsed[i].FileName);
  end;

  jML32 := json.O['ML32'];
  jML32.S['FileName'] := FML32.FoundFileName;
  jML32.S['Linker32'] := FML32.Linker32Bit.FoundFileName;
  jML32.S['Linker16'] := FML32.Linker16Bit.FoundFileName;
  jML32.S['RC'] := FML32.RC.FoundFileName;
  jML32.S['LIB'] := FML32.LIB.FoundFileName;

  jML64 := json.O['ML64'];
  jML64.S['FileName'] := FML64.FoundFileName;
  jML64.S['Linker32'] := FML64.Linker32Bit.FoundFileName;
  jML64.S['RC'] := FML64.RC.FoundFileName;
  jML64.S['LIB'] := FML64.LIB.FoundFileName;

  jML16 := json.O['ML16'];
  jML16.S['FileName'] := FML16.FoundFileName;
  jML16.S['Linker16'] := FML16.Linker16Bit.FoundFileName;
  jML16.S['RC'] := FML16.RC.FoundFileName;
  jML16.S['LIB'] := FML16.LIB.FoundFileName;

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
  FMSSDKIncludePath := json.S['MSSDKIncludePath'];
  FTemplatesFolder := json.S['TemplatesFolder'];
  FFunctionListWidth := json.I['FunctionListWidth'];
  FFunctionListFuncCol := json.I['FunctionListFuncCol'];
  FFunctionListLabelCol := json.I['FunctionListLabelCol'];
  FLabelsListWidth := json.I['LabelsListWidth'];
  FLabelsListFuncCol := json.I['LabelsListFuncCol'];
  FLabelsListLabelCol := json.I['LabelsListLabelCol'];
  FFunctionsLabelsHeight := json.I['FunctionsLabelsHeight'];
  if FFunctionsLabelsHeight < 100 then
    FFunctionsLabelsHeight := 100;
  FMainPanelWidth := json.I['MainPanelWidth'];
  if FMainPanelWidth < 600 then
    FMainPanelWidth := 600;
  FProjectExplorerNameCol := json.I['ProjectExplorerNameCol'];
  FProjectExplorerSizeCol := json.I['ProjectExplorerSizeCol'];
  FContextHelpHeight := json.I['ContextHelpHeight'];
  FContextHelp := json.B['ContextHelp'];
  FContextHelpFontName := json.S['ContextHelpFontName'];
  FContextHelpFontSize := json.I['ContextHelpFontSize'];
  FOutputFontName := json.S['OutputFontName'];
  FOutputFontSize := json.I['OutputFontSize'];

  for i := 0 to json.A['LastFilesUsed'].Count-1 do
  begin
    f := TVisualMASMFile.Create;
    f.FileName := json.A['LastFilesUsed'].Items[i].Value;
    FLastFilesUsed.Insert(0, f);
  end;

  FML32.FoundFileName := json['ML32'].S['FileName'];
  FML32.Linker32Bit.FoundFileName := json['ML32'].S['Linker32'];
  FML32.Linker16Bit.FoundFileName := json['ML32'].S['Linker16'];
  FML32.RC.FoundFileName := json['ML32'].S['RC'];
  FML32.LIB.FoundFileName := json['ML32'].S['LIB'];

  FML64.FoundFileName := json['ML64'].S['FileName'];
  FML64.Linker32Bit.FoundFileName := json['ML64'].S['Linker32'];
  FML64.RC.FoundFileName := json['ML64'].S['RC'];
  FML64.LIB.FoundFileName := json['ML64'].S['LIB'];

  FML16.FoundFileName := json['ML16'].S['FileName'];
  FML16.Linker16Bit.FoundFileName := json['ML16'].S['Linker16'];
  FML16.RC.FoundFileName := json['ML16'].S['RC'];
  FML16.LIB.FoundFileName := json['ML16'].S['LIB'];

  frmMain.Height := FMainFormHeight;
  frmMain.Left := FMainFormLeft;
  frmMain.Top := FMainFormTop;
  frmMain.Width := FMainFormWidth;
  if FMainFormMaximized then
    frmMain.WindowState := wsMaximized;
  frmMain.panRight.Width := FMainFormPanRightWidth;
  frmMain.pagBottom.Height := FMainFormPanBottomHeight;
  frmMain.panFunctions.Width := FFunctionListWidth;
  frmMain.vstFunctions.Header.Columns[0].Width := FFunctionListFuncCol;
  frmMain.vstFunctions.Header.Columns[1].Width := FFunctionListLabelCol;
  frmMain.panLabels.Width := FLabelsListWidth;
  frmMain.vstLabels.Header.Columns[0].Width := FLabelsListFuncCol;
  frmMain.vstLabels.Header.Columns[1].Width := FLabelsListLabelCol;
  frmMain.panFunctionsLabels.Height := FFunctionsLabelsHeight;
  frmMain.panMain.Width := FMainPanelWidth;
  frmMain.vstProject.Header.Columns[0].Width := FProjectExplorerNameCol;
  frmMain.vstProject.Header.Columns[1].Width := FProjectExplorerSizeCol;
  frmMain.panHelp.Height := FContextHelpHeight;
  frmMain.panHelp.Font.Name := FContextHelpFontName;
  frmMain.panHelp.Font.Size := FContextHelpFontSize;
  frmMain.panHelp.Visible := FContextHelp;
  frmMain.splHelp.Visible := FContextHelp;

  if FOutputFontName='' then
    FOutputFontName := 'Courier New';
  if FOutputFontSize<6 then
    FOutputFontSize := 8;
  frmMain.memOutput.Font.Name := FOutputFontName;
  frmMain.memOutput.Font.Size := FOutputFontSize;

  if FMSSDKIncludePath = '' then
  begin
    // See if we have the MS SDK installed
    if DirectoryExists(SDK_PATH) then
      FMSSDKIncludePath := SDK_PATH;
  end;
end;

end.
