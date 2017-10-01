unit uFrmNewItems;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, VirtualTrees,
  ExtCtrls, StdCtrls, ComCtrls, ImgList;

type
  TfrmNewItems = class(TForm)
    lstItems: TListView;
    Splitter1: TSplitter;
    Panel1: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    tvTree: TTreeView;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tvTreeChange(Sender: TObject; Node: TTreeNode);
    procedure lstItemsDblClick(Sender: TObject);
    procedure Setup;
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    FAddToGroup: boolean;
    procedure AddWindowsItems(items: TListItems);
    procedure AddMSDOSItems(items: TListItems);
    procedure AddApplicationItems(items: TListItems);
    procedure AddOtherItems(items: TListItems);
  public
    procedure AddNewProject(addToGroup: boolean);
    procedure HighlightApplications;
    procedure HighlightMSDOSFiles;
    procedure AddNewItem;
    procedure HighlightWindowsFiles;
  end;

var
  frmNewItems: TfrmNewItems;

implementation

{$R *.dfm}

uses uDM, uSharedGlobals;

procedure TfrmNewItems.btnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmNewItems.FormShow(Sender: TObject);
begin
  tvTree.FullExpand;
end;

procedure TfrmNewItems.HighlightApplications;
begin
  Setup;
  tvTree.Items[0].Selected := true;
end;

procedure TfrmNewItems.HighlightMSDOSFiles;
begin
  Setup;
  tvTree.Items[2].Selected := true;
end;

procedure TfrmNewItems.HighlightWindowsFiles;
begin
  Setup;
  tvTree.Items[1].Selected := true;
end;

procedure TfrmNewItems.lstItemsDblClick(Sender: TObject);
begin
  AddNewItem;
end;

procedure TfrmNewItems.AddNewItem;
begin
  if lstItems.Selected = nil then
  begin
    ShowMessage('Select an item, first.');
    exit;
  end;

  if lstItems.Selected.Caption = NEW_ITEM_ASSEMBLY_FILE then
  begin
    dm.actAddNewAssemblyFileExecute(self);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_TEXT_FILE then
  begin
    dm.actAddNewTextFileExecute(self);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_BATCH_FILE then
  begin
    dm.actAddNewBatchFileExecute(self);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_DIALOG then
  begin
    dm.actFileAddNewDialogExecute(self);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_RC then
  begin
    dm.actAddNewRCFileExecute(self);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_INC_FILE then
  begin
    dm.actAddNewIncludeFileExecute(self);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_DEF_FILE then
  begin
    dm.actAddNewModuleDefinitionFileExecute(self);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_MANIFEST_FILE then
  begin
    dm.actAddNewManifestFileExecute(self);
    close;
  end;

  if lstItems.Selected.Caption = NEW_ITEM_PROJECT_GROUP then
  begin
    dm.actGroupNewGroupExecute(self);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_16_BIT_MSDOS_COM_APP then
  begin
    dm.CreateNewProject(ptDos16COM);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_16_BIT_MSDOS_EXE_APP then
  begin
    dm.CreateNewProject(ptDos16EXE);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_16_BIT_WIN_EXE_APP then
  begin
    dm.CreateNewProject(ptWin16);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_16_BIT_WIN_DLL_APP then
  begin
    dm.CreateNewProject(ptWin16Dll);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_32_BIT_WIN_EXE_APP then
  begin
    dm.CreateNewProject(ptWin32);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_32_BIT_WIN_DLG_APP then
  begin
    dm.CreateNewProject(ptWin32Dlg);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_32_BIT_WIN_CON_APP then
  begin
    dm.CreateNewProject(ptWin32Con);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_32_BIT_WIN_DLL_APP then
  begin
    dm.CreateNewProject(ptWin32DLL);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_64_BIT_WIN_EXE_APP then
  begin
    dm.CreateNewProject(ptWin64);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_64_BIT_WIN_DLL_APP then
  begin
    dm.CreateNewProject(ptWin64DLL);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_LIB_APP then
  begin
    dm.CreateNewProject(ptLib);
    close;
  end;
  dm.SynchronizeProjectManagerWithGroup;
  dm.UpdateUI(true);
end;

procedure TfrmNewItems.tvTreeChange(Sender: TObject; Node: TTreeNode);
begin
  lstItems.Items.BeginUpdate;
  lstItems.Items.Clear;

  if Node.Text = NEW_ITEM_ASSEMBLY_PROJECTS then
    AddApplicationItems(lstItems.Items);

  if Node.Parent <> nil then
  begin
    if (Node.Parent.Text = NEW_ITEM_ASSEMBLY_PROJECTS) and (Node.Text = NEW_ITEM_WINDOWS) then
      AddWindowsItems(lstItems.Items);

    if (Node.Parent.Text = NEW_ITEM_ASSEMBLY_PROJECTS) and (Node.Text = NEW_ITEM_MSDOS) then
      AddMSDOSItems(lstItems.Items);
  end;

  if Node.Text = NEW_ITEM_OTHER_FILES then
    AddOtherItems(lstItems.Items);

  lstItems.Items.EndUpdate;
end;

procedure TfrmNewItems.AddWindowsItems(items: TListItems);
var
  item: TListItem;
