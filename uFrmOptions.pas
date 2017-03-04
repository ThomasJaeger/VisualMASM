unit uFrmOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ComCtrls, sPageControl,
  VirtualTrees, ExtCtrls, StdCtrls, sButton, sPanel, ToolWin,
  sToolBar, SynEditHighlighter, SynHighlighterPas, SynEdit, SynMemo,
  sTreeView, Mask, sMaskEdit, sCustomComboEdit, sComboEdit, sLabel,
  sGroupBox, sCheckBox, sComboBox, uFrmThemePreview, sSkinProvider,
  sListBox, uSharedGlobals, sTrackBar, sSkinManager;

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
    btnResetToDefaultTheme: TsButton;
    sLabel2: TsLabel;
    cmbCodeEditor: TsComboBox;
    btnSelectSkin: TsButton;
    sLabel1: TsLabel;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    sLabel5: TsLabel;
    sTrackBar4: TsTrackBar;
    sGroupBox1: TsGroupBox;
    sLabel6: TsLabel;
    sLabel7: TsLabel;
    sLabel8: TsLabel;
    sLabel18: TsLabel;
    sLabel22: TsLabel;
    sLabel23: TsLabel;
    sLabel24: TsLabel;
    sLabel25: TsLabel;
    sLabel26: TsLabel;
    sLabel27: TsLabel;
    sLabel28: TsLabel;
    sLabel29: TsLabel;
    sTrackBar2: TsTrackBar;
    sTrackBar1: TsTrackBar;
    sTrackBar3: TsTrackBar;
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
    procedure btnResetToDefaultThemeClick(Sender: TObject);
    procedure cmbCodeEditorChange(Sender: TObject);
    procedure btnSelectSkinClick(Sender: TObject);
    procedure sTrackBar1SkinPaint(Sender: TObject; Canvas: TCanvas);
    procedure sTrackBar1Change(Sender: TObject);
    procedure sTrackBar2Change(Sender: TObject);
    procedure sTrackBar3Change(Sender: TObject);
  private
    FPreview: TfrmThemePreview;
    procedure UpdateUI;
    procedure SaveOptions;
    procedure SaveFileLocations;
    procedure SaveGeneral;
    procedure ChangeHUE(sm: TsSkinManager; Value: integer; DoRepaint: boolean);
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

uses uFrmSetup, uDM, uML, uFrmMain, acSelectSkin, acntUtils, sStyleSimply;

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

procedure TfrmOptions.btnSelectSkinClick(Sender: TObject);
begin
  SelectSkin(frmMain.sSkinManager1);
  dm.ApplyTheme(cmbCodeEditor.Text);
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
  UpdateUI;
end;

procedure TfrmOptions.UpdateUI;
begin
  // Update General
  chkOpenLastUsedProject.Checked := dm.VisualMASMOptions.OpenLastProjectUsed;
  chkDoNotShowToolTips.Checked := dm.VisualMASMOptions.DoNotShowToolTips;

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

procedure TfrmOptions.sTrackBar1Change(Sender: TObject);
begin
  if not aSkinChanging and (frmMain.sSkinManager1.HueOffset <> sTrackBar1.Position) then begin // If not in a skin changing (global variable from AC package used)
    frmMain.sSkinManager1.BeginUpdate;
    sLabel1.Caption := IntToStr(sTrackBar1.Position);
    frmMain.sSkinManager1.HueOffset := sTrackBar1.Position;
    frmMain.sSkinManager1.EndUpdate(True, False); // Repaint without animation
  end;
end;

procedure TfrmOptions.sTrackBar1SkinPaint(Sender: TObject; Canvas: TCanvas);
const
  LineHeight = 3;
var
  R: TRect;
  x: integer;
  HUEValue, HUEStep: real;
begin
//  R := sTrackBar1.ChannelRect;
//  OffsetRect(R, 0, HeightOf(R) + 4);
//  InflateRect(R, -WidthOf(sTrackBar1.ThumbRect) div 2, 0);
//  R.Bottom := R.Top + LineHeight;
//  HUEValue := 0;
//  HUEStep := 360 / WidthOf(R);
//  Canvas.Brush.Style := bsClear;
//  Canvas.Pen.Style := psSolid;
//  for x := 0 to WidthOf(R) - 1 do begin
//    Canvas.Pen.Color := ChangeHue(frmMain.sSkinManager1,(HUEValue), 5460991);
//    Canvas.MoveTo(R.Left + X, R.Top);
//    Canvas.LineTo(R.Left + X, R.Top + LineHeight);
//    HUEValue := HUEValue + HUEStep;
//  end;
end;

procedure TfrmOptions.sTrackBar2Change(Sender: TObject);
begin
  if not aSkinChanging and (frmMain.sSkinManager1.Saturation <> sTrackBar2.Position) then begin // If not in a skin changing (global variable from AC package used)
    frmMain.sSkinManager1.BeginUpdate;
    sLabel2.Caption := IntToStr(sTrackBar2.Position);
    frmMain.sSkinManager1.Saturation := sTrackBar2.Position;
    frmMain.sSkinManager1.EndUpdate(True, False); // Repaint without animation
  end;
end;

procedure TfrmOptions.sTrackBar3Change(Sender: TObject);
begin
  if not aSkinChanging and (frmMain.sSkinManager1.Brightness <> sTrackBar3.Position) then begin // If not in a skin changing (global variable from AC package used)
    frmMain.sSkinManager1.BeginUpdate;
    sLabel3.Caption := IntToStr(sTrackBar3.Position);
    frmMain.sSkinManager1.Brightness := sTrackBar3.Position;
    frmMain.sSkinManager1.EndUpdate(True, False); // Repaint without animation
  end;
end;

procedure TfrmOptions.ChangeHUE(sm: TsSkinManager; Value: integer; DoRepaint: boolean);
begin
  sm.BeginUpdate;
  sm.HueOffset := Value;
  sm.EndUpdate(DoRepaint, False {no animation});
end;

procedure TfrmOptions.SaveGeneral;
begin
  dm.VisualMASMOptions.OpenLastProjectUsed := chkOpenLastUsedProject.Checked;
  dm.VisualMASMOptions.DoNotShowToolTips := chkDoNotShowToolTips.Checked;
  dm.VisualMASMOptions.Theme := frmMain.sSkinManager1.SkinName;
  dm.VisualMASMOptions.ThemeCodeEditor := cmbCodeEditor.Text;
//  dm.VisualMASMOptions.ThemeExtendedBorders := chkDisplayExtendedWindowBorders.Checked;
end;

procedure TfrmOptions.SaveFileLocations;
begin
//  if length(txtML32.Text) > 0 then
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

procedure TfrmOptions.btnResetToDefaultThemeClick(Sender: TObject);
var
  i: integer;
begin
  frmMain.sSkinManager1.SkinName := THEME_DEFAULT;
  frmMain.sSkinManager1.Active := true;

  for i:=0 to cmbCodeEditor.Items.Count-1 do
  begin
    if cmbCodeEditor.Items[i] = THEME_CODE_EDITOR_DEFAULT then
    begin
      cmbCodeEditor.ItemIndex := i;
      break;
    end;
  end;
end;

procedure TfrmOptions.cmbCodeEditorChange(Sender: TObject);
begin
  dm.ApplyTheme(cmbCodeEditor.Text);
end;

end.
