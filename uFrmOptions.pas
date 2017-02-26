unit uFrmOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ComCtrls, sPageControl,
  VirtualTrees, ExtCtrls, StdCtrls, sButton, sPanel, ToolWin,
  sToolBar, SynEditHighlighter, SynHighlighterPas, SynEdit, SynMemo,
  sTreeView, Mask, sMaskEdit, sCustomComboEdit, sComboEdit, sLabel,
  sGroupBox, sCheckBox, sComboBox, uFrmThemePreview, sSkinProvider,
  sListBox, uSharedGlobals;

type
  TfrmOptions = class(TForm)
    pagOptions: TsPageControl;
    sPanel1: TsPanel;
    btnCancel: TsButton;
    btnOk: TsButton;
    tvTree: TsTreeView;
    tabFileLocations: TsTabSheet;
    grp32Bit: TsGroupBox;
    sLabel10: TsLabel;
    sLabel11: TsLabel;
    sLabel12: TsLabel;
    sLabel21: TsLabel;
    txtML32: TsComboEdit;
    txtLink32: TsComboEdit;
    txtRC32: TsComboEdit;
    txtLIB32: TsComboEdit;
    grp64Bit: TsGroupBox;
    sLabel13: TsLabel;
    sLabel14: TsLabel;
    sLabel15: TsLabel;
    sLabel20: TsLabel;
    txtML64: TsComboEdit;
    txtLink64: TsComboEdit;
    txtRC64: TsComboEdit;
    txtLIB64: TsComboEdit;
    grp16Bit: TsGroupBox;
    sLabel9: TsLabel;
    sLabel16: TsLabel;
    sLabel17: TsLabel;
    sLabel19: TsLabel;
    txtML16: TsComboEdit;
    txtLink16: TsComboEdit;
    txtRC16: TsComboEdit;
    txtLIB16: TsComboEdit;
    btnRunSetupWizard: TsButton;
    tabGeneral: TsTabSheet;
    chkOpenLastUsedProject: TsCheckBox;
    chkDoNotShowToolTips: TsCheckBox;
    tabThemes: TsTabSheet;
    lblAvailableThemes: TsLabel;
    lstThemes: TsListBox;
    btnResetToDefaultTheme: TsButton;
    sLabel2: TsLabel;
    cmbCodeEditor: TsComboBox;
    chkDisplayExtendedWindowBorders: TsCheckBox;
    procedure btnOkClick(Sender: TObject);
    procedure btnRunSetupWizardClick(Sender: TObject);
    procedure txtML32ButtonClick(Sender: TObject);
    procedure txtLink32ButtonClick(Sender: TObject);
    procedure txtRC32ButtonClick(Sender: TObject);
    procedure txtLIB32ButtonClick(Sender: TObject);
    procedure txtML64ButtonClick(Sender: TObject);
    procedure txtLink64ButtonClick(Sender: TObject);
    procedure txtRC64ButtonClick(Sender: TObject);
    procedure txtLIB64ButtonClick(Sender: TObject);
    procedure txtML16ButtonClick(Sender: TObject);
    procedure txtLink16ButtonClick(Sender: TObject);
    procedure txtRC16ButtonClick(Sender: TObject);
    procedure txtLIB16ButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tvTreeChange(Sender: TObject; Node: TTreeNode);
    procedure lstThemesClick(Sender: TObject);
    procedure btnResetToDefaultThemeClick(Sender: TObject);
    procedure cmbCodeEditorChange(Sender: TObject);
    procedure chkDisplayExtendedWindowBordersClick(Sender: TObject);
  private
    FPreview: TfrmThemePreview;
    procedure UpdateUI;
    procedure SaveOptions;
    procedure SaveFileLocations;
    procedure SaveGeneral;
    procedure CreatePreview;
    procedure SetCurrentThemeIndex;
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

uses uFrmSetup, uDM, uML, uFrmMain;

{$R *.dfm}

procedure TfrmOptions.btnOkClick(Sender: TObject);
begin
  SaveOptions;
end;

procedure TfrmOptions.btnRunSetupWizardClick(Sender: TObject);
begin
  if frmSetup.ShowModal = mrOk then
    UpdateUI;
end;

procedure TfrmOptions.txtML32ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('ML.EXE',txtML32);
end;

