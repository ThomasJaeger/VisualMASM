unit uFrmOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls,
  VirtualTrees, ExtCtrls, StdCtrls, ToolWin, SynEditHighlighter, SynHighlighterPas, SynEdit, SynMemo,
  Mask, uSharedGlobals, System.IOUtils, Vcl.Buttons, Vcl.Themes;

type
  TfrmOptions = class(TForm)
    dlgFont: TFontDialog;
    Panel1: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    tvTree: TTreeView;
    pagOptions: TPageControl;
    tabGeneral: TTabSheet;
    tabFileLocations: TTabSheet;
    tabThemes: TTabSheet;
    chkOpenLastUsedProject: TCheckBox;
    chkDoNotShowToolTips: TCheckBox;
    grpContextHelp2: TGroupBox;
    btnChangeContextHelpFont: TButton;
    GroupBox1: TGroupBox;
    btnChangeOutputWindowFont: TButton;
    lblContextHelpFont: TLabel;
    lblOutputFont: TLabel;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Label2: TLabel;
    txtSDKIncludePath: TEdit;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    txtML16: TEdit;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    txtLink16: TEdit;
    SpeedButton3: TSpeedButton;
    Label5: TLabel;
    txtRC16: TEdit;
    SpeedButton4: TSpeedButton;
    Label6: TLabel;
    txtLIB16: TEdit;
    SpeedButton5: TSpeedButton;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    SpeedButton6: TSpeedButton;
    Label8: TLabel;
    SpeedButton7: TSpeedButton;
    Label9: TLabel;
    SpeedButton8: TSpeedButton;
    Label10: TLabel;
    SpeedButton9: TSpeedButton;
    txtML64: TEdit;
    txtLink64: TEdit;
    txtRC64: TEdit;
    txtLIB64: TEdit;
    GroupBox3: TGroupBox;
    Label11: TLabel;
    SpeedButton10: TSpeedButton;
    Label12: TLabel;
    SpeedButton11: TSpeedButton;
    Label13: TLabel;
    SpeedButton12: TSpeedButton;
    Label14: TLabel;
    SpeedButton13: TSpeedButton;
    txtML32: TEdit;
    txtLink32: TEdit;
    txtRC32: TEdit;
    txtLIB32: TEdit;
    Label15: TLabel;
    cmbCodeEditor: TComboBox;
    GroupBox6: TGroupBox;
    Label16: TLabel;
    btnCommonProjectFolder: TSpeedButton;
    Label17: TLabel;
    btnResetCommonProjectFolder: TSpeedButton;
    txtCommonProjectFolder: TEdit;
    tabDebug: TTabSheet;
    radUseExternalDebugger: TRadioButton;
    radVisualMASMDebugger: TRadioButton;
    lblDebuggerPath: TLabel;
    txtDebugger: TEdit;
    btnBrowseDebugger: TSpeedButton;
    lblDebuggerDescription: TLabel;
    radDoNottStartDebugger: TRadioButton;
    tabFileAssociation: TTabSheet;
    Label18: TLabel;
    GroupBox7: TGroupBox;
    chkASM: TCheckBox;
    chkINC: TCheckBox;
    chkRC: TCheckBox;
    btnAssociateFileTypes: TButton;
    Label1: TLabel;
    btnRunSetupWizard: TButton;
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
    procedure txtSDKIncludePathButtonClick(Sender: TObject);
    procedure btnChangeContextHelpFontClick(Sender: TObject);
    procedure btnChangeOutputWindowFontClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCommonProjectFolderClick(Sender: TObject);
    procedure btnResetCommonProjectFolderClick(Sender: TObject);
    procedure btnBrowseDebuggerClick(Sender: TObject);
    procedure radUseExternalDebuggerClick(Sender: TObject);
    procedure radDoNottStartDebuggerClick(Sender: TObject);
    procedure radVisualMASMDebuggerClick(Sender: TObject);
    procedure btnAssociateFileTypesClick(Sender: TObject);
  private
    procedure UpdateUI;
    procedure SaveOptions;
    procedure SaveFileLocations;
    procedure SaveGeneral;
    procedure LoadColorFiles;
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

uses uFrmSetup, uDM, uML, uFrmMain;

{$R *.dfm}

procedure TfrmOptions.btnAssociateFileTypesClick(Sender: TObject);
begin
  if chkASM.Checked then
    RegisterFileType(pftASM);
  if chkINC.Checked then
    RegisterFileType(pftINC);
  if chkRC.Checked then
    RegisterFileType(pftRC);
  ShowMessage('File extensions have been associated with '+APP_NAME);
end;

procedure TfrmOptions.btnBrowseDebuggerClick(Sender: TObject);
begin
  dm.PromptForFile('', txtDebugger);
  txtDebugger.Text := '"' + txtDebugger.Text + '" ' + DEBUGGER_OUTPUT_FILE;
  Show;
end;

