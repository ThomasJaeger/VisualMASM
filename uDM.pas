unit uDM;

interface

uses
  System.SysUtils, System.Classes, acPathDialog, sDialogs, Vcl.Dialogs,
  System.Actions, Vcl.ActnList, Vcl.XPStyleActnCtrls, Vcl.ActnMan, Vcl.ImgList,
  Vcl.Controls, acAlphaImageList, sPageControl, sStatusBar, Vcl.ComCtrls,
  uSharedGlobals, uGroup, uProject, uProjectFile, VirtualTrees,
  uVisualMASMOptions, UITypes, SynEditHighlighter, SynHighlighterAsmMASM,
  SynColors, SynMemo, SynCompletionProposal, SynEdit, SynHighlighterRC, SynHighlighterBat, SynHighlighterCPM,
  SynHighlighterIni, Vcl.Graphics, SynUnicode, SynHighlighterHashEntries, SynEditDocumentManager, StrUtils;

type
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
    function GetSynMemoFromProjectFile(projectFile: TProjectFile): TSynMemo;
  public
    procedure CreateEditor(projectFile: TProjectFile);
    procedure Initialize;
    procedure SynchronizeProjectManagerWithGroup;
    function SaveChanges: boolean;
    property Group: TGroup read FGroup;
    property VisualMASMOptions: TVisualMASMOptions read FVisualMASMOptions;
    procedure SaveGroup;
    procedure CloseDocument(index: integer);
    procedure UpdateUI;
    procedure HighlightNode(intId: integer);
    property ShuttingDown: boolean read FShuttingDown write FShuttingDown;
    property LastTabIndex: integer read FLastTabIndex write FLastTabIndex;
    procedure FocusPage;
    function OpenFile(dlgTitle: string): TProjectFile;
    procedure CreateNewProject(projectType: TProjectType; addToGroup: boolean);
    procedure CloseProjectFile(intId: integer);
    procedure SaveFileContent(projectFile: TProjectFile);
    function PromptForFileName(projectFile: TProjectFile): string;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  uFrmMain, uFrmNewItems, uFrmAbout, uTFile, uFrmRename;

procedure Tdm.Initialize;
begin
  FVisualMASMOptions := TVisualMASMOptions.Create;
  FVisualMASMOptions.LoadFile;
  FCodeCompletionList := TUnicodeStringList.Create;
  FCodeCompletionList.LoadFromFile(CODE_COMPLETION_LIST_FILENAME);
  FCodeCompletionInsertList := TUnicodeStringList.Create;
  FCodeCompletionInsertList.LoadFromFile(CODE_COMPLETION_INSERT_LIST_FILENAME);

  FGroup := TGroup.Create(DEFAULT_PROJECTGROUP_NAME);

  if not FileExists(EDITOR_COLORS_FILENAME)then
  begin
    synASMMASM.SynColors := TSynColors.Create;
    synASMMASM.SaveFile(EDITOR_COLORS_FILENAME);
  end;
  synASMMASM.LoadFile(EDITOR_COLORS_FILENAME);
  UpdateUI;
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
      SaveGroup;
    if promptResult = mrCancel then
      result := false;
  end;
end;

procedure Tdm.SynchronizeProjectManagerWithGroup;
var
  project: TProject;
  projectFile: TProjectFile;
  rootNode: PVirtualNode;
  projectNode: PVirtualNode;
  fileNode: PVirtualNode;
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

procedure Tdm.SaveGroup;
begin
  //

end;