procedure TfrmOptions.txtLink32ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LINK.EXE',txtLink32);
end;

procedure TfrmOptions.txtRC32ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('RC.EXE',txtRC32);
end;

procedure TfrmOptions.txtLIB32ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LIB.EXE',txtLIB32);
end;

procedure TfrmOptions.txtML64ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('ML64.EXE',txtML64);
end;

procedure TfrmOptions.txtLink64ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LINK.EXE',txtLink64);
end;

procedure TfrmOptions.txtRC64ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('RC.EXE',txtRC64);
end;

procedure TfrmOptions.txtLIB64ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LIB.EXE',txtLIB64);
end;

procedure TfrmOptions.txtML16ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('ML.EXE',txtML16);
end;

procedure TfrmOptions.txtLink16ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LINK.EXE',txtLink16);
end;

procedure TfrmOptions.txtRC16ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('RC.EXE',txtRC16);
end;

procedure TfrmOptions.txtLIB16ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LIB.EXE',txtLIB16);
end;

procedure TfrmOptions.FormShow(Sender: TObject);
begin
  tvTree.Items[0].Selected := true;
  CreatePreview;
  UpdateUI;
end;

procedure TfrmOptions.UpdateUI;
begin
  // Update General
  chkOpenLastUsedProject.Checked := dm.VisualMASMOptions.OpenLastProjectUsed;
  chkDoNotShowToolTips.Checked := dm.VisualMASMOptions.DoNotShowToolTips;
  chkDisplayExtendedWindowBorders.Checked := frmMain.sSkinManager1.ExtendedBorders;

  // Update File Locations
  txtML32.Text := dm.VisualMASMOptions.ML32.FoundFileName;
  txtLink32.Text := dm.VisualMASMOptions.ML32.Linker32Bit.FoundFileName;
  txtLIB32.Text := dm.VisualMASMOptions.ML32.LIB.FoundFileName;
  txtRC32.Text := dm.VisualMASMOptions.ML32.RC.FoundFileName;

  txtML64.Text := dm.VisualMASMOptions.ML64.FoundFileName;
  txtLink64.Text := dm.VisualMASMOptions.ML64.Linker32Bit.FoundFileName;
  txtLIB64.Text := dm.VisualMASMOptions.ML64.LIB.FoundFileName;
  txtRC64.Text := dm.VisualMASMOptions.ML64.RC.FoundFileName;

  txtML16.Text := dm.VisualMASMOptions.ML16.FoundFileName;
  txtLink16.Text := dm.VisualMASMOptions.ML16.Linker16Bit.FoundFileName;
  txtLIB16.Text := dm.VisualMASMOptions.ML16.LIB.FoundFileName;
  txtRC16.Text := dm.VisualMASMOptions.ML16.RC.FoundFileName;
end;

procedure TfrmOptions.SaveOptions;
begin
  SaveGeneral;
  SaveFileLocations;
end;

procedure TfrmOptions.SaveGeneral;
begin
  dm.VisualMASMOptions.OpenLastProjectUsed := chkOpenLastUsedProject.Checked;
  dm.VisualMASMOptions.DoNotShowToolTips := chkDoNotShowToolTips.Checked;
  dm.VisualMASMOptions.Theme := frmMain.sSkinManager1.SkinName;
  dm.VisualMASMOptions.ThemeCodeEditor := cmbCodeEditor.Text;
  dm.VisualMASMOptions.ThemeExtendedBorders := chkDisplayExtendedWindowBorders.Checked;
end;