procedure TfrmOptions.btnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmOptions.btnChangeContextHelpFontClick(Sender: TObject);
begin
  dlgFont.Font.Name := dm.VisualMASMOptions.ContextHelpFontName;
  dlgFont.Font.Size := dm.VisualMASMOptions.ContextHelpFontSize;

  if dlgFont.Execute then begin
    dm.VisualMASMOptions.ContextHelpFontName := dlgFont.Font.Name;
    dm.VisualMASMOptions.ContextHelpFontSize := dlgFont.Font.Size;
    UpdateUI;
  end;
end;

procedure TfrmOptions.btnChangeOutputWindowFontClick(Sender: TObject);
begin
  dlgFont.Font.Name := dm.VisualMASMOptions.OutputFontName;
  dlgFont.Font.Size := dm.VisualMASMOptions.OutputFontSize;

  if dlgFont.Execute then begin
    dm.VisualMASMOptions.OutputFontName := dlgFont.Font.Name;
    dm.VisualMASMOptions.OutputFontSize := dlgFont.Font.Size;
    UpdateUI;
  end;
end;

procedure TfrmOptions.btnCommonProjectFolderClick(Sender: TObject);
begin
  dm.PromptForPath('Common Project Folder', txtCommonProjectFolder);
end;

procedure TfrmOptions.btnOkClick(Sender: TObject);
begin
  SaveOptions;
  close;
end;

procedure TfrmOptions.btnRunSetupWizardClick(Sender: TObject);
begin
  if frmSetup.ShowModal = mrOk then
    UpdateUI;
end;

procedure TfrmOptions.txtML32ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('ML.EXE',txtML32);
  Show;
end;

procedure TfrmOptions.txtLink32ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LINK.EXE',txtLink32);
  Show;
end;

procedure TfrmOptions.txtRC32ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('RC.EXE',txtRC32);
  Show;
end;

procedure TfrmOptions.txtLIB32ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LIB.EXE',txtLIB32);
  Show;
end;

procedure TfrmOptions.txtML64ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('ML64.EXE',txtML64);
  Show;
end;

procedure TfrmOptions.txtLink64ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LINK.EXE',txtLink64);
  Show;
end;

procedure TfrmOptions.txtRC64ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('RC.EXE',txtRC64);
  Show;
end;

procedure TfrmOptions.txtSDKIncludePathButtonClick(Sender: TObject);
begin
  dm.PromptForPath('Microsoft SDK Include Path',txtSDKIncludePath);
  Show;
end;

procedure TfrmOptions.txtLIB64ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LIB.EXE',txtLIB64);
  Show;
end;

procedure TfrmOptions.txtML16ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('ML.EXE',txtML16);
  Show;
end;

procedure TfrmOptions.txtLink16ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LINK16.EXE',txtLink16);
  Show;
end;

procedure TfrmOptions.txtRC16ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('RC.EXE',txtRC16);
  Show;
end;

procedure TfrmOptions.txtLIB16ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LIB.EXE',txtLIB16);
  Show;
end;

procedure TfrmOptions.FormShow(Sender: TObject);
begin
  tvTree.Items[0].Selected := true;
  tvTree.Selected := tvTree.Items[0];
  UpdateUI;
  case dm.VisualMASMOptions.Debugger of
    dtNone: radDoNottStartDebugger.Checked := true;
    dtVisualMASM: radVisualMASMDebugger.Checked := true;
    dtExternal: radUseExternalDebugger.Checked := true;
  end;
end;

procedure TfrmOptions.UpdateUI;
begin
  // Update General
  chkOpenLastUsedProject.Checked := dm.VisualMASMOptions.OpenLastProjectUsed;
  chkDoNotShowToolTips.Checked := dm.VisualMASMOptions.DoNotShowToolTips;
  lblContextHelpFont.Caption := dm.VisualMASMOptions.ContextHelpFontName +
    ', ' + inttostr(dm.VisualMASMOptions.ContextHelpFontSize);
  lblOutputFont.Caption := dm.VisualMASMOptions.OutputFontName +
    ', ' + inttostr(dm.VisualMASMOptions.OutputFontSize);

  // Update File Locations
  txtSDKIncludePath.Text := dm.VisualMASMOptions.MSSDKIncludePath;

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

  txtCommonProjectFolder.Text := dm.VisualMASMOptions.CommonProjectsFolder;
  txtDebugger.Text := dm.VisualMASMOptions.DebuggerFileName;

  LoadColorFiles;
end;

procedure TfrmOptions.LoadColorFiles;
var
  fileName: string;
  i: Integer;
