unit uDM;

interface

uses
  System.SysUtils, System.Classes, acPathDialog, sDialogs, Vcl.Dialogs,
  System.Actions, Vcl.ActnList, Vcl.XPStyleActnCtrls, Vcl.ActnMan, Vcl.ImgList,
  Vcl.Controls, acAlphaImageList, sPageControl, sStatusBar, Vcl.ComCtrls,
  uSharedGlobals, uGroup, uProject, uProjectFile, VirtualTrees,
  uVisualMASMOptions, UITypes, SynEditHighlighter, SynHighlighterAsmMASM,
  SynColors, SynMemo, SynCompletionProposal, SynEdit, SynHighlighterRC, SynHighlighterBat, SynHighlighterCPM,
  SynHighlighterIni, Vcl.Graphics, SynUnicode, SynHighlighterHashEntries, SynEditDocumentManager, StrUtils,
  Contnrs, uVisualMASMFile, Windows, SynEditTypes, SynEditRegexSearch, SynEditMiscClasses, SynEditSearch,
  uBundle, sComboEdit, System.Generics.Collections, Generics.Defaults, Vcl.WinHelpViewer, HTMLHelpViewer,
  sScrollBox, uFraDesign, System.IOUtils, edIOUtils, ed_Designer, DesignIntf, edActns, Vcl.StdActns,
  eddObjInspFrm, uDebugger, uDebugSupportPlugin, Registry, System.TypInfo, Vcl.Menus;

