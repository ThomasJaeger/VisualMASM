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
  Contnrs, uVisualMASMFile, Windows;

type
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
    FDebugSupportPlugins: TStringList;
    FWeHaveAssemblyErrors: boolean;
    FPressingCtrl: boolean;
    FToken: string;
    FAttributes: TSynHighlighterAttributes;
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
    procedure ResetProjectTree;
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
    procedure FocusPage;
    function OpenFile(dlgTitle: string): TProjectFile;
    procedure CreateNewProject(projectType: TProjectType);
    procedure CloseProjectFile(intId: integer);
    procedure SaveFileContent(projectFile: TProjectFile);
    function PromptForFileName(projectFile: TProjectFile): string;
    procedure CheckIfChangesHaveBeenMadeAndPromptIfNecessary;
    property Token: string read FToken write FToken;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  uFrmMain, uFrmNewItems, uFrmAbout, uTFile, uFrmRename, uDebugSupportPlugin,
  Vcl.Menus, WinApi.ShellApi, Vcl.Forms, Messages, Vcl.Clipbrd, JsonDataObjects,
  System.TypInfo;

procedure Tdm.Initialize;
var
  i: Integer;
begin
  FVisualMASMOptions := TVisualMASMOptions.Create;
  FVisualMASMOptions.LoadFile;

  for i := 0 to FVisualMASMOptions.LastFilesUsed.Count-1 do
  begin
    UpdateMenuWithLastUsedFiles(FVisualMASMOptions.LastFilesUsed[i].FileName);
  end;

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

  if FVisualMASMOptions.OpenLastProjectUsed then
  begin
    if FVisualMASMOptions.LastFilesUsed.Count > 0 then
    begin
      LoadGroup(FVisualMASMOptions.LastFilesUsed[0].FileName);
    end;
  end;

  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
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
begin
  if FGroup.ActiveProject = nil then
  begin
    ShowMessage(ERR_NO_PROJECT_CREATED);
    exit;
  end;
  projectFile := FGroup.ActiveProject.CreateProjectFile(DEFAULT_FILE_NAME, FVisualMASMOptions);
  CreateEditor(projectFile);
  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
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
  if data.Level = 2 then
    path := FGroup[data.ProjectId].ProjectFile[data.FileId].Path;
  Clipboard.AsText := path;
end;

procedure Tdm.actDeleteFileExecute(Sender: TObject);
var
  projectFile: TProjectFile;
  data: PProjectData;
begin
  projectFile := GetCurrentFileInProjectExplorer;
  if projectFile = nil then exit;
  if MessageDlg('Delete file '+projectFile.Name+'?',mtCustom,[mbYes,mbCancel], 0) = mrYes then
  begin
    RemoveTabsheet(projectFile);
    if TFile.Exists(projectFile.FileName) then
      TFile.Delete(projectFile.FileName);
    data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
    if data.Level = 2 then
      FGroup[data.ProjectId].DeleteProjectFile(data.FileId);
    SynchronizeProjectManagerWithGroup;
    UpdateUI(true);
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
    if (data<> nil) and (data.Level = 2) then
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
  if data.Level = 2 then
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
    UpdateUI(true);

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
  if data.Level = 2 then
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

procedure Tdm.actGroupNewGroupExecute(Sender: TObject);
begin
  // Create the new group
  actFileCloseAllExecute(self);
  FGroup := TGroup.Create(DEFAULT_PROJECTGROUP_NAME);
  SynchronizeProjectManagerWithGroup;
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

procedure Tdm.actOpenProjectExecute(Sender: TObject);
begin
  AddExistingProject('Open Project', false);
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

procedure Tdm.actProjectRenameExecute(Sender: TObject);
var
  extPos: integer;
  newName: string;
begin
  frmRename.CurrentName := FGroup.ActiveProject.Name;
  frmRename.NewName := FGroup.ActiveProject.Name;

  if frmRename.ShowModal = mrOk then
  begin
    FGroup.ActiveProject.Name := frmRename.txtNewName.Text;
    FGroup.ActiveProject.Modified := true;
    SetProjectName(FGroup.ActiveProject);
    SynchronizeProjectManagerWithGroup;
    UpdateUI(true);
  end;
end;

procedure Tdm.actProjectSaveAsExecute(Sender: TObject);
var
  fileName: string;
begin
  fileName := PromptForProjectFileName(FGroup.ActiveProject);
  if length(fileName)>0 then
    SaveProject(FGroup.ActiveProject, fileName);
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

procedure Tdm.actRemoveFromProjectExecute(Sender: TObject);
var
  data: PProjectData;