begin
  cmbCodeEditor.Items.Clear;
  for fileName in TDirectory.GetFiles(dm.VisualMASMOptions.AppFolder+'\Colors\')  do
  begin
    cmbCodeEditor.Items.Add(TPath.GetFileNameWithoutExtension(fileName));
  end;

  if length(dm.VisualMASMOptions.ThemeCodeEditor)<3 then
    dm.VisualMASMOptions.ThemeCodeEditor := 'Default';

  for i := 0 to cmbCodeEditor.Items.Count-1 do
  begin
    if cmbCodeEditor.Items[i] = dm.VisualMASMOptions.ThemeCodeEditor then
    begin
      cmbCodeEditor.ItemIndex := i;
      break;
    end;
  end;
end;

procedure TfrmOptions.radDoNottStartDebuggerClick(Sender: TObject);
begin
  UpdateUI;
  lblDebuggerPath.Visible := false;
  txtDebugger.Visible := false;
  btnBrowseDebugger.Visible := false;
  lblDebuggerDescription.Visible := false;
end;

procedure TfrmOptions.radUseExternalDebuggerClick(Sender: TObject);
begin
  UpdateUI;
  lblDebuggerPath.Visible := true;
  txtDebugger.Visible := true;
  btnBrowseDebugger.Visible := true;
  lblDebuggerDescription.Visible := true;
end;

procedure TfrmOptions.radVisualMASMDebuggerClick(Sender: TObject);
begin
  UpdateUI;
  lblDebuggerPath.Visible := false;
  txtDebugger.Visible := false;
  btnBrowseDebugger.Visible := false;
  lblDebuggerDescription.Visible := false;
end;

procedure TfrmOptions.SaveOptions;
begin
  SaveGeneral;
  SaveFileLocations;

//  frmMain.panHelp.Visible := dm.VisualMASMOptions.ContextHelp;
//  frmMain.splHelp.Visible := dm.VisualMASMOptions.ContextHelp;
//  if frmMain.panHelp.Visible then
    dm.LoadColors(cmbCodeEditor.Text);

  frmMain.memOutput.Font.Name := dm.VisualMASMOptions.OutputFontName;
  frmMain.memOutput.Font.Size := dm.VisualMASMOptions.OutputFontSize;

  // C:\Program Files\Debugging Tools for Windows (x64)
  if radDoNottStartDebugger.Checked then
    dm.VisualMASMOptions.Debugger := dtNone;
  if radVisualMASMDebugger.Checked then
    dm.VisualMASMOptions.Debugger := dtVisualMASM;
  if radUseExternalDebugger.Checked then
    dm.VisualMASMOptions.Debugger := dtExternal;

  if dm.VisualMASMOptions.Debugger = dtExternal then
  begin
    if length(txtDebugger.Text)<3 then
    begin
      ShowMessage('No valid external debugger specified. Resetting to None');
      dm.VisualMASMOptions.Debugger := dtNone;
    end else begin
      dm.VisualMASMOptions.DebuggerFileName := txtDebugger.Text;
    end;
  end;
end;

procedure TfrmOptions.SaveGeneral;
begin
  dm.VisualMASMOptions.OpenLastProjectUsed := chkOpenLastUsedProject.Checked;
  dm.VisualMASMOptions.DoNotShowToolTips := chkDoNotShowToolTips.Checked;
  dm.VisualMASMOptions.ThemeCodeEditor := cmbCodeEditor.Text;
  dm.VisualMASMOptions.CommonProjectsFolder := txtCommonProjectFolder.Text;
  if length(dm.VisualMASMOptions.CommonProjectsFolder)>2 then
    dm.VisualMASMOptions.CommonProjectsFolder :=
      IncludeTrailingPathDelimiter(dm.VisualMASMOptions.CommonProjectsFolder);
end;

procedure TfrmOptions.SaveFileLocations;
begin
  dm.VisualMASMOptions.MSSDKIncludePath := txtSDKIncludePath.Text;

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
  case node.AbsoluteIndex of
    0: pagOptions.ActivePage := tabGeneral;
    1: pagOptions.ActivePage := tabFileLocations;
    2: pagOptions.ActivePage := tabThemes;
    3: pagOptions.ActivePage := tabDebug;
    4: pagOptions.ActivePage := tabFileAssociation;
  end;
end;

procedure TfrmOptions.btnResetCommonProjectFolderClick(Sender: TObject);
begin
  txtCommonProjectFolder.Text := dm.VisualMASMOptions.AppFolder+PROJECTS_FOLDER;
end;

procedure TfrmOptions.btnResetToDefaultThemeClick(Sender: TObject);
var
  i: integer;
begin
  for i:=0 to cmbCodeEditor.Items.Count-1 do
  begin
    if cmbCodeEditor.Items[i] = THEME_CODE_EDITOR_DEFAULT then
    begin
      cmbCodeEditor.ItemIndex := i;
      break;
    end;
  end;
  dm.ApplyTheme(cmbCodeEditor.Text);
end;

procedure TfrmOptions.cmbCodeEditorChange(Sender: TObject);
begin
  dm.LoadColors(cmbCodeEditor.Text);
  dm.ApplyTheme(cmbCodeEditor.Text);
end;

end.
