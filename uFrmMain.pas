unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ImgList,
  VirtualTrees, Vcl.AppEvnts, SynEdit, SynMemo, System.TypInfo, Soap.WebServExp, Soap.WSDLBind,
  Xml.XMLSchema, HTMLUn2, HtmlView, Soap.WSDLPub, Vcl.ToolWin, LMDDckSite, LMDXML,
  Vcl.Styles.Utils.SystemMenu,
  Vcl.Styles.Hooks,
  Vcl.Styles.Utils.Menus, //Style Popup and Shell Menus (class #32768)
  Vcl.Styles.Utils.Forms, //Style dialogs box (class #32770)
  Vcl.Styles.Utils.StdCtrls, //Style buttons, static, and so on
  Vcl.Styles.Utils.ComCtrls, //Style SysTreeView32, SysListView32
  Vcl.Styles.Utils.ScreenTips, //Style the tooltips_class32 class
  Vcl.Styles.Utils.SysControls,
  Vcl.Styles.Utils.SysStyleHook, Vcl.Imaging.pngimage, Vcl.Themes, LMDIdeCompBar, LMDDsgComboBox, Vcl.Grids,
  LMDInsPropPage, LMDInsPropInsp, LMDDsgPropInsp, LMDIdeCompTree, LMDIdeManager, LMDSvcPvdr, LMDIdeAlignPltte,
  LMDIdeObjEdrMgr, LMDIdeProjMgr, Vcl.XPMan, LMDDckAlphaImages, d_frmEditor, System.Actions, Vcl.ActnList,
  LMDDsgDesigner, Vcl.Buttons, ActiveX, System.Generics.Collections, LMDTypes;

