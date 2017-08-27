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
      FActiveLayout: string;
      FMainFormMaximized: boolean;
      FTheme: string;
      FThemeCodeEditor: string;
      FThemeExtendedBorders: boolean;
      FTemplatesFolder: string;
      FFunctionListFuncCol: integer;
      FFunctionListLabelCol: integer;
      FLabelsListFuncCol: integer;
      FLabelsListLabelCol: integer;
      FFunctionsLabelsHeight: integer;
      FProjectExplorerNameCol: integer;
      FProjectExplorerBuildCol: integer;
      FProjectExplorerSizeCol: integer;
      FMSSDKIncludePath: string;
      FContextHelpFontName: string;
      FContextHelpFontSize: integer;
      FOutputFontName: string;
      FOutputFontSize: integer;
      FCommonProjectsFolder: string;
      FDebugger: TDebuggerType;
      FDebuggerFileName: string;
      procedure Initialize;
      procedure AssignDefaultValues;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
      procedure SaveFile;
      procedure LoadFile;
      procedure ResetCommonProjectsFolder;
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
      property ActiveLayout: string read FActiveLayout write FActiveLayout;
      property MainFormMaximized: boolean read FMainFormMaximized write FMainFormMaximized;
      property Theme: string read FTheme write FTheme;
      property ThemeCodeEditor: string read FThemeCodeEditor write FThemeCodeEditor;
      property ThemeExtendedBorders: boolean read FThemeExtendedBorders write FThemeExtendedBorders;
      property AppFolder: string read FAppFolder write FAppFolder;
      property TemplatesFolder: string read FTemplatesFolder write FTemplatesFolder;
      property FunctionListFuncCol: integer read FFunctionListFuncCol write FFunctionListFuncCol;
      property FunctionListLabelCol: integer read FFunctionListLabelCol write FFunctionListLabelCol;
      property LabelsListFuncCol: integer read FLabelsListFuncCol write FLabelsListFuncCol;
      property LabelsListLabelCol: integer read FLabelsListLabelCol write FLabelsListLabelCol;
      property FunctionsLabelsHeight: integer read FFunctionsLabelsHeight write FFunctionsLabelsHeight;
      property ProjectExplorerNameCol: integer read FProjectExplorerNameCol write FProjectExplorerNameCol;
      property ProjectExplorerBuildCol: integer read FProjectExplorerBuildCol write FProjectExplorerBuildCol;
      property ProjectExplorerSizeCol: integer read FProjectExplorerSizeCol write FProjectExplorerSizeCol;
      property MSSDKIncludePath: string read FMSSDKIncludePath write FMSSDKIncludePath;
      property ContextHelpFontName: string read FContextHelpFontName write FContextHelpFontName;
      property ContextHelpFontSize: integer read FContextHelpFontSize write FContextHelpFontSize;
      property OutputFontName: string read FOutputFontName write FOutputFontName;
      property OutputFontSize: integer read FOutputFontSize write FOutputFontSize;
      property CommonProjectsFolder: string read FCommonProjectsFolder write FCommonProjectsFolder;
      property Debugger: TDebuggerType read FDebugger write FDebugger;
      property DebuggerFileName: string read FDebuggerFileName write FDebuggerFileName;
  end;

implementation

uses
  uFrmMain;

procedure TVisualMASMOptions.Initialize;
begin
  FAppFolder := ExtractFilePath(Application.ExeName);
  FTemplatesFolder := AppFolder+TEMPLATES_FOLDER;
  FActiveLayout := DEFAULT_LAYOUT;
  FMainFormMaximized := false;
  ResetCommonProjectsFolder;

  FShowWelcomePage := true;
  FVersion := VISUALMASM_FILE_VERSION;
  LasFilesUsedMax := LAST_FILES_USED_MAX;
  FLastFilesUsed := TList<TVisualMASMFile>.Create;
  FML32 := TML.Create;
  FML64 := TML.Create;
  FML16 := TML.Create;
  FOpenLastProjectUsed := true;
  FMSSDKIncludePath := '';
  FContextHelpFontName := 'Tahoma';
  FContextHelpFontSize := 10;
  FOutputFontName := 'Courier New';
  FOutputFontSize := 10;
  FFunctionListFuncCol := 100;
  FFunctionListLabelCol := 40;
  FLabelsListFuncCol := 100;
  FLabelsListLabelCol := 40;
  FProjectExplorerNameCol := 100;
  FProjectExplorerBuildCol := 80;
  FProjectExplorerSizeCol := 100;
  FTheme := 'Auric';
  FDebugger := dtNone;
  FDebuggerFileName := '';
