unit uFrmProjectOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, sTreeView, ExtCtrls, sPanel, StdCtrls, sButton, Mask,
  sMaskEdit, sCustomComboEdit, sComboEdit, sLabel, sGroupBox, sCheckBox,
  sPageControl, sMemo, acAlphaHints, uProject, sListBox, sCheckListBox,
  uSharedGlobals, uProjectFile, TypInfo;

type
  TfrmProjectOptions = class(TForm)
    pagOptions: TsPageControl;
    tabAssembleEvents: TsTabSheet;
    tabLinkEvents: TsTabSheet;
    sPanel1: TsPanel;
    btnCancel: TsButton;
    btnOk: TsButton;
    tvTree: TsTreeView;
    tabFilesToAssemble: TsTabSheet;
    sLabel7: TsLabel;
    lstAssembleFiles: TsCheckListBox;
    tabPreAssemble: TsTabSheet;
    sGroupBox1: TsGroupBox;
    sLabel1: TsLabel;
    memPreAssembleEventCommandLine: TsMemo;
    sLabel8: TsLabel;
    tabExclusiveAssemble: TsTabSheet;
    sGroupBox2: TsGroupBox;
    sLabel3: TsLabel;
    memAssembleEventCommandLine: TsMemo;
    tabPostAssemble: TsTabSheet;
    sGroupBox3: TsGroupBox;
    sLabel2: TsLabel;
    memPostAssembleEventCommandLine: TsMemo;
    tabPreLink: TsTabSheet;
    sGroupBox4: TsGroupBox;
    sLabel4: TsLabel;
    memPreLinkEventCommandLine: TsMemo;
    tabExclusiveLink: TsTabSheet;
    sGroupBox5: TsGroupBox;
    sLabel5: TsLabel;
    memLinkEventCommandLine: TsMemo;
    tabAdditionalLink: TsTabSheet;
    sGroupBox7: TsGroupBox;
    sLabel9: TsLabel;
    memAdditionalLinkSwitches: TsMemo;
    tabPostLink: TsTabSheet;
    sGroupBox6: TsGroupBox;
    sLabel6: TsLabel;
    memPostLinkEventCommandLine: TsMemo;
    tabGeneral: TsTabSheet;
    sLabel10: TsLabel;
    lblGeneralProjectType: TsLabel;
    sLabel11: TsLabel;
    lblGeneralProjectName: TsLabel;
    sLabel12: TsLabel;
    lblGeneralCreated: TsLabel;
    sGroupBox8: TsGroupBox;
    sLabel13: TsLabel;
    txtLibraryPath: TsComboEdit;
    tabAdditionalLinkFiles: TsTabSheet;
    sGroupBox9: TsGroupBox;
    sLabel14: TsLabel;
    memAdditionalLinkFiles: TsMemo;
    procedure FormShow(Sender: TObject);
    procedure tvTreeChange(Sender: TObject; Node: TTreeNode);
    procedure btnOkClick(Sender: TObject);
    procedure txtLibraryPathButtonClick(Sender: TObject);
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
    ptWin64: pt:=NEW_ITEM_64_BIT_WIN_EXE_APP;
    ptWin32DLL: pt:=NEW_ITEM_32_BIT_WIN_DLL_APP;
    ptWin64DLL: pt:=NEW_ITEM_64_BIT_WIN_DLL_APP;
    ptDos16COM: pt:=NEW_ITEM_16_BIT_MSDOS_COM_APP;
    ptDos16EXE: pt:=NEW_ITEM_16_BIT_MSDOS_EXE_APP;
    ptWin16: pt:=NEW_ITEM_16_BIT_WIN_EXE_APP;
    ptWin16DLL: pt:=NEW_ITEM_16_BIT_WIN_DLL_APP;
  end;
  lblGeneralProjectType.Caption := pt;
  lblGeneralCreated.Caption := DateTimeToStr(FProject.Created);

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
    1: pagOptions.ActivePage := tabFilesToAssemble;
    2: pagOptions.ActivePage := tabAssembleEvents;
    3: pagOptions.ActivePage := tabPreAssemble;
    4: pagOptions.ActivePage := tabExclusiveAssemble;
    5: pagOptions.ActivePage := tabPostAssemble;
    6: pagOptions.ActivePage := tabLinkEvents;
    7: pagOptions.ActivePage := tabPreLink;
    8: pagOptions.ActivePage := tabExclusiveLink;
    9: pagOptions.ActivePage := tabAdditionalLink;
    10: pagOptions.ActivePage := tabAdditionalLinkFiles;
    11: pagOptions.ActivePage := tabPostLink;
  end;
//  pagOptions.ActivePageIndex := node.Index;
end;

procedure TfrmProjectOptions.btnOkClick(Sender: TObject);
var
  i: integer;
begin
//c:\MASM32\BIN\Rc.exe /v C:\Source\VisualMASM\Projects\rsrc.rc
//c:\MASM32\BIN\Cvtres.exe /machine:ix86 C:\Source\VisualMASM\Projects\rsrc.res
  FProject.Modified := true;

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
end;

procedure TfrmProjectOptions.txtLibraryPathButtonClick(Sender: TObject);
begin
  dm.PromptForPath('Library Path',txtLibraryPath);
end;

end.