type
  TButtonExStyleHook = class(TButtonStyleHook)
  private
    procedure WMLButtonDblClk(var Message: TWMMouse); message WM_LBUTTONDBLCLK;
  end;

  TfrmMain = class(TForm)
    mnuMain: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    N31: TMenuItem;
    N32BitWindowsEXEApplication1: TMenuItem;
    N3264Bit1: TMenuItem;
    N61: TMenuItem;
    N64BitWindowsEXEApplication1: TMenuItem;
    N1: TMenuItem;
    N12: TMenuItem;
    N14: TMenuItem;
    N6: TMenuItem;
    N11: TMenuItem;
    N13: TMenuItem;
    N29: TMenuItem;
    Other1: TMenuItem;
    Open1: TMenuItem;
    O5: TMenuItem;
    mnuReopen: TMenuItem;
    N5: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    S8: TMenuItem;
    S9: TMenuItem;
    C1: TMenuItem;
    C2: TMenuItem;
    N2: TMenuItem;
    mnuExit: TMenuItem;
    Edit1: TMenuItem;
    Undo1: TMenuItem;
    Redo1: TMenuItem;
    N24: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    PasteSpecial1: TMenuItem;
    SelectAll1: TMenuItem;
    N35: TMenuItem;
    CommentLine1: TMenuItem;
    S10: TMenuItem;
    F1: TMenuItem;
    S11: TMenuItem;
    SearchPrevious1: TMenuItem;
    N38: TMenuItem;
    R10: TMenuItem;
    N3: TMenuItem;
    G1: TMenuItem;
    N36: TMenuItem;
    oggleBookmark1: TMenuItem;
    mnuSearchToggleBookmark: TMenuItem;
    Bookmark01: TMenuItem;
    Bookmark02: TMenuItem;
    Bookmark03: TMenuItem;
    Bookmark04: TMenuItem;
    Bookmark1: TMenuItem;
    Bookmark2: TMenuItem;
    Bookmark3: TMenuItem;
    Bookmark4: TMenuItem;
    Bookmark5: TMenuItem;
    G2: TMenuItem;
    mnuSearchGoToBookmark: TMenuItem;
    GotoBookmark01: TMenuItem;
    GotoBookmark1: TMenuItem;
    GotoBookmark2: TMenuItem;
    GotoBookmark3: TMenuItem;
    GotoBookmark4: TMenuItem;
    GotoBookmark5: TMenuItem;
    GotoBookmark6: TMenuItem;
    GotoBookmark7: TMenuItem;
    GotoBookmark8: TMenuItem;
    V1: TMenuItem;
    P1: TMenuItem;
    A8: TMenuItem;
    B2: TMenuItem;
    N22: TMenuItem;
    ShowinExplorer2: TMenuItem;
    Copypath4: TMenuItem;
    DOSPromptHere4: TMenuItem;
    N40: TMenuItem;
    MakeactiveProject2: TMenuItem;
    N41: TMenuItem;
    A5: TMenuItem;
    N20: TMenuItem;
    A6: TMenuItem;
    A7: TMenuItem;
    N28: TMenuItem;
    Options1: TMenuItem;
    R1: TMenuItem;
    R2: TMenuItem;
    T1: TMenuItem;
    O1: TMenuItem;
    Help1: TMenuItem;
    V2: TMenuItem;
    A9: TMenuItem;
    N27: TMenuItem;
    A10: TMenuItem;
    N26: TMenuItem;
    mnuHelpResources: TMenuItem;
    N23: TMenuItem;
    About1: TMenuItem;
    popFile: TPopupMenu;
    popFileOpen: TMenuItem;
    D1: TMenuItem;
    N34: TMenuItem;
    Assemble1: TMenuItem;
    N8: TMenuItem;
    D2: TMenuItem;
    N32: TMenuItem;
    S1: TMenuItem;
    Copypath1: TMenuItem;
    DOSPromptHere2: TMenuItem;
    N19: TMenuItem;
    S6: TMenuItem;
    S7: TMenuItem;
    R8: TMenuItem;
    popGroup: TPopupMenu;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    N39: TMenuItem;
    AssembleallProjects1: TMenuItem;
    BuildallProjects1: TMenuItem;
    N33: TMenuItem;
    ShowinExplorer1: TMenuItem;
    Copypath3: TMenuItem;
    DOSPromptHere3: TMenuItem;
    MenuItem6: TMenuItem;
    S2: TMenuItem;
    S3: TMenuItem;
    R4: TMenuItem;
    popMemo: TPopupMenu;
    CommentUncommentLine1: TMenuItem;
    N37: TMenuItem;
    C4: TMenuItem;
    E1: TMenuItem;
    P5: TMenuItem;
    N30: TMenuItem;
    T2: TMenuItem;
    B1: TMenuItem;
    B3: TMenuItem;
    Bookmark11: TMenuItem;
    Bookmark12: TMenuItem;
    Bookmark13: TMenuItem;
    Bookmark14: TMenuItem;
    Bookmark15: TMenuItem;
    Bookmark16: TMenuItem;
    Bookmark17: TMenuItem;
    Bookmark18: TMenuItem;
    G4: TMenuItem;
    B5: TMenuItem;
    GotoBookmark02: TMenuItem;
    GotoBookmark03: TMenuItem;
    GotoBookmark04: TMenuItem;
    GotoBookmark05: TMenuItem;
    GotoBookmark06: TMenuItem;
    GotoBookmark07: TMenuItem;
    GotoBookmark08: TMenuItem;
    GotoBookmark09: TMenuItem;
    GotoBookmark010: TMenuItem;
    popProject: TPopupMenu;
    mnuProjectRun: TMenuItem;
    mnuProjectAssemble: TMenuItem;
    mnuProjectBuild: TMenuItem;
    N7: TMenuItem;
    S4: TMenuItem;
    Copypath2: TMenuItem;
    DOSPromptHere1: TMenuItem;
    N21: TMenuItem;
    MakeactiveProject1: TMenuItem;
    N9: TMenuItem;
    mnuProjectAdd: TMenuItem;
    N10: TMenuItem;
    R5: TMenuItem;
    R6: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    S5: TMenuItem;
    R7: TMenuItem;
    N18: TMenuItem;
    O3: TMenuItem;
    timerProjectTreeHint: TTimer;
    TreeImages: TImageList;
    AssemblyFile1: TMenuItem;
    NewGroup1: TMenuItem;
    popFunctions: TPopupMenu;
    GotoFunction1: TMenuItem;
    imglGutterGlyphs: TImageList;
    popLabels: TPopupMenu;
    GotoLabel1: TMenuItem;
    N42: TMenuItem;
    HighlightWords1: TMenuItem;
    N43: TMenuItem;
    Changeselectiontolowercase1: TMenuItem;
    ChangeselectiontoUPPERcase1: TMenuItem;
    ChangeselectiontoCamelCase1: TMenuItem;
    N44: TMenuItem;
    Win32Help1: TMenuItem;
    mnuDesign: TMenuItem;
    oggleDialogAssembly1: TMenuItem;
    WSDLHTMLPublish1: TWSDLHTMLPublish;
    N47: TMenuItem;
    M1: TMenuItem;
    MicrosoftMASM61Reference1: TMenuItem;
    N32BitWindowsConsoleApplication1: TMenuItem;
    Why1: TMenuItem;
    WindowsAPIIndex1: TMenuItem;
    DockManager: TLMDDockManager;
    Site: TLMDDockSite;
    pnlOutput: TLMDDockPanel;
    pnlProjectManager: TLMDDockPanel;
    pnlFunctions: TLMDDockPanel;
    pnlLabels: TLMDDockPanel;
    pnlHelp: TLMDDockPanel;
    htmlHelp: THtmlViewer;
    vstFunctions: TVirtualStringTree;
    vstLabels: TVirtualStringTree;
    vstProject: TVirtualStringTree;
    pnlWelcomePage: TLMDDockPanel;
    N46: TMenuItem;
    pnlDebugEvents: TLMDDockPanel;
    pnlModules: TLMDDockPanel;
    pnlThreads: TLMDDockPanel;
    pnlRegisters: TLMDDockPanel;
    memOutput: TMemo;
    memDebugEvents: TMemo;
    memModules: TMemo;
    memThreads: TMemo;
    memRegisters: TMemo;
    lblCopyright: TLabel;
    imgLogo: TImage;
    Label1: TLabel;
    Label2: TLabel;
    iml16x16Icons: TImageList;
    DisabledActionImages: TLMDAlphaImageList;
    CompImages: TLMDAlphaImageList;
    XPManifest: TXPManifest;
    ProjMgr: TLMDProjectManager;
    ObjEditorMgr: TLMDObjectEditorManager;
    AlignPalette: TLMDAlignPalette;
    ServicePvdr: TLMDServiceProvider;
    IDEMgr: TLMDIdeManager;
    AppEvents: TApplicationEvents;
    ToolBar2: TToolBar;
    btnRun: TToolButton;
    ToolButton13: TToolButton;
    cmbLayout: TComboBox;
    btnSaveLayout: TToolButton;
    ToolButton4: TToolButton;
    cmbStyles: TComboBox;
    pnlObjectTree: TLMDDockPanel;
    CompTree: TLMDComponentTree;
    pnlObjectInspector: TLMDDockPanel;
    InspectorTabs: TTabControl;
    PropInsp: TLMDPropertyInspector;
    ObjectCombo: TLMDObjectComboBox;
    Shape1: TShape;
    Shape2: TShape;
    LMDDockPanel1: TLMDDockPanel;
    CompBar: TLMDComponentBar;
    ActionList: TActionList;
    actNewProj: TAction;
    actAddUnit: TAction;
    actAddForm: TAction;
    actSave: TAction;
    actSaveAs: TAction;
    actSaveProjectAs: TAction;
    actSaveAll: TAction;
    actClose: TAction;
    actCloseAll: TAction;
    actOpen: TAction;
    actRun: TAction;
    actTerminate: TAction;
    actAlignPalette: TAction;
    actTabOrderDlg: TAction;
    actCreationOrderDlg: TAction;
    actSaveLayout: TAction;
    actStepOver: TAction;
    actTraceInto: TAction;
    actCloseIDE: TAction;
    ToolButton5: TToolButton;
    ShowAlignPalette1: TMenuItem;
    estDialog1: TMenuItem;
    N48: TMenuItem;
    N45: TMenuItem;
    Alignrightedges1: TMenuItem;
    Aligntogrid1: TMenuItem;
    Alignbottoms1: TMenuItem;
    Alignhorizontalcenters1: TMenuItem;
    Centerhorizontallyinwindow1: TMenuItem;
    Spaceequallyhorizontally1: TMenuItem;
    Alignleftedges1: TMenuItem;
    Alignrightedges2: TMenuItem;
    Alignverticalcenters1: TMenuItem;
    Centerverticallyinwindow1: TMenuItem;
    Spaceequallyvertically1: TMenuItem;
    N49: TMenuItem;
    N50: TMenuItem;
    N51: TMenuItem;
    Bringtofront1: TMenuItem;
    Sendtoback1: TMenuItem;
    N52: TMenuItem;
    Lockselection1: TMenuItem;
    Deleteselected1: TMenuItem;
    N53: TMenuItem;
    aborder1: TMenuItem;
    Creationorder1: TMenuItem;
    N54: TMenuItem;
    Copy2: TMenuItem;
    Paste2: TMenuItem;
    Cut2: TMenuItem;
    Selectall2: TMenuItem;
    Deleteselected2: TMenuItem;
    ToolButton1: TToolButton;
    popRunDebug: TPopupMenu;
    RunDebug1: TMenuItem;
    popRunRelease: TPopupMenu;
    popPNGTest: TPopupMenu;
    PopMenu1: TMenuItem;
    ComponentImages: TLMDAlphaImageList;
    ComponentImages16x16: TLMDAlphaImageList;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    mnuProjectAddNewOther: TMenuItem;
    Other3: TMenuItem;
    N4: TMenuItem;
    timTheme: TTimer;
    N32BitWindowsDialogApplication1: TMenuItem;
    ChangeProjectBuildOrder1: TMenuItem;
    N15: TMenuItem;
    ExportFunctions1: TMenuItem;
    N55: TMenuItem;
    IncreaseFontSize1: TMenuItem;
    DecreaseFontSize1: TMenuItem;
    SetupVisualMASM1: TMenuItem;
    YourfirstHelloWorldprogram1: TMenuItem;
    N32bitMessageBoxApplication1: TMenuItem;
    N32bitDialogApplication1: TMenuItem;
    N32bitConsoleApplication1: TMenuItem;
    N32bitWindowsDLLs1: TMenuItem;
    Libraries1: TMenuItem;
    pnlErrors: TLMDDockPanel;
    vstErrors: TVirtualStringTree;
    procedure vstProjectGetPopupMenu(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      const P: TPoint; var AskParent: Boolean; var PopupMenu: TPopupMenu);
    procedure FormCreate(Sender: TObject);
    procedure vstProjectGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
    procedure vstProjectGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
      Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
    procedure FormDestroy(Sender: TObject);
    procedure vstProjectPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure FormShow(Sender: TObject);
    procedure vstProjectNodeDblClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
    procedure mnuExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnuSearchToggleBookmarkClick(Sender: TObject);
    procedure mnuSearchGoToBookmarkClick(Sender: TObject);
    procedure vstFunctionsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
    procedure vstFunctionsNodeDblClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
    procedure vstFunctionsGetPopupMenu(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      const P: TPoint; var AskParent: Boolean; var PopupMenu: TPopupMenu);
    procedure vstLabelsGetPopupMenu(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; const P: TPoint;
      var AskParent: Boolean; var PopupMenu: TPopupMenu);
    procedure vstLabelsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
    procedure vstLabelsNodeDblClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
    procedure btnBackClick(Sender: TObject);
    procedure btnForwardClick(Sender: TObject);
    procedure ViewPanelClick(Sender: TObject);
    procedure DockManagerReadAppInfo(Sender: TObject; const Xml: ILMDXmlDocument);
    procedure DockManagerWriteAppInfo(Sender: TObject; const Xml: ILMDXmlDocument);
    procedure SiteChange(Sender: TObject);
    procedure cmbStylesChange(Sender: TObject);
    procedure cmbLayoutSelect(Sender: TObject);
    procedure actSaveLayoutExecute(Sender: TObject);
    procedure InspectorTabsChange(Sender: TObject);
    procedure vstProjectDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      var Allowed: Boolean);
    procedure vstProjectDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState;
      Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure vstProjectDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject;
      Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure vstErrorsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
    procedure vstErrorsNodeDblClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
    procedure vstErrorsCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
      var Result: Integer);
    procedure PropInspTranslateProp(Sender: TObject; const APropName: TLMDString; var ATranslatedName: TLMDString);
    procedure PropInspFilterProp(Sender: TObject; AInstance: TPersistent; APropInfo: ILMDProperty; AIsSubProp: Boolean;
      var AIncludeProp: Boolean);
  private
    FOriginalFocusedSelectionColor: TColor;
    FSelectedFocusedSelectionColor: TColor;
    FNextDocId: Integer;
    FLayout: string;
    FUpdatingLayoutCombo: boolean;
    FLayoutsPath: string;
    FChangingStyle: boolean;
    procedure LoadStyles;
    function TryLoadLayout(const AName: string): Boolean;
    procedure GetTabbedDocPanels(AResult: TList);
    procedure UpdateLayoutCombo;
    procedure LoadLayoutList(AResult: TStrings);
    procedure RedockDocs(APanels: TList);
    procedure DockAsTabbedDoc(APanel: TLMDDockPanel);
    procedure SaveLayout(const AName: string);
    procedure ChangeStyle(style: string; timeBasedChange: boolean = false);
    function FilterProperty(AInstance: TPersistent; APropInfo: ILMDProperty): boolean;
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uDM, uSharedGlobals, uGroup, uProject, uProjectFile;

