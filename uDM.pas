unit uDM;

interface

uses
  System.SysUtils, System.Classes, acPathDialog, sDialogs, Vcl.Dialogs,
  System.Actions, Vcl.ActnList, Vcl.XPStyleActnCtrls, Vcl.ActnMan, Vcl.ImgList,
  Vcl.Controls, acAlphaImageList, sPageControl, sStatusBar, Vcl.ComCtrls,
  uSharedGlobals, uGroup, uProject, uProjectFile, VirtualTrees,
  uVisualMASMOptions, BCEditor.Editor, BCCommon.Dialog.Popup.Highlighter.Color,
  BCCommon.FileUtils, UITypes, BCEditor.Highlighter;

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
    procedure actAddNewAssemblyFileExecute(Sender: TObject);
    procedure actGroupNewGroupExecute(Sender: TObject);
    procedure actAddNewProjectExecute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
  private
    FGroup: TGroup;
    FVisualMASMOptions: TVisualMASMOptions;
    FPopupHighlighterColorDialog: TPopupHighlighterColorDialog;
    FHighlighterColorStrings: TStringList;
    FHighlighterStrings: TStringList;
    FMASMHighlighter: TBCEditorHighlighter;
  public
    procedure CreateEditor(projectFile: TProjectFile);
    procedure Initialize;
    procedure SynchronizeProjectManagerWithGroup;
    property Group: TGroup read FGroup;
    property VisualMASMOptions: TVisualMASMOptions read FVisualMASMOptions;
    procedure SaveGroup;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  uFrmMain, uFrmNewItems, uFrmAbout;

procedure Tdm.Initialize;
begin
  FVisualMASMOptions := TVisualMASMOptions.Create;
  FVisualMASMOptions.LoadFile;

  FGroup := TGroup.Create(DEFAULT_PROJECTGROUP_NAME);

  FHighlighterStrings := GetHighlighters;
  FHighlighterColorStrings := GetHighlighterColors;

//  FMASMHighlighter := TBCEditorHighlighter.Create(frmMain);
//  FMASMHighlighter.LoadFromFile(HIGHLIGHTER_FILENAME);
//  FMASMHighlighter.Colors.LoadFromFile(EDITOR_COLORS_FILENAME);
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
  if FGroup.Modified then
  begin
    promptResult := MessageDlg('Save changes?',mtCustom,[mbYes,mbNo,mbCancel], 0);
    if promptResult = mrYes then
    begin
      SaveGroup;
    end else if promptResult = mrCancel then
    begin
      exit;
    end;
  end;

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
  projectFile := TProjectFile.Create(DEFAULT_FILE_NAME);
  CreateEditor(projectFile);
end;

procedure Tdm.actAddNewProjectExecute(Sender: TObject);
begin
  frmNewItems.AddNewProject(true);
  frmNewItems.ShowModal;
end;

procedure Tdm.actGroupNewGroupExecute(Sender: TObject);
begin
  // Create the new group
  FGroup := TGroup.Create(DEFAULT_PROJECTGROUP_NAME);
  SynchronizeProjectManagerWithGroup;
end;

procedure Tdm.CreateEditor(projectFile: TProjectFile);
var
  memo: TBCEditor;
  tabSheet: TsTabSheet;
  statusBar: TsStatusBar;
  statusPanel: TStatusPanel;
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

//  statusBar := TsStatusBar.Create(tabSheet);
//  statusBar.Parent := tabSheet;
//  statusBar.Align := alBottom;
//  statusBar.SizeGrip := false;
//  statusBar.Height := 19;
//  statusBar.AutoHint := true;   // Show hint from menus like the short-cuts
////  statusBar.OnHint := StatusBarHintHandler;
//  // Cursor position
//  statusPanel := statusBar.Panels.Add;
//  statusPanel.Width := 70;
//  statusPanel.Alignment := taCenter;
//  // MODIFIED status
//  statusPanel := statusBar.Panels.Add;
//  statusPanel.Width := 70;
//  statusPanel.Alignment := taCenter;
//  // INSERT status
//  statusPanel := statusBar.Panels.Add;
//  statusPanel.Width := 70;
//  statusPanel.Alignment := taCenter;
//  statusPanel.Text := 'Insert';
//  // Line count
//  statusPanel := statusBar.Panels.Add;
//  statusPanel.Width := 130;
//  statusPanel.Alignment := taLeftJustify;
//  // Regular text
//  statusPanel := statusBar.Panels.Add;
//  statusPanel.Width := 70;
//  statusPanel.Alignment := taLeftJustify;

  //memo := TSynMemo.Create(tabSheet);
  memo := TBCEditor.Create(tabSheet);
  memo.Parent := tabSheet;
  memo.Align := alClient;

