unit uFrmExportFunctions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, VirtualTrees,
  System.Generics.Collections, uSharedGlobals, uEditors, uProject;

const
  // Helper message to decouple node change handling from edit handling.
  WM_STARTEDITING = WM_USER + 778;

type
  TfrmExportFunctions = class(TForm)
    Label1: TLabel;
    vstFunctions: TVirtualStringTree;
    Panel1: TPanel;
    btnExport: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure vstFunctionsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
    procedure vstFunctionsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
      var InitialStates: TVirtualNodeInitStates);
    procedure FormShow(Sender: TObject);
    procedure vstFunctionsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstFunctionsCreateEditor(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      out EditLink: IVTEditLink);
    procedure vstFunctionsEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      var Allowed: Boolean);
    procedure vstFunctionsFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure btnCancelClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure vstFunctionsHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure vstFunctionsChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
  private
    FProject: TProject;
    procedure Synchronize;
    procedure SelectAll;
    procedure UnselectAll;
  public
    property Project: TProject read FProject write FProject;
  end;

var
  frmExportFunctions: TfrmExportFunctions;

implementation

{$R *.dfm}

uses
  uDM;

procedure TfrmExportFunctions.btnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmExportFunctions.btnExportClick(Sender: TObject);
var
  node: PVirtualNode;
  Data: PFunctionData;
begin
  FProject.MarkAllFunctionsNotToExport;
  node := vstFunctions.GetFirst;
  while Assigned(node) do
  begin
    Data := vstFunctions.GetNodeData(node);
    if Data.Export then
      FProject.ExportFunction(Data.Name, Data.ExportAs, Data.FileId);
    node := vstFunctions.GetNext(node);
  end;
  FProject.UpdateSavedFunction;
  FProject.Modified := true;
  close;
end;

procedure TfrmExportFunctions.FormCreate(Sender: TObject);
begin
  vstFunctions.NodeDataSize := SizeOf(TFunctionData);
end;

procedure TfrmExportFunctions.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #27) or (key = #$D) then
  begin
    key := #0;
  end;
end;

procedure TfrmExportFunctions.FormShow(Sender: TObject);
begin
  if not dm.IsThemeBright then
    vstFunctions.Colors.SelectionTextColor := clBlack;
  vstFunctions.RootNodeCount := FProject.Functions.Count;
  Synchronize;
  vstFunctions.SetFocus;
end;

procedure TfrmExportFunctions.vstFunctionsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  with Sender do
  begin
    // Start immediate editing as soon as another node gets focused.
    if Assigned(Node) and (Node.Parent <> RootNode) and not (tsIncrementalSearching in TreeStates) then
    begin
      // We want to start editing the currently selected node. However it might well happen that this change event
      // here is caused by the node editor if another node is currently being edited. It causes trouble
      // to start a new edit operation if the last one is still in progress. So we post us a special message and
      // in the message handler we then can start editing the new node. This works because the posted message
      // is first executed *after* this event and the message, which triggered it is finished.
      PostMessage(Self.Handle, WM_STARTEDITING, WPARAM(Node), 0);
    end;
  end;
end;

procedure TfrmExportFunctions.vstFunctionsChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PFunctionData;
begin
  Data := Sender.GetNodeData(Node);
  if Sender.CheckState[Node] = csCheckedNormal then
  begin
    Data.Export := true;
  end else begin
    Data.Export := false;
  end;
end;

procedure TfrmExportFunctions.vstFunctionsCreateEditor(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; out EditLink: IVTEditLink);
begin
  EditLink := TPropertyEditLink.Create;
end;

procedure TfrmExportFunctions.vstFunctionsEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  var Allowed: Boolean);
var
  Data: PFunctionData;
begin
  with Sender do
  begin
//    Data := GetNodeData(Node);
//    Allowed := (Node.Parent <> RootNode) and (Column = 1) and (Data.ValueType <> vtNone);
    Allowed := (Column = 1);
  end;
end;

procedure TfrmExportFunctions.vstFunctionsFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PFunctionData;
begin
  Data := Sender.GetNodeData(Node);
  Finalize(Data^);
end;

procedure TfrmExportFunctions.vstFunctionsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  data: PFunctionData;
begin
  data := Sender.GetNodeData(Node);
  case Column of
    0: CellText := data.Name;
    1: CellText := data.ExportAs;
    2: CellText := data.FileName;
  end;
end;

procedure TfrmExportFunctions.vstFunctionsHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
begin
  if hhiOnCheckbox in HitInfo.HitPosition then
  begin
    if Sender.Columns[HitInfo.Column].CheckState = csCheckedNormal then
      SelectAll
    else if Sender.Columns[HitInfo.Column].CheckState = csUncheckedNormal then
      UnselectAll;
    vstFunctions.Refresh;
  end;
end;

procedure TfrmExportFunctions.vstFunctionsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PFunctionData;
  Level: Integer;
begin
  data := Sender.GetNodeData(Node);
  Level := Sender.GetNodeLevel(Node);
  if Level = 0 then
  begin
    Sender.CheckType[Node] := ctCheckBox;
    if Assigned(data) and data.Export then
      Sender.CheckState[Node] := csCheckedNormal
    else
      Sender.CheckState[Node] := csUncheckedNormal;
  end;
end;

procedure TfrmExportFunctions.Synchronize;
var
  node: PVirtualNode;
  data: PFunctionData;
  i: integer;
begin
  vstFunctions.BeginUpdate;
  vstFunctions.Clear;

  for i := 0 to FProject.Functions.Count-1 do
  begin
    node := vstFunctions.AddChild(nil);
    data := vstFunctions.GetNodeData(node);
    data^.FileId := FProject.Functions[i].FileId;
    data^.FileName := FProject.Functions[i].FileName;
    data^.Line := FProject.Functions[i].Line;
    data^.Name := FProject.Functions[i].Name;
    data^.ExportAs := FProject.Functions[i].ExportAs;
    data^.Export := FProject.Functions[i].Export;
  end;

  vstFunctions.Refresh;
  vstFunctions.FullExpand;
  vstFunctions.EndUpdate;
end;

procedure TfrmExportFunctions.SelectAll;
var
  node: PVirtualNode;
  Data: PFunctionData;
begin
  node := vstFunctions.GetFirst;
  while Assigned(node) do
  begin
    Data := vstFunctions.GetNodeData(node);
    Data.Export := true;
    node.CheckState := csCheckedNormal;
    vstFunctions.InvalidateNode(node);
    node := vstFunctions.GetNext(node);
  end;
end;

procedure TfrmExportFunctions.UnselectAll;
var
  node: PVirtualNode;
  Data: PFunctionData;
begin
  node := vstFunctions.GetFirst;
  while Assigned(node) do
  begin
    Data := vstFunctions.GetNodeData(node);
    Data.Export := false;
    node.CheckState := csUncheckedNormal;
    vstFunctions.InvalidateNode(node);
    node := vstFunctions.GetNext(node);
  end;
end;

end.