const
  INFOTEXT_MODIFIED = 'Modified';
  KEYSTATE_INSERT = 0;
  KEYSTATE_INSERT_TEXT = 'Insert';
  KEYSTATE_OVERWRITE = 1;
  KEYSTATE_OVERWRITE_TEXT = 'Overwrite';

procedure TButtonExStyleHook.WMLButtonDblClk(var Message: TWMMouse);
begin
  if not (csDesigning in Control.ComponentState) then
    inherited;
end;

procedure TfrmMain.actSaveLayoutExecute(Sender: TObject);
var
  s: string;
begin
  s := FLayout;
  if InputQuery('Save Layout', 'Enter layout name:', s) and (s <> '') then
  begin
    s := ChangeFileExt(ExtractFileName(s), ''); // Remove all possible
                                                // path/extension like info.
    SaveLayout(s);
    UpdateLayoutCombo;
  end;
end;

procedure TfrmMain.btnBackClick(Sender: TObject);
begin
  htmlHelp.HistoryIndex := htmlHelp.HistoryIndex + 1;
  htmlHelp.Repaint;
end;

procedure TfrmMain.btnForwardClick(Sender: TObject);
begin
  htmlHelp.HistoryIndex := htmlHelp.HistoryIndex - 1;
  htmlHelp.Repaint;
end;

procedure TfrmMain.cmbLayoutSelect(Sender: TObject);
var
  ltnm: string;
begin
  if not FUpdatingLayoutCombo then
  begin
    ltnm := '';
    if cmbLayout.ItemIndex <> -1 then
      ltnm := cmbLayout.Items[cmbLayout.ItemIndex];
    if ltnm <> '' then
      TryLoadLayout(ltnm);
  end;
end;

procedure TfrmMain.cmbStylesChange(Sender: TObject);
begin
  ChangeStyle(cmbStyles.Items[cmbStyles.ItemIndex]);
end;

procedure TfrmMain.DockManagerReadAppInfo(Sender: TObject; const Xml: ILMDXmlDocument);
var
  elem: ILMDXmlElement;
begin
  elem := Xml.DocumentElement.FindElement('application', '', Null);
  if elem <> nil then
  begin
    { Load main form bounds }

    SetBounds(elem.GetIntAttr('left', Left),
              elem.GetIntAttr('top', Top),
              elem.GetIntAttr('width', Width),
              elem.GetIntAttr('height', Height));
  end;
end;

procedure TfrmMain.DockManagerWriteAppInfo(Sender: TObject; const Xml: ILMDXmlDocument);
var
  elem: ILMDXmlElement;
begin
  elem := Xml.DocumentElement.AppendElement('application');

  { Save main form bounds }

  elem.SetIntAttr('left', Left);
  elem.SetIntAttr('top', Top);
  elem.SetIntAttr('width', Width);
  elem.SetIntAttr('height', Height);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dm.ShuttingDown := true;
  dm.CheckIfChangesHaveBeenMadeAndPromptIfNecessary;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i: integer;
  item: TMenuItem;
  pnl: TLMDDockPanel;