end;

procedure TVisualMASMOptions.AssignDefaultValues;
begin
  FTheme := 'Auric';
  if FMainFormMaximized then
    frmMain.WindowState := wsMaximized;
  frmMain.vstFunctions.Header.Columns[0].Width := FFunctionListFuncCol;
  frmMain.vstFunctions.Header.Columns[1].Width := FFunctionListLabelCol;
  frmMain.vstLabels.Header.Columns[0].Width := FLabelsListFuncCol;
  frmMain.vstLabels.Header.Columns[1].Width := FLabelsListLabelCol;
  frmMain.vstProject.Header.Columns[0].Width := FProjectExplorerNameCol;
  frmMain.vstProject.Header.Columns[1].Width := FProjectExplorerBuildCol;
  frmMain.vstProject.Header.Columns[2].Width := FProjectExplorerSizeCol;

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

  ResetCommonProjectsFolder;
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
  FActiveLayout := frmMain.cmbLayout.Text;
  FMainFormMaximized := (frmMain.WindowState = wsMaximized);
  if frmMain.vstFunctions <> nil then
  begin
    FFunctionListFuncCol := frmMain.vstFunctions.Header.Columns[0].Width;
    FFunctionListLabelCol := frmMain.vstFunctions.Header.Columns[1].Width;
  end;
  if frmMain.vstLabels <> nil then
  begin
    FLabelsListFuncCol := frmMain.vstLabels.Header.Columns[0].Width;
    FLabelsListLabelCol := frmMain.vstLabels.Header.Columns[1].Width;
  end;
  if frmMain.vstProject <> nil then
  begin
    FProjectExplorerNameCol := frmMain.vstProject.Header.Columns[0].Width;
    FProjectExplorerBuildCol := frmMain.vstProject.Header.Columns[1].Width;
    FProjectExplorerSizeCol := frmMain.vstProject.Header.Columns[2].Width;
  end;

  json := TJSONObject.Create();
  json.I['Version'] := VISUALMASM_FILE_VERSION;
  json.B['ShowWelcomePage'] := FShowWelcomePage;
  json.B['DoNotShowToolTips'] := FDoNotShowToolTips;
  json.B['OpenLastProjectUsed'] := FOpenLastProjectUsed;
  json.I['LasFilesUsedMax'] := FLasFilesUsedMax;
  json.S['ActiveLayout'] := FActiveLayout;
  json.B['MainFormMaximized'] := FMainFormMaximized;
  json.S['Theme'] := FTheme;
  json.S['ThemeCodeEditor'] := FThemeCodeEditor;
  json.B['ThemeExtendedBorders'] := FThemeExtendedBorders;
  json.S['AppFolder'] := FAppFolder;
  json.S['MSSDKIncludePath'] := ExcludeTrailingPathDelimiter(FMSSDKIncludePath);
  json.S['TemplatesFolder'] := FTemplatesFolder;
  json.I['FunctionListFuncCol'] := FFunctionListFuncCol;
  json.I['FunctionListLabelCol'] := FFunctionListLabelCol;
  json.I['LabelsListFuncCol'] := FLabelsListFuncCol;
  json.I['LabelsListLabelCol'] := FLabelsListLabelCol;
  json.I['FunctionsLabelsHeight'] := FFunctionsLabelsHeight;
  json.I['ProjectExplorerNameCol'] := FProjectExplorerNameCol;
  json.I['ProjectExplorerBuildCol'] := FProjectExplorerBuildCol;
  json.I['ProjectExplorerSizeCol'] := FProjectExplorerSizeCol;
  json.S['ContextHelpFontName'] := FContextHelpFontName;
  json.I['ContextHelpFontSize'] := FContextHelpFontSize;
  json.S['OutputFontName'] := FOutputFontName;
  json.I['OutputFontSize'] := FOutputFontSize;
  json.S['CommonProjectsFolder'] := FCommonProjectsFolder;
  json.I['Debugger'] := integer(FDebugger);
  json.S['DebuggerFileName'] := FDebuggerFileName;

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

  fileName := FAppFolder+DATA_FOLDER+VISUAL_MASM_FILE;
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
  fileName := FAppFolder+DATA_FOLDER+VISUAL_MASM_FILE;
  if not FileExistsStripped(fileName) then
  begin
    AssignDefaultValues;
    exit;
  end;

  json := TJSONObject.ParseFromFile(fileName) as TJsonObject;
  FShowWelcomePage := json.B['ShowWelcomePage'];
  FDoNotShowToolTips := json.B['DoNotShowToolTips'];
  FOpenLastProjectUsed := json.B['OpenLastProjectUsed'];
  FLasFilesUsedMax := json.I['LasFilesUsedMax'];
  FActiveLayout := json.S['ActiveLayout'];
  FMainFormMaximized := json.B['MainFormMaximized'];
  FTheme := json.S['Theme'];
  if FTheme = '' then
    FTheme := 'Auric';
  FThemeCodeEditor := json.S['ThemeCodeEditor'];
  FThemeExtendedBorders := json.B['ThemeExtendedBorders'];
  FAppFolder := json.S['AppFolder'];
  FMSSDKIncludePath := json.S['MSSDKIncludePath'];
  FTemplatesFolder := json.S['TemplatesFolder'];
  FFunctionListFuncCol := json.I['FunctionListFuncCol'];
  if FFunctionListFuncCol > 300 then
    FFunctionListFuncCol := 100;
  FFunctionListLabelCol := json.I['FunctionListLabelCol'];
  if FFunctionListLabelCol > 300 then
    FFunctionListLabelCol := 40;
  FLabelsListFuncCol := json.I['LabelsListFuncCol'];
  FLabelsListLabelCol := json.I['LabelsListLabelCol'];
  if FLabelsListFuncCol > 300 then
    FLabelsListFuncCol := 100;
  if FLabelsListLabelCol > 300 then
    FLabelsListLabelCol := 40;
  FFunctionsLabelsHeight := json.I['FunctionsLabelsHeight'];
  if FFunctionsLabelsHeight < 100 then
    FFunctionsLabelsHeight := 100;
  FProjectExplorerNameCol := json.I['ProjectExplorerNameCol'];
  if FProjectExplorerNameCol > 400 then
    FProjectExplorerNameCol := 150;
  FProjectExplorerBuildCol := json.I['ProjectExplorerBuildCol'];
  if FProjectExplorerBuildCol>80 then
    FProjectExplorerBuildCol := 80;
  FProjectExplorerSizeCol := json.I['ProjectExplorerSizeCol'];
  FContextHelpFontName := json.S['ContextHelpFontName'];
  FContextHelpFontSize := json.I['ContextHelpFontSize'];
  FOutputFontName := json.S['OutputFontName'];
  FOutputFontSize := json.I['OutputFontSize'];
  FCommonProjectsFolder := json.S['CommonProjectsFolder'];
  if FCommonProjectsFolder = '' then
    ResetCommonProjectsFolder;
  for i := 0 to json.A['LastFilesUsed'].Count-1 do
  begin
    f := TVisualMASMFile.Create;
    f.FileName := json.A['LastFilesUsed'].Items[i].Value;
    FLastFilesUsed.Insert(0, f);
  end;
  FDebugger := TDebuggerType(json.I['Debugger']);
  FDebuggerFileName := json.S['DebuggerFileName'];

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

  if FMainFormMaximized then
    frmMain.WindowState := wsMaximized;
  frmMain.vstFunctions.Header.Columns[0].Width := FFunctionListFuncCol;
  frmMain.vstFunctions.Header.Columns[1].Width := FFunctionListLabelCol;
  frmMain.vstLabels.Header.Columns[0].Width := FLabelsListFuncCol;
  frmMain.vstLabels.Header.Columns[1].Width := FLabelsListLabelCol;
  frmMain.vstProject.Header.Columns[0].Width := FProjectExplorerNameCol;
  frmMain.vstProject.Header.Columns[1].Width := FProjectExplorerBuildCol;
  frmMain.vstProject.Header.Columns[2].Width := FProjectExplorerSizeCol;

  if FOutputFontName='' then
    FOutputFontName := 'Courier New';
  if FOutputFontSize<6 then
    FOutputFontSize := 10;
  frmMain.memOutput.Font.Name := FOutputFontName;
  frmMain.memOutput.Font.Size := FOutputFontSize;

  if FMSSDKIncludePath = '' then
  begin
    // See if we have the MS SDK installed
    if DirectoryExists(SDK_PATH) then
      FMSSDKIncludePath := SDK_PATH;
  end;
end;

procedure TVisualMASMOptions.ResetCommonProjectsFolder;
begin
  FCommonProjectsFolder := AppFolder+PROJECTS_FOLDER;
end;

end.