//  case projectFile.ProjectFileType of
//    pftASM: memo.Highlighter := synASMMASM;
//    pftRC: memo.Highlighter := synRC;
//    pftTXT: ;
//    pftDLG: ;
//    pftBAT: memo.Highlighter := synBat;
//    pftINI: memo.Highlighter := synINI;
//    pftCPP: memo.Highlighter := synCPP;
//  end;

  //memo.ActiveLineColor := $002C2923;
//  memo.ActiveLineColor := BrightenColor(frmMain.sSkinManager1.GetGlobalColor);
  //memo.ActiveLineColor := frmMain.sSkinManager1.GetGlobalColor;
  //memo.ActiveLineColor := BrightenColor(frmMain.sSkinManager1.GetHighLightColor(false));
  //memo.ActiveLineColor := DarkenColor(frmMain.sSkinManager1.GetHighLightColor(false));

  memo.PopupMenu := frmMain.popMemo;
//  memo.TabWidth := 4;
////  memo.OnChange := DoOnChangeSynMemo;
  memo.Encoding := TEncoding.ANSI;
  memo.HelpType := htKeyword;
  memo.Highlighter.LoadFromFile(HIGHLIGHTER_FILENAME);
  memo.Highlighter.Colors.LoadFromFile(EDITOR_COLORS_FILENAME);
//  memo.Highlighter := FMASMHighlighter;
  //memo.LoadFromFile(GetHighlighterFileName('JSON.json'));
  memo.Lines.Text := memo.Highlighter.Info.General.Sample;
//  memo.Scroll.Bars := TScrollStyle.ssBoth;
  memo.Minimap.Visible := true;
  memo.ShowHint := true;
  memo.CodeFolding.Visible := memo.Highlighter.CodeFoldingRangeCount > 0;
//  TitleBar.Items[TITLE_BAR_HIGHLIGHTER].Caption := Editor.Highlighter.Name;
  memo.MoveCaretToBOF;

//  memo.OnStatusChange := SynEditorStatusChange;
//  memo.OnSpecialLineColors := SynEditorSpecialLineColors;
//  memo.OnKeyDown := SynMemoKeyDown;
//  memo.OnMouseCursor := SynMemoMouseCursor;
//  memo.OnEnter := SynMemoOnEnter;
//  memo.SelectedColor.Background := frmMain.sSkinManager1.GetHighLightColor(true);
//  memo.SelectedColor.Foreground := frmMain.sSkinManager1.GetHighLightFontColor(true);
//  memo.BookMarkOptions.BookmarkImages := ImageList1;
//  memo.Gutter.ShowLineNumbers := true;
//  memo.Gutter.DigitCount := 5;
//  memo.Gutter.Color := frmMain.sSkinManager1.GetGlobalColor;
//  memo.Gutter.Font.Color := frmMain.sSkinManager1.GetGlobalFontColor;
//  memo.Gutter.BorderColor := frmMain.sSkinManager1.GetGlobalFontColor;
//  memo.Gutter.Gradient := false;
////  memo.Gutter.GradientStartColor := frmMain.sSkinManager1.GetGlobalColor;
////  memo.Gutter.GradientEndColor := clBlack;
//  //memo.Gutter.GradientSteps := 200;   // 48 = default
//  memo.RightEdgeColor := clNone;
//  memo.WantTabs := true;
//  memo.Options := [eoAutoIndent, eoDragDropEditing, eoEnhanceEndKey,
//    eoScrollPastEol, eoShowScrollHint,
//    //eoSmartTabs, // eoTabsToSpaces,
//    eoSmartTabDelete, eoGroupUndo, eoTabIndent];
//  scpDOSCOM.Editor := memo;
//  SynCompletionProposal1.Editor := memo;
//  SynAutoComplete1.Editor := memo;
//  memo.Text := projectFile.Content;
////  memo.Font.Name := 'Tiny';
////  memo.Font.Size := 1;
//  FDebugSupportPlugins.AddObject('',TDebugSupportPlugin.Create(memo, projectFile));

  frmMain.sPageControl1.ActivePage := tabSheet;
  memo.SetFocus;
//  UpdateStatusBarForMemo(memo);
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  Initialize;
end;

end.