begin
  FChangingStyle := false;
  startingUp := true;
//  TVclStylesSystemMenu.Create(Self);

  for i := 0 to ComponentCount - 1 do
    if Components[i] is TLMDDockPanel then
    begin
      pnl := TLMDDockPanel(Components[i]);
      item := TMenuItem.Create(Self);
      item.Caption := pnl.Caption;
      item.ImageIndex := pnl.ImageIndex;
      item.Tag := Integer(pnl);
      item.OnClick := ViewPanelClick;
      V1.Add(item);
    end;

  vstProject.NodeDataSize := SizeOf(TProjectData);
  vstFunctions.NodeDataSize := SizeOf(TFunctionData);
  vstLabels.NodeDataSize := SizeOf(TLabelData);
  FOriginalFocusedSelectionColor := vstProject.Colors.FocusedSelectionColor;
  FSelectedFocusedSelectionColor := $00008CFF;

  CompBar.RegisterComponent(COMPONENT_PALETTE_STANDARD, TLabel, 'Label', 0);
  CompBar.RegisterComponent(COMPONENT_PALETTE_STANDARD, TEdit, 'Edit', 1);
  CompBar.RegisterComponent(COMPONENT_PALETTE_STANDARD, TMemo, 'Memo', 2);
  CompBar.RegisterComponent(COMPONENT_PALETTE_STANDARD, TButton, 'Button', 3);
  CompBar.RegisterComponent(COMPONENT_PALETTE_STANDARD, TCheckBox, 'CheckBox', 4);
  CompBar.RegisterComponent(COMPONENT_PALETTE_STANDARD, TRadioButton, 'RadioButton', 5);
  CompBar.RegisterComponent(COMPONENT_PALETTE_STANDARD, TListBox, 'ListBox', 6);
  CompBar.RegisterComponent(COMPONENT_PALETTE_STANDARD, TComboBox, 'ComboBox', 7);
  CompBar.RegisterComponent(COMPONENT_PALETTE_STANDARD, TGroupBox, 'GroupBox', 8);
  CompBar.RegisterComponent(COMPONENT_PALETTE_STANDARD, TRadioGroup, 'RadioGroup', 9);
  CompBar.RegisterComponent(COMPONENT_PALETTE_STANDARD, TPanel, 'Panel', 10);
  CompBar.RegisterComponent(COMPONENT_PALETTE_STANDARD, TMenu, 'Menu', 11);
  CompBar.RegisterComponent(COMPONENT_PALETTE_STANDARD, TPopupMenu, 'PopupNenu', 12);
  CompBar.RegisterComponent(COMPONENT_PALETTE_STANDARD, TScrollBar, 'ScrollBar', 13);
//  CompBar.RegisterComponent('Standard', TActionList, 11);
  CompBar.RegisterComponent(COMPONENT_PALETTE_WIN32, TTabControl, 'TabControl', 14);
//  CompBar.RegisterComponent(COMPONENT_PALETTE_WIN32, TPageControl, 15);
  CompBar.RegisterComponent(COMPONENT_PALETTE_WIN32, TImageList, 'ImageList', 16);
  CompBar.RegisterComponent(COMPONENT_PALETTE_WIN32, TTreeView, 'TreeView', 17);
  CompBar.Pages[0].Expanded := True;

  FLayoutsPath := ExtractFileDir(GetModuleName(HINSTANCE)) + PathDelim + LAYOUTS_FOLDER;
  FLayout := DEFAULT_LAYOUT;
  UpdateLayoutCombo;
end;

procedure TfrmMain.ViewPanelClick(Sender: TObject);
begin
  TControl((Sender as TMenuItem).Tag).Show;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  dm.VisualMASMOptions.SaveFile;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  cmd : string;
  i : Integer;
  pf: TProjectFile;
begin
  if not FChangingStyle then
    begin
    if dm.VisualMASMOptions.ActiveLayout <>'' then
      TryLoadLayout(dm.VisualMASMOptions.ActiveLayout)
    else begin
      if not TryLoadLayout(DEFAULT_LAYOUT) then
        DockManager.ApplyDesignLayout;
    end;

    LoadStyles;

    caption := 'Visual MASM '+VISUALMASM_VERSION_DISPLAY;

    // Check for parameters
    if ParamCount > 0 then
    begin
      dm.PrepareToOpenFileFromCommandLine;
      for i := 1 to ParamCount do
      begin
        pf := dm.OpenFile('', paramstr(i));
        dm.Group.ActiveProject.AddProjectFile(pf);
      end;
      dm.SynchronizeProjectManagerWithGroup;
      dm.UpdateUI(true);
    end else begin
      if dm.VisualMASMOptions.OpenLastProjectUsed then
      begin
        if dm.VisualMASMOptions.LastFilesUsed.Count > 0 then
        begin
          dm.LoadGroup(dm.VisualMASMOptions.LastFilesUsed[0].FileName);
        end;
      end;
    end;
    dm.UpdateStatusBarForMemo(dm.GetMemo);
  end;

  if pnlWelcomePage.Showing then
    pnlWelcomePage.Show;

  startingUp := false;
  dm.UpdateUI(true);
end;

procedure TfrmMain.mnuExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.mnuSearchGoToBookmarkClick(Sender: TObject);
begin
  dm.GoToBookMark(TMenuItem(Sender).Tag);
end;

procedure TfrmMain.mnuSearchToggleBookmarkClick(Sender: TObject);
begin
  dm.ToggleBookMark(TMenuItem(Sender).Tag);
end;

procedure TfrmMain.PropInspFilterProp(Sender: TObject; AInstance: TPersistent; APropInfo: ILMDProperty;
  AIsSubProp: Boolean; var AIncludeProp: Boolean);
begin
  AIncludeProp := FilterProperty(AInstance, APropInfo);
end;

function TfrmMain.FilterProperty(AInstance: TPersistent; APropInfo: ILMDProperty): boolean;
begin
  result := true;
  if AInstance is TButton then
  begin
    with APropInfo do
    begin
      if Name = 'Action' then
        result := false;
    end;
  end;
end;

procedure TfrmMain.PropInspTranslateProp(Sender: TObject; const APropName: TLMDString; var ATranslatedName: TLMDString);
begin
//  ShowMessage(APropName);
end;

procedure TfrmMain.SiteChange(Sender: TObject);
begin
  if not startingUp then
    dm.SiteChanged;
end;

procedure TfrmMain.vstProjectDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  var Allowed: Boolean);
begin
// TODO: Implement Drag & Drop
//  Allowed := True;
end;

procedure TfrmMain.vstProjectDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject;
  Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  pSource, pTarget: PVirtualNode;
  attMode: TVTNodeAttachMode;
  sourceData, targetData: PProjectData;
  List: TList<PVirtualNode>;