procedure Tdm.actAboutExecute(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure Tdm.actAddNewAssemblyFileExecute(Sender: TObject);
var
  projectFile: TProjectFile;
begin
  if FGroup.ActiveProject = nil then
  begin
    ShowMessage(ERR_NO_PROJECT_CREATED);
    exit;
  end;
  projectFile := FGroup.ActiveProject.CreateProjectFile(DEFAULT_FILE_NAME, FVisualMASMOptions);
  CreateEditor(projectFile);
  SynchronizeProjectManagerWithGroup;
  UpdateUI;
end;

procedure Tdm.actAddNewBatchFileExecute(Sender: TObject);
var
  projectFile: TProjectFile;
begin
  if FGroup.ActiveProject = nil then
  begin
    ShowMessage(ERR_NO_PROJECT_CREATED);
    exit;
  end;
  projectFile := FGroup.ActiveProject.CreateProjectFile('Batch'+inttostr(FGroup.ActiveProject.ProjectFiles.Count+1)+'.bat',
    FVisualMASMOptions, pftBAT);
  CreateEditor(projectFile);
  SynchronizeProjectManagerWithGroup;
  UpdateUI;
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

procedure Tdm.actAddNewTextFileExecute(Sender: TObject);
var
  projectFile: TProjectFile;
begin
  if FGroup.ActiveProject = nil then
  begin
    ShowMessage(ERR_NO_PROJECT_CREATED);
    exit;
  end;
  projectFile := FGroup.ActiveProject.CreateProjectFile('Text'+inttostr(FGroup.ActiveProject.ProjectFiles.Count+1)+'.txt',
    FVisualMASMOptions, pftTXT);
  CreateEditor(projectFile);
  SynchronizeProjectManagerWithGroup;
  UpdateUI;
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

function Tdm.OpenFile(dlgTitle: string): TProjectFile;
var
  projectFile: TProjectFile;
  fileExt: string;
begin
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
    projectFile := FGroup.ActiveProject.CreateProjectFile(ExtractFileName(dlgOpen.FileName),
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
    UpdateUI;

    result := projectFile;
  end;
end;

procedure Tdm.actEditCommentLineExecute(Sender: TObject);
begin
  if frmMain.sPageControl1.ActivePage <> nil then
    CommentUncommentLine(GetMemo);
end;

procedure Tdm.actEditCopyExecute(Sender: TObject);
begin
  if frmMain.sPageControl1.ActivePage <> nil then
    GetMemo.CopyToClipboard;
end;

procedure Tdm.actEditCutExecute(Sender: TObject);
begin
  if frmMain.sPageControl1.ActivePage <> nil then
    GetMemo.CutToClipboard;
end;

procedure Tdm.actEditDeleteExecute(Sender: TObject);
begin
  if frmMain.sPageControl1.ActivePage <> nil then
    GetMemo.SelText := '';
end;

procedure Tdm.actEditPasteExecute(Sender: TObject);
begin
  if frmMain.sPageControl1.ActivePage <> nil then
    GetMemo.PasteFromClipboard;
end;

procedure Tdm.actEditRedoExecute(Sender: TObject);
begin
  if frmMain.sPageControl1.ActivePage <> nil then
    GetMemo.Redo;
end;

procedure Tdm.actEditSelectAllExecute(Sender: TObject);
begin
  if frmMain.sPageControl1.ActivePage <> nil then
    GetMemo.SelectAll;
end;

procedure Tdm.actEditUndoExecute(Sender: TObject);
begin
  if frmMain.sPageControl1.ActivePage <> nil then
    GetMemo.Undo;
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
  CreateNewProject(ptWin32, false);
end;

procedure Tdm.CreateNewProject(projectType: TProjectType; addToGroup: boolean);
begin
  FGroup.CreateNewProject(projectType, FVisualMASMOptions);
  FGroup.ActiveProject.CreateProjectFile(DEFAULT_FILE_NAME, FVisualMASMOptions, pftASM);
  CreateEditor(FGroup.ActiveProject.ActiveFile);
  SynchronizeProjectManagerWithGroup;
  UpdateUI;
end;

procedure Tdm.actFileRenameExecute(Sender: TObject);
begin
  frmRename.CurrentName := FGroup.ActiveProject.ActiveFile.Name;
  frmRename.NewName := FGroup.ActiveProject.ActiveFile.Name;

  if frmRename.ShowModal = mrOk then
  begin
    FGroup.ActiveProject.ActiveFile.Name := frmRename.txtNewName.Text;
    if FileExists(FGroup.ActiveProject.ActiveFile.FileName) then
      RenameFile(FGroup.ActiveProject.ActiveFile.FileName,
        FGroup.ActiveProject.ActiveFile.Path + frmRename.txtNewName.Text);
    FGroup.ActiveProject.ActiveFile.FileName := FGroup.ActiveProject.ActiveFile.Path + frmRename.txtNewName.Text;
    FGroup.ActiveProject.ActiveFile.Modified := true;
    FGroup.ActiveProject.Modified := true;
    SynchronizeProjectManagerWithGroup;
    UpdateUI;
    UpdatePageCaption(FGroup.ActiveProject.ActiveFile);
  end;
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

procedure Tdm.actGroupNewGroupExecute(Sender: TObject);
begin
  // Create the new group
  actFileCloseAllExecute(self);
  FGroup := TGroup.Create(DEFAULT_PROJECTGROUP_NAME);
  SynchronizeProjectManagerWithGroup;
end;

procedure Tdm.actNew16BitDOSComAppExecute(Sender: TObject);
begin
  CreateNewProject(ptDos16COM, false);
end;

procedure Tdm.actNew16BitDOSExeAppExecute(Sender: TObject);
begin
  CreateNewProject(ptDos16EXE, false);
end;

procedure Tdm.actNew64BitWindowsExeAppExecute(Sender: TObject);
begin
  CreateNewProject(ptWin64, false);
end;

procedure Tdm.actNewOtherExecute(Sender: TObject);
var
  data: PProjectData;
begin
  data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
  if data <> nil then
  begin
    if data.Level = 1 then
    begin
      case FGroup[data.ProjectId].ProjectType of
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
  end else
    frmNewItems.HighlightApplications;
  frmNewItems.ShowModal;
end;

procedure Tdm.actSaveExecute(Sender: TObject);
var
  data: PProjectData;
begin
  data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
  if data=nil then exit;
  if data.Level = 2 then
    SaveFileContent(FGroup.Projects[data.ProjectId].ProjectFile[data.FileId]);
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
//  statusBar.OnHint := StatusBarHintHandler;
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
begin
  if FStatusBar = nil then
    CreateStatusBar;
  tabSheet := CreateTabSheet(projectFile);
  memo := CreateMemo(projectFile);
  memo.Parent := tabSheet;
  memo.Text := projectFile.Content;

  case projectFile.ProjectFileType of
    pftASM: memo.Highlighter := synASMMASM;
    pftRC: memo.Highlighter := synRC;
    pftTXT: ;
    pftDLG: ;
    pftBAT: memo.Highlighter := synBat;
    pftINI: memo.Highlighter := synINI;
    pftCPP: memo.Highlighter := synCPP;
  end;

  frmMain.sPageControl1.ActivePage := tabSheet;
  if memo.CanFocus then
    memo.SetFocus;

//  UpdateStatusBarForMemo(memo);
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
////  memo.OnChange := DoOnChangeSynMemo;
  memo.HelpType := htKeyword;
  memo.Highlighter := synASMMASM;
  //memo.ShowHint := true;

//  memo.OnStatusChange := SynEditorStatusChange;
//  memo.OnSpecialLineColors := SynEditorSpecialLineColors;
//  memo.OnKeyDown := SynMemoKeyDown;
//  memo.OnMouseCursor := SynMemoMouseCursor;
  memo.OnEnter := SynMemoOnEnter;
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
//  FDebugSupportPlugins.AddObject('',TDebugSupportPlugin.Create(memo, projectFile));

  AssignColorsToEditor(memo);
  result := memo;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  Initialize;
end;

procedure Tdm.AssignColorsToEditor(memo: TSynMemo);
begin
  synASMMASM.AssignColors(memo);
  memo.Gutter.Color := $313131;
  memo.Gutter.Font.Color := clSilver;
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

procedure Tdm.CloseDocument(index: integer);
begin
  if frmMain.sPageControl1.PageCount > 1 then
    frmMain.sPageControl1.ActivePageIndex := 0;
  UpdateUI;
end;

function Tdm.GetMemo: TSynMemo;
var
  x: integer;
begin
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

procedure Tdm.UpdateUI;
var
  memoVisible: boolean;
begin
  memoVisible := frmMain.sPageControl1.ActivePage <> nil;

  actEditUndo.Enabled := memoVisible;
  actEditRedo.Enabled := memoVisible;
  actEditCut.Enabled := memoVisible;
  actEditCopy.Enabled := memoVisible;
  actEditPaste.Enabled := memoVisible;
  actEditDelete.Enabled := memoVisible;
  actEditCommentLine.Enabled := memoVisible;
  actEditSelectAll.Enabled := memoVisible;
  actFileCloseAll.Enabled := memoVisible;

  if memoVisible then
    HighlightNode(frmMain.sPageControl1.ActivePage.Tag);
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
      if (data.Level = 2) and (data.FileIntId = intId) then
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

procedure Tdm.FocusPage;
var
  i: integer;
  foundIt: boolean;
begin
  foundIt := false;
  // Look for the page with the filename
  with frmMain.sPageControl1 do
    for i := 0 to PageCount-1 do
    begin
      //if (Pages[i].Caption = fileName) or (Pages[i].Caption = (MODIFIED_CHAR+fileName)) then
      if Pages[i].Tag = FGroup.ActiveProject.ActiveFile.IntId then
      begin
        ActivePageIndex := i;
        foundIt := true;
        FocusMemo(Pages[i]);
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
    if sender is TSynMemo then
      SynCompletionProposal1.Editor := sender as TSynMemo;
  end;
  UpdateUI;
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
  UpdateUI;
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

procedure Tdm.SaveFileContent(projectFile: TProjectFile);
var
  fn: string;
  memo: TSynMemo;
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
  memo := GetSynMemoFromProjectFile(projectFile);
  projectFile.Content := memo.Text;
  TFile.WriteAllText(projectFile.FileName, projectFile.Content);
  memo.Modified := false;
  projectFile.Modified := false;
  projectFile.SizeInBytes := length(projectFile.Content);
  SynchronizeProjectManagerWithGroup;
  UpdateUI;
  UpdatePageCaption(projectFile);
end;

function Tdm.GetSynMemoFromProjectFile(projectFile: TProjectFile): TSynMemo;
var
  i,x: integer;
begin
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

end.

