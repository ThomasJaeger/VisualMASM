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
  public
    procedure CreateEditor(projectFile: TProjectFile);
    procedure Initialize;
    procedure SynchronizeProjectManagerWithGroup;
    function SaveChanges: boolean;
    property Group: TGroup read FGroup;
    property VisualMASMOptions: TVisualMASMOptions read FVisualMASMOptions;
    procedure SaveGroup;
    procedure SetActiveDocument;
    procedure CloseDocument(index: integer);
    procedure UpdateUI;
    procedure HighlightNode(intId: integer);
    property ShuttingDown: boolean read FShuttingDown write FShuttingDown;
    property LastTabIndex: integer read FLastTabIndex write FLastTabIndex;
    procedure FocusPage;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  uFrmMain, uFrmNewItems, uFrmAbout, uTFile;

procedure Tdm.Initialize;
begin
  FVisualMASMOptions := TVisualMASMOptions.Create;
  FVisualMASMOptions.LoadFile;
  FCodeCompletionList := TUnicodeStringList.Create;
  FCodeCompletionList.LoadFromFile(CODE_COMPLETION_LIST_FILENAME);
  FCodeCompletionInsertList := TUnicodeStringList.Create;
  FCodeCompletionInsertList.LoadFromFile(CODE_COMPLETION_INSERT_LIST_FILENAME);

  FGroup := TGroup.Create(DEFAULT_PROJECTGROUP_NAME);
  FGroup.CreateNewProject(ptWin32, FVisualMASMOptions);

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
  projectFile := FGroup.ActiveProject.CreateProjectFile(DEFAULT_FILE_NAME, FVisualMASMOptions);

  case FGroup.ActiveProject.ProjectType of
    ptWin32: projectFile.Content := ReadWin32BitExeMasm32File;
    ptWin64: projectFile.Content := ReadWin64BitExeWinSDK64File;
    ptWin32DLL: ;
    ptWin64DLL: ;
    ptDos16COM: projectFile.Content := Read16BitDosCOMStub;
    ptDos16EXE: projectFile.Content := Read16BitDosEXEStub;
    ptWin16: ;
    ptWin16DLL: ;
  end;

  CreateEditor(projectFile);
  SetActiveDocument;
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

procedure Tdm.actGroupNewGroupExecute(Sender: TObject);
begin
  // Create the new group
  FGroup := TGroup.Create(DEFAULT_PROJECTGROUP_NAME);
  SynchronizeProjectManagerWithGroup;
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
  tabSheet.ShowHint := true;
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
  memo.ShowHint := true;
//  TitleBar.Items[TITLE_BAR_HIGHLIGHTER].Caption := Editor.Highlighter.Name;

//  memo.OnStatusChange := SynEditorStatusChange;
//  memo.OnSpecialLineColors := SynEditorSpecialLineColors;
//  memo.OnKeyDown := SynMemoKeyDown;
//  memo.OnMouseCursor := SynMemoMouseCursor;
//  memo.OnEnter := SynMemoOnEnter;
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

//  memo.Text := projectFile.Content;
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

procedure Tdm.SetActiveDocument;
//var
//  doc: ISynDocument;
begin
//  synDM.Memo := FMemo;
//  synDM.CurrentDocumentIndex := frmMain.sPageControl1.ActivePageIndex;
//  synDM.ApplyCurrentDocument;
//  if frmMain.sPageControl1.PageCount > 0 then
//  begin
//    FMemo.Parent := frmMain.sPageControl1.Pages[frmMain.sPageControl1.ActivePageIndex];
////    if frmMain.sPageControl1.ActivePage <> nil then
////      SYNdm.Memo.Parent := frmMain.sPageControl1.ActivePage
////    else
////      SYNdm.Memo.Parent := frmMain.sPageControl1.Pages[0];
//    FMemo.SetFocus;
//  end;
end;

procedure Tdm.CloseDocument(index: integer);
begin
  if frmMain.sPageControl1.PageCount > 1 then
    frmMain.sPageControl1.ActivePageIndex := 0;
  SetActiveDocument;
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
    CreateMemo(FGroup.ActiveProject.ActiveFile);
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

end.