begin
  pSource := TVirtualStringTree(Source).FocusedNode;
  sourceData := vstProject.GetNodeData(pSource);

  pTarget := Sender.DropTargetNode;
  targetData := vstProject.GetNodeData(pTarget);

  case Mode of
    dmNowhere: attMode := amNoWhere;
    dmAbove: attMode := amInsertBefore;
    dmOnNode, dmBelow: attMode := amInsertAfter;
  end;

  if Effect = DROPEFFECT_COPY then
    Sender.CopyTo(pSource, pTarget, amAddChildLast, False)
  else if Effect = DROPEFFECT_MOVE then
    Sender.MoveTo(pSource, pTarget, attMode, False);

//  case Sender.GetNodeLevel(pTarget) of
//    0:
//      case Mode of
//        dmNowhere:
//          attMode := amNoWhere;
//        else
//          attMode :=  amAddChildLast;
//      end;
//    1:
//      case Mode of
//        dmNowhere:
//          attMode := amNoWhere;
//        dmAbove:
//          attMode := amInsertBefore;
//        dmOnNode, dmBelow:
//          attMode := amInsertAfter;
//      end;
//
//  end;
//  List:= TList<PVirtualNode>.create();
//  pSource :=  Sender.GetFirstSelected();
//  while Assigned(pSource) do
//  begin
//     List.Add(pSource);
//     pSource := Sender.GetNextSelected(pSource);
//  end;
//
//  for pSource in List do
//   Sender.MoveTo(pSource, pTarget, attMode, False);
//
//  List.Free;
end;

procedure TfrmMain.vstProjectDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState;
  Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
var
  sourceNode, targetNode: PVirtualNode;
  sourceData, targetData: PProjectData;
  sourceLevel, targetLevel: integer;
begin
  sourceNode := Sender.FocusedNode;
  sourceData := vstProject.GetNodeData(sourceNode);
  sourceLevel := Sender.GetNodeLevel(sourceNode);

  targetNode := Sender.DropTargetNode;
  targetData := vstProject.GetNodeData(targetNode);
  targetLevel := Sender.GetNodeLevel(targetNode);

  if (sourceLevel = 2) and (targetLevel = 1) then
  begin
    Accept := true;
  end;

//  if (sourceLevel = 3) and (targetLevel = 3) then
//  begin
//    Accept := true;
//  end;

//  if (pUsedNode <> nil) and (pTargetNode <> nil) then begin
//    Accept := (pUsedNode.Parent = pTargetNode.Parent);
//  end;

//  Accept := (Source = Sender);
end;

procedure TfrmMain.vstProjectGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
var
  level: integer;
  data: PProjectData;
  project: TProject;
  projectFile: TProjectFile;
begin
  data:=vstProject.GetNodeData(Node);
  if (Kind in [ikNormal, ikSelected]) and (Column = 0) then
  begin
    level := Sender.GetNodeLevel(Node);
    if level = 0 then
      ImageIndex := 9;

    if level = 1 then
    begin
      if data.ProjectId = '' then exit;
      project:=dm.Group[data.ProjectId];
      if project <> nil then
        case project.ProjectType of
          ptDos16COM: ImageIndex := 0;
          ptDos16EXE: ImageIndex := 0;
          ptWin16: ImageIndex := 1;
          ptWin16DLL: ImageIndex := 2;
          ptWin32: ImageIndex := 1;
          ptWin32Dlg: ImageIndex := 12;
          ptWin32Con: ImageIndex := 11;
          ptWin32DLL: ImageIndex := 2;
          ptWin64: ImageIndex := 1;
          ptWin64DLL: ImageIndex := 2;
          ptLib: ImageIndex := 14;
        end;
    end;

    if (level = 2) or (level = 3) then
    begin
      if (data.ProjectId = '') or (data.FileId = '') then exit;
      project:=dm.Group[data.ProjectId];
      if project <> nil then
      begin
        projectFile:=dm.Group[data.ProjectId].ProjectFile[data.FileId];
        if projectFile <> nil then
          case projectFile.ProjectFileType of
            pftASM: ImageIndex := 4;
            pftRC: ImageIndex := 5;
            pftTXT,pftDef: ImageIndex := 6;
            pftDLG: ImageIndex := 1;
            pftBAT: ImageIndex := 8;
            pftINC: ImageIndex := 10;
            pftBinary: ImageIndex := 13;
            pftLib: ImageIndex := 14;
            pftManifest: ImageIndex := 15;
          end;
      end;
    end;
  end;
end;

procedure TfrmMain.vstProjectGetPopupMenu(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  const P: TPoint; var AskParent: Boolean; var PopupMenu: TPopupMenu);
var
  level: integer;
  menuItem,mnuProjectAddNew: TMenuItem;
  data: PProjectData;
  pf: TProjectFile;

  procedure CreateExecutionProjectMenu;
  begin
    menuItem := TMenuItem.Create(popProject);
    menuItem.Action := dm.actProjectRun;
    popProject.Items.Add(menuItem);
  end;

  procedure CreateAssembleProjectMenu;
  begin
    menuItem := TMenuItem.Create(popProject);
    menuItem.Action := dm.actProjectAssemble;
    popProject.Items.Add(menuItem);
  end;

  procedure CreateStandardProjectMenu;
  begin
    menuItem := TMenuItem.Create(popProject);
    menuItem.Action := dm.actProjectBuild;
    popProject.Items.Add(menuItem);

    menuItem := TMenuItem.Create(popProject);
    menuItem.Caption := '-';
    popProject.Items.Add(menuItem);

    menuItem := TMenuItem.Create(popProject);
    menuItem.Action := dm.actShowInExplorer;
    popProject.Items.Add(menuItem);

    menuItem := TMenuItem.Create(popProject);
    menuItem.Action := dm.actCopyPath;
    popProject.Items.Add(menuItem);

    menuItem := TMenuItem.Create(popProject);
    menuItem.Action := dm.actDOSPromnptHere;
    popProject.Items.Add(menuItem);

    menuItem := TMenuItem.Create(popProject);
    menuItem.Caption := '-';
    popProject.Items.Add(menuItem);

    menuItem := TMenuItem.Create(popProject);
    menuItem.Action := dm.actAddToProject;
    popProject.Items.Add(menuItem);

    mnuProjectAddNew := TMenuItem.Create(popProject);
    mnuProjectAddNew.Caption := 'Add New';
    mnuProjectAddNew.Name := 'mnuProjectAddNew';
    popProject.Items.Add(mnuProjectAddNew);
  end;

  procedure CreateBottomProjectMenu;
  begin
    menuItem := TMenuItem.Create(popProject);
    menuItem.Caption := '-';
    popProject.Items.Add(menuItem);

    menuItem := TMenuItem.Create(popProject);
    menuItem.Action := dm.actGroupRemoveProject;
    popProject.Items.Add(menuItem);

    menuItem := TMenuItem.Create(popProject);
    menuItem.Caption := '-';
    popProject.Items.Add(menuItem);

    menuItem := TMenuItem.Create(popProject);
    menuItem.Action := dm.actProjectSave;
    popProject.Items.Add(menuItem);

    menuItem := TMenuItem.Create(popProject);
    menuItem.Action := dm.actProjectSaveAs;
    popProject.Items.Add(menuItem);

    menuItem := TMenuItem.Create(popProject);
    menuItem.Action := dm.actProjectRename;
    popProject.Items.Add(menuItem);

    menuItem := TMenuItem.Create(popProject);
    menuItem.Caption := '-';
    popProject.Items.Add(menuItem);

    menuItem := TMenuItem.Create(popProject);
    menuItem.Action := dm.actProjectOptions;
    popProject.Items.Add(menuItem);
  end;

