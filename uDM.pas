unit uDM;

interface

uses
  System.SysUtils, System.Classes, Vcl.Dialogs, Vcl.StdCtrls, System.Actions, Vcl.ActnList,
  Vcl.XPStyleActnCtrls, Vcl.ActnMan, Vcl.ImgList, Vcl.Controls, Vcl.ComCtrls, uSharedGlobals,
  uGroup, uProject, uProjectFile, VirtualTrees, uVisualMASMOptions, UITypes, SynEditHighlighter,
  SynHighlighterAsmMASM, SynColors, SynMemo, SynCompletionProposal, SynEdit, SynHighlighterRC,
  SynHighlighterBat, SynHighlighterCPM, SynHighlighterIni, Vcl.Graphics, SynUnicode,
  SynHighlighterHashEntries, StrUtils, Contnrs, uVisualMASMFile, Windows, SynEditTypes,
  SynEditRegexSearch, SynEditMiscClasses, SynEditSearch, uBundle, System.Generics.Collections,
  Generics.Defaults, Vcl.WinHelpViewer, HTMLHelpViewer, System.IOUtils,
  DesignIntf, Vcl.StdActns, uDebugger, uDebugSupportPlugin, Registry, System.TypInfo, Vcl.Menus,
  uHTML, LMDDckSite, Vcl.Themes, LMDDckAlphaImages, d_frmEditor, Vcl.Forms, LMDDsgModule,
  LMDIdeActns, LMDDsgDesigner, SynURIOpener, SynHighlighterURI, KHexEditor, KEditCommon,
  uFrmExportFunctions, KControls;

type
  TCommaPos = record
    startX: integer;
    endX: integer;
  end;

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
    FFileId: string;
    procedure GetSource;
    procedure SetResults;
//    procedure ShowProgress;
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
    actAddNewRCFile: TAction;
    actAddNewIncludeFile: TAction;
    actToggleDialogAssembly: TAction;
    actViewIncreaseFontSize: TAction;
    actHelpMSProgrammersGuide: TAction;
    actHelpMSREf: TAction;
    actFileNew32BitWindowsConsoleApp: TAction;
    actHelpVideosWhy: TAction;
    scpParams: TSynCompletionProposal;
    actHelpWinAPIIndex: TAction;
    dlgSave: TSaveDialog;
    dlgPath: TFileOpenDialog;
    dlgOpen: TOpenDialog;
    iml64x64Icons: TImageList;
    iml32x32Icons: TImageList;
    ActionImages: TLMDAlphaImageList;
    iml128x128: TLMDAlphaImageList;
    actDesignShowAlignPalette: TAction;
    actDesignTestDialog: TAction;
    RunTimeModule: TLMDModule;
    LMDAlignToGrid1: TLMDAlignToGrid;
    LMDAlignLeft1: TLMDAlignLeft;
    LMDAlignRight1: TLMDAlignRight;
    LMDAlignHSpaceEqually1: TLMDAlignHSpaceEqually;
    LMDAlignHCenter1: TLMDAlignHCenter;
    LMDAlignHCenterInWindow1: TLMDAlignHCenterInWindow;
    LMDAlignTop1: TLMDAlignTop;
    LMDAlignBottom1: TLMDAlignBottom;
    LMDAlignVSpaceEqually1: TLMDAlignVSpaceEqually;
    LMDAlignVCenter1: TLMDAlignVCenter;
    LMDAlignVCenterInWindow1: TLMDAlignVCenterInWindow;
    LMDDsgCut1: TLMDDsgCut;
    LMDDsgCopy1: TLMDDsgCopy;
    LMDDsgPaste1: TLMDDsgPaste;
    LMDDsgSelectAll1: TLMDDsgSelectAll;
    LMDDsgDelSelected1: TLMDDsgDelSelected;
    LMDDsgClearLocks1: TLMDDsgClearLocks;
    LMDDsgLockSelected1: TLMDDsgLockSelected;
    LMDDsgBringToFront1: TLMDDsgBringToFront;
    LMDDsgSendToBack1: TLMDDsgSendToBack;
    LMDDsgTabOrderDlg1: TLMDDsgTabOrderDlg;
    LMDDsgCreationOrderDlg1: TLMDDsgCreationOrderDlg;
    iml64x64: TLMDAlphaImageList;
    actProjectRunDebug: TAction;
    actFileNew32BitWindowsDialogApp: TAction;
    synURISyn: TSynURISyn;
    synURIOpener: TSynURIOpener;
    actFileOpenFileInProjectManager: TAction;
    actFileCompile: TAction;
    actGroupChangeProjectBuildOrder: TAction;
    actExportFunctions: TAction;
    actAddNewModuleDefinitionFile: TAction;
    actEditIncreaseFontSize: TAction;
    actEditDecreaseFontSize: TAction;
    actHelpVideosSetup: TAction;
    actHelpVideosHelloWorld: TAction;
    actHelpVideosMsgBoxApp: TAction;
    actHelpVideoDialogApp: TAction;
    actHelpVideosConsoleApp: TAction;
    actHelpVideosDLLs: TAction;
    actHelpVideosLibrary: TAction;
    actAddNewManifestFile: TAction;
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
    procedure actAddNewRCFileExecute(Sender: TObject);
    procedure actAddNewIncludeFileExecute(Sender: TObject);
    procedure actToggleDialogAssemblyExecute(Sender: TObject);
    procedure actToggleDialogAssemblyUpdate(Sender: TObject);
    procedure actHelpMSProgrammersGuideExecute(Sender: TObject);
    procedure actHelpMSREfExecute(Sender: TObject);
    procedure actFileNew32BitWindowsConsoleAppExecute(Sender: TObject);
    procedure actHelpVideosWhyExecute(Sender: TObject);
    procedure OnParamsExecute(Kind: SynCompletionType; Sender: TObject; var CurrentInput: string; var x, y: Integer;
      var CanExecute: Boolean);
    procedure actHelpWinAPIIndexExecute(Sender: TObject);
    procedure actDesignShowAlignPaletteExecute(Sender: TObject);
    procedure actDesignTestDialogExecute(Sender: TObject);
    procedure actProjectRunDebugExecute(Sender: TObject);
    procedure actFileOpenExecute(Sender: TObject);
    procedure actGroupBuildAllProjectsExecute(Sender: TObject);
    procedure actGroupAssembleAllProjectsExecute(Sender: TObject);
    procedure actResourcesExecute(Sender: TObject);
    procedure actFileNew32BitWindowsDialogAppExecute(Sender: TObject);
    procedure actFileOpenFileInProjectManagerExecute(Sender: TObject);
    procedure actFileCompileExecute(Sender: TObject);
    procedure actGroupChangeProjectBuildOrderExecute(Sender: TObject);
    procedure actNew32BitWindowsDllAppExecute(Sender: TObject);
    procedure actNew64BitWindowsDllAppExecute(Sender: TObject);
    procedure actNew16BitWindowsDllAppExecute(Sender: TObject);
    procedure actExportFunctionsExecute(Sender: TObject);
    procedure actAddNewModuleDefinitionFileExecute(Sender: TObject);
    procedure actNew16BitWindowsExeAppExecute(Sender: TObject);
    procedure actEditIncreaseFontSizeExecute(Sender: TObject);
    procedure actEditDecreaseFontSizeExecute(Sender: TObject);
    procedure actHelpVideosSetupExecute(Sender: TObject);
    procedure actHelpVideosHelloWorldExecute(Sender: TObject);
    procedure actHelpVideosMsgBoxAppExecute(Sender: TObject);
    procedure actHelpVideoDialogAppExecute(Sender: TObject);
    procedure actHelpVideosConsoleAppExecute(Sender: TObject);
    procedure actHelpVideosDLLsExecute(Sender: TObject);
    procedure actHelpVideosLibraryExecute(Sender: TObject);
    procedure actAddNewManifestFileExecute(Sender: TObject);
  private
    FDesigner: TLMDDesigner;
    FStatusBar: TStatusBar;
    FNextDocId: integer;
    FGroup: TGroup;
    FVisualMASMOptions: TVisualMASMOptions;
//    FHighlighterColorStrings: TStringList;
//    FHighlighterStrings: TStringList;
//    FSynColors: TSynColors;
    FCodeCompletionList: TStringList;
    FCodeCompletionInsertList: TStringList;
    FParamLookupList: TStringList;
    FParamList: TStringList;
    FShuttingDown: boolean;
    FLastTabIndex: integer;
    FLastOpenDialogDirectory: string;
//    FDebugSupportPlugins: TList<TDebugSupportPlugin>;
    FWeHaveAssemblyErrors: boolean;
    FPressingCtrl: boolean;
    FToken: string;
    FParamToken: string;
    FAttributes: TSynHighlighterAttributes;
    FSearchFromCaret: boolean;
    FBundles: TStringList;
    FWorkerThread: TThread;
    FFunctions: TList<TFunctionData>;
    FLabels: TList<TLabelData>;
    FSearchKey: string;
    FIgnoreAll: boolean;
    FMnemonics: TStringList;
    FRegisters: TStringList;
    FDirectives: TStringList;
    FOperators: TStringList;
    FCommas: TList<TCommaPos>;
    procedure CommentUncommentLine(memo: TSynMemo);
    procedure CreateStatusBar(pnl: TLMDDockPanel);
    function CreateMemo(projectFile: TProjectFile; pnl: TLMDDockPanel): TSynMemo;
    function ProcessCommentText(text: string): string;
    procedure FocusMemo(pnl: TLMDDockPanel);
    function ReadWin32BitExeMasm32File: string;
    function ReadWin64BitExeWinSDK64File: string;
    function Read16BitDosCOMStub: string;
    function Read16BitDosEXEStub: string;
    procedure SynMemoOnEnter(sender: TObject);
    procedure UpdatePageCaption(projectFile: TProjectFile);
    procedure ClosePanelByProjectFileIntId(intId: integer);
    procedure ClosePanelsByProject(project: TProject);
    function GetSynMemoFromProjectFile(projectFile: TProjectFile): TSynMemo;
    procedure AddExistingProject(title: string; addProject: boolean);
    procedure OpenGroupOrProject(fileName: string; addProject: boolean);
    procedure UpdateMenuWithLastUsedFiles(fileName: string = '');
    function LoadProject(fileName: string): TProject;
    procedure SetProjectName(project: TProject; oldName: string; name: string = '');
    function SaveProject(project: TProject; fileName: string = ''): boolean;
    function PromptForProjectFileName(project: TProject): string;
    function StrippedOfNonAscii(const s: string): string;
    function CreateProject(name: string; projectType: TProjectType = ptWin32): TProject;
    function CreateProjectFile(name: string; fileType: TProjectFileType = pftASM): TProjectFile;
    procedure FocusFileInTabs(id: string);
    procedure RemoveTabsheet(projectFile: TProjectFile);
    function GetCurrentFileInProjectExplorer: TProjectFile;
    procedure SynMemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SynEditorStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure StatusBarHintHandler(Sender: TObject);
    procedure ShowSearchReplaceDialog(AReplace: boolean);
    procedure DoSearchReplaceText(AReplace: boolean; ABackwards: boolean; memo: TSynMemo);
    procedure HideWelcomePage;
    procedure BuildProject(project: TProject; useActiveProject: boolean; debug: boolean);
    function AssembleProject(project: TProject; useActiveProject: boolean; debug: boolean = false): boolean;
    procedure LinkProject(project: TProject; debug: boolean = false);
    procedure ExecuteCommandLines(executeStrings: string);
    function AssembleFile(pf: TProjectFile; project: TProject; debug: boolean = false): boolean;
    procedure ClearAssemblyErrors(pf: TProjectFile);
    function ParseAssemblyOutput(output: string; projectFile: TProjectFile): boolean;
    procedure PositionCursorToFirstError(projectFile: TProjectFile);
    function CreateSwitchesCommandFile(project: TProject; finalFile: string; debug: boolean = false): string;
    function CreateCommandFile(project: TProject; switches: string = ''): string;
    procedure CleanupFiles(project: TProject);
    procedure FocusTabWithAssemblyErrors(project: TProject);
    procedure RunProject(project: TProject; useActiveProject: boolean = true; debug: boolean = false);
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
    procedure ReadError(Reader: TReader; const Message: string; var Handled: Boolean);
    procedure ReaderCreateComponent(Reader: TReader; ComponentClass: TComponentClass; var Component: TComponent);
    function GetFormDesignerFromProjectFile(projectFile: TProjectFile): TfrmEditor;
    procedure DoAcceptProperty(const PropEdit: IProperty; var PropName: WideString; var Accept: Boolean);
    function ResourceCompileFile(pf: TProjectFile; project: TProject): boolean;
    procedure DeleteProjectFileFromDebugPlugin(pf: TProjectFile);
    procedure CheckEnvironmentVariable;
    function FindMethod(const MethName: string): boolean;
//    procedure GetParamList(ptData: PTypeData; SL: TStrings);
    function GetMASMEndTokenLineNumber: integer;
    procedure UpdateFunctionList(memo: TSynMemo);
    procedure UpdateToggleUI;
    procedure DoOnMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure DoOnMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure SynMemoMouseCursor(Sender: TObject; const aLineCharPos: TBufferCoord; var aCursor: TCursor);
//    function RunAsAdminAndWaitForCompletion(hWnd: HWND; filename: string; Parameters: string): Boolean;
    function VerifyFileLocations(project: TProject): boolean;
    procedure HighlightFirstFileInProject(project: TProject);
    procedure LoadParamterList;
    function CountOccurences(const SubText: string; const Text: string): integer;
    procedure DockAsTabbedDoc(APanel: TLMDDockPanel);
    function GetActivePanel: TLMDDockPanel;
    function AtLeastOneDocumentOpen: boolean;
    function GetPanelByProjectFileIntId(id: integer): TLMDDockPanel;
    function GetStatusBar: TStatusBar;
    function GetProjectFileFromActivePanel: TProjectFile;
    function GetDialogStyle(f: TForm): string;
    function GetCommonProperties(left, top, width, height: integer): string;
    function GetButtonStyle(btn: TButton): string;
    procedure OnClosePanel(Sender: Tobject; var CloseAction: TLMDockPanelCloseAction);
    procedure AdjustBasedOnTheme(theme: string);
    procedure ApplyDarkHelp(theme: string);
    procedure ApplyBrightHelp;
    procedure LoadCodeCompletionList;
    function FunctionExistsInSourceFile(functionName: string; pf: TProjectFile): boolean;
    function GetFrmEditorFromActiveDesigner: TfrmEditor;
    procedure UpdateActionItemsWithCurrentDesigner;
    procedure UpdateRunMenu;
    procedure MenuItemDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
    procedure OnRunDebugMenuItemClick(Sender: TObject);
    procedure OnRunReleaseMenuItemClick(Sender: TObject);
    procedure CreateOutputFiles(project: TProject; debug: boolean = false);
    procedure ApplyBrightRCHighLighting;
    procedure ApplyDarkRCHighLighting;
    procedure ApplyBrightBATHighLighting;
    procedure ApplyDarkBATHighLighting;
    function GetCurrentProjectInProjectExplorer: TProject;
    procedure CreateOutputFile(pf: TProjectFile; project: TProject; debug: boolean = false);
    procedure ToggleTabs;
    procedure FocusPanel(fileIntId: integer);
    procedure HexEditorChange(Sender: TObject);
    function GetHexEditorFromProjectFile(projectFile: TProjectFile): TKHexEditor;
    function GetDefFileFromProject(project: TProject): TProjectFile;
    procedure ParseModuleDefinitionFile(project: TProject);
    procedure ApplyThemeToHexEditor(e: TKHexEditor);
    procedure ApplyDarkSelectionColorForTrees;
    procedure ClearAssembleErrorMarks(pf: TProjectFile = nil);
    procedure DisplayErrorPanel(pf: TProjectFile);
    procedure ParseDesignerFormsInProject(project: TProject);
    function IsFileLoadedIntoPanel(pf: TProjectFile): boolean;
    procedure GetDlus(dc: HDC; out HorizontalDluSize, VerticalDluSize: Real);
    procedure GetDlgBaseUnits(handle: HWND; leftPixels, topPixels, widthPixels, heightPixels: integer;
                out leftDLUs, topDLUs, widthDLUs, heightDLUs: integer);
    procedure AssignManigestToResourceFile(project: TProject);
  public
    function GetMemo: TSynMemo;
    procedure UpdateStatusBarForMemo(memo: TSynMemo; regularText: string = '');
    procedure LoadGroup(fileName: string);
    procedure CreateEditor(projectFile: TProjectFile);
    procedure Initialize;
    procedure SynchronizeProjectManagerWithGroup;
    function SaveChanges: boolean;
    property Group: TGroup read FGroup;
    property VisualMASMOptions: TVisualMASMOptions read FVisualMASMOptions;
    procedure SaveGroup(fileName: string);
    procedure UpdateUI(highlightActiveNode: boolean);
    procedure HighlightNode(intId: integer);
    property ShuttingDown: boolean read FShuttingDown write FShuttingDown;
    property LastTabIndex: integer read FLastTabIndex write FLastTabIndex;
    procedure FocusPage(projectFile: TProjectFile; updateContent: boolean = false);
    function OpenFile(dlgTitle: string; fileToOpen: string = ''): TProjectFile;
    function AddFileToCurrentProject(dlgTitle: string): TProjectFile;
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
    procedure PromptForFile(fn: string; txtControl: TEdit);
    procedure PromptForPath(caption: string; txtControl: TEdit);
    property Functions: TList<TFunctionData> read FFunctions write FFunctions;
    property Labels: TList<TLabelData> read FLabels write FLabels;
    procedure SynchronizeFunctions;
    procedure SynchronizeLabels;
    procedure GoToFunctionOnLine(line: integer);
    procedure ApplyTheme(name: string; updateTabs: boolean = true);
    procedure LoadColors(theme: string);
    procedure LoadDialog(projectFile: TProjectFile; pnl: TLMDDockPanel);
    function GetMemoFromProjectFile(projectFile: TProjectFile): TSynMemo;
    function CreateMethod(const MethName: string; fileId: string): Boolean;
    function GetLineNumberForMethod(const MethName: string): integer;
    procedure GoToMethod(const MethodName: string; fileId: string);
    property StatusBar: TStatusBar read GetStatusBar write FStatusBar;
    procedure FocusActiveFileAndMemo;
    procedure Parse(c: TComponent; rcFile: TProjectFile = nil);
    procedure CloseAllDialogsBeforeSwitchingTheme;
    procedure AssignColorsToAllMemos(updateTabs: boolean = true);
    property Designer: TLMDDesigner read FDesigner write FDesigner;
    procedure SiteChanged;
    procedure ResetProjectOutputFolder(project: TProject);
    procedure UpdateProjectMenuItems;
    function IsThemeBright: boolean;
    procedure PrepareToOpenFileFromCommandLine;
    procedure GoToLineNumber(IntId: integer; ln: integer);
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  uFrmMain, uFrmNewItems, uFrmAbout, uTFile, uFrmRename,
  WinApi.ShellApi, Messages, Vcl.Clipbrd, JsonDataObjects,
  dlgConfirmReplace, dlgReplaceText, dlgSearchText, uFrmLineNumber,
  uFrmOptions, uML, uFrmSetup, uFrmProjectOptions, uFrmDownload, uFrmVideo, uFrmProjectBuildOrder;

var
  gbSearchBackwards: boolean;
  gbSearchCaseSensitive: boolean;
  gbSearchFromCaret: boolean;
  gbSearchSelectionOnly: boolean;
//  gbSearchTextAtCaret: boolean;
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
  i: integer;
begin
  FCommas := TList<TCommaPos>.Create;

  //actViewIncreaseFontSize.ShortCut := Vcl.menus.ShortCut(VK_OEM_PLUS, [ssCtrl]);
  // TextToShortCut('Ctrl') + VK_OEM_PLUS;
  FDirectives := TStringList.Create;
  FDirectives.Delimiter := ',';
  FDirectives.DelimitedText := Directives;

  FRegisters := TStringList.Create;
  FRegisters.Delimiter := ',';
  FRegisters.DelimitedText := Registers;

  FMnemonics := TStringList.Create;
  FMnemonics.Delimiter := ',';
  FMnemonics.DelimitedText := Mnemonics;

  FOperators := TStringList.Create;
  FOperators.Delimiter := ',';
  FOperators.DelimitedText := Operators;

  FFunctions := TList<TFunctionData>.Create;
  FLabels := TList<TLabelData>.Create;
  FWorkerThread := TScanKeywordThread.Create;

  FVisualMASMOptions := TVisualMASMOptions.Create;
  FVisualMASMOptions.LoadFile;

  for i := 0 to FVisualMASMOptions.LastFilesUsed.Count-1 do
  begin
    UpdateMenuWithLastUsedFiles(FVisualMASMOptions.LastFilesUsed[i].FileName);
  end;

  FCodeCompletionInsertList := TStringList.Create;
  FCodeCompletionInsertList.LoadFromFile(FVisualMASMOptions.AppFolder+DATA_FOLDER+CODE_COMPLETION_INSERT_LIST_FILENAME);
  SynCompletionProposal1.InsertList := FCodeCompletionInsertList;

  FCodeCompletionList := TStringList.Create;