type
//  TDebugSupportPlugin = class(TSynEditPlugin)
//  protected
//    FEditor: TSynEdit;
//    procedure AfterPaint(ACanvas: TCanvas; const AClip: TRect;
//      FirstLine, LastLine: integer); override;
//    procedure LinesInserted(FirstLine, Count: integer); override;
//    procedure LinesDeleted(FirstLine, Count: integer); override;
//  public
//    constructor Create(editor: TSynEdit);
//  end;

  TScanKeywordThread = class(TThread)
  private
    fHighlighter: TSynCustomHighlighter;
    FFunctions: TList<TFunctionData>;
    FLabels: TList<TLabelData>;
    fLastPercent: integer;
    fScanEventHandle: THandle;
    //fSource: string;
    fSource: TStringList;
    fSourceChanged: boolean;
    procedure GetSource;
    procedure SetResults;
    procedure ShowProgress;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;

    procedure SetModified;
    procedure Shutdown;
  end;

  TFileAction = class(TAction)
  private
    FVisualMASMFile: TVisualMASMFile;
  public
    property VisualMASMFile: TVisualMASMFile read FVisualMASMFile write FVisualMASMFile;
  end;

  Tdm = class(TDataModule)
    iml32x32Icons: TsAlphaImageList;
    iml64x64Icons: TsAlphaImageList;
    sAlphaImageList1: TsAlphaImageList;
    ActionManager1: TActionManager;
    actOptions: TAction;
    actFileNew32BitWindowsExeAppAddToGroup: TAction;
    actAbout: TAction;
    actNew32BitWindowsDllApp: TAction;
    actNew64BitWindowsExeApp: TAction;
    actNew64BitWindowsDllApp: TAction;
    actNew16BitDOSComApp: TAction;
    actSearchFind: TAction;
    actFindInFiles: TAction;
    actSearchReplace: TAction;
    actSearchAgain: TAction;
    actSearchPrevious: TAction;
    actGoToLineNumber: TAction;
    actWelcomePage: TAction;
    actHelpInstallingVisualMASM: TAction;
    actGettingStarted: TAction;
    actHelloWorldMSDOS: TAction;
    actHelloWorldWindows: TAction;
    actAskQuestionsProvideFeedback: TAction;
    actNew16BitDOSExeApp: TAction;
    actNew16BitWindowsExeApp: TAction;
    actNew16BitWindowsDllApp: TAction;
    actResources: TAction;
    actClosePage: TAction;
    actAddNewAssemblyFile: TAction;
    actViewProjectManager: TAction;
    actViewOutput: TAction;
    actViewCommandLine: TAction;
    actProperties: TAction;
    actNewOther: TAction;
    actAddNewTextFile: TAction;
    actAddToProject: TAction;
    actAddNewBatchFile: TAction;
    actNewProjectGroup: TAction;
    actOpenProject: TAction;
    actShowInExplorer: TAction;
    actDOSPromnptHere: TAction;
    actRemoveFromProject: TAction;
    actDeleteFile: TAction;
    actSave: TAction;
    actAddNewProject: TAction;
    actAddExistingProject: TAction;
    actNew16BitDOSComAppAddToGroup: TAction;
    actEditUndo: TAction;
    actEditRedo: TAction;
    actEditCut: TAction;
    actEditCopy: TAction;
    actEditPaste: TAction;
    actCopyPath: TAction;
    actReopenFile: TAction;
    actAssembleFile: TAction;
    actProjectBuild: TAction;
    actProjectOptions: TAction;
    actFileRename: TAction;
    actProjectRename: TAction;
    actGroupRename: TAction;
    actProjectAssemble: TAction;
    actProjectSave: TAction;
    actProjectSaveAs: TAction;
    actGroupSaveAs: TAction;
    actFileSaveAs: TAction;
    actGroupRemoveProject: TAction;
    actGroupSave: TAction;
    actProjectRun: TAction;
    actFileSaveAll: TAction;
    actEditDelete: TAction;
    actEditCommentLine: TAction;
    actEditSelectAll: TAction;
    actFileOpen: TAction;
    actProjectMakeActiveProject: TAction;
    actFileClose: TAction;
    actFileCloseAll: TAction;
    actGroupAssembleAllProjects: TAction;
    actGroupBuildAllProjects: TAction;
    ImageList1: TImageList;
    dlgSave: TsSaveDialog;
    dlgOpen: TsOpenDialog;
    dlgPath: TsPathDialog;
    actGroupNewGroup: TAction;
    synASMMASM: TSynAsmMASMSyn;
    SynCompletionProposal1: TSynCompletionProposal;
    SynAutoComplete1: TSynAutoComplete;
    synRC: TSynRCSyn;
    synBat: TSynBatSyn;
    synIni: TSynIniSyn;
    synCPP: TSynCPMSyn;
    SynEditSearch1: TSynEditSearch;
    SynEditRegexSearch1: TSynEditRegexSearch;
    actSearchGoToFunction: TAction;
    actSearchGoToLabel: TAction;
    actEditHighlightWords: TAction;
    actEditLowerCase: TAction;
    actEditUpperCase: TAction;
    actEditCamcelCase: TAction;
    actHelpWin32Help: TAction;
    actFileAddNewDialog: TAction;
    imgDesigner: TImageList;
    actDesigner: TActionList;
    FileNew: TAction;
    dsnAlignToGrid1: TdsnAlignToGrid;
    dsnBringToFront1: TdsnBringToFront;
    dsnSendToBack1: TdsnSendToBack;
    dsnAlignmentDlg1: TdsnAlignmentDlg;
    dsnSizeDlg1: TdsnSizeDlg;
    dsnScale1: TdsnScale;
    dsnTabOrderDlg1: TdsnTabOrderDlg;
    dsnCreationOrderDlg1: TdsnCreationOrderDlg;
    dsnFlipChildrenAll1: TdsnFlipChildrenAll;
    dsnFlipChildren1: TdsnFlipChildren;
    dsnCopy1: TdsnCopy;
    dsnCut1: TdsnCut;
    dsnDelete1: TdsnDelete;
    dsnPaste1: TdsnPaste;
    dsnLockControls1: TdsnLockControls;
    dsnSelectAll1: TdsnSelectAll;
    FileOpen: TAction;
    FileSave: TAction;
    FileMerge: TAction;
    DesignMode: TAction;
    DsnAbout: TAction;
    FileClose: TAction;
    FileCloseAll: TAction;
    actBDSStyle: TAction;
    actReadOnly: TAction;
    dsnUndo1: TdsnUndo;
    dsnRedo1: TdsnRedo;
    dsnTextEditMode1: TdsnTextEditMode;
    dsnGroupControls1: TdsnGroupControls;
    dsnUngroupControls1: TdsnUngroupControls;
    dsnShowTabOrder1: TdsnShowTabOrder;
    actAddNewRCFile: TAction;
    actAddNewIncludeFile: TAction;
    actToggleDialogAssembly: TAction;
    actViewIncreaseFontSize: TAction;
    procedure actAddNewAssemblyFileExecute(Sender: TObject);
    procedure actGroupNewGroupExecute(Sender: TObject);
    procedure actAddNewProjectExecute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure AssignColorsToEditor(memo: TSynMemo);
    procedure actEditSelectAllExecute(Sender: TObject);
    procedure actEditCopyExecute(Sender: TObject);
    procedure actEditPasteExecute(Sender: TObject);
    procedure actEditCutExecute(Sender: TObject);
    procedure actEditUndoExecute(Sender: TObject);
    procedure actEditRedoExecute(Sender: TObject);
    procedure actEditDeleteExecute(Sender: TObject);
    procedure actEditCommentLineExecute(Sender: TObject);
    procedure actFileCloseAllExecute(Sender: TObject);
    procedure actAddNewTextFileExecute(Sender: TObject);
    procedure actAddNewBatchFileExecute(Sender: TObject);
    procedure actNewOtherExecute(Sender: TObject);
    procedure actAddToProjectExecute(Sender: TObject);
    procedure actFileRenameExecute(Sender: TObject);
    procedure actFileNew32BitWindowsExeAppAddToGroupExecute(Sender: TObject);
    procedure actNew64BitWindowsExeAppExecute(Sender: TObject);
    procedure actNew16BitDOSComAppExecute(Sender: TObject);
    procedure actNew16BitDOSExeAppExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actAddExistingProjectExecute(Sender: TObject);
    procedure actOpenProjectExecute(Sender: TObject);
    procedure actReopenFileExecute(Sender: TObject);
    procedure actShowInExplorerExecute(Sender: TObject);
    procedure actGroupRemoveProjectExecute(Sender: TObject);
    procedure actProjectRenameExecute(Sender: TObject);
    procedure actCopyPathExecute(Sender: TObject);
    procedure actDOSPromnptHereExecute(Sender: TObject);
    procedure actProjectMakeActiveProjectExecute(Sender: TObject);
    procedure actGroupSaveAsExecute(Sender: TObject);
    procedure actProjectSaveAsExecute(Sender: TObject);
    procedure actProjectSaveExecute(Sender: TObject);
    procedure actFileSaveAsExecute(Sender: TObject);
    procedure actFileSaveAllExecute(Sender: TObject);
    procedure actGroupSaveExecute(Sender: TObject);
    procedure actGroupRenameExecute(Sender: TObject);
    procedure actRemoveFromProjectExecute(Sender: TObject);
    procedure actDeleteFileExecute(Sender: TObject);
    procedure actSearchFindExecute(Sender: TObject);
    procedure actSearchAgainExecute(Sender: TObject);
    procedure actSearchReplaceExecute(Sender: TObject);
    procedure actSearchPreviousExecute(Sender: TObject);
    procedure actGoToLineNumberExecute(Sender: TObject);
    procedure actOptionsExecute(Sender: TObject);
    procedure actProjectBuildExecute(Sender: TObject);
    procedure actProjectAssembleExecute(Sender: TObject);
    procedure actAssembleFileExecute(Sender: TObject);
    procedure actProjectRunExecute(Sender: TObject);
    procedure actProjectOptionsExecute(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure actSearchGoToFunctionExecute(Sender: TObject);
    procedure actSearchGoToLabelExecute(Sender: TObject);
    procedure actEditHighlightWordsExecute(Sender: TObject);
    procedure actEditLowerCaseExecute(Sender: TObject);
    procedure actEditUpperCaseExecute(Sender: TObject);
    procedure actEditCamcelCaseExecute(Sender: TObject);
    procedure actHelpWin32HelpExecute(Sender: TObject);
    procedure actFileAddNewDialogExecute(Sender: TObject);
    procedure actReadOnlyExecute(Sender: TObject);
    procedure actReadOnlyUpdate(Sender: TObject);
    procedure actAddNewRCFileExecute(Sender: TObject);
    procedure actAddNewIncludeFileExecute(Sender: TObject);
    procedure actToggleDialogAssemblyExecute(Sender: TObject);
    procedure actToggleDialogAssemblyUpdate(Sender: TObject);
  private
    FGroup: TGroup;
    FVisualMASMOptions: TVisualMASMOptions;
    FHighlighterColorStrings: TStringList;
    FHighlighterStrings: TStringList;
    FSynColors: TSynColors;
    FCodeCompletionList: TUnicodeStringList;
    FCodeCompletionInsertList: TUnicodeStringList;
    FStatusBar: TsStatusBar;
    FShuttingDown: boolean;
    FLastTabIndex: integer;
    FLastOpenDialogDirectory: string;
    FDebugSupportPlugins: TList<TDebugSupportPlugin>;
    FWeHaveAssemblyErrors: boolean;
    FPressingCtrl: boolean;
    FToken: string;
    FAttributes: TSynHighlighterAttributes;
    FSearchFromCaret: boolean;
    FBundles: TStringList;
    FWorkerThread: TThread;
    FFunctions: TList<TFunctionData>;
    FLabels: TList<TLabelData>;
    FSearchKey: string;
    FIgnoreAll: boolean;
    procedure CommentUncommentLine(memo: TSynMemo);
    procedure CreateStatusBar;
    function CreateMemo(projectFile: TProjectFile): TSynMemo;
    function CreateTabSheet(projectFile: TProjectFile): TsTabSheet;
    function ProcessCommentText(text: string): string;
    function GetMemo: TSynMemo;
    procedure FocusMemo(tabSheet: TTabSheet);
    function ReadWin32BitExeMasm32File: string;
    function ReadWin64BitExeWinSDK64File: string;
    function Read16BitDosCOMStub: string;
    function Read16BitDosEXEStub: string;
    procedure SynMemoOnEnter(sender: TObject);
    procedure UpdatePageCaption(projectFile: TProjectFile);
    procedure ClosePageByProjectFileIntId(intId: integer);
    procedure ClosePagesByProject(project: TProject);
    function GetSynMemoFromProjectFile(projectFile: TProjectFile): TSynMemo;
    procedure AddExistingProject(title: string; addProject: boolean);
    procedure OpenGroupOrProject(fileName: string; addProject: boolean);
    procedure UpdateMenuWithLastUsedFiles(fileName: string = '');
    procedure LoadGroup(fileName: string);
    function LoadProject(fileName: string): TProject;
    procedure SetProjectName(project: TProject; name: string = '');
    procedure SaveProject(activeProject: TProject; fileName: string = '');
    function PromptForProjectFileName(project: TProject): string;
    function StrippedOfNonAscii(const s: string): string;
    function CreateProject(name: string; projectType: TProjectType = ptWin32): TProject;
    function CreateProjectFile(name: string; fileType: TProjectFileType = pftASM): TProjectFile;
    procedure FocusFileInTabs(id: string);
    procedure RemoveTabsheet(projectFile: TProjectFile);
    function GetCurrentFileInProjectExplorer: TProjectFile;
    procedure SynMemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SynEditorStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure UpdateStatusBarForMemo(memo: TSynMemo; regularText: string = '');
    procedure StatusBarHintHandler(Sender: TObject);
    procedure ShowSearchReplaceDialog(AReplace: boolean);
    procedure DoSearchReplaceText(AReplace: boolean; ABackwards: boolean; memo: TSynMemo);
    procedure HideWelcomePage;
    procedure BuildProject(project: TProject; useActiveProject: boolean);
    procedure AssembleProject(project: TProject; useActiveProject: boolean);
    procedure LinkProject(project: TProject);
    procedure ExecuteCommandLines(executeStrings: string);
    function AssembleFile(projectFile: TProjectFile; project: TProject): boolean;
    procedure ClearAssemblyErrors(projectFile: TProjectFile);
    function ParseAssemblyOutput(output: string; projectFile: TProjectFile): boolean;
    procedure PositionCursorToFirstError(projectFile: TProjectFile);
    function CreateLinkerSwitchesCommandFile(project: TProject; finalFile: string): string;
    function CreateLinkCommandFile(project: TProject): string;
    procedure CleanupFiles(project: TProject);
    function GetCurrentProjectInProjectExplorer: TProject;
    procedure FocusTabWithAssemblyErrors;
    procedure RunProject(useActiveProject: boolean = true);
    procedure LocateML;
    procedure CreateBundles;
    procedure SynEditorSpecialLineColors(Sender: TObject; Line: Integer; var Special: Boolean; var FG, BG: TColor);
    procedure DoOnChangeSynMemo(sender: TObject);
    procedure DoSynMemoDblClick(sender: TObject);
    procedure DoOnPaintTransient(Sender: TObject; Canvas: TCanvas; TransientType: TTransientType);
    procedure HighlightWords(memo: TSynMemo);
    procedure DoChange(Sender: TObject);
    function CamelCase(const s: string): string; var t1: integer; first: boolean;
    procedure CheckForWin32HLP;
    procedure UpdateStatusBarFor(regularText: string = '');
    function BindRoot(Form: TComponent; tabSheet: TsTabSheet): TfraDesign;
    procedure ReadError(Reader: TReader; const Message: string; var Handled: Boolean);
    procedure ReaderCreateComponent(Reader: TReader; ComponentClass: TComponentClass; var Component: TComponent);
    function GetFormDesignerFromProjectFile(projectFile: TProjectFile): TzFormDesigner;
    procedure DoAcceptProperty(const PropEdit: IProperty; var PropName: WideString; var Accept: Boolean);
    function GetFormDesigner: TzFormDesigner;
    function GetObjectInspector: TObjectInspectorFrame;
    function ResourceCompileFile(projectFile: TProjectFile; project: TProject): boolean;
    procedure DeleteProjectFileFromDebugPlugin(pf: TProjectFile);
    procedure CheckEnvironmentVariable;
    function FindMethod(const MethName: string): boolean;
    procedure GetParamList(ptData: PTypeData; SL: TStrings);
    function GetMASMEndTokenLineNumber: integer;
    procedure UpdateFunctionList(memo: TSynMemo);
    procedure UpdateToggleUI;
    procedure DoOnMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure DoOnMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
  public
    procedure CreateEditor(projectFile: TProjectFile);
    procedure Initialize;
    procedure SynchronizeProjectManagerWithGroup;
    function SaveChanges: boolean;
    property Group: TGroup read FGroup;
    property VisualMASMOptions: TVisualMASMOptions read FVisualMASMOptions;
    procedure SaveGroup(fileName: string);
    procedure CloseDocument(index: integer; ProjectFileIntId: integer);
    procedure UpdateUI(highlightActiveNode: boolean);
    procedure HighlightNode(intId: integer);
    property ShuttingDown: boolean read FShuttingDown write FShuttingDown;
    property LastTabIndex: integer read FLastTabIndex write FLastTabIndex;
    procedure FocusPage(projectFile: TProjectFile; updateContent: boolean = false);
    function OpenFile(dlgTitle: string): TProjectFile;
    procedure CreateNewProject(projectType: TProjectType);
    procedure CloseProjectFile(intId: integer);
    procedure SaveFileContent(projectFile: TProjectFile);
    function PromptForFileName(projectFile: TProjectFile): string;
    procedure CheckIfChangesHaveBeenMadeAndPromptIfNecessary;
    property Token: string read FToken write FToken;
    procedure ToggleBookMark(bookmark: integer);
    procedure GoToBookMark(bookmark: integer);
    property Bundles: TStringList read FBundles write FBundles;
    function GetBundle(mlMD5Hash: string): TBundle;
    function PlatformString(platformType: TPlatformType): string;
    procedure PromptForFile(fn: string; txtControl: TsComboEdit);
    procedure PromptForPath(caption: string; txtControl: TsComboEdit);
    property Functions: TList<TFunctionData> read FFunctions write FFunctions;
    property Labels: TList<TLabelData> read FLabels write FLabels;
    procedure SynchronizeFunctions;
    procedure SynchronizeLabels;
    procedure GoToFunctionOnLine(line: integer);
    procedure ApplyTheme(name: string; updateTabs: boolean = true);
    procedure LoadColors(theme: string);
    procedure LoadDialog(projectFile: TProjectFile; tabSheet: TsTabSheet);
    function GetMemoFromProjectFile(projectFile: TProjectFile): TSynMemo;
    function CreateMethod(const MethName: string; Instance: TObject; pInfo: PPropInfo; fileId: string): Boolean;
    function GetLineNumberForMethod(const MethName: string): integer;
    procedure GoToMethod(const MethodName: string; fileId: string);
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  uFrmMain, uFrmNewItems, uFrmAbout, uTFile, uFrmRename,
  WinApi.ShellApi, Vcl.Forms, Messages, Vcl.Clipbrd, JsonDataObjects,
  dlgConfirmReplace, dlgReplaceText, dlgSearchText, uFrmLineNumber,
  uFrmOptions, uML, uFrmSetup, uFrmProjectOptions, uFrmDownload, edUtils;

var
  gbSearchBackwards: boolean;
  gbSearchCaseSensitive: boolean;
  gbSearchFromCaret: boolean;
  gbSearchSelectionOnly: boolean;
  gbSearchTextAtCaret: boolean;
  gbSearchWholeWords: boolean;
  gbSearchRegex: boolean;

  gsSearchText: string;
  gsSearchTextHistory: string;
  gsReplaceText: string;
  gsReplaceTextHistory: string;

//constructor TDebugSupportPlugin.Create(editor: TSynEdit);
//begin
//  inherited Create(editor);
//  FEditor := editor;
//end;
//
//procedure TDebugSupportPlugin.AfterPaint(ACanvas: TCanvas; const AClip: TRect;
//  FirstLine, LastLine: integer);
//begin
////  FEditor.PaintGutterGlyphs(ACanvas, AClip, FirstLine, LastLine);
//end;
//
//procedure TDebugSupportPlugin.LinesInserted(FirstLine, Count: integer);
//begin
//// Note: You will need this event if you want to track the changes to
////       breakpoints in "Real World" apps, where the editor is not read-only
//end;
//
//procedure TDebugSupportPlugin.LinesDeleted(FirstLine, Count: integer);
//begin
//// Note: You will need this event if you want to track the changes to
////       breakpoints in "Real World" apps, where the editor is not read-only
//end;

procedure Tdm.Initialize;
var
  i: Integer;
begin
  //actViewIncreaseFontSize.ShortCut := Vcl.menus.ShortCut(VK_OEM_PLUS, [ssCtrl]);
  // TextToShortCut('Ctrl') + VK_OEM_PLUS;

  FFunctions := TList<TFunctionData>.Create;
  FLabels := TList<TLabelData>.Create;
  FWorkerThread := TScanKeywordThread.Create;

  FVisualMASMOptions := TVisualMASMOptions.Create;
  FVisualMASMOptions.LoadFile;

  frmMain.sSkinManager1.SkinDirectory := FVisualMASMOptions.AppFolder+'\Skins';
  frmMain.sSkinManager1.SkinName := FVisualMASMOptions.Theme;

  for i := 0 to FVisualMASMOptions.LastFilesUsed.Count-1 do
  begin
    UpdateMenuWithLastUsedFiles(FVisualMASMOptions.LastFilesUsed[i].FileName);
  end;

  FCodeCompletionList := TUnicodeStringList.Create;
  FCodeCompletionList.LoadFromFile(CODE_COMPLETION_LIST_FILENAME);
  FCodeCompletionInsertList := TUnicodeStringList.Create;
  FCodeCompletionInsertList.LoadFromFile(CODE_COMPLETION_INSERT_LIST_FILENAME);

  FGroup := TGroup.Create(DEFAULT_PROJECTGROUP_NAME);
  LoadColors('');

  if FVisualMASMOptions.OpenLastProjectUsed then
  begin
    if FVisualMASMOptions.LastFilesUsed.Count > 0 then
    begin
      LoadGroup(FVisualMASMOptions.LastFilesUsed[0].FileName);
    end;
  end;

  // *************************************************
  // Create list of available MASM files to search for
  // *************************************************
  CreateBundles;

  LocateML;

  // ************************************
  // Check if we have the Win32.hlp file.
  // If not, try to download it.
  // ************************************
  CheckForWin32HLP;

  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

procedure Tdm.CheckForWin32HLP;
var
  fs: TFileStream;
begin
  if not TFile.Exists(FVisualMASMOptions.AppFolder+WIN32_HLP_FILENAME) then
  begin
//    // try to download WIN32_HLP_FILENAME
//    if MessageDlg('Can not find the Win32 API help file. Would you like Visual MASM to '+CRLF+
//      'download it for you?'+CRLF+CRLF+
//      'The Win32 API help file is required for context sensitive help when you press F1.',
//      mtCustom,[mbYes,mbCancel], 0) = mrYes then
//    begin
//      try
//        frmDownload.Show;
//        frmDownload.Caption := 'Downloading win32.hlp';
//        frmDownload.sGauge1.Progress := 0;
//        Application.ProcessMessages;
//
//        fs := TFileStream.Create(FVisualMASMOptions.AppFolder+WIN32_HLP_FILENAME_COMPRESSED, fmCreate);
//        try
//          httpDownloadNewVersion.OutputStream := fs;
//          httpDownloadNewVersion.Get(WIN32_HLP_URL);
//        finally
//          fs.Free;
//          if TFile.Exists(FVisualMASMOptions.AppFolder+WIN32_HLP_FILENAME_COMPRESSED) then
//          begin
//            frmDownload.Caption := 'Decompressing win32.hlp';
//            Application.ProcessMessages;
//            with CreateInArchive(CLSID_CFormat7z) do
//            begin
//              SetProgressCallback(nil, ProgressCallback);
//              OpenFile(FVisualMASMOptions.AppFolder+WIN32_HLP_FILENAME_COMPRESSED);
//              ExtractTo(FVisualMASMOptions.AppFolder);
//            end;
//          end;
//          frmDownload.Hide;
//        end;
//      except
//        on E : Exception do
//        begin
//          //error := E.Message;
//        end;
//      end;
//    end;
//    if TFile.Exists(FVisualMASMOptions.AppFolder+WIN32_HLP_FILENAME_COMPRESSED) then
//      TFile.Delete(FVisualMASMOptions.AppFolder+WIN32_HLP_FILENAME_COMPRESSED);
  end else begin
    Application.HelpFile := dm.VisualMASMOptions.AppFolder+WIN32_HLP_FILENAME;
    //HtmlHelp(0, Application.HelpFile, HH_DISPLAY_TOC, 0);
    //Application.HelpKeyword('MessageBox');
    //Application.HelpCommand(HELP_FINDER, 0);
    //Application.HelpContext(1);
  end;
end;

procedure Tdm.LoadColors(theme: string);
var
  colorFileName: string;
begin
  if theme <>'' then
  begin
    colorFileName := FVisualMASMOptions.AppFolder+'Colors\'+theme+'.json';
  end else begin
    if (length(FVisualMASMOptions.ThemeCodeEditor)>0) and (colorFileName='') then
      colorFileName := FVisualMASMOptions.AppFolder+'Colors\'+FVisualMASMOptions.ThemeCodeEditor+'.json'
    else
      colorFileName := FVisualMASMOptions.AppFolder+'Colors\'+EDITOR_COLORS_FILENAME;
  end;

  if FVisualMASMOptions.ThemeCodeEditor = 'Blue' then
    frmMain.sAlphaHints1.TemplateName := 'White Baloon'
  else
    frmMain.sAlphaHints1.TemplateName := 'Dark Baloon';
  frmMain.sAlphaHints1.Active := false;
  frmMain.sAlphaHints1.Active := true;

  if not FileExists(colorFileName)then
  begin
    synASMMASM.SynColors := TSynColors.Create;
    synASMMASM.SaveFile(colorFileName);
  end;
  synASMMASM.LoadFile(colorFileName);
end;

function Tdm.SaveChanges: boolean;
var
  promptResult: integer;
begin
  result := true;
  if FGroup=nil then exit;
  if FGroup.Modified then
  begin
    promptResult := MessageDlg('Save changes?',mtCustom,[mbYes,mbNo,mbCancel], 0);
    if promptResult = mrYes then
      SaveGroup(FGroup.FileName);
    if promptResult = mrCancel then
      result := false;
  end;
end;

procedure Tdm.SynchronizeProjectManagerWithGroup;
var
  project: TProject;
  projectFile,childProjectFile: TProjectFile;
  rootNode: PVirtualNode;
  projectNode: PVirtualNode;
  fileNode,childFileNode: PVirtualNode;
  data: PProjectData;
  promptResult: integer;
begin
  if FGroup=nil then exit;

  frmMain.vstProject.BeginUpdate;
  frmMain.vstProject.Clear;

  // Add the root node
  rootNode := frmMain.vstProject.AddChild(nil);
  frmMain.vstProject.Expanded[rootNode] := true;
  data := frmMain.vstProject.GetNodeData(rootNode);
  data^.ProjectId := '';
  data^.Name := FGroup.Name;
  data^.Level := 0;
  data^.FileId := '';
  data^.FileSize := 0;

  for project in FGroup.Projects.Values do
  begin
    // Project node
    projectNode := frmMain.vstProject.AddChild(rootNode);
    frmMain.vstProject.Expanded[projectNode] := true;
    data := frmMain.vstProject.GetNodeData(projectNode);
    data^.ProjectId := project.Id;
    data^.Name := project.Name;
    data^.Level := 1;
    data^.FileId := '';
    data^.FileSize := 0;
    data^.ProjectIntId := project.IntId;

    // Project Files
    for projectFile in project.ProjectFiles.Values do
    begin
      if projectFile.ChildFileRCId<>'' then begin
        fileNode := frmMain.vstProject.AddChild(projectNode);
        data := frmMain.vstProject.GetNodeData(fileNode);
        data^.ProjectId := project.Id;
        data^.ProjectIntId := project.IntId;
        data^.Name := projectFile.Name;
        data^.Level := 2;
        data^.FileId := projectFile.Id;
        data^.FileSize := projectFile.SizeInBytes;
        data^.FileIntId := projectFile.IntId;

        childFileNode := frmMain.vstProject.AddChild(fileNode);
        childProjectFile := FGroup.GetProjectFileById(projectFile.ChildFileRCId);
        data := frmMain.vstProject.GetNodeData(childFileNode);
        data^.ProjectId := project.Id;
        data^.ProjectIntId := project.IntId;
        data^.Name := childProjectFile.Name;
        data^.Level := 3;
        data^.FileId := childProjectFile.Id;
        data^.FileSize := childProjectFile.SizeInBytes;
        data^.FileIntId := childProjectFile.IntId;

        if projectFile.ChildFileASMId<>'' then begin
          childFileNode := frmMain.vstProject.AddChild(fileNode);
          childProjectFile := FGroup.GetProjectFileById(projectFile.ChildFileASMId);
          data := frmMain.vstProject.GetNodeData(childFileNode);
          data^.ProjectId := project.Id;
          data^.ProjectIntId := project.IntId;
          data^.Name := childProjectFile.Name;
          data^.Level := 3;
          data^.FileId := childProjectFile.Id;
          data^.FileSize := childProjectFile.SizeInBytes;
          data^.FileIntId := childProjectFile.IntId;
        end;
      end else begin
        if projectFile.ParentFileId='' then begin
          fileNode := frmMain.vstProject.AddChild(projectNode);
          data := frmMain.vstProject.GetNodeData(fileNode);
          data^.ProjectId := project.Id;
          data^.ProjectIntId := project.IntId;
          data^.Name := projectFile.Name;
          data^.Level := 2;
          data^.FileId := projectFile.Id;
          data^.FileSize := projectFile.SizeInBytes;
          data^.FileIntId := projectFile.IntId;
        end;
      end;
    end;
  end;

  frmMain.vstProject.Refresh;
  frmMain.vstProject.FullExpand;
  frmMain.vstProject.EndUpdate;

  if (FGroup <> nil) and (FGroup.ActiveProject <> nil) then
  begin
    frmMain.tabProject.Caption := FGroup.ActiveProject.Name;
    if FGroup.ActiveProject.Modified or ((FGroup.ActiveProject<> nil) and (FGroup.ActiveProject.Modified)) then
      frmMain.tabProject.Caption := MODIFIED_CHAR+frmMain.tabProject.Caption;
  end;
end;

procedure Tdm.SynchronizeFunctions;
var
  node: PVirtualNode;
  data: PFunctionData;
  i: integer;
begin
  if frmMain.vstFunctions = nil then exit;

  frmMain.vstFunctions.BeginUpdate;
  frmMain.vstFunctions.Clear;

//  Functions.Sort(TComparer<string>.Construct(
//    function (const L, R: string): integer
//    begin
//      Result := L - R;
//    end
//  )) ;

  for i:=0 to FFunctions.Count-1 do
  begin
    //node := frmMain.vstFunctions.AddChild(rootNode);
    node := frmMain.vstFunctions.AddChild(nil);
    frmMain.vstFunctions.Expanded[node] := true;
    data := frmMain.vstFunctions.GetNodeData(node);
    data^.Name := FFunctions.Items[i].Name;
    data^.Line := FFunctions.Items[i].Line;
  end;

  frmMain.vstFunctions.Refresh;
  frmMain.vstFunctions.FullExpand;
  frmMain.vstFunctions.EndUpdate;
end;

procedure Tdm.SynchronizeLabels;
var
  node: PVirtualNode;
  data: PLabelData;
  i: integer;
begin
  if frmMain.vstLabels = nil then exit;

  frmMain.vstLabels.BeginUpdate;
  frmMain.vstLabels.Clear;

  for i:=0 to FLabels.Count-1 do
  begin
    node := frmMain.vstLabels.AddChild(nil);
    frmMain.vstLabels.Expanded[node] := true;
    data := frmMain.vstLabels.GetNodeData(node);
    data^.Name := FLabels.Items[i].Name;
    data^.Line := FLabels.Items[i].Line;
  end;

  frmMain.vstLabels.Refresh;
  frmMain.vstLabels.FullExpand;
  frmMain.vstLabels.EndUpdate;
end;

procedure Tdm.SaveGroup(fileName: string);
var
  project: TProject;
  json, jGroup, jProjects: TJSONObject;
  fileContent: TStringList;
begin
//  if (FGroup.FileName='') or (pos('\',FGroup.FileName)=0) then
//  begin
//    dlgSave.Title := 'Save '+FGroup.Name+' As';
//    dlgSave.Filter := ANY_FILE_FILTER;
//    dlgSave.FilterIndex := 1;
//    if length(FGroup.FileName)>0 then
//      dlgSave.FileName := FGroup.FileName
//    else
//      dlgSave.FileName := FGroup.Name;
//    if dlgSave.Execute then
//      FGroup.FileName := dlgSave.FileName
//    else
//      FGroup.FileName := '';
//    if length(FGroup.FileName) = 0 then exit; // User canceled
//    if TFile.Exists(FGroup.FileName) then
//    begin
//      if MessageDlg('File '+ExtractFileName(FGroup.FileName)+
//        ' alrady exists. Overwrite?',mtCustom,[mbYes,mbCancel], 0) <> mrYes then
//      begin
//        exit; // User canceled
//      end;
//    end;
//  end;

  if fileName = '' then exit;

  FGroup.FileName := fileName;
  UpdateMenuWithLastUsedFiles(fileName);
  FGroup.Name := ChangeFileExt(ExtractFileName(fileName), '');

  json := TJSONObject.Create();
  json.I['Version'] := VISUALMASM_FILE_VERSION;
  jGroup := json.O['Group'];
  jGroup.S['Name'] := FGroup.Name;
  jGroup.S['Id'] := FGroup.Id;
  jGroup.S['Created'] := DateTimeToStr(FGroup.Created);
  jGroup.S['FileName'] := FGroup.FileName;
  if FGroup.ActiveProject <> nil then
    jGroup.S['SelectedProjectId'] := FGroup.ActiveProject.Id
  else
    jGroup.S['SelectedProjectId'] := '';

  if (FGroup.ActiveProject <> nil) and (FGroup.ActiveProject.ActiveFile <> nil) then
    FGroup.LastFileOpenId := FGroup.ActiveProject.ActiveFile.Id;
  jGroup.S['LastFileOpenId'] := FGroup.LastFileOpenId;

  for project in FGroup.Projects.Values do
  begin
    SaveProject(project);
    jProjects := jGroup.A['Projects'].AddObject;
    jProjects.S['Id'] := project.Id;
    jProjects.S['Name'] := project.Name;
    jProjects.S['FileName'] := project.FileName;
  end;

  FGroup.Modified := false;

  fileContent := TStringList.Create;
  fileContent.Text := json.ToJSON(false);
  fileContent.SaveToFile(fileName);

  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

procedure Tdm.SaveProject(activeProject: TProject; fileName: string = '');
var
  f: TProjectFile;
  json, jProject, jFiles: TJSONObject;
  newFileName: string;
  fileContent: TStringList;
begin
  if fileName <> '' then
    activeProject.FileName := fileName;

  if pos('\',activeProject.FileName)=0 then
  begin
    // Project was never saved
    newFileName := PromptForProjectFileName(activeProject);
    if newFileName = '' then exit;
    activeProject.FileName := newFileName;
    activeProject.Name := ExtractFileName(activeProject.FileName);
    SetProjectName(activeProject);
    if length(activeProject.FileName)>0 then
    begin
      if FileExists(activeProject.FileName) then
        if MessageDlg(ExtractFileName(activeProject.FileName)+' already exists. Overwrite?',mtCustom,[mbYes,mbCancel], 0) = mrCancel then
          exit;
    end;
  end;

  activeProject.Modified := false;

  json := TJSONObject.Create();
  json.I['Version'] := VISUALMASM_FILE_VERSION;
  jProject := json.O['Project'];
  jProject.S['Name'] := activeProject.Name;
  jProject.S['Id'] := activeProject.Id;
  jProject.S['FileName'] := activeProject.FileName;
  jProject.S['Created'] := DateTimeToStr(activeProject.Created);
  jProject.S['Type'] := GetEnumName(TypeInfo(TProjectType),integer(activeProject.ProjectType));
  jProject.S['PreAssembleEventCommandLine'] := activeProject.PreAssembleEventCommandLine;
  jProject.S['AssembleEventCommandLine'] := activeProject.AssembleEventCommandLine;
  jProject.S['PostAssembleEventCommandLine'] := activeProject.PostAssembleEventCommandLine;
  jProject.S['PreLinkEventCommandLine'] := activeProject.PreLinkEventCommandLine;
  jProject.S['LinkEventCommandLine'] := activeProject.LinkEventCommandLine;
  jProject.S['AdditionalLinkSwitches'] := activeProject.AdditionalLinkSwitches;
  jProject.S['AdditionalLinkFiles'] := activeProject.AdditionalLinkFiles;
  jProject.S['PostLinkEventCommandLine'] := activeProject.PostLinkEventCommandLine;
  jProject.S['LibraryPath'] := activeProject.LibraryPath;

  for f in activeProject.ProjectFiles.Values do
  begin
    SaveFileContent(f);
    jFiles := json.A['Files'].AddObject;
    jFiles.S['Id'] := f.Id;
    jFiles.S['Name'] := f.Name;
    jFiles.S['Created'] := DateTimeToStr(f.Created);
    jFiles.S['Type'] := GetEnumName(TypeInfo(TProjectFileType),integer(f.ProjectFileType));
    jFiles.S['Path'] := f.Path;
    jFiles.B['IsOpen'] := f.IsOpen;
    jFiles.B['AssembleFile'] := f.AssembleFile;
    jFiles.S['ChildFileRCId'] := f.ChildFileRCId;
    jFiles.S['ChildFileASMId'] := f.ChildFileASMId;
    jFiles.S['ParentFileId'] := f.ParentFileId;
  end;

  fileContent := TStringList.Create;
  fileContent.Text := json.ToJSON(false);
  fileContent.SaveToFile(activeProject.FileName);

  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

function Tdm.PromptForProjectFileName(project: TProject): string;
var
  fileName: string;
begin
  frmMain.sAlphaHints1.HideHint;
  if FGroup = nil then
    dlgSave.Title := 'Save '+DEFAULT_PROJECT_NAME+' As'
  else
    dlgSave.Title := 'Save '+project.Name+' As';
  dlgSave.Filter := PROJECT_FILTER;
  dlgSave.FilterIndex := 1;
  if length(project.FileName)>0 then
    dlgSave.FileName := project.FileName
  else begin
    fileName := StringReplace(project.Name, ExtractFileExt(project.Name), '', [rfReplaceAll, rfIgnoreCase]);
    dlgSave.FileName := fileName+PROJECT_FILE_EXT;
  end;
  if dlgSave.Execute then
    result := dlgSave.FileName
  else
    result := '';
end;

procedure Tdm.actAboutExecute(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure Tdm.actAddExistingProjectExecute(Sender: TObject);
begin
  AddExistingProject('Add Existing Project', true);
end;

procedure Tdm.actAddNewAssemblyFileExecute(Sender: TObject);
var
  projectFile: TProjectFile;
  project: TProject;
begin
  if FGroup.ActiveProject = nil then
  begin
    ShowMessage(ERR_NO_PROJECT_CREATED);
    exit;
  end;
  project := GetCurrentProjectInProjectExplorer;
  if project = nil then exit;
  projectFile := project.CreateProjectFile(DEFAULT_FILE_NAME, FVisualMASMOptions);
  CreateEditor(projectFile);
  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

procedure Tdm.actAddNewBatchFileExecute(Sender: TObject);
var
  projectFile: TProjectFile;
  project: TProject;
begin
  if FGroup.ActiveProject = nil then
  begin
    ShowMessage(ERR_NO_PROJECT_CREATED);
    exit;
  end;
  project := GetCurrentProjectInProjectExplorer;
  if project = nil then exit;
  projectFile := project.CreateProjectFile('Batch'+inttostr(project.ProjectFiles.Count+1)+'.bat',
    FVisualMASMOptions, pftBAT);
  CreateEditor(projectFile);
  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

procedure Tdm.actAddNewIncludeFileExecute(Sender: TObject);
var
  projectFile: TProjectFile;
  project: TProject;
begin
  if FGroup.ActiveProject = nil then
  begin
    ShowMessage(ERR_NO_PROJECT_CREATED);
    exit;
  end;
  project := GetCurrentProjectInProjectExplorer;
  if project = nil then exit;
  projectFile := project.CreateProjectFile('Inc'+inttostr(project.ProjectFiles.Count+1)+'.inc',
    FVisualMASMOptions, pftINC);
  CreateEditor(projectFile);
  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

function Tdm.ReadWin32BitExeMasm32File: string;
var
  text: string;
begin
  result := TFile.ReadAllText(FVisualMASMOptions.TemplatesFolder+WIN_32_BIT_EXE_MASM32_FILENAME);
end;

function Tdm.ReadWin64BitExeWinSDK64File: string;
var
  text: string;
begin
  result := TFile.ReadAllText(FVisualMASMOptions.TemplatesFolder+WIN_64_BIT_EXE_WINSDK64_FILENAME);
end;

function Tdm.Read16BitDosCOMStub: string;
var
  text: string;
begin
  result := TFile.ReadAllText(FVisualMASMOptions.TemplatesFolder+DOS_16_BIT_COM_STUB_FILENAME);
end;

function Tdm.Read16BitDosEXEStub: string;
var
  text: string;
begin
  result := TFile.ReadAllText(FVisualMASMOptions.TemplatesFolder+DOS_16_BIT_EXE_STUB_FILENAME);
end;

procedure Tdm.actAddNewProjectExecute(Sender: TObject);
begin
  frmNewItems.AddNewProject(true);
  frmNewItems.ShowModal;
end;

procedure Tdm.actAddNewRCFileExecute(Sender: TObject);
var
  projectFile: TProjectFile;
  project: TProject;
begin
  if FGroup.ActiveProject = nil then
  begin
    ShowMessage(ERR_NO_PROJECT_CREATED);
    exit;
  end;
  project := GetCurrentProjectInProjectExplorer;
  if project = nil then exit;
  projectFile := project.CreateProjectFile('Resource'+inttostr(project.ProjectFiles.Count+1)+'.rc',
    FVisualMASMOptions, pftRC);
  CreateEditor(projectFile);
  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

procedure Tdm.actAddNewTextFileExecute(Sender: TObject);
var
  projectFile: TProjectFile;
  project: TProject;
begin
  if FGroup.ActiveProject = nil then
  begin
    ShowMessage(ERR_NO_PROJECT_CREATED);
    exit;
  end;
  project := GetCurrentProjectInProjectExplorer;
  if project = nil then exit;
  projectFile := project.CreateProjectFile('Text'+inttostr(project.ProjectFiles.Count+1)+'.txt',
    FVisualMASMOptions, pftTXT);
  CreateEditor(projectFile);
  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

procedure Tdm.actAddToProjectExecute(Sender: TObject);
begin
  if FGroup.ActiveProject = nil then
  begin
    ShowMessage(ERR_NO_PROJECT_CREATED);
    exit;
  end;
  OpenFile('Add to Project');
end;

procedure Tdm.actAssembleFileExecute(Sender: TObject);
var
  projectFile: TProjectFile;
  project: TProject;
  outputFile: string;
begin
  frmMain.memOutput.Clear;

  project := GetCurrentProjectInProjectExplorer;
  projectFile := GetCurrentFileInProjectExplorer;

  ClearAssemblyErrors(projectFile);

  if AssembleFile(projectFile, project) then
  begin
    outputFile := ExtractFilePath(projectFile.FileName) +
      ChangeFileExt(ExtractFileName(projectFile.FileName), '') + '.obj';
    if FileExists(outputFile) then
      frmMain.memOutput.Lines.Add('Created '+outputFile+' ('+inttostr(FileSize(outputFile))+' bytes)');
  end;

  FocusTabWithAssemblyErrors;
end;

procedure Tdm.actCopyPathExecute(Sender: TObject);
var
  data: PProjectData;
  path: string;
begin
  data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
  if data.Level = 0 then
    path := ExtractFilePath(FGroup.FileName);
  if data.Level = 1 then
//  testName := TGroup(list.Objects[list.IndexOf(group.Id)]).Name;
    path := ExtractFilePath(FGroup[data.ProjectId].FileName);
  if (data.Level = 2) or (data.Level = 3) then
    path := FGroup[data.ProjectId].ProjectFile[data.FileId].Path;
  Clipboard.AsText := path;
end;

procedure Tdm.actDeleteFileExecute(Sender: TObject);
var
  projectFile,pf,child: TProjectFile;
  data: PProjectData;
  i: integer;
begin
  projectFile := GetCurrentFileInProjectExplorer;
  if projectFile = nil then exit;
  if MessageDlg('Delete file '+projectFile.Name+'?',mtCustom,[mbYes,mbCancel], 0) = mrYes then
  begin
    RemoveTabsheet(projectFile);
    DeleteProjectFileFromDebugPlugin(projectFile);
    if TFile.Exists(projectFile.FileName) then
      TFile.Delete(projectFile.FileName);
    data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
    if (data.Level = 2) or (data.Level = 3) then
    begin
      if projectFile.ProjectFileType = pftDLG then
      begin
        // Delete child file as well
        child := dm.Group.GetProjectFileById(projectFile.ChildFileRCId);
        if child <> nil then
          ClosePageByProjectFileIntId(child.IntId);
        FGroup[data.ProjectId].DeleteProjectFile(projectFile.ChildFileRCId);

        child := dm.Group.GetProjectFileById(projectFile.ChildFileASMId);
        if child <> nil then
          ClosePageByProjectFileIntId(child.IntId);
        FGroup[data.ProjectId].DeleteProjectFile(projectFile.ChildFileASMId);
      end;
      FGroup[data.ProjectId].DeleteProjectFile(data.FileId);
    end;
    SynchronizeProjectManagerWithGroup;
    UpdateUI(true);
  end;
end;

procedure Tdm.DeleteProjectFileFromDebugPlugin(pf: TProjectFile);
var
  i: integer;
begin
  // Delete from Debug Support
  for i:= 0 to FDebugSupportPlugins.Count-1 do
  begin
    pf := FDebugSupportPlugins.Items[i].ProjectFile;
    if (pf <> nil) and (pf is TProjectFile) and Assigned(pf) then
    begin
      if pf.Id = pf.Id then
      begin
        FDebugSupportPlugins.Delete(i);
        break;
      end;
    end;
  end;
end;

function Tdm.GetCurrentFileInProjectExplorer: TProjectFile;
var
  data: PProjectData;
begin
  result := nil;
  if frmMain.vstProject.FocusedNode = nil then
  begin
    //ShowMessage('No file highlighted. Select a file in the project explorer.');
    //exit;
  end else begin
    data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
    if (data<> nil) and ((data.Level = 2) or (data.Level = 3)) then
      result := FGroup[data.ProjectId].ProjectFile[data.FileId];
  end;
  if result = nil then
  begin
    // Try to get the project file from the current tab instead
    if frmMain.sPageControl1.ActivePage <> nil then
    begin
      result := FGroup.GetProjectFileByIntId(frmMain.sPageControl1.ActivePage.Tag);
    end;
  end;
end;

function Tdm.GetCurrentProjectInProjectExplorer: TProject;
var
  data: PProjectData;
begin
  result := nil;
  if frmMain.vstProject.FocusedNode = nil then
  begin
    ShowMessage('No file highlighted. Select a file in the project explorer.');
    exit;
  end else begin
    data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
    if (data<> nil) and ((data.Level = 2) or (data.Level = 3) or (data.Level = 1)) then
      result := FGroup[data.ProjectId];
  end;
//  if result = nil then
//  begin
//    // Try to get the project file from the current tab instead
//    if frmMain.sPageControl1.ActivePage <> nil then
//    begin
//      result := FGroup.GetProjectFileByIntId(frmMain.sPageControl1.ActivePage.Tag);
//    end;
//  end;
end;

procedure Tdm.actDOSPromnptHereExecute(Sender: TObject);
var
  data: PProjectData;
  path: string;
begin
  Data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
  if data.Level = 0 then
    path := ExtractFilePath(FGroup.FileName);
  if data.Level = 1 then
    path := ExtractFilePath(FGroup[data.ProjectId].FileName);
  if ((data.Level = 2) or (data.Level = 3)) then
    path := FGroup[data.ProjectId].ProjectFile[data.FileId].Path;
// http://stackoverflow.com/questions/3515867/send-parameter-to-cmd
//
//  To start cmd.exe and immediately execute a command, use the /K flag:
//
//  procedure TForm1.FormCreate(Sender: TObject);
//  begin
//    ShellExecute(Handle, nil, 'cmd.exe', '/K cd C:\WINDOWS', nil, SW_SHOWNORMAL);
//  end;
//  To run a command in cmd.exe and then immediately close the console window, use the /C flag:
//
//  procedure TForm1.FormCreate(Sender: TObject);
//  begin
//    ShellExecute(Handle, nil, 'cmd.exe', '/C del myfile.txt', nil, SW_SHOWNORMAL);
//  end;
  ShellExecute(Application.Handle, 'open', 'cmd',
    PChar('/K cd "'+path+'"'), nil, SW_NORMAL);
end;

function Tdm.OpenFile(dlgTitle: string): TProjectFile;
var
  projectFile: TProjectFile;
  fileExt: string;
  project: TProject;
begin
  project := GetCurrentProjectInProjectExplorer;
  if project = nil then exit;
  if FLastOpenDialogDirectory = '' then
    FLastOpenDialogDirectory := FVisualMASMOptions.AppFolder;
  dlgOpen.InitialDir := FLastOpenDialogDirectory;
  dlgOpen.Title := dlgTitle; //'Add to Project';
  dlgOpen.Filter := ANY_FILE_FILTER+'|'+synASMMASM.DefaultFilter+'|'+
    synBAT.DefaultFilter+'|'+RESOURCE_FILTER+'|'+INI_FILTER;
  if dlgOpen.Execute then
  begin
    FLastOpenDialogDirectory := ExtractFilePath(dlgOpen.FileName);
    fileExt := UpperCase(ExtractFileExt(dlgOpen.FileName));
    projectFile := project.CreateProjectFile(ExtractFileName(dlgOpen.FileName),
      FVisualMASMOptions);
    projectFile.Path := ExtractFilePath(dlgOpen.FileName);

    if (fileExt = '.ASM') or (fileExt = '.INC') then
      projectFile.ProjectFileType := pftASM
    else if fileExt = '.BAT' then
      projectFile.ProjectFileType := pftBAT
    else if fileExt = '.TXT' then
      projectFile.ProjectFileType := pftTXT
    else if fileExt = '.RC' then
      projectFile.ProjectFileType := pftRC
    else if fileExt = '.INI' then
      projectFile.ProjectFileType := pftINI
    else if (fileExt = '.C') or (fileExt = '.CPP') or (fileExt = '.CC') or (fileExt = '.H') or (fileExt = '.HPP') or (fileExt = '.HH') or (fileExt = '.CXX') or (fileExt = '.HXX') or (fileExt = '.CU') then
      projectFile.ProjectFileType := pftCPP
    else
      projectFile.ProjectFileType := pftOther;

    projectFile.Content := TFile.ReadAllText(dlgOpen.FileName);
    projectFile.SizeInBytes := length(projectFile.Content);
    projectFile.Modified := false;

    CreateEditor(projectFile);
    SynchronizeProjectManagerWithGroup;
    UpdateUI(true);

    result := projectFile;
  end;
end;

procedure Tdm.actEditCamcelCaseExecute(Sender: TObject);
var
  memo: TSynMemo;
begin
  if frmMain.sPageControl1.ActivePage <> nil then
  begin
    FSearchKey := '';
    memo := GetMemo;
    if memo <> nil then
    begin
      if memo.SelAvail then
      begin
        memo.SelText := CamelCase(memo.SelText);
      end;
    end;
  end;
end;

procedure Tdm.actEditCommentLineExecute(Sender: TObject);
var
  memo: TSynMemo;
begin
  memo := GetMemo;
  if memo <> nil then
  begin
    if frmMain.sPageControl1.ActivePage <> nil then
      CommentUncommentLine(memo);
  end;
end;

procedure Tdm.actEditCopyExecute(Sender: TObject);
var
  memo: TSynMemo;
begin
  memo := GetMemo;
  if memo <> nil then
  begin
    if frmMain.sPageControl1.ActivePage <> nil then
      memo.CopyToClipboard;
  end;
end;

procedure Tdm.actEditCutExecute(Sender: TObject);
var
  memo: TSynMemo;
begin
  memo := GetMemo;
  if memo <> nil then
  begin
    if frmMain.sPageControl1.ActivePage <> nil then
      memo.CutToClipboard;
  end;
end;

procedure Tdm.actEditDeleteExecute(Sender: TObject);
var
  memo: TSynMemo;
begin
  memo := GetMemo;
  if memo <> nil then
  begin
    if frmMain.sPageControl1.ActivePage <> nil then
      memo.SelText := '';
  end;
end;

procedure Tdm.actEditHighlightWordsExecute(Sender: TObject);
var
  word: string;
  wordStart: integer;
  buffer: TBufferCoord;
  memo: TSynMemo;
begin
  memo := GetMemo;
  if memo <> nil then
  begin
    wordStart := memo.WordStart.Char;
    word := memo.WordAtCursor;

    if not memo.SelAvail then begin
      buffer := memo.CaretXY;
      buffer.Char := memo.WordStart.Char;
      memo.BlockBegin := buffer;
      buffer.Char := buffer.Char+length(word);
      memo.BlockEnd := buffer;
    end;

    HighlightWords(memo);
  end;
end;

procedure Tdm.actEditLowerCaseExecute(Sender: TObject);
var
  memo: TSynMemo;
begin
  if frmMain.sPageControl1.ActivePage <> nil then
  begin
    FSearchKey := '';
    memo := GetMemo;
    if memo <> nil then
    begin
      if memo.SelAvail then
      begin
        memo.SelText := lowercase(memo.SelText);
      end;
    end;
  end;
end;

procedure Tdm.actEditPasteExecute(Sender: TObject);
var
  memo: TSynMemo;
begin
  if frmMain.sPageControl1.ActivePage <> nil then
  begin
    memo := GetMemo;
    if memo <> nil then
    begin
      memo.PasteFromClipboard;
    end;
  end;
end;

procedure Tdm.actEditRedoExecute(Sender: TObject);
var
  memo: TSynMemo;
begin
  if frmMain.sPageControl1.ActivePage <> nil then
  begin
    memo := GetMemo;
    if memo <> nil then
    begin
      FSearchKey := '';
      memo.Redo;
    end;
  end;
end;

procedure Tdm.actEditSelectAllExecute(Sender: TObject);
var
  memo: TSynMemo;
begin
  if frmMain.sPageControl1.ActivePage <> nil then
  begin
    memo := GetMemo;
    if memo <> nil then
    begin
      memo.SelectAll;
    end;
  end;
end;

procedure Tdm.actEditUndoExecute(Sender: TObject);
var
  memo: TSynMemo;
begin
  if frmMain.sPageControl1.ActivePage <> nil then
  begin
    memo := GetMemo;
    if memo <> nil then
    begin
      FSearchKey := '';
      memo.Undo;
    end;
  end;
end;

procedure Tdm.actEditUpperCaseExecute(Sender: TObject);
var
  memo: TSynMemo;
begin
  if frmMain.sPageControl1.ActivePage <> nil then
  begin
    FSearchKey := '';
    memo := GetMemo;
    if memo <> nil then
    begin
      if memo.SelAvail then
      begin
        memo.SelText := uppercase(memo.SelText);
      end;
    end;
  end;
end;

procedure Tdm.actFileAddNewDialogExecute(Sender: TObject);
var
  parentProjectFile,childProjectFile: TProjectFile;
  fileName: string;
  project: TProject;
begin
  if FGroup.ActiveProject = nil then
  begin
    ShowMessage(ERR_NO_PROJECT_CREATED);
    exit;
  end;
  project := GetCurrentProjectInProjectExplorer;
  if project = nil then exit;

  fileName := 'Dialog'+inttostr(project.ProjectFiles.Count+1);

  parentProjectFile := project.CreateProjectFile(fileName+'.dlg', FVisualMASMOptions, pftDLG);

  childProjectFile := project.CreateProjectFile(fileName+'.rc', FVisualMASMOptions, pftRC);
  childProjectFile.ParentFileId := parentProjectFile.Id;
  childProjectFile.IsOpen := false;
  childProjectFile.Content := NEW_ITEM_RC_HEADER;
  parentProjectFile.ChildFileRCId := childProjectFile.Id;

  childProjectFile := project.CreateProjectFile(fileName+'.asm', FVisualMASMOptions, pftASM);
  childProjectFile.ParentFileId := parentProjectFile.Id;
  childProjectFile.IsOpen := false;
  childProjectFile.Content := CreateResourceCodeBehind(fileName);
  parentProjectFile.ChildFileASMId := childProjectFile.Id;

  CreateEditor(parentProjectFile);

  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

procedure Tdm.actFileCloseAllExecute(Sender: TObject);
var
  i: integer;
begin
  with frmMain.sPageControl1 do
    for i := PageCount-1 downto 0 do
      Pages[i].Free;
end;

procedure Tdm.actFileNew32BitWindowsExeAppAddToGroupExecute(Sender: TObject);
begin
  CreateNewProject(ptWin32);
end;

procedure Tdm.CreateNewProject(projectType: TProjectType);
begin
  FGroup.CreateNewProject(projectType, FVisualMASMOptions);
  CreateEditor(FGroup.ActiveProject.ActiveFile);
  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

procedure Tdm.actFileRenameExecute(Sender: TObject);
var
  projectFile: TProjectFile;
  project: TProject;
begin
  projectFile := GetCurrentFileInProjectExplorer;
  if projectFile = nil then exit;

  frmRename.CurrentName := projectFile.Name;
  frmRename.NewName := projectFile.Name;

  if frmRename.ShowModal = mrOk then
  begin
    projectFile.Name := frmRename.txtNewName.Text;
    if FileExists(projectFile.FileName) then
      RenameFile(projectFile.FileName,
        projectFile.Path + frmRename.txtNewName.Text);
    projectFile.FileName := projectFile.Path + frmRename.txtNewName.Text;
    projectFile.Modified := true;
    project := FGroup.GetProjectByFileIntId(projectFile.IntId);
    project.Modified := true;

    SynchronizeProjectManagerWithGroup;
    UpdateUI(true);
    UpdatePageCaption(FGroup.ActiveProject.ActiveFile);
  end;
end;

procedure Tdm.actFileSaveAllExecute(Sender: TObject);
begin
  CheckIfChangesHaveBeenMadeAndPromptIfNecessary;
end;

procedure Tdm.actFileSaveAsExecute(Sender: TObject);
var
  fileName: string;
  data: PProjectData;
  projectFile: TProjectFile;
begin
  data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
  if (data.Level = 2) or (data.Level = 3) then
    projectFile := FGroup[data.ProjectId].ProjectFile[data.FileId];
  if projectFile = nil then
  begin
    ShowMessage('Unable to get project file');
    exit;
  end;
  fileName := PromptForFileName(projectFile);
  if length(fileName)>0 then
  begin
    projectFile.FileName := fileName;
    projectFile.Path := ExtractFilePath(projectFile.FileName);
    projectFile.Name := ExtractFileName(fileName);
    projectFile.Modified := true;
    FGroup.ActiveProject.Modified := true;
    SaveFileContent(projectFile);
  end;
end;

procedure Tdm.CheckIfChangesHaveBeenMadeAndPromptIfNecessary;
var
  i: integer;
  projectFile: TProjectFile;
begin
  if FGroup.ActiveProject = nil then exit;

  if not SaveChanges then exit;
  actGroupSaveExecute(self);

//  for i:=0 to FGroup.ProjectCount-1 do
//  begin
//    if FGroup.ProjectByIndex[i].Modified then
//    begin
//      SaveProject(FGroup.ProjectByIndex[i]);
//    end;
//  end;

  if (not ShuttingDown) and (projectFile <> nil) then
    HighlightNode(projectFile.IntId);
end;

procedure Tdm.UpdatePageCaption(projectFile: TProjectFile);
var
  i: integer;
begin
  // Look for the page with the filename
  with frmMain.sPageControl1 do
    for i := 0 to PageCount-1 do
    begin
      //if Pages[i].Caption = (MODIFIED_CHAR+fileName) then
      if Pages[i].Tag = projectFile.IntId then
      begin
        if (projectFile.Modified) and (pos(MODIFIED_CHAR,projectFile.Name)=0) then
          Pages[i].Caption := MODIFIED_CHAR+projectFile.Name
        else
          Pages[i].Caption := projectFile.Name;
        break;
      end;
    end;
end;

procedure Tdm.actGoToLineNumberExecute(Sender: TObject);
var
  projectFile: TProjectFile;
  memo: TSynMemo;
begin
  if frmGoToLineNumber.ShowModal = mrok then
  begin
    projectFile := GetCurrentFileInProjectExplorer;
    memo := GetSynMemoFromProjectFile(projectFile);
    if memo = nil then exit;
    memo.GotoLineAndCenter(frmGoToLineNumber.spnLine.Value);
  end;
end;

procedure Tdm.actGroupNewGroupExecute(Sender: TObject);
begin
  // Create the new group
  actFileCloseAllExecute(self);
  FGroup := TGroup.Create(DEFAULT_PROJECTGROUP_NAME);
  SynchronizeProjectManagerWithGroup;
  UpdateUI(false);
end;

procedure Tdm.actGroupRemoveProjectExecute(Sender: TObject);
var
  data: PProjectData;
  i: integer;
  project, projectToBeDeleted: TProject;
  projectFile: TProjectFile;
  gotMilk: boolean;
  mbResult: integer;
begin
  data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
  projectToBeDeleted := FGroup.ProjectById[data.ProjectId];

  if projectToBeDeleted.Modified then
  begin
    mbResult := MessageDlg('Save project '+projectToBeDeleted.Name+'?',mtCustom,[mbYes,mbNo,mbCancel], 0);
    if mbResult = mrYes then
    begin
//      SaveProject(FGroup.ProjectById[data.ProjectId]);
    end;
  end;

  if mbResult = mrCancel then exit;

  if data.Level = 1 then
  begin
    // First check if this is an active project, if so, pick a new one
    if FGroup.ActiveProject.Id = data.ProjectId then
    begin
      for project in FGroup.Projects.Values do
      begin
        for projectFile in project.ProjectFiles.Values do
        begin
          if project.Id <> data.ProjectId then
          begin
            FGroup.ActiveProject := project;
            gotMilk := true;
            break;
          end;
        end;
        if gotMilk then break;
      end;
    end;
    ClosePagesByProject(projectToBeDeleted);

    for projectFile in projectToBeDeleted.ProjectFiles.Values do
      DeleteProjectFileFromDebugPlugin(projectFile);

    FGroup.DeleteProject(data.ProjectId);
    SynchronizeProjectManagerWithGroup;
  end;
  UpdateUI(true);
end;

procedure Tdm.actGroupRenameExecute(Sender: TObject);
begin
  frmRename.CurrentName := FGroup.Name;
  frmRename.NewName := FGroup.Name;

  if frmRename.ShowModal = mrOk then
  begin
    FGroup.Name := frmRename.txtNewName.Text;
    if FileExists(FGroup.FileName) then
      RenameFile(FGroup.FileName,ExtractFilePath(FGroup.FileName)+FGroup.Name+GROUP_FILE_EXT);
    FGroup.FileName := ExtractFilePath(FGroup.FileName)+FGroup.Name+GROUP_FILE_EXT;
    FGroup.Modified := true;
    SynchronizeProjectManagerWithGroup;
  end;
end;

procedure Tdm.actGroupSaveAsExecute(Sender: TObject);
begin
  if FGroup = nil then
  begin
    dlgSave.Title := 'Save '+DEFAULT_PROJECTGROUP_NAME+' As';
    dlgSave.FileName := DEFAULT_PROJECTGROUP_NAME+GROUP_FILE_EXT;
  end else begin
    dlgSave.Title := 'Save '+FGroup.Name+' As';
    if length(FGroup.FileName)>0 then
      dlgSave.FileName := FGroup.FileName
    else
      dlgSave.FileName := FGroup.Name+GROUP_FILE_EXT;
  end;
  dlgSave.Filter := GROUP_FILTER;
  dlgSave.FilterIndex := 1;
  if dlgSave.Execute then
  begin
    if MessageDlg(ExtractFileName(dlgSave.FileName)+' already exists. Overwrite?',
      mtCustom,[mbYes,mbCancel], 0) = mrYes then
      SaveGroup(dlgSave.FileName);
  end;
end;

procedure Tdm.actGroupSaveExecute(Sender: TObject);
begin
  if FGroup.FileName = '' then
    // Group was never saved
    actGroupSaveAsExecute(self)
  else
    SaveGroup(FGroup.FileName);
end;

procedure Tdm.actHelpWin32HelpExecute(Sender: TObject);
var
  word: string;
  memo: TSynMemo;
  link: HH_AKLINK;
begin
  memo := GetMemo;
  if memo = nil then exit;
  word := memo.WordAtCursor;
  if length(word)>1 then begin
    HtmlHelp(0, Application.HelpFile, HH_DISPLAY_TOC, 0);
    link.cbStruct := SizeOf(HH_AKLINK);
    link.fReserved := FALSE;
    link.pszKeywords := PChar(word);
    link.pszUrl := nil;
    link.pszMsgText := nil;
    link.pszMsgTitle := nil;
    link.pszWindow := nil;
    link.fIndexOnFail := True;
    HtmlHelp(0, Application.HelpFile, HH_KEYWORD_LOOKUP, Dword(@link));
  end;
end;

procedure Tdm.actNew16BitDOSComAppExecute(Sender: TObject);
begin
  CreateNewProject(ptDos16COM);
end;

procedure Tdm.actNew16BitDOSExeAppExecute(Sender: TObject);
begin
  CreateNewProject(ptDos16EXE);
end;

procedure Tdm.actNew64BitWindowsExeAppExecute(Sender: TObject);
begin
  CreateNewProject(ptWin64);
end;

procedure Tdm.actNewOtherExecute(Sender: TObject);
var
//  data: PProjectData;
  project: TProject;
begin
  project := GetCurrentProjectInProjectExplorer;
  if project <> nil then
  begin
    case project.ProjectType of
      ptWin32: frmNewItems.HighlightWindowsFiles;
      ptWin64: frmNewItems.HighlightWindowsFiles;
      ptWin32DLL: ;
      ptWin64DLL: ;
      ptDos16COM: frmNewItems.HighlightMSDOSFiles;
      ptDos16EXE: frmNewItems.HighlightMSDOSFiles;
      ptWin16: ;
      ptWin16DLL: ;
    end;
  end else
    frmNewItems.HighlightApplications;
  frmNewItems.ShowModal;
end;

procedure Tdm.actOpenProjectExecute(Sender: TObject);
begin
  AddExistingProject('Open Project', false);
end;

procedure Tdm.actOptionsExecute(Sender: TObject);
begin
  if frmOptions.ShowModal = mrOk then
    FVisualMASMOptions.SaveFile;
end;

procedure Tdm.actProjectAssembleExecute(Sender: TObject);
var
  project: TProject;
begin
  project := GetCurrentProjectInProjectExplorer;
  if project = nil then exit;
  frmMain.memOutput.Clear;
  AssembleProject(project, true);
end;

procedure Tdm.actProjectBuildExecute(Sender: TObject);
begin
  frmMain.memOutput.Clear;
  BuildProject(FGroup.ActiveProject, true);
end;

procedure Tdm.BuildProject(project: TProject; useActiveProject: boolean);
begin
  AssembleProject(project, useActiveProject);
  LinkProject(project);
end;

procedure Tdm.AssembleProject(project: TProject; useActiveProject: boolean);
var
  i: integer;
  consoleOutput: string;
  errors: string;
  projectFile: TProjectFile;
begin
  ExecuteCommandLines(project.PreAssembleEventCommandLine);

  if project.AssembleEventCommandLine = '' then
  begin
    for projectFile in project.ProjectFiles.Values do
    begin
      if (projectFile.ProjectFileType = pftASM) and projectFile.AssembleFile then
        if not AssembleFile(projectFile, project) then
          exit;
      if (projectFile.ProjectFileType = pftRC) and projectFile.AssembleFile then
        if not ResourceCompileFile(projectFile, project) then
          exit;
    end;
  end else begin
    GPGExecute('cmd /c'+project.AssembleEventCommandLine,consoleOutput,errors);
    consoleOutput := trim(consoleOutput);
    frmMain.memOutput.Lines.Add(consoleOutput);
  end;

  if useActiveProject then
    ExecuteCommandLines(FGroup.ActiveProject.PostAssembleEventCommandLine)
  else begin
    if project <> nil then
      ExecuteCommandLines(project.PostAssembleEventCommandLine);
  end;
end;

procedure Tdm.LinkProject(project: TProject);
var
  cmdLine: string;
  outputFile: string;
  consoleOutput: string;
  finalFile: string;
  errors: string;
  switchesFile: string;
  switchesContent: TStringList;
  shortPath: string;
begin
  ExecuteCommandLines(project.PreLinkEventCommandLine);

//  frmMain.memOutput.Lines.Add('Linking '+project.Name);

  shortPath := ExtractShortPathName(ExtractFilePath(project.FileName));
  finalFile := shortPath+project.Name;

//  finalFile := ExtractFilePath(project.FileName)+project.Name;

  if project.LinkEventCommandLine = '' then
  begin
    case project.ProjectType of
      ptWin32: cmdLine := ' ""'+FVisualMASMOptions.ML32.Linker32Bit.FoundFileName+'"';
      ptWin64: cmdLine := ' ""'+FVisualMASMOptions.ML64.Linker32Bit.FoundFileName+'"';
      ptWin32DLL: ;
      ptWin64DLL: ;
      ptDos16COM: cmdLine := ' "'+FVisualMASMOptions.ML16.Linker16Bit.FoundFileName+'"';
      ptDos16EXE: cmdLine := ' "'+FVisualMASMOptions.ML16.Linker16Bit.FoundFileName+'"';
      ptWin16: ;
      ptWin16DLL: ;
    end;
    switchesFile := CreateLinkerSwitchesCommandFile(project, finalFile);
    case project.ProjectType of
      ptWin32: cmdLine := cmdLine + ' @"' + switchesFile + '" @"' + CreateLinkCommandFile(project)+'"';
      ptWin64: cmdLine := cmdLine + ' @"' + switchesFile + '" @"' + CreateLinkCommandFile(project)+'"';
      ptWin32DLL: ;
      ptWin64DLL: ;
      ptDos16COM:
        begin
          switchesContent := TStringList.Create;
          switchesContent.LoadFromFile(switchesFile);
          cmdLine := cmdLine + ' ' +
            StringReplace(switchesContent.Text, #13#10, ' ', [rfReplaceAll]) + ' @'+
              CreateLinkCommandFile(project);
        end;
      ptDos16EXE:
        begin
          switchesContent := TStringList.Create;
          switchesContent.LoadFromFile(switchesFile);
          cmdLine := cmdLine + ' ' +
            StringReplace(switchesContent.Text, #13#10, ' ', [rfReplaceAll]) + ' @'+
              CreateLinkCommandFile(project);
        end;
      ptWin16: ;
      ptWin16DLL: ;
    end;
  end else begin
    cmdLine := project.LinkEventCommandLine;
  end;

  GPGExecute('cmd /c'+cmdLine,consoleOutput,errors);
  if errors <> '' then
  begin
    frmMain.memOutput.Lines.Add(errors);
//    frmMain.memOutput.Lines.Add('Command line used:');
    frmMain.memOutput.Lines.Add(cmdLine);
  end;

  consoleOutput := trim(consoleOutput);
  frmMain.memOutput.Lines.Add(consoleOutput);

  if FileExists(finalFile) then
    frmMain.memOutput.Lines.Add('Created '+finalFile+' ('+inttostr(FileSize(finalFile))+' bytes)');

  CleanupFiles(project);

  //ShellExecute(Application.Handle, 'open', PChar(project.PostLinkEventCommandLine), nil, nil, SW_SHOWNORMAL);
  //ExecuteCommandLines(project.PostLinkEventCommandLine);
end;

procedure Tdm.ExecuteCommandLines(executeStrings: string);
var
  commadLines: TStringList;
  i: integer;
  consoleOutput: string;
  errors: string;
begin
  if trim(executeStrings) <> '' then
  begin
    commadLines := TStringList.Create;
    commadLines.Text := executeStrings;
    for i:=0 to commadLines.Count-1 do
    begin
      GPGExecute('cmd /c'+commadLines[i],consoleOutput,errors);
      consoleOutput := trim(consoleOutput);
      frmMain.memOutput.Lines.Add(consoleOutput);
    end;
  end;
end;

function Tdm.AssembleFile(projectFile: TProjectFile; project: TProject): boolean;
var
  cmdLine: string;
  outputFile: string;
  consoleOutput: string;
  finalFile: string;
  errors: string;
  shortPath: string;
begin
  result := false;
  ClearAssemblyErrors(projectFile);

//  outputFile := ExtractFilePath(projectFile.FileName) +
//    ChangeFileExt(ExtractFileName(projectFile.FileName), '') + '.obj';
  shortPath := ExtractShortPathName(ExtractFilePath(projectFile.FileName));
  outputFile := shortPath+ChangeFileExt(ExtractFileName(projectFile.FileName), '') + '.obj';

  frmMain.memOutput.Lines.Add('Assembling '+ExtractFilePath(projectFile.FileName));

  if TFile.Exists(outputFile) then
    TFile.Delete(outputFile);

  case project.ProjectType of
    ptWin32: cmdLine := ' ""'+FVisualMASMOptions.ML32.FoundFileName+'" /Fo '+outputFile+
      ' /c /coff "'+projectFile.FileName+'"';
    ptWin64: cmdLine := ' ""'+FVisualMASMOptions.ML64.FoundFileName+'" /Fo '+outputFile+
      ' /c "'+projectFile.FileName+'"';
    ptWin32DLL: ;
    ptWin64DLL: ;
    ptDos16COM: cmdLine := ' "'+FVisualMASMOptions.ML32.FoundFileName+'" /c /AT /Fo'+outputFile+
      ' '+ExtractShortPathName(projectFile.FileName);
    ptDos16EXE: cmdLine := ' "'+FVisualMASMOptions.ML32.FoundFileName+'" /c /Fo'+outputFile+
      ' '+ExtractShortPathName(projectFile.FileName);
    ptWin16: ;
    ptWin16DLL: ;
  end;

  errors := '';
  GPGExecute('cmd /c'+cmdLine,consoleOutput,errors);
  if errors <> '' then
  begin
    frmMain.memOutput.Lines.Add(errors);
//    frmMain.memOutput.Lines.Add('Command line used:');
    frmMain.memOutput.Lines.Add(cmdLine);
  end;
  consoleOutput := trim(consoleOutput);
  frmMain.memOutput.Lines.Add(consoleOutput);

  if FileExists(outputFile) then
    frmMain.memOutput.Lines.Add('Created '+outputFile+' ('+inttostr(FileSize(outputFile))+' bytes)');

  result := ParseAssemblyOutput(consoleOutput,projectFile);
  PositionCursorToFirstError(projectFile);
end;

function Tdm.ResourceCompileFile(projectFile: TProjectFile; project: TProject): boolean;
var
  cmdLine: string;
  outputFile: string;
  consoleOutput: string;
  finalFile: string;
  errors: string;
  shortPath: string;
begin
  result := false;
  ClearAssemblyErrors(projectFile);

  shortPath := ExtractShortPathName(ExtractFilePath(projectFile.FileName));
  outputFile := shortPath+ChangeFileExt(ExtractFileName(projectFile.FileName), '') + '.res';

  frmMain.memOutput.Lines.Add('Compiling resource '+projectFile.FileName);

  if TFile.Exists(outputFile) then
    TFile.Delete(outputFile);

  CheckEnvironmentVariable;

  case project.ProjectType of
    ptWin32:
      begin
        if FVisualMASMOptions.MSSDKIncludePath <> '' then
          cmdLine := ' "'+FVisualMASMOptions.ML32.RC.FoundFileName+' /V /i "'+FVisualMASMOptions.MSSDKIncludePath+
            '" "'+projectFile.FileName+'"'
        else
          cmdLine := ' "'+FVisualMASMOptions.ML32.RC.FoundFileName+' /V "'+projectFile.FileName+'"';
      end;
    ptWin64:
      begin
        if FVisualMASMOptions.MSSDKIncludePath <> '' then
          cmdLine := ' "'+FVisualMASMOptions.ML64.RC.FoundFileName+' /V /i "'+FVisualMASMOptions.MSSDKIncludePath+
            '" "'+projectFile.FileName+'"'
        else
          cmdLine := ' "'+FVisualMASMOptions.ML64.RC.FoundFileName+' /V "'+projectFile.FileName+'"';
      end;
    ptWin32DLL: ;
    ptWin64DLL: ;
    ptDos16COM: ;
    ptDos16EXE: ;
    ptWin16: ;
    ptWin16DLL: ;
  end;

  errors := '';
  GPGExecute('cmd /c'+cmdLine,consoleOutput,errors);
  if errors <> '' then
  begin
    frmMain.memOutput.Lines.Add(errors);
    frmMain.memOutput.Lines.Add(cmdLine);
  end;
  consoleOutput := trim(consoleOutput);
  frmMain.memOutput.Lines.Add(consoleOutput);

  if FileExists(outputFile) then
    frmMain.memOutput.Lines.Add('Created '+outputFile+' ('+inttostr(FileSize(outputFile))+' bytes)');

  result := ParseAssemblyOutput(consoleOutput,projectFile);
  PositionCursorToFirstError(projectFile);
end;

procedure Tdm.CheckEnvironmentVariable;
var
  include: string;
begin
  include := GetEnvVarValue('INCLUDE');
  if include = '' then
  begin
    if DirectoryExists(WIN_KIT_81_PATH) then
      SetEnvVarValue('INCLUDE',WIN_KIT_81_PATH)
    else if DirectoryExists(WIN_KIT_10_PATH) then
      SetEnvVarValue('INCLUDE',WIN_KIT_10_PATH)
    else if DirectoryExists(VS_14_PATH) then
      SetEnvVarValue('INCLUDE',VS_14_PATH)
  end;
end;

procedure Tdm.PositionCursorToFirstError(projectFile: TProjectFile);
var
  memo: TSynMemo;
  i: integer;
  lineNumber: integer;
begin
  memo := GetSynMemoFromProjectFile(projectFile);
  if memo = nil then exit;
  for i:= 0 to projectFile.AssemblyErrors.Count-1 do
  begin
    if projectFile.FileName = TAssemblyError(projectFile.AssemblyErrors.Objects[i]).FileName then
    begin
      lineNumber := TAssemblyError(projectFile.AssemblyErrors.Objects[i]).LineNumber;
      if lineNumber > 0 then
      begin
        memo.GotoLineAndCenter(lineNumber);
        exit;
      end;
    end;
  end;
end;

function Tdm.ParseAssemblyOutput(output: string; projectFile: TProjectFile): boolean;
var
  i: integer;
  o: TStringList;
  assemblyError: TAssemblyError;
  lineNoPos: integer;
  errorPos: integer;
begin
  o := TStringList.Create;
  o.Text := output;
  result := true;
  projectFile.AssemblyErrors.Clear;

  // C:\masm32\examples\exampl01\minimum\minimum2.asm(23) : error A2046: missing single or double quotation mark in string
  // C:\masm32\examples\exampl01\minimum\minimum2.asm(28) : error A2006: undefined symbol : szDlgTitle

  for i:=0 to o.Count-1 do
  begin
    errorPos := pos(' : error ',o[i]);
    if errorPos>0 then
    begin
      FWeHaveAssemblyErrors := true;
      result := false;
      assemblyError := TAssemblyError.Create;
      lineNoPos := pos('(',o[i]);
      assemblyError.FileName := leftstr(o[i],lineNoPos-1);
      assemblyError.LineNumber := strtoint(copy(o[i],lineNoPos+1,pos(')',o[i])-lineNoPos-1));
      assemblyError.Description := copy(o[i],errorPos+9,256);
      projectFile.AssemblyErrors.AddObject(inttostr(assemblyError.LineNumber), assemblyError);
    end;
  end;
  projectFile.AssemblyErrors.Sort;
end;

procedure Tdm.ClearAssemblyErrors(projectFile: TProjectFile);
var
  i: integer;
  pf: TProjectFile;
  gotMilk: boolean;
begin
  if projectFile.ProjectFileType <> pftASM then exit;

  for i:= 0 to FDebugSupportPlugins.Count-1 do
  begin
    pf := FDebugSupportPlugins.Items[i].ProjectFile;
    if (pf <> nil) and (pf is TProjectFile) and Assigned(pf) then
    begin
      if (projectFile<>nil) then
      begin
        if pf.Id = projectFile.Id then
        begin
          pf.AssemblyErrors.Clear;
          break;
        end;
      end;
    end;
  end;

  // Check if we still have any assembly errors
  gotMilk := false;
  for i:= 0 to FDebugSupportPlugins.Count-1 do
  begin
    pf := FDebugSupportPlugins.Items[i].ProjectFile;
    if (pf <> nil) then begin
      if (pf.AssemblyErrors.Count > 0) then
      begin
        gotMilk := true;
        break;
      end;
    end;
  end;

  FWeHaveAssemblyErrors := gotMilk;
end;

procedure Tdm.actProjectMakeActiveProjectExecute(Sender: TObject);
var
  data: PProjectData;
begin
  data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
  if data.Level = 1 then
  begin
    FGroup.ActiveProject := FGroup[data.ProjectId];
    SynchronizeProjectManagerWithGroup;
    UpdateUI(true);
  end;
end;

procedure Tdm.actProjectOptionsExecute(Sender: TObject);
var
  project: TProject;
begin
  if FGroup.ActiveProject = nil then exit;
  project := GetCurrentProjectInProjectExplorer;
  if project = nil then exit;
  frmProjectOptions.Project := project;
  frmProjectOptions.Caption := project.Name + ' Project Options';
  frmProjectOptions.ShowModal;
end;

procedure Tdm.actProjectRenameExecute(Sender: TObject);
var
  extPos: integer;
  newName: string;
  project: TProject;
begin
  project := GetCurrentProjectInProjectExplorer;
  if project = nil then exit;
  frmRename.CurrentName := project.Name;
  frmRename.NewName := project.Name;

  if frmRename.ShowModal = mrOk then
  begin
    project.Name := frmRename.txtNewName.Text;
    project.Modified := true;
    SetProjectName(project);
    SynchronizeProjectManagerWithGroup;
    UpdateUI(true);
  end;
end;

procedure Tdm.actProjectRunExecute(Sender: TObject);
begin
  RunProject(true);
end;

procedure Tdm.RunProject(useActiveProject: boolean = true);
var
  finalFile: string;
  project: TProject;
  i: integer;
begin
  project := GetCurrentProjectInProjectExplorer;

  if FGroup.ActiveProject = nil then begin
    ShowMessage('No project has been created, yet.'+CRLF+CRLF+
      'Create a project and add your file(s) to the project, then assemble it.');
    exit;
  end;

  frmMain.memOutput.Clear;

  if useActiveProject then
    finalFile := ExtractFilePath(FGroup.ActiveProject.FileName)+FGroup.ActiveProject.Name
  else
    finalFile := ExtractFilePath(project.FileName)+project.Name;

  if FileExists(finalFile) then
    TFile.Delete(finalFile);

  if useActiveProject then
  begin
    SaveProject(FGroup.ActiveProject);
    AssembleProject(FGroup.ActiveProject, true);
    LinkProject(FGroup.ActiveProject);
  end else begin
    SaveProject(project);
    AssembleProject(project, false);
    LinkProject(project);
  end;

  if FileExists(finalFile) then
  begin
//    frmMain.memOutput.Lines.Add('Running '+finalFile);
    ShellExecute(Application.Handle, 'open', PChar(finalFile), nil, nil, SW_SHOWNORMAL);
  end;

  //HighlightNodeBasedOnActiveTab;
  FocusTabWithAssemblyErrors;
end;

procedure Tdm.actProjectSaveAsExecute(Sender: TObject);
var
  fileName: string;
  project: TProject;
begin
  project := GetCurrentProjectInProjectExplorer;
  if project = nil then exit;
  fileName := PromptForProjectFileName(project);
  if length(fileName)>0 then
    SaveProject(project, fileName);
end;

procedure Tdm.actProjectSaveExecute(Sender: TObject);
begin
  SaveProject(FGroup.ActiveProject, FGroup.ActiveProject.FileName);
end;

procedure Tdm.SetProjectName(project: TProject; name: string = '');
var
  extPos: integer;
  newName: string;
  nameToProcess: string;
begin
  if name <> '' then
    nameToProcess := name
  else
    nameToProcess := project.Name;

  // Check if the new name has a . (an extension) included
  extPos := pos('.',nameToProcess);
  if extPos > 0 then
  begin
    // Get name up to the extension part
    newName := copy(nameToProcess, 0, extPos-1);
    newName := ExtractFilePath(project.FileName) + newName + PROJECT_FILE_EXT;
    if FileExists(project.FileName) then
      RenameFile(project.FileName,newName);
    project.FileName := newName;

    // Set name based on project type
    newName := copy(nameToProcess, 0, extPos-1);
    case project.ProjectType of
      ptWin32: newName := newName + '.exe';
      ptWin64: newName := newName + '.exe';
      ptWin32DLL: newName := newName + '.dll';
      ptWin64DLL: newName := newName + '.dll';
      ptDos16COM: newName := newName + '.com';
      ptDos16EXE: newName := newName + '.exe';
      ptWin16: newName := newName + '.exe';
      ptWin16DLL: newName := newName + '.dll';
    end;
    project.Name := newName;
    FGroup.Modified := true;
  end;
end;

procedure Tdm.actReadOnlyExecute(Sender: TObject);
var
  designer: TzFormDesigner;
  inspector: TObjectInspectorFrame;
begin
  designer := GetFormDesigner;
  inspector := GetObjectInspector;
  if designer <> nil then
  begin
    designer.ReadOnly := not designer.ReadOnly;
    inspector.ReadOnly := designer.ReadOnly;
  end;
end;

procedure Tdm.actReadOnlyUpdate(Sender: TObject);
var
  designer: TzFormDesigner;
begin
  designer := GetFormDesigner;
  if designer <> nil then
  begin
    actReadOnly.Enabled := designer <> nil;
    if actReadOnly.Enabled then
      actReadOnly.Checked := designer.ReadOnly;
  end;
end;

procedure Tdm.actRemoveFromProjectExecute(Sender: TObject);
var
  data: PProjectData;
begin
  data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
  RemoveTabsheet(FGroup[data.ProjectId].ProjectFile[data.FileId]);
  if (data.Level = 2) or (data.Level = 3) then
  begin
    FGroup[data.ProjectId].DeleteProjectFile(data.FileId);
    FGroup[data.ProjectId].Modified := true;
  end;
  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

procedure Tdm.RemoveTabsheet(projectFile: TProjectFile);
var
  x: Integer;
begin
  with frmMain.sPageControl1 do
    for x := 0 to PageCount-1 do
    begin
      //if (Pages[x].Caption = projectFile.Name) or (Pages[x].Caption = (MODIFIED_CHAR+projectFile.Name)) then
      if Pages[x].Tag = projectFile.IntId then
      begin
        Pages[x].Free;
        break;
      end;
    end;
end;

procedure Tdm.actReopenFileExecute(Sender: TObject);
var
  f: TVisualMASMFile;
begin
  actFileCloseAllExecute(self);
  f := TFileAction(Sender).VisualMASMFile;
  OpenGroupOrProject(f.FileName, true);
end;

procedure Tdm.actSaveExecute(Sender: TObject);
var
  data: PProjectData;
begin
  data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
  if data=nil then exit;
  if (data.Level = 2) or (data.Level = 3) then
    SaveFileContent(FGroup.Projects[data.ProjectId].ProjectFile[data.FileId]);
end;

procedure Tdm.actSearchAgainExecute(Sender: TObject);
var
  projectFile: TProjectFile;
  memo: TSynMemo;
begin
  if length(gsSearchText)=0  then
  begin
    ShowSearchReplaceDialog(false);
    exit;
  end;
  //projectFile := GetCurrentFileInProjectExplorer;
  memo := GetSynMemoFromProjectFile(FGroup.ActiveProject.ActiveFile);
  if memo = nil then exit;
  DoSearchReplaceText(false,false,memo);
end;

procedure Tdm.actSearchFindExecute(Sender: TObject);
begin
  ShowSearchReplaceDialog(false);
end;

procedure Tdm.actSearchGoToFunctionExecute(Sender: TObject);
var
  node: PVirtualNode;
  data: PFunctionData;
begin
  if ShuttingDown then exit;
  try
    node := frmMain.vstFunctions.GetFirst;
    while Assigned(node) do
    begin
      data := frmMain.vstFunctions.GetNodeData(node);
      if frmMain.vstFunctions.Selected[node] then
      begin
        GoToFunctionOnLine(data.Line);
        exit;
      end;
      node := frmMain.vstFunctions.GetNext(node);
    end;
  finally

  end;
end;

procedure Tdm.actSearchGoToLabelExecute(Sender: TObject);
var
  node: PVirtualNode;
  data: PLabelData;
begin
  if ShuttingDown then exit;
  try
    node := frmMain.vstLabels.GetFirst;
    while Assigned(node) do
    begin
      data := frmMain.vstLabels.GetNodeData(node);
      if frmMain.vstLabels.Selected[node] then
      begin
        GoToFunctionOnLine(data.Line);
        exit;
      end;
      node := frmMain.vstLabels.GetNext(node);
    end;
  finally

  end;
end;

procedure Tdm.actSearchPreviousExecute(Sender: TObject);
var
  projectFile: TProjectFile;
  memo: TSynMemo;
begin
  //projectFile := GetCurrentFileInProjectExplorer;
  memo := GetSynMemoFromProjectFile(FGroup.ActiveProject.ActiveFile);
  if memo = nil then exit;
  DoSearchReplaceText(false,true,memo);
end;

procedure Tdm.actSearchReplaceExecute(Sender: TObject);
begin
  ShowSearchReplaceDialog(true);
end;

procedure Tdm.ShowSearchReplaceDialog(AReplace: boolean);
var
  dlg: TTextSearchDialog;
  projectFile: TProjectFile;
  memo: TSynMemo;
begin
  HideWelcomePage;
  projectFile := GetCurrentFileInProjectExplorer;
  memo := GetSynMemoFromProjectFile(projectFile);
  if memo = nil then exit;
  UpdateStatusBarForMemo(memo, '');
  if AReplace then
    dlg := TTextReplaceDialog.Create(Self)
  else
    dlg := TTextSearchDialog.Create(Self);
  with dlg do try
    // assign search options
    SearchBackwards := gbSearchBackwards;
    SearchCaseSensitive := gbSearchCaseSensitive;
    SearchFromCursor := gbSearchFromCaret;
    SearchInSelectionOnly := gbSearchSelectionOnly;
    // start with last search text
    SearchText := gsSearchText;
//    if gbSearchTextAtCaret then begin
      // if something is selected search for that text
      if memo.SelAvail and (memo.BlockBegin.Line = memo.BlockEnd.Line)
      then
        SearchText := memo.SelText
      else
        SearchText := memo.GetWordAtRowCol(memo.CaretXY);
//    end;
    SearchTextHistory := gsSearchTextHistory;
    if AReplace then with dlg as TTextReplaceDialog do begin
      ReplaceText := gsReplaceText;
      ReplaceTextHistory := gsReplaceTextHistory;
    end;
    SearchWholeWords := gbSearchWholeWords;
    if ShowModal = mrOK then begin
      gbSearchBackwards := SearchBackwards;
      gbSearchCaseSensitive := SearchCaseSensitive;
      gbSearchFromCaret := SearchFromCursor;
      gbSearchSelectionOnly := SearchInSelectionOnly;
      gbSearchWholeWords := SearchWholeWords;
      gbSearchRegex := SearchRegularExpression;
      gsSearchText := SearchText;
      gsSearchTextHistory := SearchTextHistory;
      if AReplace then with dlg as TTextReplaceDialog do begin
        gsReplaceText := ReplaceText;
        gsReplaceTextHistory := ReplaceTextHistory;
      end;
      FSearchFromCaret := gbSearchFromCaret;
      if gsSearchText <> '' then begin
        DoSearchReplaceText(AReplace, gbSearchBackwards, memo);
        fSearchFromCaret := TRUE;
      end;
    end;
  finally
    dlg.Free;
  end;
end;

procedure Tdm.DoSearchReplaceText(AReplace: boolean; ABackwards: boolean; memo: TSynMemo);
var
  Options: TSynSearchOptions;
begin
  UpdateStatusBarForMemo(memo, '');
  if AReplace then
    Options := [ssoPrompt, ssoReplace, ssoReplaceAll]
  else
    Options := [];
  if ABackwards then
    Include(Options, ssoBackwards);
  if gbSearchCaseSensitive then
    Include(Options, ssoMatchCase);
  if not fSearchFromCaret then
    Include(Options, ssoEntireScope);
  if gbSearchSelectionOnly then
    Include(Options, ssoSelectedOnly);
  if gbSearchWholeWords then
    Include(Options, ssoWholeWord);
  if gbSearchRegex then
    memo.SearchEngine := SynEditRegexSearch1
  else
    memo.SearchEngine := SynEditSearch1;
  if memo.SearchReplace(gsSearchText, gsReplaceText, Options) = 0 then
  begin
    MessageBeep(MB_ICONASTERISK);
    UpdateStatusBarForMemo(memo, gsSearchText+' not found');
    if ssoBackwards in Options then
      memo.BlockEnd := memo.BlockBegin
    else
      memo.BlockBegin := memo.BlockEnd;
    memo.CaretXY := memo.BlockBegin;
  end;

  if ConfirmReplaceDialog <> nil then
    ConfirmReplaceDialog.Free;
end;

procedure Tdm.actShowInExplorerExecute(Sender: TObject);
var
  data: PProjectData;
  fileName: string;
begin
  data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
  if data=nil then exit;

  if data.Level = 0 then
    fileName := FGroup.FileName;
  if data.Level = 1 then
    fileName := FGroup[data.ProjectId].FileName;
  if (data.Level = 2) or (data.Level = 3) then
    fileName := FGroup.ProjectById[data.ProjectId].ProjectFile[data.FileId].Path+
      FGroup.ProjectById[data.ProjectId].ProjectFile[data.FileId].Name;
  if TFile.Exists(fileName) then
    ShellExecute(Application.Handle, 'open', 'explorer.exe',
      PChar('/select,"'+fileName+'"'), nil, SW_NORMAL)
  else
    ShellExecute(Application.Handle, 'open', 'explorer.exe',
      PChar(ExtractFilePath(fileName)+'"'), nil, SW_NORMAL);
end;

procedure Tdm.actToggleDialogAssemblyExecute(Sender: TObject);
var
  projectFile: TProjectFile;
begin
  if (FGroup.ActiveProject.ActiveFile.ChildFileASMId <> '') then
  begin
    projectFile := FGroup.GetProjectFileById(FGroup.ActiveProject.ActiveFile.ChildFileASMId);
    FocusPage(projectFile);
  end else if (FGroup.ActiveProject.ActiveFile.ParentFileId <> '') then
  begin
    projectFile := FGroup.GetProjectFileById(FGroup.ActiveProject.ActiveFile.ParentFileId);
    FocusPage(projectFile);
  end;
end;

procedure Tdm.actToggleDialogAssemblyUpdate(Sender: TObject);
begin
  UpdateToggleUI;
end;

//procedure Tdm.actViewIncreaseFontSizeExecute(Sender: TObject);
//var
//  memp: TSynMemo;
//begin
//  memp := GetMemo;
//  memp.Font.Size := memp.Font.Size + 1;
//end;

procedure Tdm.UpdateToggleUI;
begin
  if (FGroup.ActiveProject.ActiveFile.ChildFileASMId <> '') or
    (FGroup.ActiveProject.ActiveFile.ParentFileId <> '') then
  begin
    actToggleDialogAssembly.Enabled := true;
  end else begin
    actToggleDialogAssembly.Enabled := false;
  end;
end;

procedure Tdm.CreateStatusBar;
var
  statusPanel: TStatusPanel;
begin
  FStatusBar := TsStatusBar.Create(frmMain.sPageControl1);
  FStatusBar.Parent := frmMain.sPageControl1;
  FStatusBar.Align := alBottom;
  FStatusBar.SizeGrip := false;
  FStatusBar.Height := 19;
  FStatusBar.AutoHint := true;   // Show hint from menus like the short-cuts
  FStatusBar.OnHint := StatusBarHintHandler;
  // Cursor position
  statusPanel := FStatusBar.Panels.Add;
  statusPanel.Width := 70;
  statusPanel.Alignment := taCenter;
  // MODIFIED status
  statusPanel := FStatusBar.Panels.Add;
  statusPanel.Width := 70;
  statusPanel.Alignment := taCenter;
  // INSERT status
  statusPanel := FStatusBar.Panels.Add;
  statusPanel.Width := 70;
  statusPanel.Alignment := taCenter;
  statusPanel.Text := 'Insert';
  // Line count
  statusPanel := FStatusBar.Panels.Add;
  statusPanel.Width := 130;
  statusPanel.Alignment := taLeftJustify;
  // Regular text
  statusPanel := FStatusBar.Panels.Add;
  statusPanel.Width := 70;
  statusPanel.Alignment := taLeftJustify;
end;

procedure Tdm.CreateEditor(projectFile: TProjectFile);
var
  tabSheet: TsTabSheet;
  doc: ISynDocument;
  sl: TStringList;
  memo: TSynMemo;
  form: TForm;
  frame: TfraDesign;
  box: TsScrollBox;
//  rcFile: TProjectFile;
begin
  if FStatusBar = nil then
    CreateStatusBar;
  tabSheet := CreateTabSheet(projectFile);

  if projectFile.ProjectFileType=pftDLG then
  begin
    if FileExists(projectFile.FileName) then begin
      LoadDialog(projectFile, tabSheet);
    end else begin
      form := TForm.Create(tabSheet);
      form.Tag := 256;
      form.Parent := tabSheet;
      form.ControlStyle := form.ControlStyle + [csDisplayDragImage];
      form.Caption := tabSheet.Caption;
      if length(projectFile.FileName)>1 then
        form.Name := TPath.GetFilenameWithoutExtension(projectFile.FileName);
      form.Position := poScreenCenter;

      //frame := BindRoot(form, tabSheet);
      frame := TfraDesign.Create(tabSheet);
//      frame.SetProjectFile(projectFile);
//      rcFile := dm.Group.GetProjectFileById(projectFile.ChildFileId);
//      frame.SetRCFile(rcFile);
//      frame.ProjectFile := projectFile;
//      frame.RCFile := dm.Group.GetProjectFileById(projectFile.ChildFileId);
      frame.Parent := tabSheet;
      frame.Align := alClient;
      frame.ObjectInspectorFrame1.PropertyList.OnAcceptProperty := DoAcceptProperty;
      frame.ObjectInspectorFrame1.PageControl1.ActivePageIndex := 0;
      frame.FormDesigner.Target := form;

      frame.FormDesigner.Active := True;
    end;
  end else begin
    memo := CreateMemo(projectFile);
    memo.Parent := tabSheet;
    memo.Text := projectFile.Content;

    case projectFile.ProjectFileType of
      pftASM,pftINC: memo.Highlighter := synASMMASM;
      pftRC: memo.Highlighter := synRC;
      pftTXT: memo.Highlighter := nil;
      pftDLG: ;
      pftBAT: memo.Highlighter := synBat;
      pftINI: memo.Highlighter := synINI;
      pftCPP: memo.Highlighter := synCPP;
    end;
  end;

  TScanKeywordThread(FWorkerThread).SetModified;
  frmMain.sPageControl1.ActivePage := tabSheet;
//  UpdatePageCaption(projectFile);

  if projectFile.ProjectFileType<>pftDLG then
    UpdateStatusBarForMemo(memo);
end;

procedure Tdm.LoadDialog(projectFile: TProjectFile; tabSheet: TsTabSheet);
var
  fm : TForm;
  st: TStringList;
  frame: TfraDesign;
  i: Integer;
  rcFile: TProjectFile;
begin
  FIgnoreAll := false;
  fm := TForm.Create(tabSheet);
  fm.Tag := 256;
  fm.Parent := tabSheet;
  fm.Caption := tabSheet.Caption;
  fm.Name := TPath.GetFilenameWithoutExtension(projectFile.FileName);
  st := TStringList.Create;
  try
    zReadCmpFromFile(projectFile.FileName, fm, ReadError, ReaderCreateComponent,  st);
  except
    st.Free;
    fm.Free;
    Exit;
  end;

  //frame := BindRoot(fm,tabSheet);
  frame := TfraDesign.Create(tabSheet);
//  frame.SetProjectFile(projectFile);
//  rcFile := dm.Group.GetProjectFileById(projectFile.ChildFileId);
//  frame.SetRCFile(rcFile);
//  frame.ProjectFile := projectFile;
//  frame.RCFile := dm.Group.GetProjectFileById(projectFile.ChildFileId);
  frame.Parent := tabSheet;
  frame.Align := alClient;
  frame.ObjectInspectorFrame1.PropertyList.OnAcceptProperty := DoAcceptProperty;
  frame.ObjectInspectorFrame1.PageControl1.ActivePageIndex := 0;
  frame.FormDesigner.Target := fm;

  frame.FormDesigner.Events := st;
  frame.FormDesigner.Active := True;
  projectFile.Modified := false;
  st.Free;
end;

function Tdm.BindRoot(Form: TComponent; tabSheet: TsTabSheet): TfraDesign;
begin
  result := TfraDesign.Create(tabSheet);
  result.Parent := tabSheet;
  result.Align := alClient;
  result.ObjectInspectorFrame1.PropertyList.OnAcceptProperty := DoAcceptProperty;
  result.ObjectInspectorFrame1.PageControl1.ActivePageIndex := 0;
  result.FormDesigner.Target := form;
  result.FormDesigner.Active := True;
end;

procedure Tdm.DoAcceptProperty(const PropEdit: IProperty; var PropName: WideString; var Accept: Boolean);
begin
  //if PropEdit.GetName = 'Anchors' then
  if (PropName = 'Anchors') or (PropName = 'Action') then
    Accept := false;
  if PropEdit.GetName = 'ActiveControl' then
    Accept := false;
  if PropEdit.GetName = 'OnActivate' then
    Accept := false;
end;

procedure Tdm.ReadError(Reader: TReader; const Message: string; var Handled: Boolean);
begin
  Handled := FIgnoreAll;
  if not Handled then
   case MessageDlg(Message + sLineBreak + 'Ignore this error?', mtError, [mbYes, mbNo, mbAll], 0) of
     mrYes: Handled := True;
     mrAll: begin
              Handled := True;
              FIgnoreAll := True;
            end;
   end;
end;

type
  TComponentAccess = class(TComponent);

procedure Tdm.ReaderCreateComponent(Reader: TReader; ComponentClass: TComponentClass; var Component: TComponent);
var
  b: boolean;
begin
  b := SameText(ComponentClass.ClassName, 'TcxGrid');
  if b then TComponentAccess(Reader.Root).SetDesigning(True, False);
  Component := ComponentClass.Create(Reader.Root);
  if b then TComponentAccess(Reader.Root).SetDesigning(False, False);
end;

function Tdm.CreateTabSheet(projectFile: TProjectFile): TsTabSheet;
var
  tabSheet: TsTabSheet;
begin
  tabSheet := TsTabSheet.Create(frmMain.sPageControl1);
  tabSheet.Caption := projectFile.Name;
  if projectFile.Modified then
    tabSheet.Caption := MODIFIED_CHAR+tabSheet.Caption;
  tabSheet.Tag := projectFile.IntId;
  tabSheet.PageControl := frmMain.sPageControl1;
  tabSheet.TabMenu := frmMain.popTabs;
  projectFile.IsOpen := true;
  tabSheet.Hint := projectFile.Path;
  //tabSheet.ShowHint := true;
  result := tabSheet;
end;

function Tdm.CreateMemo(projectFile: TProjectFile): TSynMemo;
var
  memo: TSynMemo;
begin
  memo := TSynMemo.Create(self);
  memo.Align := alClient;
  memo.PopupMenu := frmMain.popMemo;
  memo.TabWidth := 4;
  memo.OnChange := DoOnChangeSynMemo;
  memo.HelpType := htKeyword;
  memo.Highlighter := synASMMASM;
  //memo.ShowHint := true;

  memo.OnMouseWheelDown := DoOnMouseWheelDown;
  memo.OnMouseWheelUp := DoOnMouseWheelUp;
  memo.OnStatusChange := SynEditorStatusChange;
  memo.OnChange := DoChange;
  memo.OnSpecialLineColors := SynEditorSpecialLineColors;
  memo.OnKeyDown := SynMemoKeyDown;
  memo.SearchEngine := SynEditSearch1;
//  memo.OnMouseCursor := SynMemoMouseCursor;
  memo.OnEnter := SynMemoOnEnter;
  memo.OnDblClick := DoSynMemoDblClick;
  memo.OnPaintTransient := DoOnPaintTransient;

  memo.BookMarkOptions.BookmarkImages := ImageList1;
  memo.Gutter.ShowLineNumbers := true;
  memo.Gutter.DigitCount := 5;
  memo.Gutter.Gradient := false;
  memo.WantTabs := true;
  memo.Options := [eoAutoIndent, eoDragDropEditing, eoEnhanceEndKey,
    eoScrollPastEol, eoShowScrollHint,
    //eoSmartTabs, // eoTabsToSpaces,
    eoSmartTabDelete, eoGroupUndo, eoTabIndent];

  SynCompletionProposal1.Editor := memo;
  SynCompletionProposal1.InsertList := FCodeCompletionInsertList;
  SynCompletionProposal1.ItemList := FCodeCompletionList;
  SynAutoComplete1.Editor := memo;

  FDebugSupportPlugins := TList<TDebugSupportPlugin>.Create;
  if projectFile.ProjectFileType = pftASM then
    FDebugSupportPlugins.Add(TDebugSupportPlugin.Create(memo, projectFile));

  AssignColorsToEditor(memo);
  result := memo;
end;

procedure Tdm.SynEditorSpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var FG, BG: TColor);
var
  i: integer;
  //p: TBufferCoord;
  Mark: TSynEditMark;
  memo: TSynMemo;
  intId: integer;
  pf: TProjectFile;
begin
  if FWeHaveAssemblyErrors then
  begin
    intId := TsTabSheet(TSynMemo(Sender).Parent).Tag;
    pf := FGroup.GetProjectFileByIntId(intId);
    for i:=0 to pf.AssemblyErrors.Count-1 do
    begin
      if TAssemblyError(pf.AssemblyErrors.Objects[i]).LineNumber = Line then
      begin
        Special := TRUE;
        FG := clWhite;
        BG := clRed;

//        memo := TSynMemo(Sender);
//        //p := CaretXY;
//        memo.Marks.ClearLine(Line);
//        Mark := TSynEditMark.Create(memo);
//        Mark.Line := Line;
//        //Line := p.Line;
//        //Char := p.Char;
//        Mark.ImageIndex := 11;
//        Mark.Visible := TRUE;
//        Mark.InternalImage := memo.BookMarkOptions.BookMarkImages = nil;
//        memo.Marks.Place(Mark);
      end;
    end;
  end;
end;

procedure Tdm.SynMemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  currentPageIndex: integer;
begin
  UpdateFunctionList(GetMemo);

  //if (ssCtrl in Shift) and ((Key = 59) or (Key = 118)) then
  if (ssCtrl in Shift) and (Key = 186) then  // Ctrl+;
    CommentUncommentLine(TSynMemo(Sender));

  if (ssCtrl in Shift) and (Key = 9) then  // Ctrl+Tab
  begin
    currentPageIndex := frmMain.sPageControl1.ActivePageIndex;
    frmMain.sPageControl1.ActivePageIndex := FLastTabIndex;
    FLastTabIndex := currentPageIndex;
    UpdateUI(true);
  end;

  if Key = VK_CONTROL then
    FPressingCtrl := true
  else
    FPressingCtrl := false;

  if Key = VK_F1 then
  begin
    try
      frmMain.sAlphaHints1.HideHint;
      if (Token = '') or (FAttributes.Name <> 'Api') then exit;
      screen.Cursor := crHourGlass;
      Application.HelpKeyword(Token);
    finally
      screen.Cursor := crArrow;
    end;
  end;
end;

procedure Tdm.SynEditorStatusChange(Sender: TObject; Changes: TSynStatusChanges);
const
  ModifiedStrs: array[boolean] of string = ('', 'Modified');
  InsertModeStrs: array[boolean] of string = ('Overwrite', 'Insert');
var
  p: TBufferCoord;
  Token: UnicodeString;
  Attri: TSynHighlighterAttributes;
  i,x,y: integer;
  tabSheet: TsTabSheet;
  statusBar: TsStatusBar;
  point: TPoint;
  projectFile: TProjectFile;
begin
  // Note: scAll for new file loaded
  // caret position has changed
  if Changes * [scAll, scCaretX, scCaretY] <> [] then begin
    UpdateStatusBarForMemo(TSynMemo(Sender));
//    p := TSynMemo(Sender).CaretXY;
//    //    // Detach OnChange events from spin edits,
//    //    // because re-setting caret position clears selection
//    //    inpCaretX.OnChange := nil;
//    //    inpCaretY.OnChange := nil;
//    //    inpCaretX.Value := p.Char;
//    //    inpCaretY.Value := p.Line;
//    //    // Re-attach OnChange events to spin edits
//    //    inpCaretX.OnChange := inpCaretXChange;
//    //    inpCaretY.OnChange := inpCaretYChange;
//    //    inpLineText.Text := SynEditor.LineText;
//    //    outLineCount.Text := IntToStr(SynEditor.Lines.Count);
//    tabSheet := TsTabSheet(TSynMemo(Sender).Parent);
//    for x := 0 to tabSheet.ControlCount-1 do
//    begin
//      if tabSheet.Controls[x] is TsStatusBar then
//      begin
//        statusBar := TsStatusBar(tabSheet.Controls[x]);
//        statusBar.Panels[0].Text := Format('%6d:%3d', [p.Line, p.Char]);
//        statusBar.Panels[3].Text := Format('Line count: %6d', [TSynMemo(Sender).Lines.Count]);
//        break;
//      end;
//    end;
  end;

  // horz scroll position has changed
//  if Changes * [scAll, scLeftChar] <> [] then
//    inpLeftChar.Value := SynEditor.LeftChar;

  // vert scroll position has changed
//  if Changes * [scAll, scTopLine] <> [] then
//    inpTopLine.Value := SynEditor.TopLine;

  // InsertMode property has changed
  if Changes * [scAll, scInsertMode, scReadOnly] <> [] then
  begin
    // This code is only executed once after the first
    // modifiction by the user
    if TSynMemo(Sender).ReadOnly then
      FStatusBar.Panels[2].Text := 'ReadOnly'
    else
      FStatusBar.Panels[2].Text := InsertModeStrs[TSynMemo(Sender).InsertMode];
  end;

  // Modified property has changed
  if Changes * [scAll, scModified] <> [] then
  begin
    // This code is only executed once after the first
    // modification by the user
    FStatusBar.Panels[1].Text := ModifiedStrs[TSynMemo(Sender).Modified];

    // Mark file modified
    FGroup.ActiveProject.ActiveFile.Modified := true;
    //SynchronizeProjectManagerWithGroup;
    UpdateUI(true);

//    tabSheet := TsTabSheet(TSynMemo(Sender).Parent);
//    for x := 0 to tabSheet.ControlCount-1 do
//    begin
//      if tabSheet.Controls[x] is TsStatusBar then
//      begin
//        statusBar := TsStatusBar(tabSheet.Controls[x]);
//        statusBar.Panels[1].Text := ModifiedStrs[TSynMemo(Sender).Modified];
//
//        // Mark file modified
//        projectFile := FGroup.GetProjectFileByIntId(tabSheet.Tag);
//        projectFile.Modified := true;
//        SynchronizeProjectManagerWithGroup;
//        UpdateUI(true);
//
////        for i := 0 to FGroup.ProjectCount-1 do
////        begin
////          for y := 0 to FGroup.ProjectByIndex[i].ProjectFiles.Count-1 do
////          begin
////            if tabSheet.Tag = FGroup.ProjectByIndex[i].ProjectFile[y].IntId then
////            begin
////              FGroup.ProjectByIndex[i].Modified := true;
////              FGroup.ProjectByIndex[i].ProjectFile[y].Modified := true;
////              if pos(MODIFIED_CHAR,tabSheet.Caption)=0 then
////                tabSheet.Caption := MODIFIED_CHAR+tabSheet.Caption;
////              UpdateProjectExplorer(true);
////              HighlightNode(FGroup.ProjectByIndex[i].ProjectFile[y].IntId);
////              break;
////            end;
////          end;
////        end;
//
//        break;
//      end;
//    end;
  end;

  // selection has changed
//  if Changes * [scAll, scSelection] <> [] then
//    cbExportSelected.Enabled := SynEditor.SelAvail;
//
  // select highlighter attribute at caret
  //if (SynEditor.Highlighter <> nil) and (Changes * [scAll, scCaretX, scCaretY] <> [])
//  if (Changes * [scAll, scCaretX, scCaretY] <> []) then
//  begin
//    if TSynMemo(Sender).GetHighlighterAttriAtRowCol(TSynMemo(Sender).CaretXY, Token, Attri) then
//    begin
//      //Attri := TSynMemo(Sender).Highlighter.WhitespaceAttribute;
//      //Attri := TSynMemo(Sender).Highlighter.GetTokenAttribute;
//      if Assigned(Attri) then begin
//        FAttributes := Attri;
//        FToken := Token;
//
//        if Attri.Name = 'Api' then
//        begin
//          FAttributes := Attri;
//          FToken := Token;
//          //frmMain.ShowHint;
//          point.X := 50;
//          point.Y := 50;
//          point := Mouse.CursorPos;
//          frmMain.sAlphaHints1.ShowHint(point, 'Token: <b>'+Token+'</b>', 30000);
//          frmMain.sAlphaHints1.RepaintHint;
//      cbxAttrSelect.ItemIndex := cbxAttrSelect.Items.IndexOf(Attri.Name);
//      cbxAttrSelectChange(Self);
//        end;
//      end;
//    end else begin
//      frmMain.sAlphaHints1.HideHint;
//    end;
//  end;
end;

procedure Tdm.UpdateStatusBarForMemo(memo: TSynMemo; regularText: string = '');
var
  p: TBufferCoord;
begin
  if (FStatusBar = nil) or (memo = nil) then exit;

  p := memo.CaretXY;
  FStatusBar.Panels[0].Text := Format('%6d:%3d', [p.Line, p.Char]);
  if memo.Modified then
    FStatusBar.Panels[1].Text := 'Modified'
  else
    FStatusBar.Panels[1].Text := '';
  FStatusBar.Panels[3].Text := Format('Line count: %6d', [memo.Lines.Count]);
  if (FGroup.ActiveProject <> nil) and (FGroup.ActiveProject.ActiveFile <> nil) then
    FStatusBar.Panels[4].Text := FGroup.ActiveProject.ActiveFile.FileName
  else
    FStatusBar.Panels[4].Text := regularText;
end;

procedure Tdm.UpdateStatusBarFor(regularText: string = '');
begin
  if (FStatusBar = nil) then exit;
  FStatusBar.Panels[0].Text := '';
  FStatusBar.Panels[1].Text := '';
  FStatusBar.Panels[2].Text := '';
  FStatusBar.Panels[3].Text := '';
  if (FGroup.ActiveProject <> nil) and (FGroup.ActiveProject.ActiveFile <> nil) then
    FStatusBar.Panels[4].Text := FGroup.ActiveProject.ActiveFile.FileName
  else
    FStatusBar.Panels[4].Text := regularText;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  Initialize;
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
  if FWorkerThread <> nil then
    TScanKeywordThread(FWorkerThread).Shutdown;
end;

procedure Tdm.AssignColorsToEditor(memo: TSynMemo);
begin
  synASMMASM.AssignColors(memo);
//  memo.Gutter.Color := synASMMASM.SynColors.Editor.Colors.Background;
//  memo.Gutter.Font.Color := synASMMASM.SynColors.Editor.Colors.RightEdge;
  memo.Gutter.Color := frmMain.sSkinManager1.GetGlobalColor;
  memo.Gutter.Font.Color := frmMain.sSkinManager1.GetGlobalFontColor;
  memo.Gutter.BorderColor := frmMain.sSkinManager1.GetGlobalFontColor;
  memo.Gutter.UseFontStyle := true;

  SynCompletionProposal1.ClBackground := synASMMASM.SynColors.Editor.Colors.CompletionProposalBackground;
  SynCompletionProposal1.ClBackgroundBorder := synASMMASM.SynColors.Editor.Colors.CompletionProposalBackgroundBorder;
  SynCompletionProposal1.ClSelect := synASMMASM.SynColors.Editor.Colors.CompletionProposalSelection;
  SynCompletionProposal1.ClSelectedText := synASMMASM.SynColors.Editor.Colors.CompletionProposalSelectionText;
  SynCompletionProposal1.ClTitleBackground := synASMMASM.SynColors.Editor.Colors.CompletionProposalTitle;
end;

procedure Tdm.CommentUncommentLine(memo: TSynMemo);
var
  p: TBufferCoord;
  i: integer;
  selectedLines: TStringList;
begin
  p := memo.CaretXY;

  // Check for selected text first
  if memo.SelAvail then
  begin
    selectedLines := TStringList.Create;
    selectedLines.Text := memo.SelText;
    for i:=0 to selectedLines.Count-1 do
    begin
      selectedLines.Strings[i] := ProcessCommentText(selectedLines.Strings[i]);
    end;
    memo.SelText := selectedLines.Text;
  end else begin
    memo.LineText := ProcessCommentText(memo.LineText);

    // Move caret down by one line
    if (p.Line+1) <= (memo.Lines.Count) then
      memo.GotoLineAndCenter(p.Line+1);
  end;
end;

function Tdm.ProcessCommentText(text: string): string;
var
  semiPos: integer;
  i: integer;
  firstNormalCharacterPos: integer;
begin
  result := text;
  semiPos := pos(';',text);
  if semiPos > 0 then
  begin
    // Look for first normal character position
    for i:=0 to length(text) do
    begin
      if ((ord(text[i])>32) and (ord(text[i])<127)) then
      begin
        firstNormalCharacterPos := i;
        break;
      end;
    end;
    if firstNormalCharacterPos < semiPos then
      result := ';'+text
    else begin
      //result := StringReplace(text, ';', '', [rfIgnoreCase]);
      //text[semiPos] := leftstr(text,semiPos)+rightstr(
      result := leftstr(text,semiPos-1)+rightstr(text,length(text)-semiPos);
    end;
  end else begin
    // Comment out line
    result := ';'+text;
  end;
end;

procedure Tdm.CloseDocument(index: integer; ProjectFileIntId: integer);
begin
  if frmMain.sPageControl1.PageCount > 1 then
    frmMain.sPageControl1.ActivePageIndex := 0;
  FGroup.GetProjectFileByIntId(ProjectFileIntId).IsOpen := false;
  UpdateUI(true);
end;

function Tdm.GetMemo: TSynMemo;
var
  x: integer;
begin
  result := nil;
  with frmMain.sPageControl1 do
    if PageCount > 0 then
      for x := 0 to ActivePage.ControlCount-1 do
      begin
        if ActivePage.Controls[x] is TSynMemo then
        begin
          result := TSynMemo(ActivePage.Controls[x]);
          exit;
        end;
      end;
end;

function Tdm.GetMemoFromProjectFile(projectFile: TProjectFile): TSynMemo;
var
  i,x: integer;
begin
  result := nil;
  with frmMain.sPageControl1 do
    for i := 0 to PageCount-1 do
    begin
      if Pages[i].Tag = projectFile.IntId then
      begin
        for x := 0 to Pages[i].ControlCount-1 do
        begin
          if Pages[i].Controls[x] is TSynMemo then
          begin
            result := TSynMemo(Pages[i].Controls[x]);
            exit;
          end;
        end;
      end;
    end;
end;

procedure Tdm.UpdateUI(highlightActiveNode: boolean);
var
  memoVisible: boolean;
  dlgVisible: boolean;
  memo: TSynMemo;
begin
  memoVisible := (frmMain.sPageControl1.ActivePage <> nil) and
    ((FGroup.ActiveProject <> nil) and
    (FGroup.ActiveProject.ActiveFile <> nil) and
    (FGroup.ActiveProject.ActiveFile.ProjectFileType <> pftDLG));

  dlgVisible := (frmMain.sPageControl1.ActivePage <> nil) and
    ((FGroup.ActiveProject <> nil) and
    (FGroup.ActiveProject.ActiveFile <> nil) and
    (FGroup.ActiveProject.ActiveFile.ProjectFileType = pftDLG));
  frmMain.mnuDesign.Visible := dlgVisible;

  if FStatusBar <> nil then
    FStatusBar.Visible := memoVisible;

  actAddExistingProject.Enabled := true;

  actEditUndo.Enabled := memoVisible;
  actEditRedo.Enabled := memoVisible;
  actEditCut.Enabled := memoVisible;
  actEditCopy.Enabled := memoVisible;
  actEditPaste.Enabled := memoVisible;
  actEditDelete.Enabled := memoVisible;
  actEditCommentLine.Enabled := memoVisible;
  actEditSelectAll.Enabled := memoVisible;
  actFileCloseAll.Enabled := memoVisible;
  actSearchGoToFunction.Enabled := memoVisible;
  actSearchGoToLabel.Enabled := memoVisible;
  actProjectAssemble.Enabled := memoVisible;
  actProjectOptions.Enabled := memoVisible;
  actEditHighlightWords.Enabled := memoVisible;
  actEditLowerCase.Enabled := memoVisible;
  actEditUpperCase.Enabled := memoVisible;
  actEditCamcelCase.Enabled := memoVisible;

  UpdateToggleUI;

  if ((memoVisible) or (dlgVisible)) and highlightActiveNode then
    HighlightNode(frmMain.sPageControl1.ActivePage.Tag);

  if FGroup.ActiveProject = nil then
  begin
//    actShowInExplorer.Enabled := false;
    actCopyPath.Enabled := false;
    actDOSPromnptHere.Enabled := false;
    actProjectMakeActiveProject.Enabled := false;
//    actGroupSave.Enabled := false;
//    actGroupSaveAs.Enabled := false;
    actSearchAgain.Enabled := false;
    actSearchFind.Enabled := false;
    actSearchPrevious.Enabled := false;
    actSearchReplace.Enabled := false;
    actGoToLineNumber.Enabled := false;
    frmMain.oggleBookmark1.Enabled := false;
    frmMain.G2.Enabled := false;
    actProjectBuild.Enabled := false;
    frmMain.vstFunctions.Clear;
    frmMain.vstLabels.Clear;
  end else begin
//    actAddExistingProject.Enabled := true;
    actShowInExplorer.Enabled := true;
    actCopyPath.Enabled := true;
    actDOSPromnptHere.Enabled := true;
    actProjectMakeActiveProject.Enabled := true;
//    actGroupSave.Enabled := true;
//    actGroupSaveAs.Enabled := false;
    actSearchAgain.Enabled := true;
    actSearchFind.Enabled := true;
    actSearchPrevious.Enabled := true;
    actSearchReplace.Enabled := true;
    actGoToLineNumber.Enabled := true;
    frmMain.oggleBookmark1.Enabled := true;
    frmMain.G2.Enabled := true;
    actProjectBuild.Enabled := true;
  end;

  if (FGroup.ActiveProject <> nil) and memoVisible and
    (FGroup.ActiveProject.ActiveFile <> nil) and
    (FGroup.ActiveProject.ActiveFile.ProjectFileType <> pftDLG) then
  begin
    memo := GetSynMemoFromProjectFile(FGroup.ActiveProject.ActiveFile);
    if memo <> nil then
    begin
      UpdateStatusBarForMemo(memo);
      DoOnChangeSynMemo(memo);
    end;
  end else begin
    dm.Functions.Clear;
    dm.Labels.Clear;
    frmMain.vstLabels.Clear;
    frmMain.vstFunctions.Clear;
    UpdateStatusBarFor('');
  end;
//  if memoVisible and (FGroup.ActiveProject <> nil) and (FGroup.ActiveProject.ActiveFile <> nil) then
//  begin
//    //memo := GetSynMemoFromProjectFile(FGroup.ActiveProject.ActiveFile);
//    FStatusBar.Panels[4].Text := FGroup.ActiveProject.ActiveFile.FileName;
//  end;
end;

procedure Tdm.HighlightNode(intId: integer);
var
  node: PVirtualNode;
  data: PProjectData;
  memo: TSynMemo;
begin
  if ShuttingDown then exit;
  try
    node := frmMain.vstProject.GetFirst;
    while Assigned(node) do
    begin
      data := frmMain.vstProject.GetNodeData(node);
      if (data.Level = 1) and (data.ProjectIntId = intId) then
      begin
        frmMain.vstProject.Selected[node] := true;
        frmMain.vstProject.FocusedNode := node;
        FGroup.ActiveProject := FGroup[data.ProjectId];
        exit;
      end;

      //if (data.Level = 2) and ((data.Name = fileName) or (MODIFIED_CHAR+data.Name = fileName)) then
      if ((data.Level = 2) or (data.Level = 3)) and (data.FileIntId = intId) then
      begin
        frmMain.vstProject.Selected[node] := true;
        frmMain.vstProject.FocusedNode := node;
        FGroup.ActiveProject := FGroup[data.ProjectId];
        FGroup.ActiveProject.ActiveFile := FGroup.ActiveProject.ProjectFile[data.FileId];
        exit;
      end;
      node := frmMain.vstProject.GetNext(node);
    end;
    frmMain.vstProject.FullExpand(frmMain.vstProject.GetFirst(true));
  finally

  end;
end;

procedure Tdm.FocusPage(projectFile: TProjectFile; updateContent: boolean = false);
var
  i: integer;
  foundIt: boolean;
  memo: TSynMemo;
begin
  foundIt := false;
  // Look for the page with the filename
  with frmMain.sPageControl1 do
    for i := 0 to PageCount-1 do
    begin
      //if (Pages[i].Caption = fileName) or (Pages[i].Caption = (MODIFIED_CHAR+fileName)) then
      //if Pages[i].Tag = FGroup.ActiveProject.ActiveFile.IntId then
      if Pages[i].Tag = projectFile.IntId then
      begin
        ActivePageIndex := i;
        foundIt := true;
        FocusMemo(Pages[i]);
        if updateContent then
        begin
          memo := GetMemo;
          memo.Text := projectFile.Content;
        end;
        UpdateUI(true);
        break;
      end;
    end;

  if not foundIt then
  begin
    // File is not open, yet. So, open it.
    //data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
    if TFile.Exists(FGroup.ActiveProject.ActiveFile.FileName) then
      FGroup.ActiveProject.ActiveFile.Content := TFile.ReadAllText(FGroup.ActiveProject.ActiveFile.FileName);
    CreateEditor(Group.ActiveProject.ActiveFile);
  end;
end;

procedure Tdm.FocusMemo(tabSheet: TTabSheet);
var
  i: integer;
begin
  for i := 0 to tabSheet.ControlCount-1 do
  begin
    if tabSheet.Controls[i] is TSynMemo then
    begin
      TSynMemo(tabSheet.Controls[i]).SetFocus;
      exit;
    end;
  end;
end;

procedure Tdm.SynMemoOnEnter(sender: TObject);
var
  projectFile: TProjectFile;
begin
  frmMain.sAlphaHints1.HideHint;
  if frmMain.sPageControl1.ActivePage <> nil then
  begin
    if sender is TSynMemo then begin
      SynCompletionProposal1.Editor := sender as TSynMemo;
    end;
  end;
  UpdateUI(true);
end;

procedure Tdm.CloseProjectFile(intId: integer);
var
  projectFile: TProjectFile;
begin
  projectFile := FGroup.GetProjectFileByIntId(intId);
  if projectFile = nil then exit;
//  SaveFileContent(projectFile);
  frmMain.timerTabHint.Enabled := false;
  projectFile.MarkFileClosed;
  ClosePageByProjectFileIntId(intId);
  UpdateUI(true);
end;

procedure Tdm.ClosePageByProjectFileIntId(intId: integer);
var
  i: integer;
begin
  with frmMain.sPageControl1 do
    for i := PageCount-1 downto 0 do
      if Pages[i].Tag = intId then
      begin
        Pages[i].Free;
        exit;
      end;
end;

procedure Tdm.ClosePagesByProject(project: TProject);
var
  i: integer;
  projectFile: TProjectFile;
begin
  with frmMain.sPageControl1 do
    for i := PageCount-1 downto 0 do
    begin
      for projectFile in project.ProjectFiles.Values do
      begin
        if Pages[i].Tag = projectFile.IntId then
        begin
          Pages[i].Free;
          break;
        end;
      end;
    end;
end;

procedure Tdm.SaveFileContent(projectFile: TProjectFile);
var
  fn: string;
  memo: TSynMemo;
  designer: TzFormDesigner;
begin
  if (not projectFile.IsOpen) or (projectFile.Modified = false) then exit;

  if (projectFile.Path = '') or (projectFile.FileName='') or (pos('\',projectFile.FileName)=0) then
  begin
    fn := PromptForFileName(projectFile);
    if length(fn) = 0 then exit; // User canceled
    if TFile.Exists(fn) then
    begin
      if MessageDlg('File '+ExtractFileName(fn)+' alrady exists. Overwrite?',mtCustom,[mbYes,mbCancel], 0) <> mrYes then
      begin
        exit; // User canceled
      end;
    end;
    projectFile.Path := ExtractFilePath(fn);
    projectFile.Name := ExtractFileName(fn);
    projectFile.FileName := fn;
  end;

  if projectFile.ProjectFileType=pftDLG then
  begin
    designer := GetFormDesignerFromProjectFile(projectFile);
    DsnWriteToFile(projectFile.FileName, designer, True);
  end else begin
    memo := GetSynMemoFromProjectFile(projectFile);
    if memo <> nil then
    begin
      projectFile.Content := memo.Text;
      TFile.WriteAllText(projectFile.FileName, projectFile.Content);
      memo.Modified := false;
    end;
  end;

  projectFile.Modified := false;
  projectFile.SizeInBytes := length(projectFile.Content);

  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
  UpdatePageCaption(projectFile);
end;

function Tdm.GetFormDesignerFromProjectFile(projectFile: TProjectFile): TzFormDesigner;
var
  i,x: integer;
  designer: TzFormDesigner;
begin
  result := nil;
  if projectFile = nil then
  begin
    ShowMessage('No file highlighted. Select a file in the project explorer.');
    exit;
  end;
  with frmMain.sPageControl1 do
    for i := 0 to PageCount-1 do
    begin
      if Pages[i].Tag = projectFile.IntId then
      begin
        for x := 0 to Pages[i].ControlCount-1 do
        begin
          if Pages[i].Controls[x] is TfraDesign then
          begin
            result := TfraDesign(Pages[i].Controls[x]).FormDesigner;
            exit;
          end;
        end;
      end;
    end;
end;

function Tdm.GetFormDesigner: TzFormDesigner;
var
  x: integer;
begin
  result := nil;
  with frmMain.sPageControl1 do
    if PageCount > 0 then
    begin
      for x := 0 to ActivePage.ControlCount-1 do
      begin
        if ActivePage.Controls[x] is TfraDesign then
        begin
          result := TfraDesign(ActivePage.Controls[x]).FormDesigner;
          exit;
        end;
      end;
    end;
end;

function Tdm.GetObjectInspector: TObjectInspectorFrame;
var
  x: integer;
begin
  result := nil;
  with frmMain.sPageControl1 do
    if PageCount > 0 then
    begin
      for x := 0 to ActivePage.ControlCount-1 do
      begin
        if ActivePage.Controls[x] is TfraDesign then
        begin
          result := TfraDesign(ActivePage.Controls[x]).ObjectInspectorFrame1;
          exit;
        end;
      end;
    end;
end;

function Tdm.GetSynMemoFromProjectFile(projectFile: TProjectFile): TSynMemo;
var
  i,x: integer;
begin
  result := nil;
  if projectFile = nil then
  begin
    ShowMessage('No file highlighted. Select a file in the project explorer.');
    exit;
  end;
  with frmMain.sPageControl1 do
    for i := 0 to PageCount-1 do
    begin
      if Pages[i].Tag = projectFile.IntId then
      begin
        for x := 0 to Pages[i].ControlCount-1 do
        begin
          if Pages[i].Controls[x] is TSynMemo then
          begin
            result := TSynMemo(Pages[i].Controls[x]);
            exit;
          end;
        end;
      end;
    end;
end;

function Tdm.PromptForFileName(projectFile: TProjectFile): string;
begin
  dlgSave.Title := 'Save '+projectFile.Name+' As';
  dlgSave.Filter := ANY_FILE_FILTER;
  dlgSave.FilterIndex := 1;
  if length(projectFile.FileName)>0 then
    dlgSave.FileName := projectFile.FileName
  else
    dlgSave.FileName := projectFile.Name;
  if dlgSave.Execute then
    result := dlgSave.FileName
  else
    result := '';
end;

procedure Tdm.AddExistingProject(title: string; addProject: boolean);
begin
  if FLastOpenDialogDirectory = '' then
    FLastOpenDialogDirectory := FVisualMASMOptions.AppFolder;
  dlgOpen.InitialDir := FLastOpenDialogDirectory;
  dlgOpen.Title := title;
  dlgOpen.Filter := VISUAL_MASM_FILTER+'|'+GROUP_FILTER+'|'+PROJECT_FILTER+'|'+ANY_FILE_FILTER;
  if addProject then
  begin
    dlgOpen.FileName := '*'+PROJECT_FILE_EXT;
    dlgOpen.FilterIndex := 3;
  end else begin
    dlgOpen.FileName := '*'+GROUP_FILE_EXT;
    dlgOpen.FilterIndex := 1;
  end;

  if dlgOpen.Execute then
    OpenGroupOrProject(dlgOpen.FileName, addProject);
end;

procedure Tdm.OpenGroupOrProject(fileName: string; addProject: boolean);
var
  fileExt: string;
  list: TObjectList;
begin
  if fileName = '' then exit;

  FLastOpenDialogDirectory := ExtractFilePath(fileName);
  fileExt := UpperCase(ExtractFileExt(fileName));

  UpdateMenuWithLastUsedFiles(fileName);

  FDebugSupportPlugins := TList<TDebugSupportPlugin>.Create;
  FWeHaveAssemblyErrors := false;

  if fileExt = UpperCase(GROUP_FILE_EXT) then
  begin
//    ResetProjectTree;
    addProject := true;
    LoadGroup(fileName);
  end else if fileExt = UpperCase(PROJECT_FILE_EXT) then
  begin
    if FGroup = nil then
    begin
      actGroupNewGroupExecute(self);
      FGroup.ActiveProject := LoadProject(fileName);
    end else
      LoadProject(fileName);
  end;

  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

procedure Tdm.UpdateMenuWithLastUsedFiles(fileName: string = '');
var
  menuItem: TMenuItem;
  action: TFileAction;
  f: TVisualMASMFile;
  i: Integer;
begin
  frmMain.mnuReopen.Clear;

  if fileName <> '' then
  begin
    f := TVisualMASMFile.Create;
    f.FileName := fileName;
    for i := 0 to FVisualMASMOptions.LastFilesUsed.Count-1 do
    begin
      if TVisualMASMFile(FVisualMASMOptions.LastFilesUsed[i]).FileName = fileName then
      begin
        FVisualMASMOptions.LastFilesUsed.Delete(i);
        break;
      end;
    end;
    //if i<=FVisualMASMOptions.LasFilesUsedMax then
      FVisualMASMOptions.LastFilesUsed.Insert(0, f);
  end;

  for i:=0 to FVisualMASMOptions.LastFilesUsed.Count-1 do
  begin
    f:=TVisualMASMFile(FVisualMASMOptions.LastFilesUsed[i]);
    menuItem := TMenuItem.Create(frmMain.mnuReopen);
    action := TFileAction.Create(self);
    action.VisualMASMFile := f;
    action.OnExecute := actReopenFileExecute;
    //action.ShortCut := TextToShortCut('Ctrl-'+chr(ord('a')+i));
    action.Caption := '&'+chr(ord('a')+i)+'  '+f.FileName;
    menuItem.Action := action;
    frmMain.mnuReopen.Add(menuItem);
  end;
end;

procedure Tdm.LoadGroup(fileName: string);
var
  text,fName: string;
  i: integer;
  project: TProject;
  projectFile: TProjectFile;
  activeProjectId: string;
  projectFileName: string;
  json: TJSONObject;
  dateTime: TDateTime;
begin
  if not FileExists(fileName) then exit;

  fName := StrippedOfNonAscii(fileName);
  json := TJSONObject.ParseFromFile(fName) as TJsonObject;

  FGroup := TGroup.Create;
  FGroup.Name := json['Group'].S['Name'];
  FGroup.FileName := fName;
  FGroup.Id := json['Group'].S['Id'];
  TryStrToDateTime(json['Group'].S['Created'], dateTime);
  FGroup.Created := dateTime;
  FGroup.LastFileOpenId := json['Group'].S['LastFileOpenId'];
  activeProjectId := json['Group'].S['SelectedProjectId'];

  // Projects
  for i := 0 to json['Group']['Projects'].Count-1 do
  begin
    projectFileName := json['Group']['Projects'].Items[i].S['FileName'];
    LoadProject(projectFileName);
  end;

  // Assign selected project
  FGroup.ActiveProject := FGroup.ProjectById[activeProjectId];
  if (FGroup.ActiveProject <> nil) then
  begin
    FGroup.ActiveProject.ActiveFile := FGroup.ActiveProject.ProjectFile[FGroup.LastFileOpenId];
    if FGroup.ActiveProject.ActiveFile <> nil then
      FGroup.ActiveProject.ActiveFile.Modified := false;
  end;

  FGroup.Modified := false;

  SynchronizeProjectManagerWithGroup;
  FocusFileInTabs(FGroup.LastFileOpenId);
  UpdateUI(true);
end;

procedure Tdm.FocusFileInTabs(id: string);
var
  i,x: integer;
  projectFile: TProjectFile;
begin
  if FGroup = nil then exit;
  projectFile := FGroup.GetProjectFileById(id);
  if projectFile <> nil then
  begin
    for i := 0 to frmMain.sPageControl1.PageCount-1 do
    begin
      if frmMain.sPageControl1.Pages[i].Tag = projectFile.IntId then
      begin
        frmMain.sPageControl1.ActivePageIndex := i;
        //frmMain.sPageControl1.ActivePage := frmMain.sPageControl1.Pages[i];
        exit;
      end;
    end;
  end;
end;

function Tdm.LoadProject(fileName: string): TProject;
var
  text,fName: string;
  i,x,y,z: integer;
  project: TProject;
  projectFile: TProjectFile;
  projextIndex: integer;
  json: TJSONObject;
begin
  result := nil;
  if not FileExists(fileName) then exit;

  fName := StrippedOfNonAscii(fileName);
  json := TJSONObject.ParseFromFile(fName) as TJsonObject;

  project := CreateProject(json['Project'].S['Name']);
  project.Id := json['Project'].S['Id'];
  project.FileName := json['Project'].S['FileName'];
  project.Created := strtodatetime(json['Project'].S['Created']);
  project.ProjectType := TProjectType(GetEnumValue(TypeInfo(TProjectType),json['Project'].S['Type']));
  project.PreAssembleEventCommandLine := json['Project'].S['PreAssembleEventCommandLine'];
  project.AssembleEventCommandLine := json['Project'].S['AssembleEventCommandLine'];
  project.PostAssembleEventCommandLine := json['Project'].S['PostAssembleEventCommandLine'];
  project.PreLinkEventCommandLine := json['Project'].S['PreLinkEventCommandLine'];
  project.LinkEventCommandLine := json['Project'].S['LinkEventCommandLine'];
  project.AdditionalLinkSwitches := json['Project'].S['AdditionalLinkSwitches'];
  project.AdditionalLinkFiles := json['Project'].S['AdditionalLinkFiles'];
  project.PostLinkEventCommandLine := json['Project'].S['PostLinkEventCommandLine'];
  project.LibraryPath := json['Project'].S['LibraryPath'];

  // Make sure we don't already have the project loaded
  if FGroup[project.Id]=nil then
  begin
    // Project Files
    for i := 0 to json['Files'].Count-1 do
    begin
      projectFile := CreateProjectFile(json['Files'].Items[i].S['Name']);
      projectFile.Id := json['Files'].Items[i].S['Id'];
      projectFile.Path := json['Files'].Items[i].S['Path'];
      projectFile.ChildFileRCId := json['Files'].Items[i].S['ChildFileRCId'];
      projectFile.ChildFileASMId := json['Files'].Items[i].S['ChildFileASMId'];
      projectFile.ParentFileId := json['Files'].Items[i].S['ParentFileId'];
      projectFile.FileName := projectFile.Path+projectFile.Name;
      projectFile.Created := strtodatetime(json['Files'].Items[i].S['Created']);
      projectFile.ProjectFileType := TProjectFileType(GetEnumValue(TypeInfo(TProjectFileType),
        json['Files'].Items[i].S['Type']));
      if TFile.Exists(projectFile.FileName) then
        projectFile.Content := TFile.ReadAllText(projectFile.FileName);
      projectFile.IsOpen := json['Files'].Items[i].B['IsOpen'];
      projectFile.SizeInBytes := length(projectFile.Content);
      projectFile.AssembleFile := json['Files'].Items[i].B['AssembleFile'];
      project.ProjectFiles.Add(projectFile.Id, projectFile);
      projectFile.Modified := false;
      if projectFile.IsOpen then
        CreateEditor(projectFile);
    end;
    FGroup.AddProject(project);
  end;

  project.Modified := false;

  result := project;
end;

function Tdm.CreateProject(name: string; projectType: TProjectType = ptWin32): TProject;
var
  project: TProject;
begin
  project := TProject.Create;
  project.Name := name;
  project.ProjectType := projectType;
  project.Modified := true;

  // Do not give it a filename because we want the user to enter a new
  // filename via Save As... prompt.
  //project.FileName := AppFolder+project.Name;

  result := project;
end;

function Tdm.StrippedOfNonAscii(const s: string): string;
var
  i, Count: Integer;
begin
  SetLength(Result, Length(s));
  Count := 0;
  for i := 1 to Length(s) do begin
    //if ((s[i] >= #32) and (s[i] <= #127)) or (s[i] in [#10, #13]) then begin
    if ((s[i] >= #32) and (s[i] <= #127)) then begin
      inc(Count);
      Result[Count] := s[i];
    end;
  end;
  SetLength(Result, Count);
end;

function Tdm.CreateProjectFile(name: string; fileType: TProjectFileType = pftASM): TProjectFile;
var
  projectFile: TProjectFile;
begin
  projectFile := TProjectFile.Create;
//  projectFile.Id := ;
  projectFile.Name := name;

  // If we add a path, then the initial saving will not
  // prompt the user where to save it to since it checks
  // the Path property = ''
  //projectFile.Path := AppFolder;

  // Do not give it a filename because we want the user to enter a new
  // filename via Save As... prompt.
  //projectFile.FileName := AppFolder+name;

//  projectFile.Created := ;
  projectFile.ProjectFileType := fileType;
  projectFile.IsOpen := true;
  projectFile.SizeInBytes := 0;
  projectFile.Modified := true;
  if fileType = pftASM then
    projectFile.AssembleFile := true
  else
    projectFile.AssembleFile := false;
  result := projectFile;
end;

procedure Tdm.StatusBarHintHandler(Sender: TObject);
var
  projectFile: TProjectFile;
  memo: TSynMemo;
begin
//  if not frmMain.Active then exit;
//  projectFile := GetCurrentFileInProjectExplorer;
//  if projectFile = nil then exit;
//  memo := GetSynMemoFromProjectFile(projectFile);

  //make sure StatusBar1's AutoHint = true
//  UpdateStatusBarForMemo(memo,Application.Hint);
end;

procedure Tdm.HideWelcomePage;
var
  i: integer;
begin
  for i := 0 to frmMain.sPageControl1.PageCount-1 do
  begin
    if frmMain.sPageControl1.Pages[i].Name = 'tabWelcome' then
    begin
      frmMain.sPageControl1.Pages[i].Free;
      exit;
    end;
  end;
end;

procedure Tdm.ToggleBookMark(bookmark: integer);
var
  projectFile: TProjectFile;
  memo: TSynMemo;
begin
//  projectFile := GetCurrentFileInProjectExplorer;
  memo := GetSynMemoFromProjectFile(FGroup.ActiveProject.ActiveFile);
  if memo = nil then exit;
  if memo.IsBookmark(bookmark) then
    memo.ClearBookMark(bookmark)
  else
    memo.SetBookMark(bookmark,memo.CaretX,memo.CaretY);
end;

procedure Tdm.GoToBookMark(bookmark: integer);
var
  projectFile: TProjectFile;
  memo: TSynMemo;
begin
//  projectFile := GetCurrentFileInProjectExplorer;
  memo := GetSynMemoFromProjectFile(FGroup.ActiveProject.ActiveFile);
  if memo = nil then exit;
  if memo.IsBookmark(bookmark) then
    memo.GotoBookMark(bookmark);
end;

function Tdm.GetBundle(mlMD5Hash: string): TBundle;
var
  i,x: integer;
  bundle: TBundle;
  ml: TML;
begin
  for i:=0 to FBundles.Count-1 do
  begin
    bundle:=TBundle(FBundles.Objects[i]);

    for x:=0 to bundle.MASMFiles.Count-1 do
    begin
      ml:=TML(bundle.MASMFiles.Objects[x]);

      if mlMD5Hash=ml.MD5Hash then
      begin
        result := bundle;
        exit;
      end;
    end;

  end;
end;

function Tdm.PlatformString(platformType: TPlatformType): string;
begin
  result := '';
  case platformType of
    p16BitDOS: result := '16 bit MS-DOS';
    p16BitWin: result := '16 Bit Windows';
    p32BitWin: result := '32 Bit Windows';
    p64BitWinX86amd64: result := '64 Bit Windows x86 AMD';
    p64BitWinX86ia64: result := '64 Bit Windows x86 Itenium';
  end;
end;

procedure Tdm.PromptForFile(fn: string; txtControl: TsComboEdit);
var
  path: string;
begin
  dlgOpen.Title := 'Locate '+fn;
  dlgOpen.FileName := fn;
  if length(txtControl.Text)>2 then
  begin
    path := ExtractFilePath(txtControl.Text);
    if FileExists(path+fn) then
      dlgOpen.FileName := path+fn;
  end;
  if dlgOpen.Execute then
    txtControl.Text := dlgOpen.FileName;
end;

function Tdm.CreateLinkerSwitchesCommandFile(project: TProject; finalFile: string): string;
var
  fileName: string;
  content: TStringList;
  switches: TStringList;
  shortPath: string;
begin
  shortPath := ExtractShortPathName(ExtractFilePath(project.FileName));
  //fileName := ExtractFilePath(project.FileName)+TEMP_FILE_PREFIX+'switches.txt';
  fileName := shortPath+TEMP_FILE_PREFIX+'switches.txt';
  content := TStringList.Create;
  case project.ProjectType of
    ptWin32:
      begin
        content.Add('/NOLOGO');
        content.Add('/SUBSYSTEM:WINDOWS');
        if length(project.LibraryPath)>1 then
          content.Add('/LIBPATH:"'+project.LibraryPath+'"');
        content.Add('/OUT:'+finalFile);
      end;
    ptWin64:
      begin
        content.Add('/NOLOGO');
        content.Add('/SUBSYSTEM:WINDOWS');
        if length(project.LibraryPath)>1 then
          content.Add('/LIBPATH:"'+project.LibraryPath+'"');
        content.Add('/OUT:'+finalFile);
      end;
    ptWin32DLL: ;
    ptWin64DLL: ;
    ptDos16COM:
      begin
        content.Add('/NOLOGO');
        //content.Add('/AT');
        content.Add('/TINY');
      end;
    ptDos16EXE:
      begin
        content.Add('/NOLOGO');
      end;
    ptWin16: ;
    ptWin16DLL: ;
  end;

  if project.AdditionalLinkSwitches <> '' then
  begin
    switches := TStringList.Create;
    switches.Text := project.AdditionalLinkSwitches;
    content.AddStrings(switches);
  end;

  content.SaveToFile(fileName);
  result := fileName;
end;

function Tdm.CreateLinkCommandFile(project: TProject): string;
var
  content: TStringList;
  files: TStringList;
  fileName: string;
  shortPath: string;
  projectFile: TProjectFile;
begin
  shortPath := ExtractShortPathName(ExtractFilePath(project.FileName));
  result := shortPath+TEMP_FILE_PREFIX+
    Copy(project.Name,1,pos(ExtractFileExt(project.Name),project.Name)-1)+'.txt';

  content := TStringList.Create;

  for projectFile in project.ProjectFiles.Values do
  begin
    case projectFile.ProjectFileType of
      pftASM:
        begin
          if projectFile.AssembleFile then
          begin
            fileName := ExtractShortPathName(projectFile.FileName);
            fileName := Copy(fileName,1,pos(ExtractFileExt(fileName),fileName)-1)+'.obj';
            content.Add(fileName);
          end;
        end;
      pftRC:
        begin
          if projectFile.AssembleFile then
          begin
            fileName := ExtractShortPathName(projectFile.FileName);
            fileName := Copy(fileName,1,pos(ExtractFileExt(fileName),fileName)-1)+'.res';
            content.Add(fileName);
          end;
        end;
    end;
  end;

  case project.ProjectType of
    ptWin32: ;
    ptWin64: ;
    ptWin32DLL: ;
    ptWin64DLL: ;
    ptDos16COM, ptDos16EXE:
      begin
        shortPath := ExtractShortPathName(ExtractFilePath(project.FileName));
        content.Add(shortPath+project.Name+';');  // the COM file
      end;
    ptWin16: ;
    ptWin16DLL: ;
  end;

  if project.AdditionalLinkFiles <> '' then
  begin
    files := TStringList.Create;
    files.Text := project.AdditionalLinkFiles;
    content.AddStrings(files);
  end;
  content.SaveToFile(result);
end;

procedure Tdm.CleanupFiles(project: TProject);
var
  sr: TSearchRec;
  FileAttrs: Integer;
  mask: string;
  path: string;
begin
  try
    FileAttrs := faAnyFile;
    path := ExtractFilePath(project.FileName);
    mask := path+TEMP_FILE_PREFIX+'*.*';
    if FindFirst(mask, FileAttrs, sr) = 0 then
    begin
      repeat
        if (sr.Attr and FileAttrs) = sr.Attr then
        begin
          if FileExists(path+sr.Name) then
            TFile.Delete(path+sr.Name);
        end;
      until FindNext(sr) <> 0;
      System.SysUtils.FindClose(sr);
    end;
  except

  end;
end;

procedure Tdm.FocusTabWithAssemblyErrors;
var
  i: integer;
  pf: TProjectFile;
begin
  for i:= 0 to FDebugSupportPlugins.Count-1 do
  begin
    pf := FDebugSupportPlugins.Items[i].ProjectFile;
    if (pf <> nil) and (pf.AssemblyErrors.Count > 0) then
    begin
      FocusPage(pf);
      break;
    end;
  end;
end;

procedure Tdm.LocateML;
begin
  if length(FVisualMASMOptions.ML32.FoundFileName) = 0 then
    frmSetup.ShowModal;
end;

procedure Tdm.CreateBundles;
var
  ml: TML;
  bundle: TBundle;
begin
  FBundles := TStringList.Create;

  // *********************
  // MASM32 SDK Version 11
  // *********************
  bundle := TBundle.Create;
  bundle.Name := 'MASM32 SDK Version 11';
  bundle.WebSiteURL := 'http://www.masm32.com';
  bundle.WebSiteName := 'www.masm32.com';
  bundle.DownloadURL := 'http://website.assemblercode.com/masm32/masm32v11r.zip';
  bundle.PackageDownloadFileName := 'masm32v11r.zip';
  bundle.SetupFileSize := 5012275;
  bundle.SetupFile := 'install.exe';
  bundle.MD5Hash := '3E49BD1A4B5861E129F93D3FECCECCF6';
  bundle.ProductName := 'MASM32 SDK Version 11 (apx. 5 MB in size)';
  bundle.Description := 'MASM32 SDK Version 11 is a comlete package to create 32-bit Windows applications. It includes '+CRLF+
    'Microsoft MASM 6.14.8444 and many other useful tools and libraries. Visual MASM will download '+CRLF+
    'from www.masm32.com. For more information, please visit: '+bundle.WebSiteName;

  ml := TML.Create;
  ml.MD5Hash := 'B54B173761AC671CEA635672E214A8DE';
  ml.PlatformType := p32BitWin;
  ml.OriginalFileName := 'ml.exe';
  ml.ProductName := 'Microsoft (R) Macro Assembler Version 6.14.8444';
  ml.Copyright := 'Copyright (C) Microsoft Corp 1981-1997.  All rights reserved.';

  ml.Linker32Bit.MD5Hash := 'DEC627E7E8AA84087B4841117FD89B93';
  ml.Linker32Bit.PlatformType := p32BitWin;
  ml.Linker32Bit.OriginalFileName := 'link.exe';
  ml.Linker32Bit.ProductName := 'Microsoft (R) Incremental Linker Version 5.12.8078';
  ml.Linker32Bit.Copyright := 'Copyright (C) Microsoft Corp 1992-1998. All rights reserved.';

  ml.Linker16Bit.MD5Hash := 'ED1FF59F1415AF8D64DAEE5CDBD6C12B';
  ml.Linker16Bit.PlatformType := p16BitWin;
  ml.Linker16Bit.OriginalFileName := 'link16.exe';
  ml.Linker16Bit.ProductName := 'Microsoft (R) Segmented Executable Linker  Version 5.60.339 Dec  5 1994';
  ml.Linker16Bit.Copyright := 'Copyright (C) Microsoft Corp 1984-1993.  All rights reserved.';

  ml.RC.MD5Hash := 'DCD4E8BDF307718EAC536975DD538A55';
  ml.RC.PlatformType := p32BitWin;
  ml.RC.OriginalFileName := 'rc.exe';
  ml.RC.ProductName := 'Microsoft (R) Windows (R) Resource Compiler, Version 5.00.1823.1 - Build 1823';
  ml.RC.Copyright := 'Copyright (C) Microsoft Corp. 1985-1998. All rights reserved.';

  ml.LIB.MD5Hash := 'A21EBB92BBA11C9680F33D89E63AF716';
  ml.LIB.PlatformType := p32BitWin;
  ml.LIB.OriginalFileName := 'lib.exe';
  ml.LIB.ProductName := 'Microsoft (R) Library Manager Version 5.12.8078';
  ml.LIB.Copyright := 'Copyright (C) Microsoft Corp 1992-1998. All rights reserved.';

  bundle.MASMFiles.AddObject(ml.Id, ml);
  FBundles.AddObject(bundle.Id, bundle);


  // http://www.microsoft.com/en-us/download/details.aspx?id=8442

  // **************************************************************
  // Microsoft Windows SDK for Windows 7 and .NET Framework 4 (ISO)
  // **************************************************************
  bundle := TBundle.Create;
  bundle.Name := 'Microsoft Windows SDK for Windows 7 and .NET Framework 4';
  bundle.WebSiteURL := 'http://www.microsoft.com/en-us/download/details.aspx?id=8442';
  bundle.WebSiteName := 'http://www.microsoft.com/en-us/download/details.aspx?id=8442';
  bundle.DownloadURL := SDK_URL;
  bundle.PackageDownloadFileName := SDK_ISO_FILENAME;
  bundle.SetupFile := 'setup.exe';
  bundle.SetupFileSize := 594841600;
  bundle.MD5Hash := '';
  bundle.ProductName := bundle.Name;
  bundle.Description := 'The Windows SDK provides tools, compilers, headers, libraries, code samples, and a new help system that'+CRLF+
    ' developers can use to create applications that run on Microsoft Windows. For more information, please visit: '+
    bundle.WebSiteName;


  // 32-bit installed at C:\Program Files\Microsoft Visual Studio 10.0\VC\bin
  // 64-bit installed at C:\Program Files\Microsoft Visual Studio 10.0\VC\bin\x86_amd64
  ml := TML.Create;
  ml.MD5Hash := 'C60F9E0657E639019388C6C3F223AA98';
  ml.PlatformType := p32BitWin;
  ml.OriginalFileName := 'ml.exe';
  ml.ProductName := 'Microsoft (R) Macro Assembler Version 10.00.30319.01';
  ml.Copyright := 'Copyright (C) Microsoft Corporation.  All rights reserved.';

  // NOTE: add C:\Program Files\Microsoft Visual Studio 10.0\Common7\IDE to the path
  // otherwise when executing link.exe, it will error out with:
  //
  // ---------------------------
  // link.exe - Unable To Locate Component
  // ---------------------------
  // This application has failed to start because mspdb100.dll was not found. Re-installing the application may fix this problem.
  // ---------------------------
  // OK
  // ---------------------------
  //
  // Inspect the file C:\Program Files\Microsoft Visual Studio 10.0\VC\bin\vcvars32.bat
  // to get the VC dircetories, etc.
  //

  // *********
  // 32-bit ML
  // *********

  ml.Linker32Bit.MD5Hash := 'D358960CB06C16476E89BD808A5E67FA';
  ml.Linker32Bit.PlatformType := p32BitWin;
  ml.Linker32Bit.OriginalFileName := 'link.exe';
  ml.Linker32Bit.ProductName := 'Microsoft (R) Incremental Linker Version 10.00.30319.01';
  ml.Linker32Bit.Copyright := 'Copyright (C) Microsoft Corporation.  All rights reserved.';

  // Does not ship with 16-bit linker

  // RC.EXE installed at: C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin
  // need to put dir to path: C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin
  ml.RC.MD5Hash := '414217AB692158CF1E23DBEF88A33945';
  ml.RC.PlatformType := p32BitWin;
  ml.RC.OriginalFileName := 'rc.exe';
  ml.RC.ProductName := 'Microsoft (R) Windows (R) Resource Compiler Version 6.1.7600.16385';
  ml.RC.Copyright := 'Copyright (C) Microsoft Corporation.  All rights reserved.';

  ml.LIB.MD5Hash := 'BF59579A3FDFF1A08B03F0FE7F213364';
  ml.LIB.PlatformType := p32BitWin;
  ml.LIB.OriginalFileName := 'lib.exe';
  ml.LIB.ProductName := 'Microsoft (R) Library Manager Version 10.00.30319.01';
  ml.LIB.Copyright := 'Copyright (C) Microsoft Corporation.  All rights reserved.';

  bundle.MASMFiles.AddObject(ml.Id, ml);


  // *********
  // 64-bit ML
  // *********

  ml := TML.Create;
  ml.MD5Hash := '660F05D6F2C7016B2CF72964A16ED0E4';
  ml.PlatformType := p64BitWinX86amd64;
  ml.OriginalFileName := 'ml64.exe';
  ml.ProductName := 'Microsoft (R) Macro Assembler (x64) Version 10.00.30319.01';
  ml.Copyright := 'Copyright (C) Microsoft Corporation.  All rights reserved.';

  ml.Linker32Bit.MD5Hash := 'D358960CB06C16476E89BD808A5E67FA';
  ml.Linker32Bit.PlatformType := p32BitWin;
  ml.Linker32Bit.OriginalFileName := 'link.exe';
  ml.Linker32Bit.ProductName := 'Microsoft (R) Incremental Linker Version 10.00.30319.01';
  ml.Linker32Bit.Copyright := 'Copyright (C) Microsoft Corporation.  All rights reserved.';

  // RC.EXE installed at: C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin
  // need to put dir to path: C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin
  ml.RC.MD5Hash := '414217AB692158CF1E23DBEF88A33945';
  ml.RC.PlatformType := p32BitWin;
  ml.RC.OriginalFileName := 'rc.exe';
  ml.RC.ProductName := 'Microsoft (R) Windows (R) Resource Compiler Version 6.1.7600.16385';
  ml.RC.Copyright := 'Copyright (C) Microsoft Corporation.  All rights reserved.';

  ml.LIB.MD5Hash := 'BF59579A3FDFF1A08B03F0FE7F213364';
  ml.LIB.PlatformType := p32BitWin;
  ml.LIB.OriginalFileName := 'lib.exe';
  ml.LIB.ProductName := 'Microsoft (R) Library Manager Version 10.00.30319.01';
  ml.LIB.Copyright := 'Copyright (C) Microsoft Corporation.  All rights reserved.';

  bundle.MASMFiles.AddObject(ml.Id, ml);

  // Finally, add ML to bundle
  FBundles.AddObject(bundle.Id, bundle);
end;

procedure Tdm.PromptForPath(caption: string; txtControl: TsComboEdit);
var
  path: string;
begin
  dlgPath.Caption := caption;
  if length(txtControl.Text)>2 then
    dlgPath.Path := txtControl.Text;
  if dlgPath.Execute then
    txtControl.Text := dlgPath.Path;
end;

constructor TScanKeywordThread.Create;
begin
  inherited Create(TRUE);
  //fHighlighter := TSynPasSyn.Create(nil);
  fHighlighter := dm.synASMMASM;
  FFunctions := TList<TFunctionData>.Create;
  FLabels := TList<TLabelData>.Create;
  fScanEventHandle := CreateEvent(nil, FALSE, FALSE, nil);
  if (fScanEventHandle = 0) or (fScanEventHandle = INVALID_HANDLE_VALUE) then
    raise EOutOfResources.Create('Couldn''t create WIN32 event object');
  Resume;
end;

destructor TScanKeywordThread.Destroy;
begin
  fHighlighter.Free;
  FFunctions.Free;
  FLabels.Free;
  if (fScanEventHandle <> 0) and (fScanEventHandle <> INVALID_HANDLE_VALUE) then
    CloseHandle(fScanEventHandle);
  inherited Destroy;
end;

procedure TScanKeywordThread.Execute;
var
  x,i,p: integer;
  s,rightSide: string;
  Percent: integer;
  line: integer;
  functionData: TFunctionData;
  labelData: TLabelData;
  comment: boolean;
begin
  while not Terminated do begin
    WaitForSingleObject(fScanEventHandle, INFINITE);
    repeat
      if Terminated then
        break;
      // make sure the event is reset when we are still in the repeat loop
      ResetEvent(fScanEventHandle);
      // get the modified source and set fSourceChanged to 0
      Synchronize(GetSource);
      if Terminated then
        break;
      // clear keyword list
      FFunctions.Clear;
      FLabels.Clear;
      fLastPercent := 0;

      // scan the source text for the keywords, cancel if the source in the
      // editor has been changed again
      for x := 0 to FSource.Count-1 do begin
        p := pos(' PROC',Uppercase(FSource.Strings[x]));
        if p > 0 then begin
          s := trim(copy(FSource.Strings[x],0,p-1));
          if (length(s)>0) then begin
            comment := false;
            for i := p downto 1 do begin
              if s[i]=';' then begin
                comment := true;
                break;
              end;
            end;
            if (s[1] <> ';') and (not comment) then begin
              functionData.Name := s;
              functionData.Line := x+1;
              FFunctions.Add(functionData);
            end;
          end;
        end;

        p := pos(':',FSource.Strings[x]);
        if p > 0 then begin
          s := trim(copy(FSource.Strings[x],0,p-1));
          if length(s)>0 then begin
            rightSide := trim(copy(FSource.Strings[x],p+1));
            if length(rightSide)=0 then
            begin
              comment := false;
              for i := p downto 1 do begin
                if s[i]=';' then begin
                  comment := true;
                  break;
                end;
              end;
              if (s[1] <> ';') and (not comment) then begin
                labelData.Name := s;
                labelData.Line := x+1;
                FLabels.Add(labelData);
              end;
            end;
          end;
        end;
      end;

//      fHighlighter.ResetRange;
//      fHighlighter.SetLine(fSource, 1);
//      while not fSourceChanged and not fHighlighter.GetEol do begin
//        if fHighlighter.GetTokenKind = Ord(SynHighlighterAsmMASM.tkDirectives) then begin
//          s := fHighlighter.GetToken;
//          line := fHighlighter.GetTokenPos;
//          if s='PROC' then begin
//            with fKeywords do begin
//              i := IndexOf(s);
//              if i = -1 then
//                AddObject(s + ' line: '+inttostr(line)+' ', pointer(1))
//              else
//                Objects[i] := pointer(integer(Objects[i]) + 1);
//            end;
//          end;
//        end;
//        // show progress (and burn some cycles ;-)
//        Percent := MulDiv(100, fHighlighter.GetTokenPos, Length(fSource));
//        if fLastPercent <> Percent then begin
//          fLastPercent := Percent;
//          Sleep(10);
//          Synchronize(ShowProgress);
//        end;
//        fHighlighter.Next;
//      end;
    until not fSourceChanged;

    if Terminated then
      break;
    // source was changed while scanning
    if fSourceChanged then begin
      Sleep(100);
      continue;
    end;

    fLastPercent := 100;
//    Synchronize(ShowProgress);

//    fKeywords.Sort;
//    for i := 0 to fKeywords.Count - 1 do begin
//      fKeywords[i] := fKeywords[i] + ': ' +
//        IntToStr(integer(fKeywords.Objects[i]));
//    end;
    Synchronize(SetResults);
    // and go to sleep again
  end;
end;

procedure TScanKeywordThread.GetSource;
begin
  fSource := TStringList.Create;
  if (dm.Group.ActiveProject <> nil) and (dm.Group.ActiveProject.ActiveFile <> nil) then
    fSource.Text := dm.Group.ActiveProject.ActiveFile.Content;
//    fSource.LoadFromFile(dm.Group.ActiveProject.ActiveFile.FileName);
//  else
//    fSource := '';
  fSourceChanged := FALSE;
end;

procedure TScanKeywordThread.SetModified;
begin
  fSourceChanged := TRUE;
  if (fScanEventHandle <> 0) and (fScanEventHandle <> INVALID_HANDLE_VALUE) then
    SetEvent(fScanEventHandle);
end;

procedure TScanKeywordThread.SetResults;
var
  functionData: TFunctionData;
  labelData: TLabelData;
  i: integer;
begin
  if frmMain <> nil then
  begin
    dm.Functions.Clear;
    for i:=0 to FFunctions.Count-1 do begin
      functionData.Name := FFunctions.Items[i].Name;
      functionData.Line := FFunctions.Items[i].Line;
      dm.Functions.Add(functionData);
    end;
    dm.SynchronizeFunctions;

    dm.Labels.Clear;
    for i:=0 to FLabels.Count-1 do begin
      labelData.Name := FLabels.Items[i].Name;
      labelData.Line := FLabels.Items[i].Line;
      dm.Labels.Add(labelData);
    end;
    dm.SynchronizeLabels;
  end;
end;

procedure TScanKeywordThread.ShowProgress;
begin
//  if frmMain <> nil then
//    frmMain.StatusBar1.SimpleText := Format('%d %% done', [fLastPercent]);
end;

procedure TScanKeywordThread.Shutdown;
begin
  Terminate;
  if (fScanEventHandle <> 0) and (fScanEventHandle <> INVALID_HANDLE_VALUE) then
    SetEvent(fScanEventHandle);
end;

procedure Tdm.DoOnChangeSynMemo(sender: TObject);
begin
  UpdateFunctionList(TSynMemo(sender));
end;

procedure Tdm.UpdateFunctionList(memo: TSynMemo);
begin
  dm.Functions.Clear;
  FGroup.ActiveProject.ActiveFile.Content := memo.Text;
  if FWorkerThread <> nil then
    TScanKeywordThread(FWorkerThread).SetModified;
end;

procedure Tdm.GoToFunctionOnLine(line: integer);
var
  memo: TSynMemo;
begin
  memo := GetMemo;
  if memo = nil then exit;
  memo.GotoLineAndCenter(line);
  memo.SetFocus;
end;

procedure Tdm.ApplyTheme(name: string; updateTabs: boolean = true);
var
  i,x: integer;
  memo: TSynMemo;
begin
  LoadColors(name);

  // Update all open memo controls
  if updateTabs then
    with frmMain.sPageControl1 do
      for i := 0 to PageCount-1 do
      begin
        for x := 0 to Pages[i].ControlCount-1 do
        begin
          if Pages[i].Controls[x] is TSynMemo then
          begin
            memo := TSynMemo(Pages[i].Controls[x]);
            memo.ActiveLineColor := BrightenColor(frmMain.sSkinManager1.GetGlobalColor);
            memo.SelectedColor.Background := frmMain.sSkinManager1.GetHighLightColor(true);
            memo.SelectedColor.Foreground := frmMain.sSkinManager1.GetHighLightFontColor(true);
            memo.Gutter.Color := frmMain.sSkinManager1.GetGlobalColor;
            memo.Gutter.Font.Color := frmMain.sSkinManager1.GetGlobalFontColor;
            memo.Gutter.BorderColor := frmMain.sSkinManager1.GetGlobalFontColor;
            AssignColorsToEditor(memo);
          end;
        end;
      end;
end;

procedure Tdm.DoOnPaintTransient(Sender: TObject; Canvas: TCanvas; TransientType: TTransientType);
var
  i, p: Integer;
  s: string;
  DP: TDisplayCoord;
  Pt: TPoint;
  memo: TSynMemo;
begin
  if length(FSearchKey)>0 then
  begin
    memo := TSynMemo(Sender);
    for i := memo.TopLine to ((memo.TopLine + memo.LinesInWindow )-1) do
    begin
      s := memo.Lines[i - 1];
      p := Pos(FSearchKey, s);
      while (p > 0) do
      begin
        DP := memo.BufferToDisplayPos(BufferCoord(p, i));
        Pt := memo.RowColumnToPixels(DP);
        Canvas.Brush.Color := synASMMASM.SynColors.Editor.Colors.SearchSelectiondBackground;
        Canvas.Font.Color := synASMMASM.SynColors.Editor.Colors.SearchSelectionForeground;
        Canvas.TextOut (Pt.X, Pt.Y, FSearchKey);
        p := PosEx(FSearchKey, s, p + Length(FSearchKey));
      end;
    end;
  end;
end;

procedure Tdm.DoSynMemoDblClick(sender: TObject);
begin
  HighlightWords(TSynMemo(sender));
end;

procedure Tdm.HighlightWords(memo: TSynMemo);
var
  word: string;
  wordStart: integer;
begin
  if memo.SelAvail then
  begin
    wordStart := memo.WordStart.Char;
    word := memo.SelText;

    if word = FSearchKey then
    begin
      FSearchKey := '';
    end else begin
      FSearchKey := word;
      //memo.CaretX := wordStart;
    end;
  end;
end;

procedure Tdm.DoChange(Sender: TObject);
var
  word,oldSsearch: string;
  memo: TSynMemo;
  oldCaretXY: TBufferCoord;
  oldX: integer;
begin
  if length(FSearchKey)>0 then
  begin
    memo := TSynMemo(Sender);
    oldCaretXY := memo.CaretXY;
    oldX := oldCaretXY.Char;
    word := memo.WordAtCursor;
    gbSearchBackwards := false;
    gbSearchCaseSensitive := false;
    gbSearchFromCaret := true;
    gbSearchSelectionOnly := false;
    gbSearchWholeWords := false;
    gbSearchRegex := false;
    gsSearchText := FSearchKey;
    gsReplaceText := word;
    gsSearchTextHistory := '';
    oldSsearch := FSearchKey;
    FSearchKey := '';
    DoSearchReplaceText(true,false,memo);
    memo.CaretXY := oldCaretXY;
    FSearchKey := oldSsearch;
    if not memo.SelAvail then begin
      oldCaretXY.Char := memo.WordStart.Char;
      memo.BlockBegin := oldCaretXY;
      oldCaretXY.Char := oldCaretXY.Char+length(word);
      memo.BlockEnd := oldCaretXY;
    end;
    HighlightWords(memo);
    oldCaretXY.Char := oldX;
    memo.CaretXY := oldCaretXY;
  end;
end;

function Tdm.CamelCase(const s: string): string;
var
  t1: integer;
  first: boolean;
begin
  result := LowerCase(s);
  first := true;
  for t1 := 1 to length(result) do
  begin
    if result[t1] = ' ' then begin
      first := true;
    end else
      if first then begin
        result[t1] := UpCase(result[t1]);
        first := false;
      end;
  end;
end;

function Tdm.CreateMethod(const MethName: string; Instance: TObject; pInfo: PPropInfo; fileId: string): Boolean;
var
  Code, Comment: string;
  SL: TStringList;
  i, offs, ins_p, lineNumber: integer;
  projectFile: TProjectFile;
  memo: TSynMemo;
  InsertionPos: TBufferCoord;
  StrToInsert: string;
begin
  if fileId = '' then exit;
  projectFile := FGroup.GetProjectFileById(fileId);

  dm.Group.ActiveProject.ActiveFile := projectFile;

  Result := (MethName <> '') and
     (FindMethod(MethName) = false) and
     (pInfo^.PropType^^.Kind = tkMethod);

  if Result then
  begin
    SL := TStringList.Create;
    try
      StrToInsert := CRLF;
      StrToInsert := StrToInsert + MethName + ' proc hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD' + CRLF;
      StrToInsert := StrToInsert + TAB + '; Your code here' + CRLF;
      StrToInsert := StrToInsert + TAB + 'xor eax, eax	; return false' + CRLF;
      StrToInsert := StrToInsert + TAB + 'ret' + CRLF;
      StrToInsert := StrToInsert + MethName + ' endp' + CRLF;
      FocusPage(projectFile, true);
      lineNumber := GetMASMEndTokenLineNumber;
      memo := GetMemo;
      InsertionPos.Char := 1;
      InsertionPos.Line := lineNumber;
      memo.InsertLine(InsertionPos, InsertionPos, PWideChar(StrToInsert), True);

      projectFile.Content := memo.Text;
      projectFile.Modified := true;
      if FWorkerThread <> nil then
        TScanKeywordThread(FWorkerThread).SetModified;
      Application.ProcessMessages;  // Allow function thread to find new procedure
      memo.GotoLineAndCenter(GetLineNumberForMethod(MethName));
    finally
      SL.Free;
    end;
  end;
end;

function Tdm.GetMASMEndTokenLineNumber: integer;
var
  memo: TSynMemo;
  i: Integer;
  line: string;
begin
  result := 1;
  memo := GetMemo;
  for i := memo.Lines.Count downto 1 do
  begin
    line := memo.Lines[i];
    if SameText(line, MASM_END_TOKEN) then
    begin
      result := i;
      exit;
    end;
  end;
end;

function Tdm.FindMethod(const MethName: string): boolean;
var
  i: integer;
begin
  result := false;
  if MethName <> '' then
  begin
    for i := 0 to FFunctions.Count-1 do
    begin
      if SameText(FFunctions[i].Name, MethName) then
      begin
        result := true;
        exit;
      end;
    end;
  end;
end;

function Tdm.GetLineNumberForMethod(const MethName: string): integer;
var
  i: integer;
begin
  result := 1;
  if MethName <> '' then
  begin
    for i := 0 to FFunctions.Count-1 do
    begin
      if SameText(FFunctions[i].Name, MethName) then
      begin
        result := FFunctions[i].Line;
        exit;
      end;
    end;
  end;
end;

procedure Tdm.GoToMethod(const MethodName: string; fileId: string);
var
  memo: TSynMemo;
  projectFile: TProjectFile;
begin
  projectFile := FGroup.GetProjectFileById(fileId);
  if (MethodName <> '') and (projectFile <> nil) then
  begin
    FocusPage(projectFile, true);
    if FWorkerThread <> nil then
      TScanKeywordThread(FWorkerThread).SetModified;
    Application.ProcessMessages;  // Allow function thread to find new procedure
    memo := GetMemo;
    dm.Group.ActiveProject.ActiveFile := projectFile;
    if (FindMethod(MethodName) = true) then
      memo.GotoLineAndCenter(GetLineNumberForMethod(MethodName));
  end;
end;

procedure Tdm.GetParamList(ptData: PTypeData; SL: TStrings);
var
  i, k: integer;
  pName, pType: PShortString;
  ParamFlags: TParamFlags;
  pf: TParamFlag;
  sParFlags: string;
const
   ParamFlagToStr: array[TParamFlag] of AnsiString = ('var ', 'const ', '', '', '', 'out ', '');
begin
  k := 0;
  for i := 1 to ptData^.ParamCount do
   begin
    ParamFlags := TParamFlags(ptData^.ParamList[k]);
    sParFlags := '';
//    for ParamFlag := Low(ParamFlag) to High(ParamFlag) do
//      if ParamFlag in ParamFlags then
//        sParFlags := sParFlags + ParamFlagToStr[ParamFlag];

    Inc(k);
    pName := @ptData^.ParamList[k];
    Inc(k, Length(pName^) + 1);
    pType := @ptData^.ParamList[k];
    Inc(k, Length(pType^) + 1);
    SL.Add(sParFlags + pName^ + '=' + pType^);
   end;
end;

procedure Tdm.DoOnMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
  memp: TSynMemo;
begin
  if ssCtrl in Shift Then
  begin
    memp := GetMemo;
    memp.Font.Size := memp.Font.Size - 1;
  end;
end;

procedure Tdm.DoOnMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
  memp: TSynMemo;
begin
  if ssCtrl in Shift Then
  begin
    memp := GetMemo;
    memp.Font.Size := memp.Font.Size + 1;
  end;
end;

end.