begin
//  sAlphaHints1.HideHint;
  timerProjectTreeHint.Enabled := false;
  data:=vstProject.GetNodeData(Node);
  level := Sender.GetNodeLevel(Node);
  dm.UpdateUI(false);
  case Column of
    -1, 0:
      begin
        if level = 0 then
          PopupMenu := popGroup;

        if level = 1 then
        begin
          PopupMenu := popProject;

          case dm.Group.ProjectById[data.ProjectId].ProjectType of
            ptDos16COM, ptDos16EXE:
              begin
                popProject.Items.Clear;
                CreateExecutionProjectMenu;
                CreateAssembleProjectMenu;
                CreateStandardProjectMenu;

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewAssemblyFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewTextFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewBatchFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Caption := '-';
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actNewOther;
                mnuProjectAddNew.Add(menuItem);
              end;
            ptWin16:
              begin
                popProject.Items.Clear;
                CreateExecutionProjectMenu;
                CreateAssembleProjectMenu;
                CreateStandardProjectMenu;

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewAssemblyFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actFileAddNewDialog;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewTextFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewBatchFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Caption := '-';
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actNewOther;
                mnuProjectAddNew.Add(menuItem);
              end;
            ptWin32, ptWin32Dlg, ptWin64:
              begin
                popProject.Items.Clear;
                CreateExecutionProjectMenu;
                CreateAssembleProjectMenu;
                CreateStandardProjectMenu;

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewAssemblyFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actFileAddNewDialog;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewTextFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewBatchFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Caption := '-';
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actNewOther;
                mnuProjectAddNew.Add(menuItem);
              end;
            ptWin16DLL,ptWin32DLL,ptWin64DLL:
              begin
                popProject.Items.Clear;
                CreateAssembleProjectMenu;

                dm.actExportFunctions.Visible := true;
                menuItem := TMenuItem.Create(popProject);
                menuItem.Action := dm.actExportFunctions;
                popProject.Items.Add(menuItem);

                CreateStandardProjectMenu;

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewAssemblyFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actFileAddNewDialog;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewTextFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewBatchFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Caption := '-';
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actNewOther;
                mnuProjectAddNew.Add(menuItem);
              end;
            ptWin32Con:
              begin
                popProject.Items.Clear;
                CreateExecutionProjectMenu;
                CreateAssembleProjectMenu;
                CreateStandardProjectMenu;

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewAssemblyFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewTextFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewBatchFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Caption := '-';
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actNewOther;
                mnuProjectAddNew.Add(menuItem);
              end;
            ptLib:
              begin
                popProject.Items.Clear;
                CreateAssembleProjectMenu;
                CreateStandardProjectMenu;

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewAssemblyFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actAddNewTextFile;
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Caption := '-';
                mnuProjectAddNew.Add(menuItem);

                menuItem := TMenuItem.Create(mnuProjectAddNew);
                menuItem.Action := dm.actNewOther;
                mnuProjectAddNew.Add(menuItem);
              end;
          end;

          CreateBottomProjectMenu;
        end;

        if (level = 2) or (level = 3) then
        begin
          popFile.Items.Clear;

          pf := dm.Group.GetProjectFileById(data.FileId);
          if (pf <> nil) then
          begin
            case pf.ProjectFileType of
              pftRC:
                begin
                  menuItem := TMenuItem.Create(popFile);
                  menuItem.Action := dm.actFileCompile;
                  popFile.Items.Add(menuItem);
                end;
              pftASM:
                begin
                  menuItem := TMenuItem.Create(popFile);
                  menuItem.Action := dm.actAssembleFile;
                  popFile.Items.Add(menuItem);
                end
            end;
          end;

          menuItem := TMenuItem.Create(popFile);
          menuItem.Action := dm.actFileOpenFileInProjectManager;
          popFile.Items.Add(menuItem);

          menuItem := TMenuItem.Create(popFile);
          menuItem.Caption := '-';
          popFile.Items.Add(menuItem);

          menuItem := TMenuItem.Create(popFile);
          menuItem.Action := dm.actRemoveFromProject;
          popFile.Items.Add(menuItem);

          menuItem := TMenuItem.Create(popFile);
          menuItem.Action := dm.actDeleteFile;
          popFile.Items.Add(menuItem);

          menuItem := TMenuItem.Create(popFile);
          menuItem.Caption := '-';
          popFile.Items.Add(menuItem);

          menuItem := TMenuItem.Create(popFile);
          menuItem.Action := dm.actShowInExplorer;
          popFile.Items.Add(menuItem);

          menuItem := TMenuItem.Create(popFile);
          menuItem.Action := dm.actCopyPath;
          popFile.Items.Add(menuItem);

          menuItem := TMenuItem.Create(popFile);
          menuItem.Action := dm.actDOSPromnptHere;
          popFile.Items.Add(menuItem);

          menuItem := TMenuItem.Create(popFile);
          menuItem.Caption := '-';
          popFile.Items.Add(menuItem);

          menuItem := TMenuItem.Create(popFile);
          menuItem.Action := dm.actSave;
          popFile.Items.Add(menuItem);

          menuItem := TMenuItem.Create(popFile);
          menuItem.Action := dm.actFileSaveAs;
          popFile.Items.Add(menuItem);

          menuItem := TMenuItem.Create(popFile);
          menuItem.Action := dm.actFileRename;
          popFile.Items.Add(menuItem);

          PopupMenu := popFile;
        end;
      end;
  else
    PopupMenu := nil;
  end;
end;

procedure TfrmMain.vstProjectGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  Data: PProjectData;
  projectFile: TProjectFile;
  project: TProject;
//  modfied: boolean;
begin
  Data := Sender.GetNodeData(Node);
    case Column of
      0:   // Name column
        if Node.Parent = Sender.RootNode then
        begin
          // root nodes
          if (Node.Index = 0) and (dm.Group <> nil) then
          begin
            CellText := dm.Group.Name;
            if dm.Group.Modified then
              CellText := MODIFIED_CHAR+CellText;
          end else
            CellText := MODIFIED_CHAR+DEFAULT_PROJECTGROUP_NAME;
        end else begin
          case Sender.GetNodeLevel(Node) of
            1:
              begin
                if (dm.Group = nil) or (data.ProjectId = '') then exit;
                if dm.Group[data.ProjectId] <> nil then
                begin
                  CellText := dm.Group[data.ProjectId].Name;
                  if dm.Group[data.ProjectId].Modified then
                    CellText := MODIFIED_CHAR+CellText;
                end;
              end;
            2:
              begin
                if (dm.Group = nil) or (data.ProjectId = '') or (data.FileId = '') then exit;
                if dm.Group[data.ProjectId] <> nil then
                begin
                  projectFile:=dm.Group[data.ProjectId].ProjectFile[data.FileId];
                  if projectFile <> nil then
                  begin
