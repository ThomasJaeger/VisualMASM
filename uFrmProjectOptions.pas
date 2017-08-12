unit uFrmProjectOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls,
  ExtCtrls, StdCtrls, Mask, uProject, uSharedGlobals, uProjectFile, TypInfo, Vcl.Buttons, Vcl.CheckLst;

type
  TfrmProjectOptions = class(TForm)
    Panel1: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    tvTree: TTreeView;
    pagOptions: TPageControl;
    tabAssembleEvents: TTabSheet;
    tabExclusiveAssemble: TTabSheet;
    tabGeneral: TTabSheet;
    tabFilesToAssemble: TTabSheet;
    tabAdditionalLink: TTabSheet;
    tabAdditionalLinkFiles: TTabSheet;
    memAdditionalLinkFiles: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    memAdditionalLinkSwitches: TMemo;
    Label3: TLabel;
    memAssembleEventCommandLine: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblGeneralProjectName: TLabel;
    lblGeneralProjectType: TLabel;
    lblGeneralCreated: TLabel;
    Label7: TLabel;
    tabPreAssemble: TTabSheet;
    Label8: TLabel;
    memPreAssembleEventCommandLine: TMemo;
    tabPostAssemble: TTabSheet;
    Label9: TLabel;
    memPostAssembleEventCommandLine: TMemo;
    tabExclusiveLink: TTabSheet;
    Label10: TLabel;
    memLinkEventCommandLine: TMemo;
    tabLibraryPath: TTabSheet;
    Label11: TLabel;
    txtLibraryPath: TEdit;
    SpeedButton2: TSpeedButton;
    tabPreLink: TTabSheet;
    memPreLinkEventCommandLine: TMemo;
    Label12: TLabel;
    tabPostLink: TTabSheet;
    Label13: TLabel;
    memPostLinkEventCommandLine: TMemo;
    lstAssembleFiles: TCheckListBox;
    tabLinkEvents: TTabSheet;
    GroupBox2: TGroupBox;
    optBuildConfigurationRelease: TRadioButton;
    optBuildConfigurationDebug: TRadioButton;
    Label20: TLabel;
    Label21: TLabel;
    GroupBox1: TGroupBox;
    Label15: TLabel;
    btnOuputFolder: TSpeedButton;
    Label14: TLabel;
    btnResetOutputFolder: TSpeedButton;
    txtOutputFolder: TEdit;
    lblProjectFile: TLabel;
    Label17: TLabel;
    procedure FormShow(Sender: TObject);
    procedure tvTreeChange(Sender: TObject; Node: TTreeNode);
    procedure btnOkClick(Sender: TObject);
    procedure txtLibraryPathButtonClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOuputFolderClick(Sender: TObject);
    procedure btnResetOutputFolderClick(Sender: TObject);
  private
    FProject: TProject;
    procedure UpdateUI;
  public
    property Project: TProject read FProject write FProject;
  end;

var
  frmProjectOptions: TfrmProjectOptions;

implementation

uses uDM;

{$R *.dfm}

procedure TfrmProjectOptions.FormShow(Sender: TObject);
begin
  tvTree.Items[0].Selected := true;
  tvTree.Selected := tvTree.Items[0];
  tvTree.FullExpand;
  UpdateUI;
end;

procedure TfrmProjectOptions.UpdateUI;
var
  pt: string;
  projectFile: TProjectFile;