procedure TfrmOptions.SaveFileLocations;
begin
  if length(txtML32.Text) > 0 then
    dm.VisualMASMOptions.ML32.FoundFileName := txtML32.Text;
  if length(txtLink32.Text) > 0 then
    dm.VisualMASMOptions.ML32.Linker32Bit.FoundFileName := txtLink32.Text;
  if length(txtLIB32.Text) > 0 then
    dm.VisualMASMOptions.ML32.LIB.FoundFileName := txtLIB32.Text;
  if length(txtRC32.Text) > 0 then
    dm.VisualMASMOptions.ML32.RC.FoundFileName := txtRC32.Text;

  if length(txtML64.Text) > 0 then
    dm.VisualMASMOptions.ML64.FoundFileName := txtML64.Text;
  if length(txtLink64.Text) > 0 then
    dm.VisualMASMOptions.ML64.Linker32Bit.FoundFileName := txtLink64.Text;
  if length(txtLIB64.Text) > 0 then
    dm.VisualMASMOptions.ML64.LIB.FoundFileName := txtLIB64.Text;
  if length(txtRC64.Text) > 0 then
    dm.VisualMASMOptions.ML64.RC.FoundFileName := txtRC64.Text;

  if length(txtML16.Text) > 0 then
    dm.VisualMASMOptions.ML16.FoundFileName := txtML16.Text;
  if length(txtLink16.Text) > 0 then
    dm.VisualMASMOptions.ML16.Linker16Bit.FoundFileName := txtLink16.Text;
  if length(txtLIB16.Text) > 0 then
    dm.VisualMASMOptions.ML16.LIB.FoundFileName := txtLIB16.Text;
  if length(txtRC16.Text) > 0 then
    dm.VisualMASMOptions.ML16.RC.FoundFileName := txtRC16.Text;
end;

procedure TfrmOptions.tvTreeChange(Sender: TObject; Node: TTreeNode);
begin
  pagOptions.ActivePageIndex := node.Index;
end;

procedure TfrmOptions.CreatePreview;
var
  i: integer;
begin
  lstThemes.Clear;
  if frmMain.sSkinManager1.InternalSkins.Count > 0 then
    for i := 0 to frmMain.sSkinManager1.InternalSkins.Count - 1 do
    begin
      lstThemes.Items.Add(frmMain.sSkinManager1.InternalSkins[i].Name);
    end;

  lblAvailableThemes.Caption := 'Available Themes ('+inttostr(lstThemes.Count)+')';
  lstThemes.Sorted := true;

//  cmbCodeEditor.Clear;
//  for i:=0 to dm.Themes.Count-1 do
//  begin
//    cmbCodeEditor.AddItem(TTheme(dm.Themes.Objects[i]).Name,dm.Themes.Objects[i]);
//    if dm.CodeEditorTheme.Name = cmbCodeEditor.Items[cmbCodeEditor.Items.Count-1] then
//      cmbCodeEditor.ItemIndex := cmbCodeEditor.Items.Count-1;
//  end;

  SetCurrentThemeIndex;
end;

procedure TfrmOptions.lstThemesClick(Sender: TObject);
begin
  frmMain.sSkinManager1.SkinName := lstThemes.Items[lstThemes.ItemIndex];
  frmMain.sSkinManager1.Active := true;
//  dm.ApplyTheme(cmbCodeEditor.Text);
end;

procedure TfrmOptions.btnResetToDefaultThemeClick(Sender: TObject);
var
  i: integer;
begin
  frmMain.sSkinManager1.SkinName := THEME_DEFAULT;
  frmMain.sSkinManager1.Active := true;
  SetCurrentThemeIndex;

  for i:=0 to cmbCodeEditor.Items.Count-1 do
  begin
    if cmbCodeEditor.Items[i] = THEME_CODE_EDITOR_DEFAULT then
    begin
      cmbCodeEditor.ItemIndex := i;
      break;
    end;
  end;

  chkDisplayExtendedWindowBorders.Checked := false;
//  dm.ApplyTheme(cmbCodeEditor.Text);
end;

procedure TfrmOptions.SetCurrentThemeIndex;
var
  i: integer;
begin
  // Set the current theme index
  for i:=0 to lstThemes.Items.Count-1 do
  begin
    if lstThemes.Items[i] = frmMain.sSkinManager1.SkinName then
    begin
      lstThemes.Selected[i] := true;
      break;
    end;
  end;

  for i:=0 to cmbCodeEditor.Items.Count-1 do
  begin
//    if cmbCodeEditor.Items[i] = frmMain.VM.ThemeCodeEditor then
//    begin
//      cmbCodeEditor.ItemIndex := i;
//      break;
//    end;
  end;
end;

procedure TfrmOptions.cmbCodeEditorChange(Sender: TObject);
begin
//  dm.ApplyTheme(cmbCodeEditor.Text);
end;

procedure TfrmOptions.chkDisplayExtendedWindowBordersClick(
  Sender: TObject);
begin
  frmMain.sSkinManager1.ExtendedBorders := chkDisplayExtendedWindowBorders.Checked;
end;

end.