//                    modfied := projectFile.Modified;
                    CellText := projectFile.Name;
                    if projectFile.Modified then
                      CellText := MODIFIED_CHAR+CellText;
                  end;
                end;
              end;
            3:
              begin
                if (dm.Group = nil) or (data.ProjectId = '') or (data.FileId = '') then exit;
                if dm.Group[data.ProjectId] <> nil then
                begin
                  projectFile:=dm.Group[data.ProjectId].ProjectFile[data.FileId];
                  if projectFile <> nil then
                  begin
//                    modfied := projectFile.Modified;
                    CellText := projectFile.Name;
                    if projectFile.Modified then
                      CellText := MODIFIED_CHAR+CellText;
                  end;
                end;
              end;
          end;
        end;
      1:  // Build order column
        begin
          if Node.Parent = Sender.RootNode then
          begin
            // root nodes
          end else begin
            case Sender.GetNodeLevel(Node) of
              1:
                begin
                  if (dm.Group = nil) or (data.ProjectId = '') then exit;
                  if dm.Group[data.ProjectId] <> nil then
                  begin
                    CellText := IntToStr(dm.Group.GetBuildOrderForProject(data.ProjectId));
                  end;
                end;
            end;
          end;
        end;
      2:  // Size column
        begin
          if Node.Parent = Sender.RootNode then
          begin
            // root nodes
          end else begin
            case Sender.GetNodeLevel(Node) of
              1:
                begin
                  if (dm.Group = nil) or (data.ProjectId = '') then exit;
                  if dm.Group[data.ProjectId] <> nil then
                  begin
                    project := dm.Group[data.ProjectId];
                    if project <> nil then
                      CellText := FormatByteSize(project.SizeInBytes);
                  end;
                end;
              2:
                begin
                  if (dm.Group = nil) or (data.ProjectId = '') or (data.FileId = '') then exit;
                  if dm.Group[data.ProjectId] <> nil then
                  begin
                    projectFile:=dm.Group[data.ProjectId].ProjectFile[data.FileId];
                    if projectFile <> nil then
                      CellText := FormatByteSize(projectFile.SizeInBytes);
                  end;
                end;
            end;
          end;
        end;
    end;
end;

procedure TfrmMain.vstErrorsCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
  var Result: Integer);
var
  data: PAssemblyError;
  data2: PAssemblyError;
begin
  data := Sender.GetNodeData(Node1);
  data2 := Sender.GetNodeData(Node2);
  result := data.LineNumber - data2.LineNumber;
end;

procedure TfrmMain.vstErrorsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  data: PAssemblyError;
begin
  data := Sender.GetNodeData(Node);

  if Assigned(data) then
  begin
    case Column of
      0:   // Error Description column
        begin
          CellText := data.Description;
        end;
      1:  // Line number column
        begin
          CellText := inttostr(data.LineNumber);
        end;
      2:  // File column
        begin
          CellText := data.FileName;
        end;
    end;
  end;
end;

procedure TfrmMain.vstErrorsNodeDblClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
var
  data: PAssemblyError;
begin
  data := Sender.GetNodeData(HitInfo.HitNode);
  dm.GoToLineNumber(data.IntId, data.LineNumber);
end;

procedure TfrmMain.vstFunctionsGetPopupMenu(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  const P: TPoint; var AskParent: Boolean; var PopupMenu: TPopupMenu);
//var
//  level: integer;
//  menuItem: TMenuItem;
//  data: PFunctionData;
begin
//  sAlphaHints1.HideHint;
//  data := vstFunctions.GetNodeData(Node);
//  level := Sender.GetNodeLevel(Node);
//  dm.UpdateUI(false);
  PopupMenu := popFunctions;
//  case Column of
//    -1, 0:
//      begin
//        if level = 0 then
//          PopupMenu := popGroup;
//
//        if level = 1 then
//        begin
//          PopupMenu := popProject;
//        end;
//
//        if level = 2 then
//        begin
//          PopupMenu := popFile;
//        end;
//      end;
//  else
//    PopupMenu := nil;
//  end;
end;

procedure TfrmMain.vstFunctionsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
//var
//  Data: PFunctionData;
//  projectFile: TProjectFile;
begin
//  Data := Sender.GetNodeData(Node);
  if (Node.Index < 0) or (Node.Index >= dm.Functions.Count) then exit;
  case Column of
    0:   // Name column
      begin
        CellText := dm.Functions.Items[Node.Index].Name;
      end;
    1:  // L:ne column
      begin
        CellText := inttostr(dm.Functions.Items[Node.Index].Line);
      end;
  end;
end;

procedure TfrmMain.vstFunctionsNodeDblClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
var
  data: PFunctionData;
begin
  data := Sender.GetNodeData(HitInfo.HitNode);
  dm.GoToFunctionOnLine(data.Line);
end;

procedure TfrmMain.vstLabelsGetPopupMenu(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  const P: TPoint; var AskParent: Boolean; var PopupMenu: TPopupMenu);
begin
  PopupMenu := popLabels;
end;

procedure TfrmMain.vstLabelsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
//var
//  Data: PLabelData;
//  projectFile: TProjectFile;
begin
//  Data := Sender.GetNodeData(Node);
  if (Node.Index < 0) or (Node.Index >= dm.Labels.Count) then exit;
  case Column of
    0:   // Name column
      begin
        CellText := dm.Labels.Items[Node.Index].Name;
      end;
    1:  // L:ne column
      begin
        CellText := inttostr(dm.Labels.Items[Node.Index].Line);
      end;
  end;
end;

procedure TfrmMain.vstLabelsNodeDblClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
var
  data: PLabelData;
begin
  data := Sender.GetNodeData(HitInfo.HitNode);
  dm.GoToFunctionOnLine(data.Line);
end;

procedure TfrmMain.vstProjectNodeDblClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
var
  data: PProjectData;
begin
  data := Sender.GetNodeData(HitInfo.HitNode);
  case HitInfo.HitColumn of
    0:   // Name column
      case Sender.GetNodeLevel(HitInfo.HitNode) of
        1:
          begin
            dm.Group.ActiveProject := dm.Group[data.ProjectId];
            dm.Group.Modified := true;
//            tabProject.Caption := dm.Group.ActiveProject.Name;
          end;
        2,3:
          begin
            dm.LastTabIndex := dm.Group.ActiveProject.ActiveFile.IntId;
            dm.Group.ActiveProject := dm.Group[data.ProjectId];
            dm.Group.ActiveProject.ActiveFile := dm.Group.ActiveProject.ProjectFile[data.FileId];
            dm.FocusPage(dm.Group.ActiveProject.ActiveFile);
          end;
      end;
  end;