//  counter := 0;
//  for i := 0 to SynCompletionProposal1.ItemList.Count -1 do
//  begin
//    inc(counter);
//  end;

  LoadParamterList;

  FGroup := TGroup.Create(DEFAULT_PROJECTGROUP_NAME);
  LoadColors('');

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
end;

procedure Tdm.CheckForWin32HLP;
//var
//  fs: TFileStream;
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
  SearchDir: string;
  searchResults : TSearchRec;
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

  if not FileExistsStripped(colorFileName)then
  begin
    synASMMASM.SynColors := TSynColors.Create;
    synASMMASM.SaveFile(colorFileName);
  end;
  synASMMASM.LoadFile(colorFileName);
//  synASMMASM.DirectivesAttri

  AdjustBasedOnTheme(theme);

  if startingUp then
  begin
    SearchDir := dm.VisualMASMOptions.AppFolder+STYLES_FOLDER;
    if DirectoryExists(SearchDir) then begin
      if FindFirst(SearchDir+'*.vsf',faAnyFile - faDirectory, searchResults) = 0 then
        repeat
          try
            if TStyleManager.IsValidStyle(SearchDir+searchResults.Name) then
              TStyleManager.LoadFromFile(SearchDir+searchResults.Name);
          except
          end;
        until FindNext(searchResults) <> 0;
    end;
    try
      TStyleManager.TrySetStyle(FVisualMASMOptions.Theme);
    except
    end;
  end;

  frmMain.memOutput.Font.Name := dm.VisualMASMOptions.OutputFontName;
  frmMain.memOutput.Font.Size := dm.VisualMASMOptions.OutputFontSize;
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
//  promptResult: integer;
begin
  if FGroup=nil then exit;

  if frmMain.vstProject = nil then exit;

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
    data^.FileSize := project.SizeInBytes;
    data^.ProjectIntId := project.IntId;
    data^.Build := project.Build;

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

        childProjectFile := FGroup.GetProjectFileById(projectFile.ChildFileRCId);
        if childProjectFile <> nil then
        begin
          childFileNode := frmMain.vstProject.AddChild(fileNode);
          data := frmMain.vstProject.GetNodeData(childFileNode);
          data^.ProjectId := project.Id;
          data^.ProjectIntId := project.IntId;
          data^.Name := childProjectFile.Name;
          data^.Level := 3;
          data^.FileId := childProjectFile.Id;
          data^.FileSize := childProjectFile.SizeInBytes;
          data^.FileIntId := childProjectFile.IntId;
        end;

        if projectFile.ChildFileASMId<>'' then begin
          childProjectFile := FGroup.GetProjectFileById(projectFile.ChildFileASMId);
          if childProjectFile <> nil then
          begin
            childFileNode := frmMain.vstProject.AddChild(fileNode);
            data := frmMain.vstProject.GetNodeData(childFileNode);
            data^.ProjectId := project.Id;
            data^.ProjectIntId := project.IntId;
            data^.Name := childProjectFile.Name;
            data^.Level := 3;
            data^.FileId := childProjectFile.Id;
            data^.FileSize := childProjectFile.SizeInBytes;
            data^.FileIntId := childProjectFile.IntId;
          end;
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
    if Assigned(data) then
    begin
      data^.Name := FFunctions.Items[i].Name;
      data^.Line := FFunctions.Items[i].Line;
    end;
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
  json, jGroup, jProjects, jBuildOrder: TJSONObject;
  fileContent: TStringList;
  i: Integer;
begin
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

  for i := 0 to FGroup.BuildOrder.Count-1 do
  begin
    jBuildOrder := jGroup.A['BuildOrder'].AddObject;
    jBuildOrder.S['Id'] := FGroup.BuildOrder[i];
  end;

  FGroup.Modified := false;

  fileContent := TStringList.Create;
  fileContent.Text := json.ToJSON(false);
  fileContent.SaveToFile(fileName);

  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

function Tdm.SaveProject(project: TProject; fileName: string = ''): boolean;
var
  f: TProjectFile;
  json, jProject, jFiles, jFunctions: TJSONObject;
  newFileName: string;
  fileContent: TStringList;
  oldProjectName: string;
  i: integer;
begin
  result := true;
  if fileName <> '' then
    project.FileName := fileName;

  if pos('\',project.FileName)=0 then
  begin
    // Project was never saved
    newFileName := PromptForProjectFileName(project);
    if newFileName = '' then
    begin
      result := false;
      exit;
    end;
    project.FileName := newFileName;
    oldProjectName := project.Name;
    project.Name := ExtractFileName(project.FileName);
    SetProjectName(project, oldProjectName);
    if length(project.FileName)>0 then
    begin
      if FileExistsStripped(project.FileName) then
        if MessageDlg(ExtractFileName(project.FileName)+' already exists. Overwrite?',mtCustom,[mbYes,mbCancel], 0) = mrCancel then
        begin
          result := false;
          exit;
        end;
    end;
  end;

  project.Modified := false;

  json := TJSONObject.Create();
  json.I['Version'] := VISUALMASM_FILE_VERSION;
  jProject := json.O['Project'];
  jProject.S['Name'] := project.Name;
  jProject.S['Id'] := project.Id;
  jProject.S['FileName'] := project.FileName;
  jProject.S['Created'] := DateTimeToStr(project.Created);
  jProject.S['Type'] := GetEnumName(TypeInfo(TProjectType),integer(project.ProjectType));
  jProject.S['PreAssembleEventCommandLine'] := project.PreAssembleEventCommandLine;
  jProject.S['AssembleEventCommandLine'] := project.AssembleEventCommandLine;
  jProject.S['PostAssembleEventCommandLine'] := project.PostAssembleEventCommandLine;
  jProject.S['PreLinkEventCommandLine'] := project.PreLinkEventCommandLine;
  jProject.S['LinkEventCommandLine'] := project.LinkEventCommandLine;
  jProject.S['AdditionalLinkSwitches'] := project.AdditionalLinkSwitches;
  jProject.S['AdditionalLinkFiles'] := project.AdditionalLinkFiles;
  jProject.S['PostLinkEventCommandLine'] := project.PostLinkEventCommandLine;
  jProject.S['LibraryPath'] := project.LibraryPath;
  jProject.S['OutputFolder'] := project.OutputFolder;
  jProject.S['OutputFile'] := project.OutputFile;
  jProject.L['SizeInBytes'] := project.SizeInBytes;
  jProject.B['Build'] := project.Build;

  for f in project.ProjectFiles.Values do
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
    jFiles.S['OutputFile'] := f.OutputFile;
  end;

  for i := 0 to project.Functions.Count-1 do
  begin
    if project.Functions[i].Export then
    begin
      jFunctions := json.A['ExportedFunctions'].AddObject;
      jFunctions.S['FileId'] := project.Functions[i].FileId;
      jFunctions.S['FileName'] := project.Functions[i].FileName;
      jFunctions.I['Line'] := project.Functions[i].Line;
      jFunctions.S['Name'] := project.Functions[i].Name;
      jFunctions.S['ExportAs'] := project.Functions[i].ExportAs;
    end;
  end;

  fileContent := TStringList.Create;
  fileContent.Text := json.ToJSON(false);
  fileContent.SaveToFile(project.FileName);

  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

procedure Tdm.OnParamsExecute(Kind: SynCompletionType; Sender: TObject; var CurrentInput: string; var x, y: Integer;
  var CanExecute: Boolean);
var
  locline, lookup: WideString;
  numOfCommas,
  TmpX,
//  savepos,
  StartX,
//  ParenCounter,
  TmpLocation    : Integer;
  FoundMatch     : Boolean;
//  point: TPoint;
  Token: UnicodeString;
  Attri: TSynHighlighterAttributes;
  tokenPos: integer;
  listIndex: integer;
  i: integer;
  commaPos: TCommaPos;
begin
  TmpLocation := -1;
  tokenPos := 0;
  FoundMatch := false;
  listIndex := -1;

  with TSynCompletionProposal(Sender).Editor do
  begin
    locLine := LineText;
    TmpX := CaretX;
    if GetHighlighterAttriAtRowCol(CaretXY, Token, Attri) then
    begin
      if Assigned(Attri) then
      begin
        listIndex := FParamLookupList.IndexOf(Token);
        tokenPos := pos(ShortString(Token), locLine);
        FoundMatch := listIndex > -1;
        if FoundMatch then
        begin
          lookup := Token;
          FParamToken := Token;
        end;
      end;
    end;

    if (not FoundMatch) then
    begin
      tokenPos := pos(ShortString(FParamToken), locLine);
      if (tokenPos>0) and (CaretX >= tokenPos) then
      begin
        listIndex := FParamLookupList.IndexOf(FParamToken);
        FoundMatch := listIndex > -1;
        lookup := FParamToken;
      end;
    end;

    // Find which param position the caret is at
    if FoundMatch then
    begin
      FCommas.Clear;
      numOfCommas := CountOccurences(',', locLine);
      StartX := tokenPos+length(lookup);
      for i := StartX to length(locLine) do
      begin
        if locLine[i] = ',' then
        begin
          commaPos.startX := i;
          FCommas.Add(commaPos);
          if FCommas.Count>1 then
          begin
            commaPos := FCommas[FCommas.Count-2];
            commaPos.endX := i-1;
            if commaPos.endX > length(locline) then
              commaPos.endX := length(locline);
            if commaPos.endX < commaPos.startX then
              commaPos.endX := commaPos.startX;
            FCommas[FCommas.Count-2] := commaPos;
          end;
//          inc(TmpLocation);
//          if i>CaretX then
//            break;
        end;
      end;
      if FCommas.Count>0 then
      begin
        commaPos := FCommas[FCommas.Count-1];
        commaPos.endX := length(locline);
        FCommas[FCommas.Count-1] := commaPos;
      end;

      for i := 0 to FCommas.Count-1 do
      begin
        if (TmpX >= FCommas[i].startX) and (TmpX <= FCommas[i].endX) then
        begin
          TmpLocation := i+1;
          break;
        end;
      end;
      if TmpX > length(locLine) then
        TmpLocation := numOfCommas;
      if TmpX < StartX then
        TmpLocation := 0;
    end;
  end;

  Application.ProcessMessages;

  CanExecute := FoundMatch;

  if CanExecute then
  begin
    TSynCompletionProposal(Sender).Form.CurrentIndex := TmpLocation;
    if lookup <> TSynCompletionProposal(Sender).PreviousToken then
    begin
      TSynCompletionProposal(Sender).ItemList.Clear;
      TSynCompletionProposal(Sender).ItemList.Add(FParamList[listIndex]);
    end;
  end else
    TSynCompletionProposal(Sender).ItemList.Clear;
end;

function Tdm.PromptForProjectFileName(project: TProject): string;
var
  fileName: string;
  newPath: string;
begin
//  frmMain.sAlphaHints1.HideHint;
  if FGroup = nil then
    dlgSave.Title := 'Save '+DEFAULT_PROJECT_NAME+' As'
  else
    dlgSave.Title := 'Save '+project.Name+' As';
  dlgSave.Filter := PROJECT_FILTER;
  dlgSave.FilterIndex := 1;
  if length(project.OutputFolder)>3 then
    ForceDirectories(project.OutputFolder);
  if length(project.FileName)>0 then
    dlgSave.FileName := project.OutputFolder+ExtractFileName(project.FileName)
  else begin
    fileName := StringReplace(project.Name, ExtractFileExt(project.Name), '', [rfReplaceAll, rfIgnoreCase]);
    dlgSave.FileName := project.OutputFolder+fileName+PROJECT_FILE_EXT;
  end;
  if dlgSave.Execute then begin
    result := dlgSave.FileName;
    newPath := ExtractFilePath(result);
    if not SameText(project.OutputFolder, newPath) then
      project.OutputFolder := IncludeTrailingPathDelimiter(newPath);
  end else
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

procedure Tdm.actAddNewManifestFileExecute(Sender: TObject);
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
  projectFile := project.CreateProjectFile(WIN_MANIFEST_FILENAME, FVisualMASMOptions, pftManifest);
  CreateEditor(projectFile);
  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

procedure Tdm.actAddNewModuleDefinitionFileExecute(Sender: TObject);
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
  projectFile := project.CreateProjectFile(WIN_DLL_MODULE_FILENAME, FVisualMASMOptions, pftDef);
  CreateEditor(projectFile);
  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

function Tdm.ReadWin32BitExeMasm32File: string;
begin
  result := TFile.ReadAllText(FVisualMASMOptions.TemplatesFolder+WIN_32_BIT_EXE_MASM32_FILENAME);
end;

function Tdm.ReadWin64BitExeWinSDK64File: string;
begin
  result := TFile.ReadAllText(FVisualMASMOptions.TemplatesFolder+WIN_64_BIT_EXE_WINSDK64_FILENAME);
end;

function Tdm.Read16BitDosCOMStub: string;
begin
  result := TFile.ReadAllText(FVisualMASMOptions.TemplatesFolder+DOS_16_BIT_COM_STUB_FILENAME);
end;

function Tdm.Read16BitDosEXEStub: string;
begin
  result := TFile.ReadAllText(FVisualMASMOptions.TemplatesFolder+DOS_16_BIT_EXE_STUB_FILENAME);
end;

procedure Tdm.actAddNewProjectExecute(Sender: TObject);
begin
  frmNewItems.AddNewProject(true);
  frmNewItems.ShowModal;
  FocusActiveFileAndMemo;
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
  AddFileToCurrentProject('Add to Project');
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

  if not SaveProject(project) then
    exit;

  ClearAssemblyErrors(projectFile);

  if AssembleFile(projectFile, project) then
  begin
    outputFile := ExtractFilePath(projectFile.FileName) +
      ChangeFileExt(ExtractFileName(projectFile.FileName), '') + '.obj';
    if FileExistsStripped(outputFile) then
      frmMain.memOutput.Lines.Add('Created '+outputFile+' ('+inttostr(FileSizeStripped(outputFile))+' bytes)');
  end;

  FocusTabWithAssemblyErrors(project);
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
  projectFile,child: TProjectFile;
  data: PProjectData;
begin
  projectFile := GetCurrentFileInProjectExplorer;
  if projectFile = nil then exit;
  if MessageDlg('Delete file '+projectFile.Name+'?',mtCustom,[mbYes,mbCancel], 0) = mrYes then
  begin
    data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
    RemoveTabsheet(projectFile);
    DeleteProjectFileFromDebugPlugin(projectFile);
    if TFile.Exists(projectFile.FileName) then
      TFile.Delete(projectFile.FileName);
    if (data.Level = 2) or (data.Level = 3) then
    begin
      if projectFile.ProjectFileType = pftDLG then
      begin
        // Delete child file as well
        child := dm.Group.GetProjectFileById(projectFile.ChildFileRCId);
        if child <> nil then
          ClosePanelByProjectFileIntId(child.IntId);
        FGroup[data.ProjectId].DeleteProjectFile(projectFile.ChildFileRCId);

        child := dm.Group.GetProjectFileById(projectFile.ChildFileASMId);
        if child <> nil then
          ClosePanelByProjectFileIntId(child.IntId);
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
//  for i:= 0 to FDebugSupportPlugins.Count-1 do
//  begin
//    pf := FDebugSupportPlugins.Items[i].ProjectFile;
//    if (pf <> nil) and (pf is TProjectFile) and Assigned(pf) then
//    begin
//      if pf.Id = pf.Id then
//      begin
//        FDebugSupportPlugins.Delete(i);
//        break;
//      end;
//    end;
//  end;
end;

function Tdm.GetCurrentFileInProjectExplorer: TProjectFile;
var
  data: PProjectData;
  pnl: TLMDDockPanel;
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
    // Try to get the project file from the current panel instead
    pnl := GetActivePanel;
    if pnl <> nil then
    begin
      result := FGroup.GetProjectFileByIntId(pnl.Tag);
    end;
  end;
end;

function Tdm.GetCurrentProjectInProjectExplorer: TProject;
var
  data: PProjectData;
  pnl: TLMDDockPanel;
begin
  result := nil;
  if frmMain.vstProject.FocusedNode = nil then
  begin
    //ShowMessage('No file highlighted. Select a file in the project explorer.');
    //exit;
    if FGroup <> nil then
      result := FGroup.ActiveProject;
  end else begin
    data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
    if (data<> nil) and ((data.Level = 2) or (data.Level = 3) or (data.Level = 1)) then
      result := FGroup[data.ProjectId];
  end;
  if result = nil then
  begin
    // Try to get the project file from the current panel instead
    pnl := GetActivePanel;
    if pnl <> nil then
    begin
      result := FGroup.GetProjectByFileIntId(pnl.Tag);
    end;
  end;
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
    PChar('/K cd /d "'+path+'"'), nil, SW_NORMAL);
end;

function Tdm.OpenFile(dlgTitle: string; fileToOpen: string = ''): TProjectFile;
var
  projectFile: TProjectFile;
  fileExt: string;
  fn: string;

  function PromptForFile(dlgTitle: string): string;
  begin
    result := '';
    if FLastOpenDialogDirectory = '' then
      FLastOpenDialogDirectory := FVisualMASMOptions.AppFolder;
    dlgOpen.InitialDir := FLastOpenDialogDirectory;
    dlgOpen.Title := dlgTitle;
    dlgOpen.Filter := ANY_FILE_FILTER+'|'+synASMMASM.DefaultFilter+'|'+
      synBAT.DefaultFilter+'|'+RESOURCE_FILTER+'|'+INI_FILTER+'|'+LIB_FILTER;
    if dlgOpen.Execute then
      result := dlgOpen.FileName;
  end;

begin
  if fileToOpen <> '' then
    fn := fileToOpen
  else
    fn := PromptForFile(dlgTitle);

  FLastOpenDialogDirectory := ExtractFilePath(fn);
  projectFile := TProjectFile.Create;
  projectFile.Name := ExtractFileName(fn);
  projectFile.Path := ExtractFilePath(fn);
  projectFile.FileName := fn;
  projectFile.IsOpen := true;
  projectFile.SizeInBytes := 0;
  if (projectFile.ProjectFileType <> pftBinary) and (projectFile.ProjectFileType <> pftLib) then
  begin
    projectFile.Content := TFile.ReadAllText(fn);
    projectFile.SizeInBytes := length(projectFile.Content);
  end;
  projectFile.Modified := false;
  CreateEditor(projectFile);
//    SynchronizeProjectManagerWithGroup;
//    UpdateUI(true);
  result := projectFile;
end;

function Tdm.AddFileToCurrentProject(dlgTitle: string): TProjectFile;
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
    synBAT.DefaultFilter+'|'+RESOURCE_FILTER+'|'+INI_FILTER+'|'+LIB_FILTER;
  if dlgOpen.Execute then
  begin
    FLastOpenDialogDirectory := ExtractFilePath(dlgOpen.FileName);
    projectFile := project.AddFile(dlgOpen.FileName);
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
  if AtLeastOneDocumentOpen then
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
    if AtLeastOneDocumentOpen then
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
    if AtLeastOneDocumentOpen then
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
    if AtLeastOneDocumentOpen then
      memo.CutToClipboard;
  end;
end;

procedure Tdm.actEditDecreaseFontSizeExecute(Sender: TObject);
var
  memo: TSynMemo;
begin
  memo := GetMemo;
  if memo <> nil then
  begin
    memo.Font.Size := memo.Font.Size - 1;
    scpParams.Font.Size := scpParams.Font.Size - 1;
  end;
end;

procedure Tdm.actEditDeleteExecute(Sender: TObject);
var
  memo: TSynMemo;
begin
  memo := GetMemo;
  if memo <> nil then
  begin
    if AtLeastOneDocumentOpen then
      memo.SelText := '';
  end;
end;

procedure Tdm.actEditHighlightWordsExecute(Sender: TObject);
var
  word: string;
//  wordStart: integer;
  buffer: TBufferCoord;
  memo: TSynMemo;
begin
  memo := GetMemo;
  if memo <> nil then
  begin
//    wordStart := memo.WordStart.Char;
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

procedure Tdm.actEditIncreaseFontSizeExecute(Sender: TObject);
var
  memp: TSynMemo;
begin
  memp := GetMemo;
  if memp <> nil then
  begin
    memp.Font.Size := memp.Font.Size + 1;
    scpParams.Font.Size := scpParams.Font.Size + 1;
  end;
end;

procedure Tdm.actEditLowerCaseExecute(Sender: TObject);
var
  memo: TSynMemo;
begin
  if AtLeastOneDocumentOpen then
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
  if AtLeastOneDocumentOpen then
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
  if AtLeastOneDocumentOpen then
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
  if AtLeastOneDocumentOpen then
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
  pf: TProjectFile;
  hexEditor: TKHexEditor;