begin
  item := items.Add;
  item.Caption := NEW_ITEM_ASSEMBLY_FILE;
  item.ImageIndex := 4;

  item := items.Add;
  item.Caption := NEW_ITEM_DIALOG;
  item.ImageIndex := 9;

  item := items.Add;
  item.Caption := NEW_ITEM_RC;
  item.ImageIndex := 5;

  item := items.Add;
  item.Caption := NEW_ITEM_BATCH_FILE;
  item.ImageIndex := 6;

  item := items.Add;
  item.Caption := NEW_ITEM_TEXT_FILE;
  item.ImageIndex := 7;

  item := items.Add;
  item.Caption := NEW_ITEM_INC_FILE;
  item.ImageIndex := 8;

  item := items.Add;
  item.Caption := NEW_ITEM_DEF_FILE;
  item.ImageIndex := 7;

  item := items.Add;
  item.Caption := NEW_ITEM_MANIFEST_FILE;
  item.ImageIndex := 11;
end;

procedure TfrmNewItems.AddMSDOSItems(items: TListItems);
var
  item: TListItem;
begin
  item := items.Add;
  item.Caption := NEW_ITEM_ASSEMBLY_FILE;
  item.ImageIndex := 4;

  item := items.Add;
  item.Caption := NEW_ITEM_BATCH_FILE;
  item.ImageIndex := 6;

  item := items.Add;
  item.Caption := NEW_ITEM_TEXT_FILE;
  item.ImageIndex := 7;

  item := items.Add;
  item.Caption := NEW_ITEM_INC_FILE;
  item.ImageIndex := 8;
end;

procedure TfrmNewItems.AddNewProject(addToGroup: boolean);
begin
  tvTree.Items[0].Selected := true;
  FAddToGroup := addToGroup;
end;

procedure TfrmNewItems.AddApplicationItems(items: TListItems);
var
  item: TListItem;
begin
  item := items.Add;
  item.Caption := NEW_ITEM_32_BIT_WIN_EXE_APP;
  item.ImageIndex := 1;

  item := items.Add;
  item.Caption := NEW_ITEM_32_BIT_WIN_DLG_APP;
  item.ImageIndex := 9;

  item := items.Add;
  item.Caption := NEW_ITEM_32_BIT_WIN_CON_APP;
  item.ImageIndex := 2;

  item := items.Add;
  item.Caption := NEW_ITEM_32_BIT_WIN_DLL_APP;
  item.ImageIndex := 3;

  item := items.Add;
  item.Caption := NEW_ITEM_64_BIT_WIN_EXE_APP;
  item.ImageIndex := 1;

  item := items.Add;
  item.Caption := NEW_ITEM_64_BIT_WIN_DLL_APP;
  item.ImageIndex := 3;

  item := items.Add;
  item.Caption := NEW_ITEM_16_BIT_WIN_EXE_APP;
  item.ImageIndex := 1;

  item := items.Add;
  item.Caption := NEW_ITEM_16_BIT_WIN_DLL_APP;
  item.ImageIndex := 3;

  item := items.Add;
  item.Caption := NEW_ITEM_16_BIT_MSDOS_EXE_APP;
  item.ImageIndex := 0;

  item := items.Add;
  item.Caption := NEW_ITEM_16_BIT_MSDOS_COM_APP;
  item.ImageIndex := 0;

  item := items.Add;
  item.Caption := NEW_ITEM_LIB_APP;
  item.ImageIndex := 10;
end;

procedure TfrmNewItems.AddOtherItems(items: TListItems);
var
  item: TListItem;
begin
  item := items.Add;
  item.Caption := NEW_ITEM_PROJECT_GROUP;
  item.ImageIndex := 9;

  item := items.Add;
  item.Caption := NEW_ITEM_BATCH_FILE;
  item.ImageIndex := 8;

  item := items.Add;
  item.Caption := NEW_ITEM_TEXT_FILE;
  item.ImageIndex := 7;

  item := items.Add;
  item.Caption := NEW_ITEM_INC_FILE;
  item.ImageIndex := 10;

  item := items.Add;
  item.Caption := NEW_ITEM_DEF_FILE;
  item.ImageIndex := 7;
end;


procedure TfrmNewItems.Setup;
var
  node: TTreeNode;
begin
  //if tvTree.Items.Count >0 then exit;
  tvTree.Items.BeginUpdate;
  tvTree.Items.Clear;

  node := tvTree.Items.Add(nil, 'Assembly Projects');

  if (dm.Group = nil) or (dm.Group.ProjectCount = 0) then
  begin

  end else begin
    tvTree.Items.AddChild(node, NEW_ITEM_WINDOWS);
    tvTree.Items.AddChild(node, NEW_ITEM_MSDOS);
    node := tvTree.Items.Add(nil, NEW_ITEM_OTHER_FILES);
    node := tvTree.Items.AddChild(node, 'Examples');
    tvTree.Items.AddChild(node, NEW_ITEM_WINDOWS);
    tvTree.Items.AddChild(node, NEW_ITEM_MSDOS);
  end;
  tvTree.FullExpand;
  tvTree.Items.EndUpdate;
end;

procedure TfrmNewItems.FormCreate(Sender: TObject);
begin
  Setup;
end;

procedure TfrmNewItems.btnOkClick(Sender: TObject);
begin
  AddNewItem;
end;

end.