end;

procedure TfrmMain.vstProjectPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType);
var
  data: PProjectData;
begin
  data:=vstProject.GetNodeData(Node);
  case Column of
    0:   // Name column
      case Sender.GetNodeLevel(Node) of
        1:
          begin
            if dm.Group.ActiveProject = nil then exit;
            if dm.Group.ActiveProject.Id = data.ProjectId then
            begin
              if vstProject.Selected[Node] then
              begin
//                TargetCanvas.Font.Color := $000061B0;
              end else begin
//                TargetCanvas.Font.Color := $00008CFF;
              end;
              TargetCanvas.Font.Style := [fsBold];
            end else
              TargetCanvas.Font.Style := [];
          end;
        2:
          begin
            //fileName := dm.Group[data.ProjectId].GetProjectFileById(data.FileId).Name;
            //dm.FocusPage(dm.Group[data.ProjectId].GetProjectFileById(data.FileId));
          end;
      end;
  end;
end;

procedure TfrmMain.LoadStyles;
var
  Style: String;
  i: integer;
  searchResults : TSearchRec;
  SearchDir: string;
  SLStyles: TStringList;
begin
  SearchDir := dm.VisualMASMOptions.AppFolder+STYLES_FOLDER+PathDelim;

  if DirectoryExists(SearchDir) then begin
    if FindFirst(SearchDir+'*.*',faAnyFile - faDirectory, searchResults) = 0 then
      repeat
        try
          if TStyleManager.IsValidStyle(SearchDir+searchResults.Name) then
            TStyleManager.LoadFromFile(SearchDir+searchResults.Name);
        except
        end;
      until FindNext(searchResults) <> 0;
  end;

  cmbStyles.Clear;

  SLStyles := TStringList.Create;
  try
    SLStyles.Duplicates := TDuplicates.dupIgnore;
    for Style in TStyleManager.StyleNames do
      SLStyles.Add(Style);
    SLStyles.Sort;

    for Style in SLStyles do
    begin
      cmbStyles.Items.Add(Style);
      if TStyleManager.ActiveStyle.Name=Style then
        cmbStyles.ItemIndex := cmbStyles.Items.Count-1;
    end;
  finally
    SLStyles.Free;
  end;
end;

function TfrmMain.TryLoadLayout(const AName: string): Boolean;
var
  flnm: string;
  pnls: TList;
//  last: TfrmEditor;
begin
  Result := False;
  flnm   := FLayoutsPath + AName + '.xml';

  if FileExistsStripped(flnm) then
  begin
    pnls := TList.Create;
    try
      GetTabbedDocPanels(pnls);
//      last := TfrmEditor.Current;

      DockManager.LoadFromFile(flnm);
      FLayout := AName;

      RedockDocs(pnls);
//      if last <> nil then
//        last.Show;
      UpdateLayoutCombo;
    finally
      pnls.Free;
    end;
    Result  := True;
  end;
end;

procedure TfrmMain.GetTabbedDocPanels(AResult: TList);
var
  zns: TList;
  i:   Integer;
  pnl: TLMDDockPanel;
begin
  // Collect all tabbed document panels into resulting
  // list. Floating documents are not considered here.
  zns := TList.Create;
  try
    Site.SpaceZone.GetPanelZones(True, zns);
    for i := 0 to zns.Count - 1 do
    begin
      pnl := TLMDDockZone(zns[i]).Panel;
      if pnl.ClientKind = dkDocument then
        AResult.Add(pnl);
    end;
  finally
    zns.Free;
  end;
end;

procedure TfrmMain.InspectorTabsChange(Sender: TObject);
begin
  if InspectorTabs.TabIndex = 0 then
    PropInsp.PropKinds := [pkProperties]
  else
    PropInsp.PropKinds := [pkEvents];
end;

procedure TfrmMain.UpdateLayoutCombo;
begin
  FUpdatingLayoutCombo := True;
  cmbLayout.Items.BeginUpdate;
  try
    cmbLayout.Items.Clear;
    LoadLayoutList(cmbLayout.Items);
    cmbLayout.ItemIndex := cmbLayout.Items.IndexOf(FLayout);
  finally
    cmbLayout.Items.EndUpdate;
    FUpdatingLayoutCombo := False;
  end;
end;

procedure TfrmMain.LoadLayoutList(AResult: TStrings);
var
  sr: TSearchRec;
begin
  if FindFirst(FLayoutsPath + '*.xml', faAnyFile, sr) <> 0 then
    Exit;
  repeat
    AResult.Add(ChangeFileExt(ExtractFileName(sr.Name), ''));
  until (FindNext(sr) <> 0);
  FindClose(sr);
end;

procedure TfrmMain.RedockDocs(APanels: TList);
var
  i:   Integer;
  pnl: TLMDDockPanel;
begin
  for i := 0 to APanels.Count - 1 do
  begin
    pnl := TLMDDockPanel(APanels[i]);
    if pnl.Site = nil then // For sure.
      DockAsTabbedDoc(pnl);
  end;
end;

procedure TfrmMain.DockAsTabbedDoc(APanel: TLMDDockPanel);
var
  zn: TLMDDockZone;
begin
  zn := Site.SpaceZone;
  while (zn <> nil) and (zn.Kind <> zkTabs) and
        (zn.ZoneCount > 0) do
    zn := zn[0];

  if zn <> nil then
  begin
    Site.DockControl(APanel, zn, alClient);
    if (APanel.Zone <> nil) and (APanel.Zone.Parent <> nil) then
    begin
      APanel.Zone.Index := APanel.Zone.Parent.ZoneCount - 1;
      APanel.Show; // Activate.
    end;
  end;
end;

procedure TfrmMain.SaveLayout(const AName: string);
var
  flnm: string;
begin
  ForceDirectories(FLayoutsPath);
  flnm := FLayoutsPath + AName + '.xml';

  DockManager.SaveToFile(flnm);
  FLayout := AName;
end;

procedure TfrmMain.ChangeStyle(style: string; timeBasedChange: boolean = false);
begin
  if style = '' then exit;
  if timeBasedChange then
  begin
//    if MessageDlg('About to change Theme based on current time. Continue?',mtCustom,[mbYes,mbNo], 0) = mrNo then
//      exit;

  end;
  dm.CloseAllDialogsBeforeSwitchingTheme;
  FChangingStyle := true;
  TStyleManager.TrySetStyle(style);
  dm.VisualMASMOptions.Theme := style;
  dm.VisualMASMOptions.ThemeCodeEditor := style;
  dm.LoadColors(style);
  dm.AssignColorsToAllMemos;
end;

initialization
  TCustomStyleEngine.UnRegisterStyleHook(TButton, TButtonStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TButton, TButtonExStyleHook);

end.
