unit uFrmNewItems;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, VirtualTrees, ExtCtrls, sSplitter,
  sPanel, StdCtrls, sButton, ComCtrls, sTreeView, sListView,
  ImgList, acAlphaImageList;

type
  TfrmNewItems = class(TForm)
    sPanel1: TsPanel;
    btnOk: TsButton;
    btnCancel: TsButton;
    tvTree: TsTreeView;
    sSplitter1: TsSplitter;
    lstItems: TListView;
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

  if lstItems.Selected.Caption = NEW_ITEM_PROJECT_GROUP then
  begin
    dm.actGroupNewGroupExecute(self);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_16_BIT_MSDOS_COM_APP then
  begin
    dm.Group.CreateNewProject(ptDos16COM, dm.VisualMASMOptions);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_16_BIT_MSDOS_EXE_APP then
  begin
    dm.Group.CreateNewProject(ptDos16EXE, dm.VisualMASMOptions);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_16_BIT_WIN_EXE_APP then
  begin
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_16_BIT_WIN_DLL_APP then
  begin
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_32_BIT_WIN_EXE_APP then
  begin
    dm.Group.CreateNewProject(ptWin32, dm.VisualMASMOptions);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_32_BIT_WIN_DLL_APP then
  begin
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_64_BIT_WIN_EXE_APP then
  begin
    dm.Group.CreateNewProject(ptWin64, dm.VisualMASMOptions);
    close;
  end;
  if lstItems.Selected.Caption = NEW_ITEM_64_BIT_WIN_DLL_APP then
  begin
    close;
  end;
  dm.SynchronizeProjectManagerWithGroup;
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
  item.Caption := 'Dialog';
  item.ImageIndex := 1;

  item := items.Add;
  item.Caption := 'Resource-Definition Script File';
  item.ImageIndex := 6;

  item := items.Add;
  item.Caption := NEW_ITEM_BATCH_FILE;
  item.ImageIndex := 8;

  item := items.Add;
  item.Caption := NEW_ITEM_TEXT_FILE;
  item.ImageIndex := 7;
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
  item.ImageIndex := 8;

  item := items.Add;
  item.Caption := NEW_ITEM_TEXT_FILE;
  item.ImageIndex := 7;
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
  item.Caption := NEW_ITEM_32_BIT_WIN_DLL_APP;
  item.ImageIndex := 2;

  item := items.Add;
  item.Caption := NEW_ITEM_64_BIT_WIN_EXE_APP;
  item.ImageIndex := 1;

  item := items.Add;
  item.Caption := NEW_ITEM_64_BIT_WIN_DLL_APP;
  item.ImageIndex := 2;

  item := items.Add;
  item.Caption := NEW_ITEM_16_BIT_WIN_EXE_APP;
  item.ImageIndex := 1;

  item := items.Add;
  item.Caption := NEW_ITEM_16_BIT_WIN_DLL_APP;
  item.ImageIndex := 2;

  item := items.Add;
  item.Caption := NEW_ITEM_16_BIT_MSDOS_EXE_APP;
  item.ImageIndex := 0;

  item := items.Add;
  item.Caption := NEW_ITEM_16_BIT_MSDOS_COM_APP;
  item.ImageIndex := 0;
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