begin
  lblGeneralProjectName.Caption := FProject.Name;
  case FProject.ProjectType of
    ptWin32: pt:=NEW_ITEM_32_BIT_WIN_EXE_APP;
    ptWin32Dlg: pt:=NEW_ITEM_32_BIT_WIN_DLG_APP;
    ptWin32Con: pt:=NEW_ITEM_32_BIT_WIN_CON_APP;
    ptWin64: pt:=NEW_ITEM_64_BIT_WIN_EXE_APP;
    ptWin32DLL: pt:=NEW_ITEM_32_BIT_WIN_DLL_APP;
    ptWin64DLL: pt:=NEW_ITEM_64_BIT_WIN_DLL_APP;
    ptDos16COM: pt:=NEW_ITEM_16_BIT_MSDOS_COM_APP;
    ptDos16EXE: pt:=NEW_ITEM_16_BIT_MSDOS_EXE_APP;
    ptWin16: pt:=NEW_ITEM_16_BIT_WIN_EXE_APP;
    ptWin16DLL: pt:=NEW_ITEM_16_BIT_WIN_DLL_APP;
    ptLib: pt:=NEW_ITEM_LIB_APP;
  end;
  lblGeneralProjectType.Caption := pt;
  lblGeneralCreated.Caption := DateTimeToStr(FProject.Created);
  lblProjectFile.Caption := FProject.FileName;

  txtOutputFolder.Text := FProject.OutputFolder;

  memPreAssembleEventCommandLine.Text := FProject.PreAssembleEventCommandLine;
  memAssembleEventCommandLine.Text := FProject.AssembleEventCommandLine;
  memPostAssembleEventCommandLine.Text := FProject.PostAssembleEventCommandLine;
  memPreLinkEventCommandLine.Text := FProject.PreLinkEventCommandLine;
  memLinkEventCommandLine.Text := FProject.LinkEventCommandLine;
  memAdditionalLinkSwitches.Text := FProject.AdditionalLinkSwitches;
  memAdditionalLinkFiles.Text := FProject.AdditionalLinkFiles;
  memPostLinkEventCommandLine.Text := FProject.PostLinkEventCommandLine;

  txtLibraryPath.Text := FProject.LibraryPath;

  lstAssembleFiles.Items.BeginUpdate;
  lstAssembleFiles.Clear;
  for projectFile in FProject.ProjectFiles.Values do
  begin
    case projectFile.ProjectFileType of
      pftASM,pftRC:
        begin
          if projectFile.FileName = '' then
            lstAssembleFiles.Items.AddObject(projectFile.Name, projectFile)
          else
            lstAssembleFiles.Items.AddObject(projectFile.FileName, projectFile);
          lstAssembleFiles.Checked[lstAssembleFiles.Items.Count-1] := projectFile.AssembleFile;
        end;
    end;
  end;
  lstAssembleFiles.Items.EndUpdate;
end;

procedure TfrmProjectOptions.tvTreeChange(Sender: TObject;
  Node: TTreeNode);
begin
  case node.AbsoluteIndex of
    0: pagOptions.ActivePage := tabGeneral;
    1: pagOptions.ActivePage := tabLibraryPath;
    2: pagOptions.ActivePage := tabFilesToAssemble;
    3: pagOptions.ActivePage := tabAssembleEvents;
    4: pagOptions.ActivePage := tabPreAssemble;
    5: pagOptions.ActivePage := tabExclusiveAssemble;
    6: pagOptions.ActivePage := tabPostAssemble;
    7: pagOptions.ActivePage := tabLinkEvents;
    8: pagOptions.ActivePage := tabPreLink;
    9: pagOptions.ActivePage := tabExclusiveLink;
    10: pagOptions.ActivePage := tabAdditionalLink;
    11: pagOptions.ActivePage := tabAdditionalLinkFiles;
    12: pagOptions.ActivePage := tabPostLink;
  end;
//  pagOptions.ActivePageIndex := node.Index;
end;

procedure TfrmProjectOptions.btnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmProjectOptions.btnOkClick(Sender: TObject);
var
  i: integer;
begin
//c:\MASM32\BIN\Rc.exe /v C:\Source\VisualMASM\Projects\rsrc.rc
//c:\MASM32\BIN\Cvtres.exe /machine:ix86 C:\Source\VisualMASM\Projects\rsrc.res
  FProject.Modified := true;

  FProject.OutputFolder := txtOutputFolder.Text;
  if length(FProject.OutputFolder)>2 then
    FProject.OutputFolder := IncludeTrailingPathDelimiter(FProject.OutputFolder);

  FProject.PreAssembleEventCommandLine := trim(memPreAssembleEventCommandLine.Text);
  FProject.AssembleEventCommandLine := trim(memAssembleEventCommandLine.Text);
  FProject.PostAssembleEventCommandLine := trim(memPostAssembleEventCommandLine.Text);
  FProject.PreLinkEventCommandLine := trim(memPreLinkEventCommandLine.Text);
  FProject.LinkEventCommandLine := trim(memLinkEventCommandLine.Text);
  FProject.PostLinkEventCommandLine := trim(memPostLinkEventCommandLine.Text);
  FProject.AdditionalLinkSwitches := memAdditionalLinkSwitches.Text;
  FProject.AdditionalLinkFiles := memAdditionalLinkFiles.Text;

  FProject.LibraryPath := txtLibraryPath.Text;

  for i:= 0 to lstAssembleFiles.Items.Count-1 do
  begin
    TProjectFile(lstAssembleFiles.Items.Objects[i]).AssembleFile :=
      lstAssembleFiles.Checked[i];
  end;

  close;
end;

procedure TfrmProjectOptions.btnOuputFolderClick(Sender: TObject);
begin
  dm.PromptForPath('Output Folder',txtOutputFolder);
end;

procedure TfrmProjectOptions.btnResetOutputFolderClick(Sender: TObject);
begin
  dm.ResetProjectOutputFolder(FProject);
  txtOutputFolder.Text := FProject.OutputFolder;
end;

procedure TfrmProjectOptions.txtLibraryPathButtonClick(Sender: TObject);
begin
  dm.PromptForPath('Library Path',txtLibraryPath);
end;

end.