begin
  data := frmMain.vstProject.GetNodeData(frmMain.vstProject.FocusedNode);
  RemoveTabsheet(FGroup[data.ProjectId].ProjectFile[data.FileId]);
  if data.Level = 2 then
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
  ResetProjectTree;
  f := TFileAction(Sender).VisualMASMFile;
  OpenGroupOrProject(f.FileName, true);
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
  if data.Level = 2 then
    fileName := FGroup.ProjectById[data.ProjectId].ProjectFile[data.FileId].Path+
      FGroup.ProjectById[data.ProjectId].ProjectFile[data.FileId].Name;
  if TFile.Exists(fileName) then
    ShellExecute(Application.Handle, 'open', 'explorer.exe',
      PChar('/select,"'+fileName+'"'), nil, SW_NORMAL)
  else
    ShellExecute(Application.Handle, 'open', 'explorer.exe',
      PChar(ExtractFilePath(fileName)+'"'), nil, SW_NORMAL);
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
    pftTXT: memo.Highlighter := nil;
    pftDLG: ;
    pftBAT: memo.Highlighter := synBat;
    pftINI: memo.Highlighter := synINI;
    pftCPP: memo.Highlighter := synCPP;
  end;

  frmMain.sPageControl1.ActivePage := tabSheet;
//  if memo.CanFocus then
//    memo.SetFocus;

  UpdateStatusBarForMemo(memo);
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
//  memo.OnChange := DoOnChangeSynMemo;
  memo.HelpType := htKeyword;
  memo.Highlighter := synASMMASM;
  //memo.ShowHint := true;

  memo.OnStatusChange := SynEditorStatusChange;
//  memo.OnSpecialLineColors := SynEditorSpecialLineColors;
  memo.OnKeyDown := SynMemoKeyDown;
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

  FDebugSupportPlugins := TStringList.Create;
  FDebugSupportPlugins.AddObject('',TDebugSupportPlugin.Create(memo, projectFile));

  AssignColorsToEditor(memo);
  result := memo;
end;

procedure Tdm.SynMemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  currentPageIndex: integer;
begin
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
    SynchronizeProjectManagerWithGroup;
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

procedure Tdm.UpdateUI(highlightActiveNode: boolean);
var
  memoVisible: boolean;
  memo: TSynMemo;
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

  if memoVisible and highlightActiveNode then
    HighlightNode(frmMain.sPageControl1.ActivePage.Tag);

  if FGroup.ActiveProject = nil then
  begin
    actAddExistingProject.Enabled := false;
    actShowInExplorer.Enabled := false;
    actCopyPath.Enabled := false;
    actDOSPromnptHere.Enabled := false;
    actProjectMakeActiveProject.Enabled := false;
//    actGroupSave.Enabled := false;
//    actGroupSaveAs.Enabled := false;
  end else begin
    actAddExistingProject.Enabled := true;
    actShowInExplorer.Enabled := true;
    actCopyPath.Enabled := true;
    actDOSPromnptHere.Enabled := true;
    actProjectMakeActiveProject.Enabled := true;
//    actGroupSave.Enabled := true;
//    actGroupSaveAs.Enabled := false;
  end;

  memo := GetSynMemoFromProjectFile(FGroup.ActiveProject.ActiveFile);
  UpdateStatusBarForMemo(memo);
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
        end;
      end;
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
  UpdateUI(true);
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

  FDebugSupportPlugins := TStringList.Create;
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
begin
  if not FileExists(fileName) then exit;

  fName := StrippedOfNonAscii(fileName);
  json := TJSONObject.ParseFromFile(fName) as TJsonObject;

  FGroup := TGroup.Create;
  FGroup.Name := json['Group'].S['Name'];
  FGroup.FileName := fName;
  FGroup.Id := json['Group'].S['Id'];
  FGroup.Created := strtodatetime(json['Group'].S['Created']);
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
  if (FGroup.ActiveProject <> nil) and (FGroup.ActiveProject.ActiveFile <> nil) then
  begin
    FGroup.ActiveProject.ActiveFile := FGroup.ActiveProject.ProjectFile[activeProjectId];
    FGroup.ActiveProject.ActiveFile.Modified := false;
  end;

  FGroup.Modified := false;

  SynchronizeProjectManagerWithGroup;
  UpdateUI(true);
  FocusFileInTabs(FGroup.LastFileOpenId);
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
      if projectFile.IsOpen then
        CreateEditor(projectFile);
      projectFile.Modified := false;
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

procedure Tdm.ResetProjectTree;
begin
//  CloseAllPages;
//  FGroup := nil;
//  FActiveProject := nil;
//  FActiveProjectFile := nil;
//  FSelectedProjectInProjectExplorer := nil;
//  FSelectedProjectFileInProjectExplorer := nil;
//  FDebugSupportPlugins.Clear;
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

end.