begin
  if AtLeastOneDocumentOpen then
  begin
    pf := GetProjectFileFromActivePanel;
    if pf <> nil then
      if (pf.ProjectFileType = pftBinary) or (pf.ProjectFileType = pftLib) then
      begin
        hexEditor := GetHexEditorFromProjectFile(pf);
        hexEditor.ExecuteCommand(TKEditCommand.ecUndo);
      end else begin
        memo := GetMemo;
        if memo <> nil then
        begin
          FSearchKey := '';
          memo.Undo;
        end;
      end;
  end;
end;

procedure Tdm.actEditUpperCaseExecute(Sender: TObject);
var
  memo: TSynMemo;
begin
  if AtLeastOneDocumentOpen then
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

procedure Tdm.actExportFunctionsExecute(Sender: TObject);
begin
  if dm.Group=nil then exit;
  if frmExportFunctions.vstFunctions = nil then exit;
  FGroup.ActiveProject.ScanFunctions;
  frmExportFunctions.Project := FGroup.ActiveProject;
  frmExportFunctions.ShowModal;
  ParseModuleDefinitionFile(FGroup.ActiveProject);
  SynchronizeProjectManagerWithGroup;
  UpdateUI(false);
end;

procedure Tdm.actFileAddNewDialogExecute(Sender: TObject);
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

  projectFile := project.CreateProjectFile('', FVisualMASMOptions, pftDLG);
  CreateEditor(projectFile);
end;

procedure Tdm.actFileCloseAllExecute(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to frmMain.Site.PanelCount-1 do
  begin
    if frmMain.Site.Panels[i].ClientKind = dkDocument then
    begin
      frmMain.Site.Panels[i].Close;
    end;
  end;
end;

procedure Tdm.actFileCompileExecute(Sender: TObject);
var
  data: PProjectData;
  pf: TProjectFile;
  project: TProject;
begin
  data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
  pf := FGroup.GetProjectFileById(data.FileId);
  project := FGroup.GetProjectByIntId(data.ProjectIntId);
  ResourceCompileFile(pf, project);
end;

procedure Tdm.actFileNew32BitWindowsConsoleAppExecute(Sender: TObject);
begin
  CreateNewProject(ptWin32Con);
end;

procedure Tdm.actFileNew32BitWindowsDialogAppExecute(Sender: TObject);
begin
  CreateNewProject(ptWin32Dlg);
end;

procedure Tdm.actFileNew32BitWindowsExeAppAddToGroupExecute(Sender: TObject);
begin
  CreateNewProject(ptWin32);
end;

procedure Tdm.actFileOpenExecute(Sender: TObject);
begin
  OpenFile('Open');
end;

procedure Tdm.actFileOpenFileInProjectManagerExecute(Sender: TObject);
var
  data: PProjectData;
begin
  data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
  FocusPage(FGroup.GetProjectFileById(data.FileId));
end;

procedure Tdm.CreateNewProject(projectType: TProjectType);
var
  project: TProject;
  pf,parentFile,rcFile,asmFile: TProjectFile;
  frmEditor: TfrmEditor;
begin
  project := FGroup.CreateNewProject(projectType, FVisualMASMOptions);
  ResetProjectOutputFolder(FGroup.ActiveProject);
  case projectType of
    ptWin32Dlg:
      begin
        pf := project.GetProjectFileWithNoChildrenAndNoParent(pftASM);
        CreateEditor(pf);
        parentFile := project.GetFirstProjectFileByType(pftDLG);
        rcFile := FGroup.GetProjectFileById(parentFile.ChildFileRCId);
        CreateEditor(rcFile);
        asmFile := FGroup.GetProjectFileById(parentFile.ChildFileASMId);
        CreateEditor(asmFile);
        CreateEditor(parentFile);
        frmEditor := GetFormDesignerFromProjectFile(parentFile);
        frmEditor.RCFile := rcFile;
        frmEditor.ProjectFile := parentFile;
        if frmEditor <> nil then
          frmEditor.Parse;
      end;
    ptWin32,ptWin64:
      begin
        AssignManigestToResourceFile(project);
        CreateEditor(FGroup.ActiveProject.ActiveFile);
      end;
    ptWin32Con,ptDos16COM,ptDos16EXE,ptLib,ptWin16:
      begin
        CreateEditor(FGroup.ActiveProject.ActiveFile);
      end;
    ptWin32DLL:
      begin
        pf := project.GetFirstProjectFileByType(pftDef);
        CreateEditor(pf);
        pf := project.GetFirstProjectFileByType(pftASM);
        CreateEditor(pf);
      end;
    ptWin64DLL:
      begin
        pf := project.GetFirstProjectFileByType(pftDef);
        CreateEditor(pf);
        pf := project.GetFirstProjectFileByType(pftASM);
        CreateEditor(pf);
      end;
    ptWin16DLL:
      begin
        pf := project.GetFirstProjectFileByType(pftDef);
        CreateEditor(pf);
        pf := project.GetFirstProjectFileByType(pftASM);
        CreateEditor(pf);
      end;
  end;
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
    if FileExistsStripped(projectFile.FileName) then
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
  if frmMain.vstProject.FocusedNode = nil then exit;
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
  projectFile: TProjectFile;
begin
  if FGroup.ActiveProject = nil then
  begin
    if FGroup.Modified then
      actGroupSaveExecute(self);
    exit;
  end;

  if not SaveChanges then exit;
  actGroupSaveExecute(self);

  if (not ShuttingDown) and (projectFile <> nil) then
    HighlightNode(projectFile.IntId);
end;

procedure Tdm.UpdatePageCaption(projectFile: TProjectFile);
var
  i: integer;
begin
  // Look for the page with the filename
  with frmMain.Site do
    for i := 0 to PanelCount-1 do
    begin
      //if Pages[i].Caption = (MODIFIED_CHAR+fileName) then
      if Panels[i].Tag = projectFile.IntId then
      begin
        if (projectFile.Modified) and (pos(MODIFIED_CHAR,projectFile.Name)=0) then
          Panels[i].Caption := MODIFIED_CHAR+projectFile.Name
        else
          Panels[i].Caption := projectFile.Name;
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

procedure Tdm.actGroupAssembleAllProjectsExecute(Sender: TObject);
var
  project: TProject;
begin
  if FGroup = nil then exit;
  frmMain.memOutput.Clear;
  for project in FGroup.Projects.Values do
  begin
    AssembleProject(project, false, false);
  end;
end;

procedure Tdm.actGroupBuildAllProjectsExecute(Sender: TObject);
var
  project: TProject;
  i: integer;
begin
  if FGroup = nil then exit;
  frmMain.memOutput.Clear;
  for i := 0 to FGroup.BuildOrder.Count-1 do
  begin
    project := FGroup.ProjectById[FGroup.BuildOrder[i]];
    BuildProject(project, false, false);
  end;
end;

procedure Tdm.actGroupChangeProjectBuildOrderExecute(Sender: TObject);
var
  i: integer;
  project: TProject;
begin
  if dm.Group=nil then exit;
  if frmProjectBuildOrder.vstProject = nil then exit;

  if frmProjectBuildOrder.ShowModal = mrOk then
  begin
    try
      FGroup.BuildOrder.Clear;

      // Clear all projects to be build
      for project in FGroup.Projects.Values do
        project.Build := false;

      // Mark projects to be built
      for i := 0 to frmProjectBuildOrder.BuildOrder.Count-1 do
      begin
        project := FGroup.ProjectById[frmProjectBuildOrder.BuildOrder[i]];
        project.Build := true;
        FGroup.BuildOrder.Add(project.Id);
      end;

      SynchronizeProjectManagerWithGroup;
      UpdateUI(false);
    finally
    end;
  end;
end;

procedure Tdm.actGroupNewGroupExecute(Sender: TObject);
begin
  // Create the new group
  actFileCloseAllExecute(self);
  FGroup := TGroup.Create(DEFAULT_PROJECTGROUP_NAME);
  FGroup.Modified := true;
  SynchronizeProjectManagerWithGroup;
  UpdateUI(false);
end;

procedure Tdm.actGroupRemoveProjectExecute(Sender: TObject);
var
  data: PProjectData;
  project, projectToBeDeleted: TProject;
  projectFile: TProjectFile;
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
        if project.Id <> data.ProjectId then
        begin
          FGroup.ActiveProject := project;
          break;
        end;
      end;
    end;
    ClosePanelsByProject(projectToBeDeleted);

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
    if FileExistsStripped(FGroup.FileName) then
      RenameFile(FGroup.FileName,ExtractFilePath(FGroup.FileName)+FGroup.Name+GROUP_FILE_EXT);
    FGroup.FileName := ExtractFilePath(FGroup.FileName)+FGroup.Name+GROUP_FILE_EXT;
    FGroup.Modified := true;
    SynchronizeProjectManagerWithGroup;
  end;
end;

procedure Tdm.actGroupSaveAsExecute(Sender: TObject);
begin
  if length(VisualMASMOptions.CommonProjectsFolder)>3 then
    ForceDirectories(VisualMASMOptions.CommonProjectsFolder);

  if FGroup = nil then
  begin
    dlgSave.Title := 'Save '+DEFAULT_PROJECTGROUP_NAME+' As';
    dlgSave.FileName := VisualMASMOptions.CommonProjectsFolder+DEFAULT_PROJECTGROUP_NAME+GROUP_FILE_EXT;
  end else begin
    dlgSave.Title := 'Save '+FGroup.Name+' As';
    if length(FGroup.FileName)>0 then
      dlgSave.FileName := VisualMASMOptions.CommonProjectsFolder+ExtractFileName(FGroup.FileName)
    else
      dlgSave.FileName := VisualMASMOptions.CommonProjectsFolder+FGroup.Name+GROUP_FILE_EXT;
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

procedure Tdm.actHelpMSProgrammersGuideExecute(Sender: TObject);
var
  fileName: string;
begin
  fileName := dm.VisualMASMOptions.AppFolder+MASM61_PROG_FILENAME;
  ShellExecute(Application.Handle, nil, PChar(fileName), nil,  nil, SW_SHOWNORMAL);
end;

procedure Tdm.actHelpMSREfExecute(Sender: TObject);
var
  fileName: string;
begin
  fileName := dm.VisualMASMOptions.AppFolder+MASM61_REF_FILENAME;
  ShellExecute(Application.Handle, nil, PChar(fileName), nil,  nil, SW_SHOWNORMAL);
end;

procedure Tdm.actHelpVideoDialogAppExecute(Sender: TObject);
begin
  frmVideo.DialogApp;
end;

procedure Tdm.actHelpVideosConsoleAppExecute(Sender: TObject);
begin
  frmVideo.ConsoleApp;
end;

procedure Tdm.actHelpVideosDLLsExecute(Sender: TObject);
begin
  frmVideo.DLLs;
end;

procedure Tdm.actHelpVideosHelloWorldExecute(Sender: TObject);
begin
  frmVideo.HelloWorld;
end;

procedure Tdm.actHelpVideosLibraryExecute(Sender: TObject);
begin
  frmVIdeo.Libraries;
end;

procedure Tdm.actHelpVideosMsgBoxAppExecute(Sender: TObject);
begin
  frmVideo.MsgBoxApp;
end;

procedure Tdm.actHelpVideosSetupExecute(Sender: TObject);
begin
  frmVideo.Setup;
end;

procedure Tdm.actHelpVideosWhyExecute(Sender: TObject);
begin
  frmVideo.Why;
end;

procedure Tdm.actHelpWin32HelpExecute(Sender: TObject);
var
  word: string;
  memo: TSynMemo;
  link: HH_AKLINK;

  procedure DisplayWin32File;
  begin
    HtmlHelp(0, Application.HelpFile, HH_DISPLAY_TOC, 0);
  end;

begin
  memo := GetMemo;
  if memo = nil then
  begin
    DisplayWin32File;
    exit;
  end;
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
  end else begin
    DisplayWin32File;
    exit;
  end;
end;

procedure Tdm.actHelpWinAPIIndexExecute(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', WINAPI_INDEX_URL, nil,  nil, SW_SHOWNORMAL);
end;

procedure Tdm.actNew16BitDOSComAppExecute(Sender: TObject);
begin
  CreateNewProject(ptDos16COM);
end;

procedure Tdm.actNew16BitDOSExeAppExecute(Sender: TObject);
begin
  CreateNewProject(ptDos16EXE);
end;

procedure Tdm.actNew16BitWindowsDllAppExecute(Sender: TObject);
begin
  CreateNewProject(ptWin16DLL);
end;

procedure Tdm.actNew16BitWindowsExeAppExecute(Sender: TObject);
begin
  CreateNewProject(ptWin16);
end;

procedure Tdm.actNew32BitWindowsDllAppExecute(Sender: TObject);
begin
  CreateNewProject(ptWin32DLL);
end;

procedure Tdm.actNew64BitWindowsDllAppExecute(Sender: TObject);
begin
  CreateNewProject(ptWin64DLL);
end;

procedure Tdm.actNew64BitWindowsExeAppExecute(Sender: TObject);
begin
  CreateNewProject(ptWin64);
end;

procedure Tdm.actNewOtherExecute(Sender: TObject);
//var
//  project: TProject;
begin
//  project := GetCurrentProjectInProjectExplorer;
//  if project <> nil then
//  begin
//    case project.ProjectType of
//      ptWin32: frmNewItems.HighlightWindowsFiles;
//      ptWin64: frmNewItems.HighlightWindowsFiles;
//      ptWin32DLL: ;
//      ptWin64DLL: ;
//      ptDos16COM: frmNewItems.HighlightMSDOSFiles;
//      ptDos16EXE: frmNewItems.HighlightMSDOSFiles;
//      ptWin16: ;
//      ptWin16DLL: ;
//    end;
//  end else
    frmNewItems.HighlightApplications;
  frmNewItems.ShowModal;
  FocusActiveFileAndMemo;
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
  if not VerifyFileLocations(project) then exit;
  frmMain.memOutput.Clear;
  if not AssembleProject(project, false, false) then
  begin
    FocusTabWithAssemblyErrors(project);
    exit;
  end;
  FocusActiveFileAndMemo;
end;

procedure Tdm.actProjectBuildExecute(Sender: TObject);
var
  project: TProject;
begin
  project := GetCurrentProjectInProjectExplorer;
  if project = nil then exit;
  if not VerifyFileLocations(project) then exit;
  frmMain.memOutput.Clear;
  SaveProject(project);
  BuildProject(project, false, false);
end;

procedure Tdm.BuildProject(project: TProject; useActiveProject: boolean; debug: boolean);
begin
  if not VerifyFileLocations(project) then exit;
  if not AssembleProject(project, useActiveProject) then
  begin
    FocusTabWithAssemblyErrors(project);
    exit;
  end;
  LinkProject(project);
  FocusActiveFileAndMemo;
end;

function Tdm.VerifyFileLocations(project: TProject): boolean;
begin
  result := true;

  if project = nil then
  begin
    result := false;
    exit;
  end;

  case project.ProjectType of
    ptWin32, ptWin32Dlg, ptWin32Con:
      if FVisualMASMOptions.ML32.FoundFileName='' then
      begin
        ShowMessage('No 32-bit Assembler found or specified.'+CRLF+
          'You can specify a 32-bit assembler in Tools -> Options -> File Locations.');
        result := false;
      end;
    ptWin64:
      if FVisualMASMOptions.ML64.FoundFileName='' then
      begin
        ShowMessage('No 64-bit Assembler found or specified.'+CRLF+
          'You can specify a 64-bit assembler in Tools -> Options -> File Locations.');
        result := false;
      end;
  end;
end;

function Tdm.AssembleProject(project: TProject; useActiveProject: boolean; debug: boolean = false): boolean;
var
  consoleOutput: string;
  errors: string;
  projectFile: TProjectFile;
begin
  result := true;
  if not VerifyFileLocations(project) then
  begin
    result := false;
    exit;
  end;
  ExecuteCommandLines(project.PreAssembleEventCommandLine);

  // Need to create filename first before creating output files
  if not SaveProject(project) then
  begin
    result := false;
    exit;
  end;
  CreateOutputFiles(project, debug);
  ParseDesignerFormsInProject(project);

  case project.ProjectType of
    ptWin32,ptWin64,ptWin32Dlg:
      begin
        AssignManigestToResourceFile(project);
        if not SaveProject(project) then
        begin
          result := false;
          exit;
        end;
      end;
    ptWin32DLL,ptWin16DLL:
      begin
        if project.Functions.Count = 0 then
        begin
          ShowMessage('Export functions first before assembling the DLL.'+CRLF+CRLF+
            'You can export functions by right clicking on the project and selecting "Export Functions".');
          result := false;
          exit;
        end;
      end;
  end;

  frmMain.memOutput.Lines.Add('');
  frmMain.memOutput.Lines.Add('*******************'+StringOfChar('*',length(project.Name)));
  frmMain.memOutput.Lines.Add('Assembling project '+project.Name);
  frmMain.memOutput.Lines.Add('*******************'+StringOfChar('*',length(project.Name)));

  if project.AssembleEventCommandLine = '' then
  begin
    for projectFile in project.ProjectFiles.Values do
    begin
      if (projectFile.ProjectFileType = pftASM) and projectFile.AssembleFile then
        if not AssembleFile(projectFile, project, debug) then
        begin
          result := false;
          exit;
        end;
      if (projectFile.ProjectFileType = pftRC) and projectFile.AssembleFile then
        if not ResourceCompileFile(projectFile, project) then
        begin
          result := false;
          exit;
        end;
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

procedure Tdm.LinkProject(project: TProject; debug: boolean = false);
var
  cmdLine: string;
  consoleOutput: string;
  errors: string;
  switchesFile: string;
  switchesContent: TStringList;
  switches: string;
  manifest: TProjectFile;
  copyResult: boolean;
  path: string;
begin
  try
    if FileExistsStripped(project.OutputFile) then
      TFile.Delete(project.OutputFile);
  finally
  end;

  ExecuteCommandLines(project.PreLinkEventCommandLine);

  if project.LinkEventCommandLine = '' then
  begin
    case project.ProjectType of
      ptWin32,ptWin32Dlg,ptWin32Con,ptWin32DLL:
        cmdLine := ' ""'+FVisualMASMOptions.ML32.Linker32Bit.FoundFileName+'"';
      ptWin64,ptWin64DLL: cmdLine := ' ""'+FVisualMASMOptions.ML64.Linker32Bit.FoundFileName+'"';
      ptDos16COM,ptDos16EXE,ptWin16,ptWin16DLL: cmdLine := ' ""'+FVisualMASMOptions.ML16.Linker16Bit.FoundFileName+'"';
      ptLib: cmdLine := ' ""'+FVisualMASMOptions.ML32.LIB.FoundFileName+'"';
    end;

    switchesFile := CreateSwitchesCommandFile(project, project.OutputFile, debug);

    case project.ProjectType of
      ptWin32,ptWin32Dlg,ptWin32Con,ptWin64:
        begin
          cmdLine := cmdLine + ' @"' + switchesFile + '" @"' + CreateCommandFile(project)+'"';
        end;
      ptDos16COM,ptDos16EXE,ptWin16:
        begin
          switchesContent := TStringList.Create;
          switchesContent.LoadFromFile(switchesFile);
          switches := StringReplace(switchesContent.Text, #13#10, ' ', [rfReplaceAll]);
          cmdLine := cmdLine + ' @"'+ CreateCommandFile(project, switches)+'""';
        end;
      ptWin32DLL,ptWin64DLL:
        begin
          ParseModuleDefinitionFile(project);
          cmdLine := cmdLine + ' @"' + switchesFile + '" @"' + CreateCommandFile(project)+'"';
        end;
      ptWin16DLL:
        begin
          switchesContent := TStringList.Create;
          switchesContent.LoadFromFile(switchesFile);
          switches := StringReplace(switchesContent.Text, #13#10, ' ', [rfReplaceAll]);
          cmdLine := cmdLine + ' @"'+ CreateCommandFile(project, switches)+'""';
        end;
      ptLib:
        begin
          cmdLine := cmdLine + ' @"' + switchesFile + '" @"' + CreateCommandFile(project)+'""';
        end;
    end;
  end else begin
    cmdLine := project.LinkEventCommandLine;
  end;

//  frmMain.memOutput.Lines.Add('Linking with: ');
//  frmMain.memOutput.Lines.Add(cmdLine);

  frmMain.memOutput.Lines.Add('');
  frmMain.memOutput.Lines.Add('****************'+StringOfChar('*',length(project.Name)));
  frmMain.memOutput.Lines.Add('Linking project '+project.Name);
  frmMain.memOutput.Lines.Add('****************'+StringOfChar('*',length(project.Name)));

  GPGExecute('cmd /c'+cmdLine,consoleOutput,errors);
  if errors <> '' then
  begin
    frmMain.memOutput.Lines.Add(errors);
    frmMain.memOutput.Lines.Add(cmdLine);
  end;

  consoleOutput := trim(consoleOutput);
  frmMain.memOutput.Lines.Add(consoleOutput);

  if FileExistsStripped(project.OutputFile) then
  begin
    project.SizeInBytes := FileSizeStripped(project.OutputFile);
    frmMain.memOutput.Lines.Add('Created '+project.OutputFile+' ('+inttostr(project.SizeInBytes)+' bytes)');
  end;

  CleanupFiles(project);

  cmdLine := project.PostLinkEventCommandLine;
  if cmdLine <> '' then
  begin
    //cmdLine := 'C:\VisualMASM\Projects\' + cmdLine;
    //cmdLine := '"' + cmdLine + '"';
    frmMain.memOutput.Lines.Add('');
    frmMain.memOutput.Lines.Add('Executing post link command line:');
    frmMain.memOutput.Lines.Add(cmdLine);
    ShellExecute(Application.Handle, nil, 'cmd.exe', PChar('/K '+cmdLine), nil, SW_SHOWNORMAL);
//    GPGExecute('"cmd.exe /K '+cmdLine,consoleOutput,errors);
//    if errors <> '' then
//      frmMain.memOutput.Lines.Add(errors);
    frmMain.memOutput.Lines.Add('Done');
  end;
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

function Tdm.AssembleFile(pf: TProjectFile; project: TProject; debug: boolean = false): boolean;
var
  cmdLine: string;
  consoleOutput: string;
  errors: string;
  debugOption: string;
begin
  result := false;

  if pf.FileName = '' then
  begin
    ShowMessage('Need to save file '+pf.Name+' first.');
    exit;
  end;

  if not FileExistsStripped(pf.FileName) then
  begin
    frmMain.memOutput.Lines.Add('Error: ' + pf.FileName + ' does not exist.');
    exit;
  end;

  ClearAssemblyErrors(pf);

  if debug then
    debugOption := ' /Zi /Zd /Zf';

  if pf.OutputFile = '' then
    CreateOutputFile(pf, project, debug);

  if FileExistsStripped(pf.OutputFile) then
    TFile.Delete(pf.OutputFile);

  case project.ProjectType of
    ptWin32,ptWin32Dlg,ptLib,ptWin32DLL,ptWin64DLL,ptWin16DLL:
      cmdLine := ' ""'+FVisualMASMOptions.ML32.FoundFileName+'" /Fo'+pf.OutputFile+debugOption+
      ' /c /coff /W3 /nologo "'+pf.FileName+'"';
    ptWin32Con: cmdLine := ' ""'+FVisualMASMOptions.ML32.FoundFileName+'" /Fo'+pf.OutputFile+debugOption+
      ' /c /coff /W3 /nologo "'+pf.FileName+'"';
    ptWin64: cmdLine := ' ""'+FVisualMASMOptions.ML64.FoundFileName+'" /Fo'+pf.OutputFile+debugOption+
      ' /c /W3 /nologo "'+pf.FileName+'"';
    ptDos16COM: cmdLine := ' ""'+FVisualMASMOptions.ML32.FoundFileName+'" /Fo'+
      pf.OutputFile+debugOption+' /c /AT /nologo "'+pf.FileName+'"';
    ptDos16EXE: cmdLine := ' ""'+FVisualMASMOptions.ML32.FoundFileName+'" /Fo'+
      pf.OutputFile+debugOption+' /c /nologo "'+pf.FileName+'"';
    ptWin16: cmdLine := ' ""'+FVisualMASMOptions.ML32.FoundFileName+'" /Fo'+
      pf.OutputFile+debugOption+' /c /W3 /nologo "'+pf.FileName+'"';
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

  if FileExistsStripped(pf.OutputFile) then
    frmMain.memOutput.Lines.Add('Created '+pf.OutputFile+' ('+inttostr(FileSizeStripped(pf.OutputFile))+' bytes)')
  else
    begin
      result := false;
      ParseAssemblyOutput(consoleOutput,pf);
      exit;
    end;

  result := ParseAssemblyOutput(consoleOutput,pf);
  PositionCursorToFirstError(pf);
end;

function Tdm.ResourceCompileFile(pf: TProjectFile; project: TProject): boolean;
var
  cmdLine: string;
  consoleOutput: string;
  errors: string;
begin
  result := false;
  ClearAssemblyErrors(pf);

  frmMain.memOutput.Lines.Add('');
  frmMain.memOutput.Lines.Add('*******************'+StringOfChar('*',length(pf.FileName)));
  frmMain.memOutput.Lines.Add('Compiling resource '+pf.FileName);
  frmMain.memOutput.Lines.Add('*******************'+StringOfChar('*',length(pf.FileName)));

  if pf.OutputFile = '' then
    CreateOutputFile(pf, project);

  if FileExistsStripped(pf.OutputFile) then
    TFile.Delete(pf.OutputFile);

  CheckEnvironmentVariable;

  case project.ProjectType of
    ptWin32,ptWin32Dlg:
      begin
        if FVisualMASMOptions.MSSDKIncludePath <> '' then
          cmdLine := ' "'+FVisualMASMOptions.ML32.RC.FoundFileName+' /V /i "'+FVisualMASMOptions.MSSDKIncludePath+
            '" /fo'+pf.OutputFile+' "'+pf.FileName+'"'
        else
          cmdLine := ' "'+FVisualMASMOptions.ML32.RC.FoundFileName+' /V /fo'+pf.OutputFile+' "'+pf.FileName+'"';
      end;
    ptWin64:
      begin
        if FVisualMASMOptions.MSSDKIncludePath <> '' then
          cmdLine := ' ""'+FVisualMASMOptions.ML64.RC.FoundFileName+' /V /i "'+FVisualMASMOptions.MSSDKIncludePath+
            '" '+pf.OutputFile
        else
          cmdLine := ' ""'+FVisualMASMOptions.ML64.RC.FoundFileName+' /V /fo'+pf.OutputFile+' "'+pf.FileName+'"';
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

  if FileExistsStripped(pf.OutputFile) then
    frmMain.memOutput.Lines.Add('Created '+pf.OutputFile+' ('+inttostr(FileSizeStripped(pf.OutputFile))+' bytes)');

  result := ParseAssemblyOutput(consoleOutput,pf);
  PositionCursorToFirstError(pf);
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
    if projectFile.FileName = projectFile.AssemblyErrors[i].FileName then
    begin
      lineNumber := projectFile.AssemblyErrors[i].LineNumber;
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
    //errorPos := pos(' : error ',o[i]);
    errorPos := pos(' error ',o[i]);
    if errorPos>0 then
    begin
      FWeHaveAssemblyErrors := true;
      result := false;
      lineNoPos := pos('(',o[i]);
      if lineNoPos > 0 then
      begin
        assemblyError.IntId := projectFile.IntId;
        assemblyError.FileName := leftstr(o[i],lineNoPos-1);
        assemblyError.LineNumber := strtoint(copy(o[i],lineNoPos+1,pos(')',o[i])-lineNoPos-1));
        assemblyError.Description := copy(o[i],errorPos+7,256);
        projectFile.AssemblyErrors.Add(assemblyError);
      end;
    end;
  end;
  projectFile.AssemblyErrors.Sort;
end;

procedure Tdm.ClearAssemblyErrors(pf: TProjectFile);
var
  i: integer;
  gotMilk: boolean;
  memo: TSynMemo;
begin
  if pf.ProjectFileType <> pftASM then exit;
  ClearAssembleErrorMarks(pf);
  pf.AssemblyErrors.Clear;
  frmMain.vstErrors.Clear;
  FWeHaveAssemblyErrors := false;
  frmMain.pnlOutput.Show;
end;

procedure Tdm.actProjectMakeActiveProjectExecute(Sender: TObject);
var
  project: TProject;
begin
  project := GetCurrentProjectInProjectExplorer;
  if project = nil then exit;
  HighlightFirstFileInProject(project);
  FGroup.ActiveProject := project;
  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
end;

procedure Tdm.HighlightFirstFileInProject(project: TProject);
var
  projectFile: TProjectFile;
begin
  if project = nil then exit;
  for projectFile in project.ProjectFiles.Values do
  begin
    if projectFile <> nil then
    begin
      project.ActiveFile := projectFile;
      break;
    end;
  end;
  if projectFile <> nil then
    FocusPage(projectFile);
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
  project: TProject;
  currentName: string;
begin
  project := GetCurrentProjectInProjectExplorer;
  if project = nil then exit;
  currentName := project.Name;
  frmRename.CurrentName := currentName;
  frmRename.NewName := project.Name;

  if frmRename.ShowModal = mrOk then
  begin
    project.Name := frmRename.txtNewName.Text;
    project.Modified := true;
    SetProjectName(project, currentName);
    SynchronizeProjectManagerWithGroup;
    UpdateUI(true);
  end;
end;

procedure Tdm.actProjectRunDebugExecute(Sender: TObject);
begin
  RunProject(nil, true, true);
end;

procedure Tdm.actProjectRunExecute(Sender: TObject);
begin
  RunProject(nil, true, false);
end;

procedure Tdm.RunProject(project: TProject; useActiveProject: boolean = true; debug: boolean = false);
var
  cmd: string;
  consoleOutput: string;
  errors: string;
begin
  if project = nil then
    project := GetCurrentProjectInProjectExplorer;
  if not VerifyFileLocations(project) then exit;

  if (project = nil) and (FGroup.ActiveProject = nil) then begin
    ShowMessage('No project has been created, yet.'+CRLF+CRLF+
      'Create a project and add your file(s) to the project, then assemble it.');
    exit;
  end;

  if project = nil then
    project := FGroup.ActiveProject;

  frmMain.memOutput.Clear;

  if FileExistsStripped(project.OutputFile) then
    TFile.Delete(project.OutputFile);

  if not AssembleProject(project, useActiveProject, debug) then
  begin
    FocusTabWithAssemblyErrors(project);
    exit;
  end;
  LinkProject(project, debug);

  if FileExistsStripped(project.OutputFile) then
  begin
    if debug then
    begin
      case dm.VisualMASMOptions.Debugger of
        dtNone: cmd := ' "' + project.OutputFile + '"';
        dtVisualMASM: cmd := ' "' + project.OutputFile + '"';
        dtExternal:
          begin
            cmd := ' "' + stringreplace(dm.VisualMASMOptions.DebuggerFileName, DEBUGGER_OUTPUT_FILE,
              project.OutputFile, [rfReplaceAll, rfIgnoreCase]) + '"';
          end;
      end;
    end else begin
      cmd := ' "' + project.OutputFile + '"';
    end;

    if errors = '' then
      ClearAssembleErrorMarks;

    GPGExecute('cmd /c'+cmd,consoleOutput,errors);
    if errors <> '' then
    begin
      frmMain.memOutput.Lines.Add(errors);
      frmMain.memOutput.Lines.Add(cmdLine);
    end else
    begin
      FocusActiveFileAndMemo;
    end;
  end;
end;

//function Tdm.RunAsAdminAndWaitForCompletion(hWnd: HWND; filename: string; Parameters: string): Boolean;
//{
//    See Step 3: Redesign for UAC Compatibility (UAC)
//    http://msdn.microsoft.com/en-us/library/bb756922.aspx
//}
//var
//  sei: TShellExecuteInfo;
//  ExitCode: DWORD;
//begin
//  ZeroMemory(@sei, SizeOf(sei));
//  sei.cbSize := SizeOf(TShellExecuteInfo);
//  sei.Wnd := hwnd;
//  //sei.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI or SEE_MASK_NOCLOSEPROCESS;
//  sei.fMask := SEE_MASK_NOCLOSEPROCESS;
//  sei.lpVerb := PChar('runas');
//  sei.lpFile := PChar(Filename); // PAnsiChar;
//  if parameters = '' then
//      sei.lpParameters := PChar(parameters); // PAnsiChar;
//  sei.nShow := SW_SHOWNORMAL; //Integer;
//
// if ShellExecuteEx(@sei) then begin
//   repeat
//     Application.ProcessMessages;
//     GetExitCodeProcess(sei.hProcess, ExitCode) ;
//   until (ExitCode = STILL_ACTIVE) or Application.Terminated;
// end;
//end;

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

procedure Tdm.SetProjectName(project: TProject; oldName: string; name: string = '');
var
  extPos,extPos2: integer;
  newName: string;
  nameToProcess: string;
  oldProjectNameWithoutExtension: string;
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
    oldProjectNameWithoutExtension := oldName;
    extPos2 := pos('.',oldProjectNameWithoutExtension);
    if extPos2 > 0 then
      oldProjectNameWithoutExtension := copy(oldProjectNameWithoutExtension, 0, extPos2-1);
    if pos(oldProjectNameWithoutExtension,project.OutputFolder)>0 then
    begin
      project.OutputFolder :=
        StringReplace(project.OutputFolder, oldProjectNameWithoutExtension, newName, [rfReplaceAll, rfIgnoreCase]);
      project.OutputFolder := IncludeTrailingPathDelimiter(project.OutputFolder);
    end;
    newName := ExtractFilePath(project.FileName) + newName + PROJECT_FILE_EXT;
    if FileExistsStripped(project.FileName) then
      RenameFile(project.FileName,newName);
    project.FileName := newName;

    // Set name based on project type
    newName := copy(nameToProcess, 0, extPos-1);
    case project.ProjectType of
      ptWin32,ptWin32Dlg,ptWin32Con,ptWin64,ptDos16EXE,ptWin16: newName := newName + '.exe';
      ptWin32DLL,ptWin64DLL,ptWin16DLL: newName := newName + '.dll';
      ptDos16COM: newName := newName + '.com';
      ptLib: newName := newName + '.lib';
    end;
    project.Name := newName;
    FGroup.Modified := true;
  end;
end;

procedure Tdm.actRemoveFromProjectExecute(Sender: TObject);
var
  data: PProjectData;
  pf: TProjectFile;
begin
  data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
  RemoveTabsheet(FGroup[data.ProjectId].ProjectFile[data.FileId]);
  if (data.Level = 2) or (data.Level = 3) then
  begin
    pf := FGroup.GetProjectFileById(data.FileId);
    if pf <> nil then
      DeleteProjectFileFromDebugPlugin(pf);
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
  with frmMain.Site do
    for x := 0 to PanelCount-1 do
    begin
      //if (Pages[x].Caption = projectFile.Name) or (Pages[x].Caption = (MODIFIED_CHAR+projectFile.Name)) then
      if Panels[x].Tag = projectFile.IntId then
      begin
        Panels[x].Free;
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

procedure Tdm.actResourcesExecute(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', RESOURCES_URL, nil,  nil, SW_SHOWNORMAL);
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
//  projectFile: TProjectFile;
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
//  projectFile: TProjectFile;
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

procedure Tdm.actDesignShowAlignPaletteExecute(Sender: TObject);
begin
  frmMain.AlignPalette.Show;
end;

procedure Tdm.actDesignTestDialogExecute(Sender: TObject);
var
  s: TMemoryStream;
  editor: TfrmEditor;
begin
  editor := GetFrmEditorFromActiveDesigner;
  if editor = nil then exit;
  s := TMemoryStream.Create;
  try
    editor.Module.SaveToStream(s);
    s.Position := 0;

    RunTimeModule.Root := TForm.Create(nil);
    RunTimeModule.LoadFromStream(s);
    RunTimeModule.Root.Align := alNone;
    RunTimeModule.Root.Width := editor.Module.Root.Width;
    RunTimeModule.Root.Height := editor.Module.Root.Height;
  finally
    s.Free;
  end;

  RunTimeModule.Root.Show;
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
  if (FGroup.ActiveProject <> nil) and (FGroup.ActiveProject.ActiveFile<>nil) and
    ((FGroup.ActiveProject.ActiveFile.ChildFileASMId <> '') or
    (FGroup.ActiveProject.ActiveFile.ParentFileId <> '')) then
  begin
    actToggleDialogAssembly.Enabled := true;
  end else begin
    actToggleDialogAssembly.Enabled := false;
  end;
end;

procedure Tdm.CreateStatusBar(pnl: TLMDDockPanel);
var
  statusPanel: TStatusPanel;
begin
  FStatusBar := TStatusBar.Create(pnl);
  FStatusBar.ParentFont := true;
  FStatusBar.Parent := pnl;
  FStatusBar.Align := alBottom;
  FStatusBar.SizeGrip := false;
  FStatusBar.Height := 22;
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
  pnl: TLMDDockPanel;
  memo: TSynMemo;
  designer: TfrmEditor;
  editor: TKHexEditor;
begin
  if projectFile = nil then exit;

  // No need to create editor if it is already loaded
  if IsFileLoadedIntoPanel(projectFile) then
    exit;

  pnl := TLMDDockPanel.Create(frmMain);
  pnl.Caption := projectFile.Name;
  if projectFile.Modified then
    pnl.Caption := MODIFIED_CHAR+pnl.Caption;
  pnl.Tag := projectFile.IntId;
  projectFile.IsOpen := true;
  pnl.Hint := projectFile.Path;
  pnl.ClientKind := dkDocument;
  pnl.OnClose := OnClosePanel;

  DockAsTabbedDoc(pnl);
  if pnl.Zone <> nil then
  begin
    pnl.Zone.Index := pnl.Zone.Parent.ZoneCount - 1;
    pnl.Show; // Activate.
  end;

  if projectFile.ProjectFileType=pftDLG then
  begin
    CreateStatusBar(pnl);
    if FileExistsStripped(projectFile.FileName) then begin
      LoadDialog(projectFile, pnl);
    end else begin
      designer := TfrmEditor.Create(pnl);
      designer.RCFile := FGroup.GetProjectFileById(projectFile.ChildFileRCId);
      designer.ProjectFile := projectFile;
      designer.Parent := pnl;
      designer.Align := alClient;
      designer.Module.Root := TForm.Create(nil);
      with TForm(designer.Module.Root) do
      begin
        Name   := 'DesignForm';
        Align  := alClient;
//        SetWindowLong(Handle, GWL_EXSTYLE,
//          GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
      end;
      designer.Designer.Active := true;
      designer.Selection.Add(designer.Module.Root);
      designer.Module.Root.SetFocus;
    end;
  end else if (projectFile.ProjectFileType=pftBinary) or (projectFile.ProjectFileType = pftLib) then
  begin
    editor := TKHexEditor.Create(pnl);
    editor.Parent := pnl;
    editor.Align := alClient;
    editor.LoadFromFile(projectFile.FileName);
    editor.OnChange := HexEditorChange;
    projectFile.SizeInBytes := editor.GetSize;
    ApplyThemeToHexEditor(editor);
  end else begin
    CreateStatusBar(pnl);
    memo := CreateMemo(projectFile, pnl);
    case projectFile.ProjectFileType of
      pftASM,pftINC: memo.Highlighter := synASMMASM;
      pftRC: memo.Highlighter := synRC;
      pftTXT,pftDef: memo.Highlighter := nil;
      pftDLG: ;
      pftBAT: memo.Highlighter := synBat;
      pftINI: memo.Highlighter := synINI;
      pftCPP: memo.Highlighter := synCPP;
    end;
    synURIOpener.Editor := memo;
    TScanKeywordThread(FWorkerThread).SetModified;
    UpdateStatusBarForMemo(memo);
  end;
end;

procedure Tdm.LoadDialog(projectFile: TProjectFile; pnl: TLMDDockPanel);
var
  designer: TfrmEditor;
begin
  FIgnoreAll := false;
  designer := TfrmEditor.Create(pnl);
  designer.ProjectFile := projectFile;
  designer.RCFile := FGroup.GetProjectFileById(projectFile.ChildFileRCId);
  designer.Parent := pnl;
  designer.Align := alClient;
  designer.Module.Root := TForm.Create(nil);
  designer.Module.LoadFromFile(projectFile.FileName);
  designer.Designer.Active := true;
  projectFile.Modified := false;
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

function Tdm.CreateMemo(projectFile: TProjectFile; pnl: TLMDDockPanel): TSynMemo;
begin
  result := TSynMemo.Create(pnl);
  result.Parent := pnl;
  result.Text := projectFile.Content;
  result.Align := alClient;
  result.PopupMenu := frmMain.popMemo;
  result.TabWidth := 4;
  result.OnChange := DoOnChangeSynMemo; // TDO assigned twice
  result.OnChange := DoChange; // TDO assigned twice
  result.HelpType := htKeyword;
  result.Highlighter := synASMMASM;
  result.BorderStyle := bsNone;
  //memo.ShowHint := true;

  result.OnMouseWheelDown := DoOnMouseWheelDown;
  result.OnMouseWheelUp := DoOnMouseWheelUp;
  result.OnStatusChange := SynEditorStatusChange;
  result.OnSpecialLineColors := SynEditorSpecialLineColors;
  result.OnKeyDown := SynMemoKeyDown;
  result.SearchEngine := SynEditSearch1;
  result.OnMouseCursor := SynMemoMouseCursor;
  result.OnEnter := SynMemoOnEnter;
  result.OnDblClick := DoSynMemoDblClick;
  result.OnPaintTransient := DoOnPaintTransient;

  result.BookMarkOptions.BookmarkImages := ImageList1;
  result.Gutter.ShowLineNumbers := true;
  result.Gutter.DigitCount := 5;
  result.Gutter.Gradient := false;
  result.WantTabs := true;
  result.Options := [eoAutoIndent, eoDragDropEditing, eoEnhanceEndKey,
    eoScrollPastEol, eoShowScrollHint,
    //eoSmartTabs, // eoTabsToSpaces,
    eoSmartTabDelete, TSynEditorOption.eoGroupUndo, eoTabIndent];
//  SynAutoComplete1.AutoCompleteList := FAutoCompletionList;
//  SynAutoComplete1.Editor := memo;

//  FDebugSupportPlugins := TList<TDebugSupportPlugin>.Create;
//  if projectFile.ProjectFileType = pftASM then
//  begin
//    FDebugSupportPlugins.Add(TDebugSupportPlugin.Create(result, projectFile));
//  end;

  AssignColorsToEditor(result);
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
    intId := TLMDDockPanel(TSynMemo(Sender).Parent).Tag;
    pf := FGroup.GetProjectFileByIntId(intId);
    for i:=0 to pf.AssemblyErrors.Count-1 do
    begin
      if pf.AssemblyErrors[i].LineNumber = Line then
      begin
        Special := TRUE;
        //FG := clWhite;
//        FG := clBlack;
//        BG := clRed;

        memo := TSynMemo(Sender);
        //p := CaretXY;
        memo.Marks.ClearLine(Line);
        Mark := TSynEditMark.Create(memo);
        Mark.Line := Line;
        //Line := p.Line;
        //Char := p.Char;
        //Mark.ImageIndex := 11;    // Bug
        Mark.ImageIndex := 10;    // Error
        Mark.Visible := TRUE;
        Mark.InternalImage := memo.BookMarkOptions.BookMarkImages = nil;
        memo.Marks.Place(Mark);
        exit;
      end;
    end;
  end;
end;

procedure Tdm.SynMemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  UpdateFunctionList(GetMemo);

  //if (ssCtrl in Shift) and ((Key = 59) or (Key = 118)) then
  if (ssCtrl in Shift) and (Key = 186) then  // Ctrl+;
    CommentUncommentLine(TSynMemo(Sender));

  if (ssCtrl in Shift) and (Key = 9) then  // Ctrl+Tab
  begin
    ToggleTabs;
    UpdateUI(true);
  end;

  if Key = VK_CONTROL then
    FPressingCtrl := true
  else
    FPressingCtrl := false;

  if Key = VK_F1 then
  begin
    try
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
//var
//  p: TBufferCoord;
//  Token: UnicodeString;
//  Attri: TSynHighlighterAttributes;
//  i,x,y: integer;
//  tabSheet: TsTabSheet;
//  statusBar: TsStatusBar;
//  point: TPoint;
//  projectFile: TProjectFile;
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
      StatusBar.Panels[2].Text := 'ReadOnly'
    else
      StatusBar.Panels[2].Text := InsertModeStrs[TSynMemo(Sender).InsertMode];
  end;

  // Modified property has changed
  if Changes * [scAll, scModified] <> [] then
  begin
    // This code is only executed once after the first
    // modification by the user
    StatusBar.Panels[1].Text := ModifiedStrs[TSynMemo(Sender).Modified];

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
//      Attri := TSynMemo(Sender).Highlighter.GetTokenAttribute;
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
////      cbxAttrSelect.ItemIndex := cbxAttrSelect.Items.IndexOf(Attri.Name);
////      cbxAttrSelectChange(Self);
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
  pf: TProjectFile;
begin
  if (StatusBar = nil) or (memo = nil) then exit;

  p := memo.CaretXY;
  StatusBar.Panels[0].Text := Format('%6d:%3d', [p.Line, p.Char]);
  if memo.Modified then
    FStatusBar.Panels[1].Text := 'Modified'
  else
    FStatusBar.Panels[1].Text := '';
  FStatusBar.Panels[3].Text := Format('Line count: %6d', [memo.Lines.Count]);

  pf := GetProjectFileFromActivePanel;
  if pf <> nil then
    FStatusBar.Panels[4].Text := pf.FileName
  else
    FStatusBar.Panels[4].Text := regularText;
end;

procedure Tdm.UpdateStatusBarFor(regularText: string = '');
var
  pf: TProjectFile;
begin
  if (StatusBar = nil) then exit;
  FStatusBar.Panels[0].Text := '';
  FStatusBar.Panels[1].Text := '';
  FStatusBar.Panels[2].Text := '';
  FStatusBar.Panels[3].Text := '';

  pf := GetProjectFileFromActivePanel;
  if pf <> nil then
    FStatusBar.Panels[4].Text := pf.FileName
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
  memo.Gutter.Color := synASMMASM.SynColors.Editor.Colors.Background;
//  memo.Gutter.Font.Color := synASMMASM.SynColors.Editor.Colors.RightEdge;
//  memo.Gutter.Color := frmMain.sSkinManager1.GetGlobalColor;
//  memo.Gutter.Font.Color := frmMain.sSkinManager1.GetGlobalFontColor;
//  memo.Gutter.BorderColor := frmMain.sSkinManager1.GetGlobalFontColor;
  memo.Gutter.BorderColor := TStyleManager.ActiveStyle.GetStyleColor(TStyleColor.scButtonFocused);
  memo.Gutter.UseFontStyle := true;

  SynCompletionProposal1.Font.Color := clWhite;

//  SynCompletionProposal1.ClBackground := synASMMASM.SynColors.Editor.Colors.CompletionProposalBackground;
//  SynCompletionProposal1.ClBackgroundBorder := synASMMASM.SynColors.Editor.Colors.CompletionProposalBackgroundBorder;
//  SynCompletionProposal1.ClSelect := synASMMASM.SynColors.Editor.Colors.CompletionProposalSelection;
//  SynCompletionProposal1.ClSelectedText := synASMMASM.SynColors.Editor.Colors.CompletionProposalSelectionText;
//  SynCompletionProposal1.ClTitleBackground := synASMMASM.SynColors.Editor.Colors.CompletionProposalTitle;
end;

procedure Tdm.CommentUncommentLine(memo: TSynMemo);
var
  p: TBufferCoord;
  i: integer;
  selectedLines: TStringList;
begin
  p := memo.CaretXY;
  memo.Modified := true;

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

function Tdm.GetMemo: TSynMemo;
var
  x: integer;
  pnl: TLMDDockPanel;
begin
  result := nil;
  pnl := GetActivePanel;
  if pnl = nil then exit;
  for x := 0 to pnl.ControlCount-1 do
  begin
    if pnl.Controls[x] is TSynMemo then
    begin
      result := TSynMemo(pnl.Controls[x]);
      exit;
    end;
  end;
end;

function Tdm.GetMemoFromProjectFile(projectFile: TProjectFile): TSynMemo;
var
  i,x: integer;
begin
  result := nil;
  if projectFile = nil then
    exit;
  with frmMain.Site do
    for i := 0 to PanelCount-1 do
    begin
      if (Panels[i].ClientKind = dkDocument) and (Panels[i].Tag = projectFile.IntId) then
      begin
        for x := 0 to Panels[i].ControlCount-1 do
        begin
          if Panels[i].Controls[x] is TSynMemo then
          begin
            result := TSynMemo(Panels[i].Controls[x]);
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
  pnl: TLMDDockPanel;
  pf: TProjectFile;
  project: TProject;
  runnable: boolean;
begin
  if startingUp or ShuttingDown then
  begin
    exit;
  end;

  pf := GetProjectFileFromActivePanel;
  project := GetCurrentProjectInProjectExplorer;

  runnable := false;
  if project <> nil then
    runnable := (project.ProjectType=ptDos16COM) or (project.ProjectType=ptDos16EXE) or (project.ProjectType=ptWin32) or
    (project.ProjectType=ptWin32Con) or (project.ProjectType=ptWin32Dlg) or (project.ProjectType=ptWin64);

  memoVisible := (pf <> nil) and (pf.ProjectFileType <> pftDLG);
  dlgVisible := (pf <> nil) and (pf.ProjectFileType = pftDLG);

  frmMain.mnuDesign.Visible := dlgVisible;

  if StatusBar <> nil then
    StatusBar.Visible := memoVisible;

  actAddExistingProject.Enabled := true;

  actEditUndo.Enabled := memoVisible;
  actEditRedo.Enabled := memoVisible;
  actEditCut.Enabled := memoVisible;
  actEditCopy.Enabled := memoVisible;
  actEditPaste.Enabled := memoVisible;
  actEditDelete.Enabled := memoVisible;
  actEditCommentLine.Enabled := memoVisible;
  actEditSelectAll.Enabled := memoVisible;
  actEditIncreaseFontSize.Enabled := memoVisible;
  actEditDecreaseFontSize.Enabled := memoVisible;
  actFileCloseAll.Enabled := memoVisible;
  actFileSaveAs.Enabled := memoVisible;
  actSearchGoToFunction.Enabled := memoVisible;
  actSearchGoToLabel.Enabled := memoVisible;
  actProjectAssemble.Enabled := memoVisible;
  actProjectOptions.Enabled := memoVisible;
  actEditHighlightWords.Enabled := memoVisible;
  actEditLowerCase.Enabled := memoVisible;
  actEditUpperCase.Enabled := memoVisible;
  actEditCamcelCase.Enabled := memoVisible;
  actSave.Enabled := memoVisible or dlgVisible;
  actFileSaveAll.Enabled := memoVisible or dlgVisible;
  actProjectRun.Enabled := (memoVisible or dlgVisible) and runnable;
  actProjectRunDebug.Enabled := (memoVisible or dlgVisible) and runnable;

  UpdateToggleUI;

  if ((memoVisible) or (dlgVisible)) and highlightActiveNode then
  begin
    pnl := GetActivePanel;
    if pnl <> nil then
      HighlightNode(pnl.Tag);
  end;

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
    if frmMain.vstFunctions <> nil then
      frmMain.vstFunctions.Clear;
    if frmMain.vstLabels <> nil then
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

  if (memoVisible) and (pf <> nil) and (pf.ProjectFileType <> pftDLG) then
  begin
    memo := GetSynMemoFromProjectFile(pf);
    if memo <> nil then
    begin
      UpdateStatusBarForMemo(memo);
      DoOnChangeSynMemo(memo);
    end;
  end else begin
    dm.Functions.Clear;
    dm.Labels.Clear;
    if frmMain.vstLabels <> nil then
      frmMain.vstLabels.Clear;
    if frmMain.vstFunctions <> nil then
      frmMain.vstFunctions.Clear;
    UpdateStatusBarFor('');
  end;
  if memoVisible and (pf <> nil) and (StatusBar <> nil)then
  begin
    //memo := GetSynMemoFromProjectFile(FGroup.ActiveProject.ActiveFile);
    StatusBar.Panels[4].Text := pf.FileName;
  end;

  UpdateRunMenu;
  UpdateProjectMenuItems;
end;

procedure Tdm.HighlightNode(intId: integer);
var
  node: PVirtualNode;
  data: PProjectData;
begin
  if ShuttingDown or (frmMain.vstProject = nil) then exit;
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
  foundIt: boolean;
  memo: TSynMemo;
  pnl: TLMDDockPanel;
begin
  foundIt := false;

  if projectFile <> nil then
  begin
    pnl := GetPanelByProjectFileIntId(projectFile.IntId);
    if pnl <> nil then
    begin
      pnl.Show;
      foundIt := true;
      FocusMemo(pnl);
      if updateContent then
      begin
        memo := GetMemo;
        memo.Text := projectFile.Content;
      end;
      UpdateUI(true);
    end else begin
      // Open the file
      CreateEditor(projectFile);
      foundIt := true;
    end;
  end;

  if not foundIt then
  begin
    // File is not open, yet. So, open it.
    //data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
    if TFile.Exists(FGroup.ActiveProject.ActiveFile.FileName) then
    begin
      FGroup.ActiveProject.ActiveFile.Content := TFile.ReadAllText(FGroup.ActiveProject.ActiveFile.FileName);
      CreateEditor(Group.ActiveProject.ActiveFile);
    end;
  end;
end;

procedure Tdm.FocusMemo(pnl: TLMDDockPanel);
var
  i: integer;
begin
  for i := 0 to pnl.ControlCount-1 do
  begin
    if pnl.Controls[i] is TSynMemo then
    begin
      TSynMemo(pnl.Controls[i]).SetFocus;
      exit;
    end;
  end;
end;

procedure Tdm.SynMemoOnEnter(sender: TObject);
begin
  if AtLeastOneDocumentOpen then
  begin
    if sender is TSynMemo then begin
      SynCompletionProposal1.Editor := sender as TSynMemo;
      scpParams.Editor := sender as TSynMemo;
      synURIOpener.Editor := sender as TSynMemo;
    end;
  end;
  UpdateUI(true);
end;

procedure Tdm.CloseProjectFile(intId: integer);
var
  projectFile: TProjectFile;
  child: TProjectFile;
  pnl: TLMDDockPanel;
begin
  projectFile := FGroup.GetProjectFileByIntId(intId);
  if projectFile = nil then exit;
  SaveFileContent(projectFile);
  projectFile.MarkFileClosed;
//  ClosePanelByProjectFileIntId(intId);

  if projectFile.ChildFileASMId <> '' then
  begin
    child := FGroup.GetProjectFileById(projectFile.ChildFileASMId);
    if child <> nil then
    begin
      pnl := GetPanelByProjectFileIntId(child.IntId);
      if pnl <> nil then
        pnl.Close;
    end;
  end;

  if projectFile.ChildFileASMId <> '' then
  begin
    child := FGroup.GetProjectFileById(projectFile.ChildFileRCId);
    if child <> nil then
    begin
      pnl := GetPanelByProjectFileIntId(child.IntId);
      if pnl <> nil then
        pnl.Close;
    end;
  end;

  UpdateUI(true);
end;

procedure Tdm.SaveFileContent(projectFile: TProjectFile);
var
  fn: string;
  memo: TSynMemo;
  designer: TfrmEditor;
  hexEditor: TKHexEditor;
begin
  if projectFile.Modified = false then exit;

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
    designer.Module.SaveToFile(projectFile.FileName);
    projectFile.SizeInBytes := length(projectFile.Content);
  end else if (projectFile.ProjectFileType=pftBinary) or (projectFile.ProjectFileType=pftLib) then
  begin
    hexEditor := GetHexEditorFromProjectFile(projectFile);
    if hexEditor = nil then
    begin
      ShowMessage('Project file is not a binary file.');
      exit;
    end else
      hexEditor.SaveToFile(projectFile.FileName);
  end else begin
    memo := GetSynMemoFromProjectFile(projectFile);
    if memo <> nil then
    begin
      projectFile.Content := memo.Text;
      memo.Modified := false;
    end;
    TFile.WriteAllText(projectFile.FileName, projectFile.Content);
    projectFile.SizeInBytes := length(projectFile.Content);
  end;

  projectFile.Modified := false;

  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
  UpdatePageCaption(projectFile);
end;

function Tdm.GetFormDesignerFromProjectFile(projectFile: TProjectFile): TfrmEditor;
var
  i,x: integer;
begin
  result := nil;
  if projectFile = nil then
  begin
    ShowMessage('No file highlighted. Select a file in the project explorer.');
    exit;
  end;
  with frmMain.Site do
    for i := 0 to PanelCount-1 do
    begin
      if Panels[i].Tag = projectFile.IntId then
      begin
        for x := 0 to Panels[i].ControlCount-1 do
        begin
          if Panels[i].Controls[x] is TfrmEditor then
          begin
            result := TfrmEditor(Panels[i].Controls[x]);
            exit;
          end;
        end;
      end;
    end;
end;

function Tdm.GetSynMemoFromProjectFile(projectFile: TProjectFile): TSynMemo;
var
  x: integer;
  pnl: TLMDDockPanel;
begin
  result := nil;
  if projectFile = nil then
  begin
    ShowMessage('No file highlighted. Select a file in the project explorer.');
    exit;
  end;
  pnl := GetPanelByProjectFileIntId(projectFile.IntId);
  if pnl = nil then exit;
  for x := 0 to pnl.ControlCount-1 do
  begin
    if pnl.Controls[x] is TSynMemo then
    begin
      result := TSynMemo(pnl.Controls[x]);
      exit;
    end;
  end;
end;

function Tdm.PromptForFileName(projectFile: TProjectFile): string;
var
  project: TProject;
begin
  project := FGroup.GetProjectByFileId(projectFile.Id);
  dlgSave.Title := 'Save '+projectFile.Name+' As';
  dlgSave.Filter := ANY_FILE_FILTER;
  dlgSave.FilterIndex := 1;
  if length(projectFile.FileName)>0 then
    dlgSave.FileName := project.OutputFolder+ExtractFileName(projectFile.FileName)
  else
    dlgSave.FileName := project.OutputFolder+projectFile.Name;
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
begin
  if fileName = '' then exit;

  FLastOpenDialogDirectory := ExtractFilePath(fileName);
  fileExt := UpperCase(ExtractFileExt(fileName));

  UpdateMenuWithLastUsedFiles(fileName);

//  FDebugSupportPlugins := TList<TDebugSupportPlugin>.Create;
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
  fName: string;
  i: integer;
  activeProjectId: string;
  projectFileName: string;
  json: TJSONObject;
  dateTime: TDateTime;
  projectId: string;
begin
  if not FileExistsStripped(fileName) then exit;

  actFileCloseAllExecute(self);
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

  FGroup.BuildOrder.Clear;
  for i := 0 to json['Group']['BuildOrder'].Count-1 do
  begin
    projectId := json['Group']['BuildOrder'].Items[i].S['Id'];
    FGroup.BuildOrder.Add(projectId);
  end;

  FGroup.Modified := false;

  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
  FocusFileInTabs(FGroup.LastFileOpenId);
end;

procedure Tdm.FocusFileInTabs(id: string);
var
  projectFile: TProjectFile;
  pnl: TLMDDockPanel;
  memo: TSynMemo;
begin
  if FGroup = nil then exit;
  projectFile := FGroup.GetProjectFileById(id);
  if projectFile <> nil then
  begin
    pnl := GetPanelByProjectFileIntId(projectFile.IntId);
    if pnl = nil then exit;
    pnl.Show;
    memo := GetMemo;
    if memo <> nil then memo.SetFocus;
  end;
end;

function Tdm.LoadProject(fileName: string): TProject;
var
  fName: string;
  i: integer;
  project: TProject;
  projectFile: TProjectFile;
  json: TJSONObject;
  fd: TFunctionData;
begin
  result := nil;
  if not FileExistsStripped(fileName) then exit;

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
  project.OutputFolder := json['Project'].S['OutputFolder'];
  if project.OutputFolder = '' then
    ResetProjectOutputFolder(project);
  project.SizeInBytes := json['Project'].L['SizeInBytes'];
  project.Build := json['Project'].B['Build'];

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

    project.SavedFunctions.Clear;
    for i := 0 to json['ExportedFunctions'].Count-1 do
    begin
      fd.FileId := json['ExportedFunctions'].Items[i].S['FileId'];
      fd.FileName := json['ExportedFunctions'].Items[i].S['FileName'];
      fd.Line := json['ExportedFunctions'].Items[i].I['Line'];
      fd.Name := json['ExportedFunctions'].Items[i].S['Name'];
      fd.ExportAs := json['ExportedFunctions'].Items[i].S['ExportAs'];
      fd.Export := true;
      project.SavedFunctions.Add(fd);
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
  ResetProjectOutputFolder(project);

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
//var
//  projectFile: TProjectFile;
//  memo: TSynMemo;
begin
//  if not frmMain.Active then exit;
//  projectFile := GetCurrentFileInProjectExplorer;
//  if projectFile = nil then exit;
//  memo := GetSynMemoFromProjectFile(projectFile);

  //make sure StatusBar1's AutoHint = true
//  UpdateStatusBarForMemo(memo,Application.Hint);
end;

procedure Tdm.HideWelcomePage;
//var
//  i: integer;
begin
//  for i := 0 to frmMain.sPageControl1.PageCount-1 do
//  begin
//    if frmMain.sPageControl1.Pages[i].Name = 'tabWelcome' then
//    begin
//      frmMain.sPageControl1.Pages[i].Free;
//      exit;
//    end;
//  end;
end;

procedure Tdm.ToggleBookMark(bookmark: integer);
var
  memo: TSynMemo;
begin
  memo := GetSynMemoFromProjectFile(FGroup.ActiveProject.ActiveFile);
  if memo = nil then exit;
  if memo.IsBookmark(bookmark) then
    memo.ClearBookMark(bookmark)
  else
    memo.SetBookMark(bookmark,memo.CaretX,memo.CaretY);
end;

procedure Tdm.GoToBookMark(bookmark: integer);
var
  memo: TSynMemo;
begin
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

procedure Tdm.PromptForFile(fn: string; txtControl: TEdit);
var
  path: string;
begin
  dlgOpen.Title := 'Locate '+fn;
  dlgOpen.FileName := fn;
  if length(txtControl.Text)>2 then
  begin
    path := ExtractFilePath(txtControl.Text);
    if FileExistsStripped(path+fn) then
      dlgOpen.FileName := path+fn;
  end;
  if dlgOpen.Execute then
    txtControl.Text := dlgOpen.FileName;
end;

function Tdm.CreateSwitchesCommandFile(project: TProject; finalFile: string; debug: boolean = false): string;
var
  fileName: string;
  content: TStringList;
  switches: TStringList;
  shortPath: string;
  defFile: TProjectFile;
begin
  shortPath := ExtractShortPathName(ExtractFilePath(project.FileName));
  //fileName := ExtractFilePath(project.FileName)+TEMP_FILE_PREFIX+'switches.txt';
  fileName := shortPath+TEMP_FILE_PREFIX+'switches.txt';
  content := TStringList.Create;

  if debug and (project.ProjectType<>ptLib) then
  begin
    case project.ProjectType of
      ptWin32,ptWin32Dlg,ptWin32Con,ptWin32DLL:
        begin
          content.Add('/DEBUG');
          content.Add('/DEBUGTYPE:COFF');
        end;
      ptWin64,ptWin64DLL:
        begin
          content.Add('/DEBUG:FULL');
        end;
      ptDos16COM,ptDos16EXE,ptWin16,ptWin16DLL:
        begin
        end;
    end;
    content.Add('/MAP');
  end;

  case project.ProjectType of
    ptWin32,ptWin32Dlg:
      begin
        content.Add('/NOLOGO');
        content.Add('/SUBSYSTEM:WINDOWS');
        content.Add('/MACHINE:IX86');
        if length(project.LibraryPath)>1 then
          content.Add('/LIBPATH:"'+project.LibraryPath+'"');
        content.Add('/OUT:'+finalFile);
      end;
    ptWin32DLL:
      begin
        content.Add('/NOLOGO');
        content.Add('/SUBSYSTEM:WINDOWS');
        content.Add('/MACHINE:IX86');
        if length(project.LibraryPath)>1 then
          content.Add('/LIBPATH:"'+project.LibraryPath+'"');
        content.Add('/OUT:'+finalFile);
        content.Add('/DLL');
        defFile := GetDefFileFromProject(project);
        if defFile <> nil then
          content.Add('/DEF:"'+defFile.FileName+'"');
      end;
    ptWin32Con:
      begin
        content.Add('/NOLOGO');
        content.Add('/SUBSYSTEM:CONSOLE');
        content.Add('/MACHINE:IX86');
        if length(project.LibraryPath)>1 then
          content.Add('/LIBPATH:"'+project.LibraryPath+'"');
        content.Add('/OUT:'+finalFile);
      end;
    ptWin64:
      begin
        content.Add('/NOLOGO');
        content.Add('/SUBSYSTEM:WINDOWS');
        content.Add('/MACHINE:X64');
        if length(project.LibraryPath)>1 then
          content.Add('/LIBPATH:"'+project.LibraryPath+'"');
        content.Add('/OUT:'+finalFile);
      end;
    ptWin64DLL:
      begin
        content.Add('/NOLOGO');
        content.Add('/SUBSYSTEM:WINDOWS');
        content.Add('/MACHINE:X64');
        if length(project.LibraryPath)>1 then
          content.Add('/LIBPATH:"'+project.LibraryPath+'"');
        content.Add('/OUT:'+finalFile);
        content.Add('/DLL');
        defFile := GetDefFileFromProject(project);
        if defFile <> nil then
          content.Add('/DEF:"'+defFile.FileName+'"');
      end;
    ptDos16COM:
      begin
        content.Add('/NOLOGO');
        //content.Add('/AT');
        content.Add('/TINY');
      end;
    ptDos16EXE,ptWin16:
      begin
        content.Add('/NOLOGO');
      end;
    ptWin16DLL:
      begin
        content.Add('/NOLOGO');
        content.Add('/DLL');
        defFile := GetDefFileFromProject(project);
        if defFile <> nil then
          content.Add('/DEF:"'+defFile.FileName+'"');
      end;
    ptLib:
      begin
        content.Add('/NOLOGO');
        content.Add('/SUBSYSTEM:WINDOWS');
        content.Add('/MACHINE:IX86');
        if length(project.LibraryPath)>1 then
          content.Add('/LIBPATH:"'+project.LibraryPath+'"');
        content.Add('/OUT:'+finalFile);
        content.Add('/VERBOSE');
      end;
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

function Tdm.CreateCommandFile(project: TProject; switches: string = ''): string;
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

  if length(switches)>0 then
    content.Add(switches);

  for projectFile in project.ProjectFiles.Values do
  begin
    case projectFile.ProjectFileType of
      pftASM, pftRC:
        begin
          if projectFile.AssembleFile then
          begin
            case project.ProjectType of
              ptDos16COM, ptDos16EXE:
                begin
                  content.Add(ExtractShortPathName(StringReplace(projectFile.OutputFile, '"', '', [rfReplaceAll])));
                end;
              else
                begin
                  content.Add(projectFile.OutputFile);
                end;
            end;
          end;
        end;
      pftLib,pftBinary:
        begin
          content.Add(ExtractShortPathName(projectFile.FileName));
        end;
    end;
  end;

  case project.ProjectType of
    ptWin32,ptWin32Dlg: ;
    ptWin32Con: ;
    ptWin64: ;
    ptWin32DLL: ;
    ptWin64DLL: ;
    ptDos16COM, ptDos16EXE:
      begin
        fileName := StringReplace(project.OutputFile, '"', '', [rfReplaceAll]);
        shortPath := ExtractShortPathName(ExtractFilePath(fileName));
        content.Add(','+shortPath+project.Name+';');
        content.Text := StringReplace(content.Text, #13#10, ' ', [rfReplaceAll]);
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
          if FileExistsStripped(path+sr.Name) then
            TFile.Delete(path+sr.Name);
        end;
      until FindNext(sr) <> 0;
      System.SysUtils.FindClose(sr);
    end;
  except

  end;
end;

procedure Tdm.FocusTabWithAssemblyErrors(project: TProject);
var
  i: integer;
  pf: TProjectFile;
begin
//  for i:= 0 to FDebugSupportPlugins.Count-1 do
//  begin
//    pf := FDebugSupportPlugins.Items[i].ProjectFile;
//    if (pf <> nil) and (pf.AssemblyErrors.Count > 0) then
//    begin
//      FocusPage(pf);
//      exit;
//    end;
//  end;
  for pf in project.ProjectFiles.Values do
  begin
    if pf.AssemblyErrors.Count > 0 then
    begin
      DisplayErrorPanel(pf);
      FocusPage(pf);
      PositionCursorToFirstError(pf);
      exit;
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

procedure Tdm.PromptForPath(caption: string; txtControl: TEdit);
begin
//  dlgPath.Caption := caption;
  if length(txtControl.Text)>2 then
    dlgPath.DefaultFolder := txtControl.Text;
  if dlgPath.Execute then
    txtControl.Text := dlgPath.FileName;
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
//  Percent: integer;
//  line: integer;
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
        if p=0 then
          p := pos(uSharedGlobals.TAB+'PROC',Uppercase(FSource.Strings[x]));
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
              functionData.FileId := FFileId;
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
  begin
    fSource.Text := dm.Group.ActiveProject.ActiveFile.Content;
    FFileId := dm.Group.ActiveProject.ActiveFile.Id;
  end;
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

//procedure TScanKeywordThread.ShowProgress;
//begin
//  if frmMain <> nil then
//    frmMain.StatusBar1.SimpleText := Format('%d %% done', [fLastPercent]);
//end;

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
  if memo = nil then exit;
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
begin
  LoadColors(name);
  AssignColorsToAllMemos(updateTabs);
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
//  wordStart: integer;
begin
  if memo.SelAvail then
  begin
//    wordStart := memo.WordStart.Char;
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

function Tdm.CreateMethod(const MethName: string; fileId: string): Boolean;
var
  SL: TStringList;
  lineNumber: integer;
  projectFile: TProjectFile;
  memo: TSynMemo;
  InsertionPos: TBufferCoord;
  StrToInsert: string;
begin
  if fileId = '' then exit;
  projectFile := FGroup.GetProjectFileById(fileId);

  dm.Group.ActiveProject.ActiveFile := projectFile;

  Result := (MethName <> '') and (FunctionExistsInSourceFile(MethName,projectFile) = false);

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
  end else begin
    GoToMethod(MethName, fileId);
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

//procedure Tdm.GetParamList(ptData: PTypeData; SL: TStrings);
//var
//  i, k: integer;
//  pName, pType: PShortString;
//  ParamFlags: TParamFlags;
//  sParFlags: string;
//const
//   ParamFlagToStr: array[TParamFlag] of AnsiString = ('var ', 'const ', '', '', '', 'out ', '');
//begin
//  k := 0;
//  for i := 1 to ptData^.ParamCount do
//   begin
//    ParamFlags := TParamFlags(ptData^.ParamList[k]);
//    sParFlags := '';
////    for ParamFlag := Low(ParamFlag) to High(ParamFlag) do
////      if ParamFlag in ParamFlags then
////        sParFlags := sParFlags + ParamFlagToStr[ParamFlag];
//
//    Inc(k);
//    pName := @ptData^.ParamList[k];
//    Inc(k, Length(pName^) + 1);
//    pType := @ptData^.ParamList[k];
//    Inc(k, Length(pType^) + 1);
//    SL.Add(sParFlags + pName^ + '=' + pType^);
//   end;
//end;

procedure Tdm.DoOnMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if ssCtrl in Shift Then
    actEditDecreaseFontSizeExecute(Sender);
end;

procedure Tdm.DoOnMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if ssCtrl in Shift Then
    actEditIncreaseFontSizeExecute(sender);
end;

procedure Tdm.SynMemoMouseCursor(Sender: TObject; const aLineCharPos: TBufferCoord; var aCursor: TCursor);
var
  point: TPoint;
  Token: UnicodeString;
  Attri: TSynHighlighterAttributes;
begin
  if (FVisualMASMOptions.DoNotShowToolTips) or (frmMain.pnlHelp = nil) then exit;

  if TSynMemo(Sender).GetHighlighterAttriAtRowCol(aLineCharPos, Token, Attri) then
  begin
    if Assigned(Attri) and (FToken <> Token) then
    begin
      point := Mouse.CursorPos;
      if Attri.Name = 'Api' then
      begin
//        frmMain.sAlphaHints1.ShowHint(point, 'Win32 API: <b>'+Token+'</b>'+BR2+'Press <b>F1</b> for help on '+Token, 30000);
        if FPressingCtrl then
        begin
          // http://www.experts-exchange.com/Programming/Languages/Q_22725085.html
        end;
        //Application.HelpKeyword(Token);
      end else if Attri.Name = 'Directives' then begin
        if FDirectives.IndexOf(lowercase(Token))>-1 then
          frmMain.htmlHelp.PositionTo(Token)
      end else if Attri.Name = 'Register' then begin
        if FRegisters.IndexOf(lowercase(Token))>-1 then
          frmMain.htmlHelp.PositionTo(Token)
      end else if Attri.Name = 'ReservedWord' then begin
        if FMnemonics.IndexOf(lowercase(Token))>-1 then
          frmMain.htmlHelp.PositionTo(Token)
      end else if Attri.Name = 'Operator' then begin
        if FOperators.IndexOf(lowercase(Token))>-1 then
          frmMain.htmlHelp.PositionTo(Token)
      end;
      FToken := Token;
      FAttributes := Attri;
    end;
  end else
//    frmMain.sAlphaHints1.HideHint;
end;

procedure Tdm.LoadParamterList;
var
  list: TStringlist;
  i: Integer;
  lookup,parameters: string;
  atPos: integer;
begin
  FParamList := TStringList.Create;
  FParamLookupList := TStringList.Create;
  list := TStringlist.Create;
  list.LoadFromFile(FVisualMASMOptions.AppFolder+DATA_FOLDER+CODE_PARAM_LIST_FILENAME);
  for i := 0 to list.Count-1 do
  begin
    lookup := list[i];
    atPos := pos(',', lookup);
    lookup := lowercase(copy(lookup,1,atPos-1));
    FParamLookupList.Add(lookup);
    parameters := trim(copy(list[i],atPos+1));
    //FParamList.Add(parameters);
    FParamList.Add(list[i]);
  end;

end;

function Tdm.CountOccurences(const SubText: string; const Text: string): integer;
begin
  if (SubText = '') OR (Text = '') OR (Pos(SubText, Text) = 0) then
    Result := 0
  else
    Result := (Length(Text) - Length(StringReplace(Text, SubText, '', [rfReplaceAll]))) div  Length(subtext);
end;

procedure Tdm.DockAsTabbedDoc(APanel: TLMDDockPanel);
var
  zn: TLMDDockZone;
begin
  zn := frmMain.Site.SpaceZone;
  while (zn <> nil) and (zn.Kind <> zkTabs) and
        (zn.ZoneCount > 0) do
    zn := zn[0];

  if zn <> nil then
    frmMain.Site.DockControl(APanel, zn, alClient);
end;

function Tdm.GetActivePanel: TLMDDockPanel;
var
  i: Integer;
  pf: TProjectFile;
begin
  result := nil;
  for i := 0 to frmMain.Site.PanelCount-1 do
  begin
    if frmMain.Site.Panels[i].ClientKind = dkDocument then
    begin
      if frmMain.Site.Panels[i].Showing then
      begin
        pf := FGroup.GetProjectFileByIntId(frmMain.Site.Panels[i].Tag);
        if pf <> nil then
        begin
          result := frmMain.Site.Panels[i];
          exit;
        end;
      end;
    end;
  end;
end;

function Tdm.AtLeastOneDocumentOpen: boolean;
var
  i: Integer;
  pnl: TLMDDockPanel;
begin
  result := false;
  pnl := GetActivePanel;
  if pnl = nil then exit;
  result := true;
end;

function Tdm.GetPanelByProjectFileIntId(id: integer): TLMDDockPanel;
var
  i: Integer;
begin
  result := nil;
  for i := 0 to frmMain.Site.PanelCount-1 do
  begin
    if frmMain.Site.Panels[i].ClientKind = dkDocument then
    begin
      if frmMain.Site.Panels[i].Tag = id then
      begin
        result := frmMain.Site.Panels[i];
        exit;
      end;
    end;
  end;
end;

procedure Tdm.ClosePanelByProjectFileIntId(intId: integer);
var
  pnl: TLMDDockPanel;
begin
  pnl := GetPanelByProjectFileIntId(intID);
  if pnl <> nil then
    //pnl.Free;
    pnl.Close;
end;

procedure Tdm.ClosePanelsByProject(project: TProject);
var
  i: integer;
  projectFile: TProjectFile;
begin
  with frmMain.Site do
    for i := PanelCount-1 downto 0 do
    begin
      for projectFile in project.ProjectFiles.Values do
      begin
        if Panels[i].Tag = projectFile.IntId then
        begin
          Panels[i].Free;
          break;
        end;
      end;
    end;
end;

function Tdm.GetStatusBar: TStatusBar;
var
  x: integer;
  pnl: TLMDDockPanel;
begin
  result := nil;
  FStatusBar := result;
  pnl := GetActivePanel;
  if pnl = nil then exit;
  for x := 0 to pnl.ControlCount-1 do
  begin
    if pnl.Controls[x] is TStatusBar then
    begin
      result := TStatusBar(pnl.Controls[x]);
      FStatusBar := result;
      exit;
    end;
  end;
end;

function Tdm.GetProjectFileFromActivePanel: TProjectFile;
var
  pnl: TLMDDockPanel;
begin
  result := nil;
  pnl := GetActivePanel;
  if pnl = nil then exit;
  result := FGroup.GetProjectFileByIntId(pnl.Tag);
end;

procedure Tdm.FocusActiveFileAndMemo;
begin
  if (FGroup <> nil) and (FGroup.ActiveProject <> nil) and (FGroup.ActiveProject.ActiveFile <> nil) then
    FocusPage(FGroup.ActiveProject.ActiveFile);
end;

procedure Tdm.Parse(c: TComponent; rcFile: TProjectFile = nil);
var
  sl: TStringList;
  f: TForm;
  i: integer;
  spaces: string;
  btn: TButton;
  lbl: TLabel;
  memo: TSynMemo;
  //rcFile: TProjectFile;
  ctrlType: string;
  edt: TEdit;
  chk: TCheckbox;
  rdio: TRadioButton;
  cmb: TComboBox;
  lst: TListBox;
  lstv: TListView;
  grp: TGroupBox;
  scl: TScrollBar;
  tv: TTreeView;
  leftDLUs, topDLUs, widthDLUs, heightDLUs: integer;
  manifest: TProjectFile;
  filename: string;
begin
  if rcFile = nil then
    rcFile := FGroup.GetProjectFileById(dm.Group.ActiveProject.ActiveFile.ChildFileRCId);
  if rcFile <> nil then
  begin
    if c is TForm then begin
      spaces := '   ';
      f := TForm(c);
      sl := TStringList.Create;
      sl.Add(NEW_ITEM_RC_HEADER);
      sl.Add('');

      sl.Add('#include "\masm32\include\resource.h"');

//      sl.Add('#include <'+SDK_PATH+'\windows.h>');
//      sl.Add('#include <'+SDK_PATH+'\commctrl.h>');
//      sl.Add('#include <'+SDK_PATH+'\richedit.h>');

//#ifndef  CREATEPROCESS_MANIFEST_RESOURCE_ID
//#define  CREATEPROCESS_MANIFEST_RESOURCE_ID  1
//#endif
//
//#ifndef  RT_MANIFEST
//#define  RT_MANIFEST                         24
//#endif
//
//CREATEPROCESS_MANIFEST_RESOURCE_ID RT_MANIFEST "program.xml"
      //sl.Add('1  24  DISCARDABLE	"C:\\Users\\Thomas\\Documents\\GitHub\\VisualMASM\\Win32\\Debug\\Projects\\Win32AppDlg\\Manifest.xml"');
      manifest := FGroup.GetProjectByFileId(rcFile.Id).GetManifest;
      if manifest <> nil then
      begin
        filename := StringReplace(manifest.FileName,'\','\\',[rfReplaceAll, rfIgnoreCase]);
        sl.Add('1  24  DISCARDABLE	"'+filename+'"');
      end;
      sl.Add('');

      // Create definitations
      for i:=0 to f.ComponentCount-1 do
      begin
        sl.Add('#define '+f.Components[i].Name+' ' + inttostr(i+1000));
      end;
      sl.Add('');

      // Dialog definition
      // https://msdn.microsoft.com/en-us/library/windows/desktop/aa381003(v=vs.85).aspx
      // https://msdn.microsoft.com/en-us/library/windows/desktop/aa381002(v=vs.85).aspx
      GetDlgBaseUnits(f.Font.Handle, f.Left, f.Top, f.ClientWidth, f.ClientHeight, leftDLUs, topDLUs, widthDLUs, heightDLUs);

      sl.Add(f.Name+' DIALOGEX '+inttostr(leftDLUs)+', '+inttostr(topDLUs)+
        ', '+inttostr(widthDLUs)+', '+inttostr(heightDLUs));

      sl.Add(GetDialogStyle(f));
      sl.Add('CAPTION "'+f.Caption+'"');
      sl.Add('CLASS "DLGCLASS"');
      sl.Add('FONT '+inttostr(f.Font.Size)+', "'+f.Font.Name+'"');
      sl.Add('{');
      for i:=0 to f.ComponentCount-1 do
      begin
        if f.Components[i] is TButton then begin
          btn := TButton(f.Components[i]);
          GetDlgBaseUnits(btn.Font.Handle, btn.Left, btn.Top, btn.Width, btn.Height, leftDLUs, topDLUs, widthDLUs, heightDLUs);
          if btn.Default then
            ctrlType := 'DEFPUSHBUTTON'
          else
            ctrlType := 'PUSHBUTTON';
          sl.Add(spaces+ctrlType+' "'+btn.Caption+'", '+btn.Name+GetCommonProperties(leftDLUs, topDLUs, widthDLUs, heightDLUs)+
            GetButtonStyle(btn));
        end;
        if f.Components[i] is TLabel then begin
          lbl := TLabel(f.Components[i]);
          GetDlgBaseUnits(lbl.Font.Handle, lbl.Left, lbl.Top, lbl.Width, lbl.Height, leftDLUs, topDLUs, widthDLUs, heightDLUs);
          if lbl.Alignment = taLeftJustify then
            ctrlType := 'LTEXT'
          else
            ctrlType := 'RTEXT';
          sl.Add(spaces+ctrlType+' "'+lbl.Caption+'", '+lbl.Name+GetCommonProperties(leftDLUs, topDLUs, widthDLUs, heightDLUs));
        end;
        if f.Components[i] is TEdit then begin
          edt := TEdit(f.Components[i]);
          GetDlgBaseUnits(edt.Font.Handle, edt.Left, edt.Top, edt.Width, edt.Height, leftDLUs, topDLUs, widthDLUs, heightDLUs);
          ctrlType := 'EDITTEXT';
          sl.Add(spaces+ctrlType+' '+edt.Name+GetCommonProperties(leftDLUs, topDLUs, widthDLUs, heightDLUs));
        end;
        if f.Components[i] is TCheckbox then begin
          chk := TCheckbox(f.Components[i]);
          GetDlgBaseUnits(chk.Font.Handle, chk.Left, chk.Top, chk.Width, chk.Height, leftDLUs, topDLUs, widthDLUs, heightDLUs);
          ctrlType := 'CHECKBOX';
          sl.Add(spaces+ctrlType+' "'+chk.Caption+'", '+chk.Name+GetCommonProperties(leftDLUs, topDLUs, widthDLUs, heightDLUs));
        end;
        if f.Components[i] is TRadioButton then begin
          rdio := TRadioButton(f.Components[i]);
          GetDlgBaseUnits(rdio.Font.Handle, rdio.Left, rdio.Top, rdio.Width, rdio.Height, leftDLUs, topDLUs, widthDLUs, heightDLUs);
          ctrlType := 'RADIOBUTTON';
          sl.Add(spaces+ctrlType+' "'+rdio.Caption+'", '+rdio.Name+GetCommonProperties(leftDLUs, topDLUs, widthDLUs, heightDLUs));
        end;
        if f.Components[i] is TComboBox then begin
          cmb := TComboBox(f.Components[i]);
          GetDlgBaseUnits(cmb.Font.Handle, cmb.Left, cmb.Top, cmb.Width, cmb.Height, leftDLUs, topDLUs, widthDLUs, heightDLUs);
          ctrlType := 'COMBOBOX';
          sl.Add(spaces+ctrlType+' '+cmb.Name+GetCommonProperties(leftDLUs, topDLUs, widthDLUs, heightDLUs));
        end;
        if f.Components[i] is TListBox then begin
          lst := TListBox(f.Components[i]);
          GetDlgBaseUnits(lst.Font.Handle, lst.Left, lst.Top, lst.Width, lst.Height, leftDLUs, topDLUs, widthDLUs, heightDLUs);
          ctrlType := 'LISTBOX';
          sl.Add(spaces+ctrlType+' '+lst.Name+GetCommonProperties(leftDLUs, topDLUs, widthDLUs, heightDLUs));
        end;
        if f.Components[i] is TListView then begin
          lstv := TListView(f.Components[i]);
          GetDlgBaseUnits(lstv.Font.Handle, lstv.Left, lstv.Top, lstv.Width, lstv.Height, leftDLUs, topDLUs, widthDLUs, heightDLUs);
          ctrlType := 'CONTROL';
          sl.Add(spaces+ctrlType+' "", '+lstv.Name+', WC_LISTVIEW, WS_TABSTOP | WS_BORDER | LVS_ALIGNLEFT | LVS_REPORT'+
            GetCommonProperties(leftDLUs, topDLUs, widthDLUs, heightDLUs));
        end;
        if f.Components[i] is TGroupBox then begin
          grp := TGroupBox(f.Components[i]);
          GetDlgBaseUnits(grp.Font.Handle, grp.Left, grp.Top, grp.Width, grp.Height, leftDLUs, topDLUs, widthDLUs, heightDLUs);
          ctrlType := 'GROUPBOX';
          sl.Add(spaces+ctrlType+' "'+grp.Caption+'", '+grp.Name+GetCommonProperties(leftDLUs, topDLUs, widthDLUs, heightDLUs));
        end;
        if f.Components[i] is TScrollBar then begin
          scl := TScrollBar(f.Components[i]);
          //GetDlgBaseUnits(scl.Font.Handle, scl.ClientWidth, scl.ClientHeight, HorizontalDLU, VerticalDLU);
          ctrlType := 'SCROLLBAR';
          sl.Add(spaces+ctrlType+' '+scl.Name+GetCommonProperties(scl.Left, scl.Top, widthDLUs, heightDLUs));
        end;
        if f.Components[i] is TTreeView then begin
          tv := TTreeView(f.Components[i]);
          GetDlgBaseUnits(tv.Font.Handle, tv.Left, tv.Top, tv.Width, tv.Height, leftDLUs, topDLUs, widthDLUs, heightDLUs);
          ctrlType := 'CONTROL';
          sl.Add(spaces+ctrlType+' "", '+tv.Name+', WC_TREEVIEW, WS_TABSTOP | WS_BORDER | TVS_INFOTIP | TVS_NOSCROLL'+
            GetCommonProperties(leftDLUs, topDLUs, widthDLUs, heightDLUs));
        end;
      end;
      sl.Add('}');

      rcFile.Content := sl.Text;
      memo := dm.GetMemoFromProjectFile(rcFile);
      if memo <> nil then
        memo.Text := rcFile.Content;
      rcFile.Modified := true;
      // IDD_DIALOG1 DIALOG 0, 0, 240, 120
      SynchronizeProjectManagerWithGroup;
    end;
  end;
end;

function Tdm.GetDialogStyle(f: TForm): string;
begin
  // https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  // https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx

  // Dialog Style
  //https://msdn.microsoft.com/en-us/library/windows/desktop/ff729172(v=vs.85).aspx
  result := 'STYLE ';
  if f.Caption<>'' then result := result + ' WS_CAPTION';
  if f.BorderStyle = bsSingle then result := result + ' | WS_BORDER';
  if f.BorderStyle = bsSizeable then result := result + ' | WS_SIZEBOX';
  if f.BorderStyle = bsDialog then result := result + ' | WS_DLGFRAME';
  if biSystemMenu in f.BorderIcons then result := result + ' | WS_SYSMENU';
  if biMinimize in f.BorderIcons then result := result + ' | WS_MINIMIZEBOX';
  if biMaximize in f.BorderIcons then result := result + ' | WS_MAXIMIZEBOX';
  if biHelp in f.BorderIcons then result := result + ' | WS_EX_CONTEXTHELP';
  if f.WindowState = wsMinimized then result := result + ' | WS_MINIMIZE';
  if f.WindowState = wsMaximized then result := result + ' | WS_MAXIMIZE';
  if f.Position = poScreenCenter then result := result + ' | DS_CENTER';
  result := result + ' | WS_POPUP';
end;

function Tdm.GetCommonProperties(left, top, width, height: integer): string;
begin
  // https://msdn.microsoft.com/en-us/library/windows/desktop/aa380902(v=vs.85).aspx
  result := ', '+inttostr(left)+', '+
    inttostr(top)+', '+
    inttostr(width)+', '+
    inttostr(height);
end;

function Tdm.GetButtonStyle(btn: TButton): string;
begin
  // https://msdn.microsoft.com/en-us/library/windows/desktop/bb775951(v=vs.85).aspx
  result := ', BS_PUSHBUTTON | BS_CENTER ';
end;

procedure Tdm.OnClosePanel(Sender: Tobject; var CloseAction: TLMDockPanelCloseAction);
var
  pnl: TLMDDockPanel;
begin
  CloseAction := caFree;
  pnl := TLMDDockPanel(Sender);
  if pnl <> nil then
    CloseProjectFile(pnl.Tag);
end;

procedure Tdm.CloseAllDialogsBeforeSwitchingTheme;
var
  i: integer;
  f: TProjectFile;
begin
  with frmMain.Site do
    for i := PanelCount-1 downto 0 do
    begin
      f := FGroup.GetProjectFileByIntId(Panels[i].Tag);
      if (f <> nil) and (f.ProjectFileType = pftDLG) then
        Panels[i].Close;
    end;
end;

procedure Tdm.AssignColorsToAllMemos(updateTabs: boolean = true);
var
  i,x: integer;
  memo: TSynMemo;
  hex: TKHexEditor;
begin
  // Update all open memo controls
  if updateTabs then
    with frmMain.Site do
      for i := 0 to PanelCount-1 do
      begin
        for x := 0 to Panels[i].ControlCount-1 do
        begin
          if Panels[i].Controls[x] is TSynMemo then
          begin
            memo := TSynMemo(Panels[i].Controls[x]);
//            memo.ActiveLineColor := BrightenColor(frmMain.sSkinManager1.GetGlobalColor);
//            memo.SelectedColor.Background := frmMain.sSkinManager1.GetHighLightColor(true);
//            memo.SelectedColor.Foreground := frmMain.sSkinManager1.GetHighLightFontColor(true);
//            memo.Gutter.Color := frmMain.sSkinManager1.GetGlobalColor;
//            memo.Gutter.Font.Color := frmMain.sSkinManager1.GetGlobalFontColor;
            memo.Gutter.BorderColor := TStyleManager.ActiveStyle.GetStyleColor(TStyleColor.scButtonFocused);
            AssignColorsToEditor(memo);
          end;
          if Panels[i].Controls[x] is TKHexEditor then
          begin
            hex := TKHexEditor(Panels[i].Controls[x]);
            ApplyThemeToHexEditor(hex);
          end;
        end;
      end;
end;

procedure Tdm.AdjustBasedOnTheme(theme: string);
begin
  with FVisualMASMOptions do
  begin
    //Amakrits.json
    //Amethyst Kamri.json
    //Aqua Graphite.json
    //Aqua Light Slate.json
    //Auric.json
    //Blue.json
    //Carbon.json
    //Charcoal Dark Slate.json
    //Cobalt XEMedia.json
    //Cyan Dusk.json
    //Cyan Night.json
    //Default.json
    //Emerald Light Slate.json
    //Golden Graphite.json
    //Iceberg Classico.json
    //Lavender Classico.json
    //Light.json
    //Luna.json
    //Metropolis UI Black.json
    //Metropolis UI Blue.json
    //Metropolis UI Dark.json
    //Metropolis UI Green.json
    //Obsidian.json
    //Ruby Graphite.json
    //Sapphire Kamri.json
    //Silver.json
    //Slate Classico.json
    //Smokey Quartz Kamri.json
    //Turquoise Gray.json
    //Windows.json
    if IsThemeBright then
    begin
      ApplyBrightHelp;
      ApplyBrightRCHighLighting;
      ApplyBrightBATHighLighting;

    end else
    begin
      ApplyDarkHelp(theme);
      ApplyDarkRCHighLighting;
      ApplyDarkBATHighLighting;
      ApplyDarkSelectionColorForTrees;
    end;
  end;
end;

procedure Tdm.ApplyDarkSelectionColorForTrees;
begin
  frmMain.vstProject.Colors.SelectionTextColor := clBlack;
  frmMain.vstFunctions.Colors.SelectionTextColor := clBlack;
  frmMain.vstLabels.Colors.SelectionTextColor := clBlack;
  frmMain.vstErrors.Colors.SelectionTextColor := clBlack;
end;

function Tdm.IsThemeBright: boolean;
var
  Theme: string;
begin
  Theme := FVisualMASMOptions.Theme;
  if (Theme='Amethyst Kamri') or (Theme='Aqua Light Slate') or (Theme='Cyan Dusk') or
    (Theme='Cyan Night') or (Theme='Emerald Light Slate') or (Theme='Iceberg Classico') or
    (Theme='Lavender Classico') or (Theme='Light') or (Theme='Luna') or (Theme='Metropolis UI Black') or
    (Theme='Metropolis UI Blue') or (Theme='Metropolis UI Dark') or (Theme='Metropolis UI Green') or
    (Theme='Obsidian') or (Theme='Sapphire Kamri') or (Theme='Silver') or (Theme='Slate Classico') or
    (Theme='Smokey Quartz Kamri') or (Theme='Turquoise Gray') or (Theme='Windows') then
    result := true
  else
    result := false;
end;

procedure Tdm.ApplyDarkHelp(theme: string);
var
  element: TSynColorsElement;
  identifierColor, keywordsColor: TColor;
begin
  for element in synASMMASM.SynColors.Elements do
  begin
    if element.Name = 'Identifier' then begin
      identifierColor := element.Foreground;
      //break;
    end;
    if element.Name = 'Keywords' then begin
      keywordsColor := element.Foreground;
      //colStr := TColorToHex(identifierColor);
      //break;
    end;
  end;

  logoFile := FVisualMASMOptions.AppFolder+IMAGES_FOLDER+'VisualMASM_white_256x183_web.png';
  frmMain.imgLogo.Picture.LoadFromFile(logoFile);

  codeCompletionListFileName := FVisualMASMOptions.AppFolder+DATA_FOLDER+'CodeComplImplListFinal_Dark.txt';
  LoadCodeCompletionList;

  if (theme='Aqua Graphite') or (theme='Carbon') or (theme='Golden Graphite') or
    (theme='Ruby Graphite') then
  begin
    frmMain.htmlHelp.DefBackground := clBlack;
  end else
  begin
    frmMain.htmlHelp.DefBackground := TStyleManager.ActiveStyle.GetSystemColor(clWindow);
  end;
  frmMain.htmlHelp.DefFontName := FVisualMASMOptions.ContextHelpFontName;
  frmMain.htmlHelp.DefFontColor := identifierColor;
  frmMain.htmlHelp.DefFontSize := FVisualMASMOptions.ContextHelpFontSize;
  frmMain.htmlHelp.DefHotSpotColor := keywordsColor;
  frmMain.htmlHelp.LoadFromFile(FVisualMASMOptions.AppFolder+'Help\default.html');
end;

procedure Tdm.ApplyBrightHelp;
var
  element: TSynColorsElement;
  identifierColor, keywordsColor: TColor;
begin
  for element in synASMMASM.SynColors.Elements do
  begin
    if element.Name = 'Identifier' then begin
      identifierColor := element.Foreground;
      //break;
    end;
    if element.Name = 'Keywords' then begin
      keywordsColor := element.Foreground;
      //colStr := TColorToHex(identifierColor);
      //break;
    end;
  end;

  logoFile := FVisualMASMOptions.AppFolder+IMAGES_FOLDER+'VisualMASM_256x163_web_2.png';
  frmMain.imgLogo.Picture.LoadFromFile(logoFile);

  codeCompletionListFileName := FVisualMASMOptions.AppFolder+DATA_FOLDER+'CodeComplImplListFinal_Bright.txt';
  LoadCodeCompletionList;

  frmMain.htmlHelp.DefBackground := clWhite;
  frmMain.htmlHelp.DefFontName := FVisualMASMOptions.ContextHelpFontName;
  frmMain.htmlHelp.DefFontColor := clBlack;
  frmMain.htmlHelp.DefFontSize := FVisualMASMOptions.ContextHelpFontSize;
  frmMain.htmlHelp.DefHotSpotColor := keywordsColor;
  frmMain.htmlHelp.LoadFromFile(FVisualMASMOptions.AppFolder+'Help\blue.html');
end;

procedure Tdm.LoadCodeCompletionList;
begin
  SynCompletionProposal1.ItemList.Clear;
  FCodeCompletionList.LoadFromFile(codeCompletionListFileName);
  SynCompletionProposal1.ItemList := FCodeCompletionList;

//  FCodeCompletionInsertList.Add('BlaBla');
//  FCodeCompletionList.Add('BlaBla');
//  FCodeCompletionList.IndexOf()

  if FCodeCompletionInsertList.Count <> FCodeCompletionList.Count then
  begin
    ShowMessage('Code completion lists are not equal in length and appear to be corrupt.');
    SynCompletionProposal1.InsertList := nil;
    SynCompletionProposal1.ItemList := nil;
  end;
end;

function Tdm.FunctionExistsInSourceFile(functionName: string; pf: TProjectFile): boolean;
var
  x,i,p: integer;
  source: TStringList;
  s: string;
  comment: boolean;
begin
  result := false;
  source := TStringList.Create;
  source.Text := pf.Content;

  for x := 0 to source.Count-1 do begin
    p := pos(' PROC',Uppercase(source.Strings[x]));
    if p=0 then
      p := pos(uSharedGlobals.TAB+'PROC',Uppercase(source.Strings[x]));
    if p > 0 then begin
      s := trim(copy(source.Strings[x],0,p-1));
      if (length(s)>0) then begin
        comment := false;
        for i := p downto 1 do begin
          if s[i]=';' then begin
            comment := true;
            break;
          end;
        end;
        if (s[1] <> ';') and (not comment) then begin
          if SameText(s,functionName) then
          begin
            result := true;
            exit;
          end;
        end;
      end;
    end;
  end;
end;

function Tdm.GetFrmEditorFromActiveDesigner: TfrmEditor;
var
  x: integer;
  pnl: TLMDDockPanel;
begin
  result := nil;
  pnl := GetActivePanel;
  if pnl = nil then exit;
  for x := 0 to pnl.ControlCount-1 do
  begin
    if pnl.Controls[x] is TfrmEditor then
    begin
      result := TfrmEditor(pnl.Controls[x]);
      exit;
    end;
  end;
end;

procedure Tdm.SiteChanged;
var
  pf: TProjectFile;
  pnl: TLMDDockPanel;
  x: integer;
begin
  dm.SynchronizeProjectManagerWithGroup;
  dm.UpdateUI(true);

  pf := GetCurrentFileInProjectExplorer;
  if pf = nil then exit;

  if FLastTabIndex = 0 then
    FLastTabIndex := pf.IntId;

  if pf.ProjectFileType = pftDLG then
  begin
    pnl := GetActivePanel;
    for x := 0 to pnl.ControlCount-1 do
    begin
      if pnl.Controls[x] is TfrmEditor then
      begin
        FDesigner := TLMDDesigner(pnl.Controls[x]);
        UpdateActionItemsWithCurrentDesigner;
        exit;
      end;
    end;
  end;
end;

procedure Tdm.UpdateActionItemsWithCurrentDesigner;
begin
  LMDAlignToGrid1.Designer := FDesigner;
  LMDAlignLeft1.Designer := FDesigner;
  LMDAlignRight1.Designer := FDesigner;
  LMDAlignHSpaceEqually1.Designer := FDesigner;
  LMDAlignHCenter1.Designer := FDesigner;
  LMDAlignHCenterInWindow1.Designer := FDesigner;
  LMDAlignTop1.Designer := FDesigner;
  LMDAlignBottom1.Designer := FDesigner;
  LMDAlignVSpaceEqually1.Designer := FDesigner;
  LMDAlignVCenter1.Designer := FDesigner;
  LMDAlignVCenterInWindow1.Designer := FDesigner;
  LMDDsgCut1.Designer := FDesigner;
  LMDDsgCopy1.Designer := FDesigner;
  LMDDsgPaste1.Designer := FDesigner;
  LMDDsgSelectAll1.Designer := FDesigner;
  LMDDsgDelSelected1.Designer := FDesigner;
  LMDDsgClearLocks1.Designer := FDesigner;
  LMDDsgLockSelected1.Designer := FDesigner;
  LMDDsgBringToFront1.Designer := FDesigner;
  LMDDsgSendToBack1.Designer := FDesigner;
  LMDDsgTabOrderDlg1.Designer := FDesigner;
  LMDDsgCreationOrderDlg1.Designer := FDesigner;
end;

procedure Tdm.UpdateRunMenu;
var
  menuItem: TMenuItem;
  project: TProject;
begin
  frmMain.popRunDebug.Items.Clear;
  frmMain.popRunRelease.Items.Clear;

  if (FGroup <> nil) and (FGroup.ActiveProject <> nil) then
    for project in FGroup.Projects.Values do
    begin
      menuItem := TMenuItem.Create(self);
      menuItem.Caption := ExtractFilePath(project.FileName)+project.Name;
      //menuItem.OnDrawItem := MenuItemDrawItem;
      menuItem.Tag := project.IntId;
      menuItem.RadioItem := true;
      menuItem.GroupIndex := 1;
      menuItem.OnClick := OnRunDebugMenuItemClick;
      if FGroup.ActiveProject.Id = project.Id then
        menuItem.Checked := true;
      frmMain.popRunDebug.Items.Add(menuItem);

      menuItem := TMenuItem.Create(self);
      menuItem.Caption := ExtractFilePath(project.FileName)+project.Name;
      //menuItem.OnDrawItem := MenuItemDrawItem;
      menuItem.Tag := project.IntId;
      menuItem.RadioItem := true;
      menuItem.GroupIndex := 1;
      menuItem.OnClick := OnRunReleaseMenuItemClick;
      if FGroup.ActiveProject.Id = project.Id then
        menuItem.Checked := true;
      frmMain.popRunRelease.Items.Add(menuItem);
    end;
end;

procedure Tdm.OnRunDebugMenuItemClick(Sender: TObject);
var
  project: TProject;
  menuItem: TMenuItem;
begin
  if Sender is TMenuItem then
  begin
    menuItem := TMenuItem(Sender);
    project := FGroup.GetProjectByIntId(menuItem.Tag);
    RunProject(project, false, true);
  end;
end;

procedure Tdm.OnRunReleaseMenuItemClick(Sender: TObject);
var
  project: TProject;
  menuItem: TMenuItem;
begin
  if Sender is TMenuItem then
  begin
    menuItem := TMenuItem(Sender);
    project := FGroup.GetProjectByIntId(menuItem.Tag);
    RunProject(project, false, false);
  end;
end;

procedure Tdm.MenuItemDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
var
  TextS: string;
  project: TProject;
  menuItem: TMenuItem;
begin
  if Sender is TMenuItem then
  begin
    menuItem := TMenuItem(Sender);
    project := FGroup.GetProjectByIntId(menuItem.Tag);
    if FGroup.ActiveProject.Id = project.Id then
      ACanvas.Font.Style := [fsBold];
    //DrawText(ACanvas.Handle, PChar(TMenuItem(Sender).Caption), -1, ARect, DT_VCENTER or DT_SINGLELINE or DT_EXPANDTABS);
    //ACanvas.Brush.Color := $DDEB2D;
    //ACanvas.Font.Color := $5312CF; // changes the color of the Text in the menu Item
    //ACanvas.FillRect(ARect);
    //ARect.Left := ACanvas.TextWidth('  ');
    //Dec(ARect.Right, 1);
    //TextS :=  ShortCutToText(TMenuItem(Sender).ShortCut);
    //DrawText(ACanvas.Handle, PChar(TMenuItem(Sender).Caption), -1, ARect, DT_VCENTER or DT_SINGLELINE or DT_EXPANDTABS);
    //if TextS <> '' then
    //  DrawText(ACanvas.Handle, PChar(TextS), -1, ARect, DT_VCENTER or DT_SINGLELINE or DT_RIGHT);
    //ACanvas.TextOut(ARect.Left+6, ARect.Top+2, TMenuItem(Sender).Caption);
    ACanvas.TextOut(ARect.Left+6, ARect.Top+2, TMenuItem(Sender).Caption);
  end;
end;

procedure Tdm.CreateOutputFiles(project: TProject; debug: boolean = false);
var
  outputFolder: string;
  projectFile: TProjectFile;
  path: string;
begin
  path := project.OutputFolder;
  if debug then
    path := path + 'Debug\'
  else
    path := path + 'Release\';
  ForceDirectories(path);
  project.OutputFile := '"'+path + project.Name+'"';
  for projectFile in project.ProjectFiles.Values do
  begin
    if (projectFile.ProjectFileType = pftASM) and projectFile.AssembleFile then
      projectFile.OutputFile := '"'+path+ChangeFileExt(ExtractFileName(projectFile.FileName), '') + '.obj"';
    if (projectFile.ProjectFileType = pftRC) and projectFile.AssembleFile then
      projectFile.OutputFile := '"'+path+ChangeFileExt(ExtractFileName(projectFile.FileName), '') + '.res"';
  end;
end;

procedure Tdm.CreateOutputFile(pf: TProjectFile; project: TProject; debug: boolean = false);
var
  outputFolder: string;
  path: string;
begin
  if pf.FileName = '' then
  begin
    ShowMessage('Need to save file first.');
    exit;
  end;
  path := project.OutputFolder;
  if debug then
    path := path + 'Debug\'
  else
    path := path + 'Release\';
  ForceDirectories(path);
  project.OutputFile := '"'+path + project.Name+'"';
  if (pf.ProjectFileType = pftASM) and pf.AssembleFile then
    pf.OutputFile := '"'+path+ChangeFileExt(ExtractFileName(pf.FileName), '') + '.obj"';
  if (pf.ProjectFileType = pftRC) and pf.AssembleFile then
    pf.OutputFile := '"'+path+ChangeFileExt(ExtractFileName(pf.FileName), '') + '.res"';
end;

procedure Tdm.ResetProjectOutputFolder(project: TProject);
begin
  project.OutputFolder := IncludeTrailingPathDelimiter(VisualMASMOptions.CommonProjectsFolder+
    StringReplace(project.Name, ExtractFileExt(project.Name), '', [rfReplaceAll, rfIgnoreCase]));
end;

procedure Tdm.ApplyBrightRCHighLighting;
begin
  synRC.CommentAttri.Background := clNone;
  synRC.CommentAttri.Foreground := clGreen;
  synRC.CommentAttri.Style := [fsItalic];

  synRC.DirecAttri.Background := clNone;
  synRC.DirecAttri.Foreground := $00999900;
  synRC.DirecAttri.Style := [fsBold];

  synRC.IdentifierAttri.Background := clNone;
  synRC.IdentifierAttri.Foreground := clNavy;
  synRC.IdentifierAttri.Style := [];

  synRC.KeyAttri.Background := clNone;
  synRC.KeyAttri.Foreground := clNavy;
  synRC.KeyAttri.Style := [fsBold];

  synRC.NumberAttri.Background := clNone;
  synRC.NumberAttri.Foreground := clBlue;
  synRC.NumberAttri.Style := [fsBold];

  synRC.SpaceAttri.Background := clNone;
  synRC.SpaceAttri.Foreground := clNone;
  synRC.SpaceAttri.Style := [];

  synRC.StringAttri.Background := clNone;
  synRC.StringAttri.Foreground := clBlue;
  synRC.StringAttri.Style := [];

  synRC.SymbolAttri.Background := clNone;
  synRC.SymbolAttri.Foreground := clFuchsia;
  synRC.SymbolAttri.Style := [fsBold];
end;

procedure Tdm.ApplyDarkRCHighLighting;
begin
  synRC.CommentAttri.Background := clNone;
  synRC.CommentAttri.Foreground := $0000C600;  // Green
  synRC.CommentAttri.Style := [fsItalic];

  synRC.DirecAttri.Background := clNone;
  synRC.DirecAttri.Foreground := $004080FF;    // Orange
  synRC.DirecAttri.Style := [fsBold];

  synRC.IdentifierAttri.Background := clNone;
  synRC.IdentifierAttri.Foreground := clSilver;
  synRC.IdentifierAttri.Style := [fsBold];

  synRC.KeyAttri.Background := clNone;
  synRC.KeyAttri.Foreground := clSkyBlue;
  synRC.KeyAttri.Style := [fsBold];

  synRC.NumberAttri.Background := clNone;
  synRC.NumberAttri.Foreground := clWhite;
  synRC.NumberAttri.Style := [fsBold];

  synRC.SpaceAttri.Background := clNone;
  synRC.SpaceAttri.Foreground := clNone;
  synRC.SpaceAttri.Style := [];

  synRC.StringAttri.Background := clNone;
  synRC.StringAttri.Foreground := clMoneyGreen;
  synRC.StringAttri.Style := [fsBold];

  synRC.SymbolAttri.Background := clNone;
  synRC.SymbolAttri.Foreground := clFuchsia;
  synRC.SymbolAttri.Style := [fsBold];
end;

procedure Tdm.ApplyBrightBATHighLighting;
begin
  synBAT.CommentAttri.Background := clNone;
  synBAT.CommentAttri.Foreground := clGreen;
  synBAT.CommentAttri.Style := [fsItalic];

  synBAT.IdentifierAttri.Background := clNone;
  synBAT.IdentifierAttri.Foreground := clNavy;
  synBAT.IdentifierAttri.Style := [];

  synBAT.KeyAttri.Background := clNone;
  synBAT.KeyAttri.Foreground := clRed;
  synBAT.KeyAttri.Style := [fsBold];

  synBAT.NumberAttri.Background := clNone;
  synBAT.NumberAttri.Foreground := clBlue;
  synBAT.NumberAttri.Style := [fsBold];

  synBAT.SpaceAttri.Background := clNone;
  synBAT.SpaceAttri.Foreground := clNone;
  synBAT.SpaceAttri.Style := [];

  synBAT.VariableAttri.Background := clNone;
  synBAT.VariableAttri.Foreground := clFuchsia;
  synBAT.VariableAttri.Style := [fsBold];
end;

procedure Tdm.ApplyDarkBATHighLighting;
begin
  synBAT.CommentAttri.Background := clNone;
  synBAT.CommentAttri.Foreground := $0000C600;  // Green
  synBAT.CommentAttri.Style := [fsItalic];

  synBAT.IdentifierAttri.Background := clNone;
  synBAT.IdentifierAttri.Foreground := clSilver;
  synBAT.IdentifierAttri.Style := [fsBold];

  synBAT.KeyAttri.Background := clNone;
  synBAT.KeyAttri.Foreground := $004080FF;    // Orange
  synBAT.KeyAttri.Style := [fsBold];

  synBAT.NumberAttri.Background := clNone;
  synBAT.NumberAttri.Foreground := clWhite;
  synBAT.NumberAttri.Style := [fsBold];

  synBAT.SpaceAttri.Background := clNone;
  synBAT.SpaceAttri.Foreground := clNone;
  synBAT.SpaceAttri.Style := [];

  synBAT.VariableAttri.Background := clNone;
  synBAT.VariableAttri.Foreground := clFuchsia;
  synBAT.VariableAttri.Style := [fsBold];
end;

procedure Tdm.UpdateProjectMenuItems;
var
  project: TProject;
  menuItem: TMenuItem;
begin
  if (FGroup = nil) or (FGroup.ActiveProject = nil) then exit;
  project := FGroup.ActiveProject;
  actExportFunctions.Visible := false;

  with frmMain.mnuProjectAddNewOther do
  begin
    Clear;
    case project.ProjectType of
      ptDos16COM, ptDos16EXE:
        begin
          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actAddNewAssemblyFile;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actAddNewTextFile;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actAddNewBatchFile;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Caption := '-';
          Add(menuItem);
        end;
      ptWin16:
        begin
          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actAddNewAssemblyFile;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actFileAddNewDialog;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actAddNewTextFile;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actAddNewBatchFile;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Caption := '-';
          Add(menuItem);
        end;
      ptWin32, ptWin32Dlg, ptWin64:
        begin
          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actAddNewAssemblyFile;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actFileAddNewDialog;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actAddNewTextFile;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actAddNewBatchFile;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Caption := '-';
          Add(menuItem);
        end;
      ptWin16DLL, ptWin32DLL, ptWin64DLL:
        begin
          actExportFunctions.Visible := true;

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actAddNewAssemblyFile;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actFileAddNewDialog;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actAddNewTextFile;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actAddNewBatchFile;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Caption := '-';
          Add(menuItem);
        end;
      ptWin32Con:
        begin
          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actAddNewAssemblyFile;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actAddNewTextFile;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Action := dm.actAddNewBatchFile;
          Add(menuItem);

          menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
          menuItem.Caption := '-';
          Add(menuItem);
        end;
    end;

    menuItem := TMenuItem.Create(frmMain.mnuProjectAddNewOther);
    menuItem.Action := dm.actNewOther;
    Add(menuItem);
  end;
end;

procedure Tdm.ToggleTabs;
var
  currentPageIndex: integer;
  pnl: TLMDDockPanel;
begin
  pnl := GetActivePanel;
  if (pnl = nil) or (FLastTabIndex = pnl.Tag) then exit;
  currentPageIndex := pnl.Tag;
  FocusPanel(FLastTabIndex);
  FLastTabIndex := currentPageIndex;
  UpdateUI(true);
end;

procedure Tdm.FocusPanel(fileIntId: integer);
var
  i: integer;
begin
  if fileIntId = 0 then exit;
  for i := 0 to frmMain.Site.PanelCount-1 do
  begin
    if frmMain.Site.Panels[i].ClientKind = dkDocument then
    begin
      if frmMain.Site.Panels[i].Tag = fileIntId then
      begin
        frmMain.Site.Panels[i].Show;
        exit;
      end;
    end;
  end;
end;

procedure Tdm.HexEditorChange(Sender: TObject);
var
  pf: TProjectFile;
  intId: integer;
begin
  intId := TLMDDockPanel(TKHexEditor(Sender).Parent).Tag;
  pf := FGroup.GetProjectFileByIntId(intId);
  if pf <> nil then
  begin
    pf.Modified := TKHexEditor(Sender).Modified;
    SynchronizeProjectManagerWithGroup;
    UpdateUI(true);
  end;
end;

function Tdm.GetHexEditorFromProjectFile(projectFile: TProjectFile): TKHexEditor;
var
  i,x: integer;
begin
  result := nil;
  if projectFile = nil then
  begin
    ShowMessage('No file highlighted. Select a file in the project explorer.');
    exit;
  end;
  with frmMain.Site do
    for i := 0 to PanelCount-1 do
    begin
      if Panels[i].Tag = projectFile.IntId then
      begin
        for x := 0 to Panels[i].ControlCount-1 do
        begin
          if Panels[i].Controls[x] is TKHexEditor then
          begin
            result := TKHexEditor(Panels[i].Controls[x]);
            exit;
          end;
        end;
      end;
    end;
end;

function Tdm.GetDefFileFromProject(project: TProject): TProjectFile;
var
  projectFile: TProjectFile;
begin
  result := nil;
  for projectFile in project.ProjectFiles.Values do
  begin
    if projectFile.ProjectFileType = pftDef then
    begin
      result := projectFile;
      exit;
    end;
  end;
end;

procedure Tdm.ParseModuleDefinitionFile(project: TProject);
var
  i,x: Integer;
  pf: TProjectFile;
  memo: TSynMemo;
  fl,temp,newContent: TStringList;
begin
  if project.SavedFunctions.Count = 0 then
  begin
    project.ScanFunctions;
    project.MarkAllFunctionsToExport;
  end;

  for pf in project.ProjectFiles.Values do
  begin
    if pf.ProjectFileType = pftDef then
    begin
      fl := TStringList.Create;
      temp := TStringList.Create;
      newContent := TStringList.Create;
      newContent.Text := pf.Content;

      if pos(PROJECT_NAME,newContent.Text)>0 then
      begin
        newContent.Text := StringReplace(newContent.Text, PROJECT_NAME, project.Name, [rfReplaceAll, rfIgnoreCase])
      end else
      begin
        for i := 0 to newContent.Count-1 do
        begin
          if pos('LIBRARY',newContent[i])=1 then
          begin
            newContent[i] := 'LIBRARY ' + project.Name;
            break;
          end;
        end;
      end;

      if project.SavedFunctions.Count > 0 then
      begin
        for i := 0 to project.SavedFunctions.Count-1 do
        begin
          if project.SavedFunctions[i].Name <> project.SavedFunctions[i].ExportAs then
            fl.Add(project.SavedFunctions[i].Name + ' = ' + project.SavedFunctions[i].ExportAs)
          else
            fl.Add(project.SavedFunctions[i].Name);
        end;
        if pos(EXPORTED_FUNCTIONS,pf.Content)>0 then
        begin
          newContent.Text := StringReplace(newContent.Text, EXPORTED_FUNCTIONS, fl.Text, [rfReplaceAll, rfIgnoreCase]);
        end else
        begin
          for i := 0 to newContent.Count-1 do
          begin
            temp.Add(newContent[i]);
            if pos('EXPORTS',newContent[i])=1 then
            begin
              for x := 0 to fl.Count-1 do
                temp.Add(fl[x]);
              break;
            end;
          end;
          newContent.Text := temp.Text;
        end;
      end;
      pf.Modified := true;
      pf.Content := newContent.Text;
      FocusPage(pf,false);
      memo := GetMemo;
      if memo <> nil then
        memo.Text := newContent.Text;
      SaveFileContent(pf);
      break;
    end;
  end;
end;

procedure Tdm.ApplyThemeToHexEditor(e: TKHexEditor);
begin
  if IsThemeBright then
  begin
    e.Colors.DigitTextEven := clMaroon;
    e.Colors.DigitTextOdd := clRed;
  end else
  begin
//    e.Colors.DigitTextEven := clGray;
//    e.Colors.DigitTextOdd := clWhite;
    e.Colors.DigitTextEven := clYellow;
    e.Colors.DigitTextOdd := clWhite;
  end;
end;

procedure Tdm.PrepareToOpenFileFromCommandLine;
var
  project: TProject;
begin
  project := FGroup.CreateNewProject(ptWin32, FVisualMASMOptions);
  project.ProjectFiles.Clear;
end;

procedure Tdm.ClearAssembleErrorMarks(pf: TProjectFile = nil);
var
  memo: TSynMemo;
  i,x: integer;

  procedure Clear;
  begin
    if memo <> nil then
    begin
      memo.Marks.Clear;
      memo.Repaint;
    end;
  end;
begin
  memo := GetMemoFromProjectFile(pf);
  if memo = nil then
  begin
    with frmMain.Site do
      for i := 0 to PanelCount-1 do
      begin
        if Panels[i].ClientKind = dkDocument then
        begin
          if Panels[i].Showing then
          begin
            for x := 0 to Panels[i].ControlCount-1 do
            begin
              if Panels[i].Controls[x] is TSynMemo then
              begin
                memo := TSynMemo(Panels[i].Controls[x]);
                Clear;
                exit;
              end;
            end;
          end;
        end;
      end;
  end;
  Clear;
end;

procedure Tdm.DisplayErrorPanel(pf: TProjectFile);
var
  rootNode: PVirtualNode;
  node: PVirtualNode;
  data: PAssemblyError;
  error: TAssemblyError;
begin
  if pf = nil then exit;

  frmMain.pnlErrors.Show;

  frmMain.vstErrors.BeginUpdate;
  frmMain.vstErrors.Clear;
  frmMain.vstErrors.NodeDataSize := SizeOf(TAssemblyError);
  frmMain.vstProject.RootNodeCount := pf.AssemblyErrors.Count;

  for error in pf.AssemblyErrors do
  begin
    node := frmMain.vstErrors.AddChild(nil);
    data := frmMain.vstErrors.GetNodeData(node);
    data^.IntId := error.IntId;
    data^.FileName := error.FileName;
    data^.LineNumber := error.LineNumber;
    data^.Description := error.Description;
  end;

  frmMain.vstErrors.Refresh;
  frmMain.vstErrors.EndUpdate;
end;

procedure Tdm.GoToLineNumber(IntId: integer; ln: integer);
var
  pf: TProjectFile;
  memo: TSynMemo;
begin
  pf := FGroup.GetProjectFileByIntId(IntId);
  if pf = nil then exit;
  memo := GetMemoFromProjectFile(pf);
  if memo = nil then exit;
  memo.SetFocus;
  memo.GotoLineAndCenter(ln);
end;

procedure Tdm.ParseDesignerFormsInProject(project: TProject);
var
//  MemoryStream: TMemoryStream;
//  StringStream: TStringStream;
  pf: TProjectFile;
  rcFile: TProjectFile;
  frm: TForm;
  frmEditor: TFrmEditor;
begin
  for pf in project.ProjectFiles.Values do
  begin
    if pf.ProjectFileType = pftDLG then
    begin
      CreateEditor(pf);
      frmEditor := GetFormDesignerFromProjectFile(pf);
      frmEditor.RCFile := FGroup.GetProjectFileById(pf.ChildFileRCId);
      frmEditor.ProjectFile := pf;
      if frmEditor <> nil then
        frmEditor.Parse(pf);
//      StringStream := TStringStream.Create(pf.Content);
//      try
//        StringStream.Position := 0;
//        MemoryStream := TMemoryStream.Create;
//        try
//          ObjectTextToBinary(StringStream, MemoryStream);
//          MemoryStream.Seek(0, soFromBeginning);
//          frm := TForm.Create(self);
//          frm.DestroyComponents;
//          MemoryStream.ReadComponent(frm);
//          rcFile := FGroup.GetProjectFileById(pf.ChildFileRCId);
//          Parse(frm, rcFile);
//        finally
//          MemoryStream.Free;
//          frm.Free;
//        end;
//      finally
//        StringStream.Free;
//      end;
    end;
  end;
end;

function Tdm.IsFileLoadedIntoPanel(pf: TProjectFile): boolean;
var
  pnl: TLMDDockPanel;
begin
  pnl := GetPanelByProjectFileIntId(pf.IntId);
  result := pnl <> nil;
end;

procedure Tdm.GetDlus(dc: HDC; out HorizontalDluSize, VerticalDluSize: Real);
var
   tm: TTextMetric;
   size: TSize;
begin
   GetTextMetrics(dc, tm);
   VerticalDluSize := tm.tmHeight / 8.0;

   GetTextExtentPoint32(dc,
         PChar('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'), 52,
         size);
   HorizontalDluSize := size.cx / 52.0;
end;

procedure Tdm.GetDlgBaseUnits(handle: HWND; leftPixels, topPixels, widthPixels, heightPixels: integer;
  out leftDLUs, topDLUs, widthDLUs, heightDLUs: integer);
var
  dc: HDC;
  tm: TTextMetric;
  size: TSize;
  avgWidth, avgHeight: real;
  VerticalDlu, HorizontalDlu: real;
  DialogUnits: Cardinal;
  hDLU, vDLU: real;
begin
  DialogUnits := GetDialogBaseUnits;
  dc := GetDC(0);

  SelectObject(dc,handle);
  GetTextMetrics(dc, tm);
  avgHeight := tm.tmHeight;

  GetTextExtentPoint32(dc,
       PChar('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'), 52,
       size);
  avgWidth := size.cx / 52.0;

  hDLU := 2 * avgWidth / LOWORD(DialogUnits);
  vDLU := 2 * avgHeight / HIWORD(DialogUnits);

  leftDLUs := Round( leftPixels / hDLU );
  topDLUs := Round( topPixels / vDLU );
  widthDLUs := Round( widthPixels / hDLU );
  heightDLUs := Round( heightPixels / vDLU );
end;

procedure Tdm.AssignManigestToResourceFile(project: TProject);
var
  rcFile: TProjectFile;
  manifest: TProjectFile;
  filename: string;
begin
  rcFile := project.GetRCFile;
  if rcFile <> nil then
  begin
    manifest := project.GetManifest;
    if manifest <> nil then
    begin
      filename := StringReplace(manifest.FileName,'\','\\',[rfReplaceAll, rfIgnoreCase]);
      rcFile.Content := NEW_ITEM_RC_HEADER + CRLF + CRLF + '1  24  DISCARDABLE	"'+filename+'"' + CRLF + CRLF;
      rcFile.Modified := true;
    end;
  end;
end;

end.

