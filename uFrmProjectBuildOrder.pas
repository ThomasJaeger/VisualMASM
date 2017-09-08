unit uFrmProjectBuildOrder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, VirtualTrees, uSharedGlobals,
  uDM, uProject, ActiveX, uGroup, System.Generics.Collections;

type
  TfrmProjectBuildOrder = class(TForm)
    Label1: TLabel;
    vstProject: TVirtualStringTree;
    Panel1: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure vstProjectGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
    procedure Synchronize;
    procedure FormShow(Sender: TObject);
    procedure vstProjectInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
      var InitialStates: TVirtualNodeInitStates);
    procedure vstProjectChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstProjectBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure vstProjectDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      var Allowed: Boolean);
    procedure vstProjectDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState;
      Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure vstProjectDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject;
      Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure vstProjectHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure SelectAll;
    procedure UnselectAll;
    procedure UpdateBuildOrder;
    function GetBuildOrderForProject(id: string): string;
    procedure AddProjectToList(project: TProject);
  private
    FBuildOrder: TList<string>;
  public
    property BuildOrder: TList<string> read FBuildOrder write FBuildOrder;
  end;

var
  frmProjectBuildOrder: TfrmProjectBuildOrder;
  finsihedStartingUp: boolean = false;

implementation

{$R *.dfm}

procedure TfrmProjectBuildOrder.FormCreate(Sender: TObject);
begin
  FBuildOrder := TList<string>.Create;
  vstProject.NodeDataSize := SizeOf(TProjectData);
end;

procedure TfrmProjectBuildOrder.vstProjectBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
var
  Data: PProjectData;
begin
  if Column = 0 then
  begin
    Sender.CheckType[Node] := ctCheckBox;
    Data := Sender.GetNodeData(Node);
    if Data.Build then
      Sender.CheckState[Node] := csCheckedNormal
    else
      Sender.CheckState[Node] := csUncheckedNormal;
  end;
end;

procedure TfrmProjectBuildOrder.vstProjectChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PProjectData;
begin
  Data := Sender.GetNodeData(Node);
  if Sender.CheckState[Node] = csCheckedNormal then
  begin
    Data.Build := true;
  end else begin
    Data.Build := false;
  end;
  UpdateBuildOrder;
end;

procedure TfrmProjectBuildOrder.vstProjectDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := true;
end;

procedure TfrmProjectBuildOrder.vstProjectDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject;
  Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  pSource, pTarget: PVirtualNode;
  attMode: TVTNodeAttachMode;
begin
  pSource := TVirtualStringTree(Source).FocusedNode;
  pTarget := Sender.DropTargetNode;

  case Mode of
    dmNowhere: attMode := amNoWhere;
    dmAbove: attMode := amInsertBefore;
    dmOnNode, dmBelow: attMode := amInsertAfter;
  end;

  Sender.MoveTo(pSource, pTarget, attMode, False);

  UpdateBuildOrder;
end;

procedure TfrmProjectBuildOrder.vstProjectDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState;
  State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TfrmProjectBuildOrder.vstProjectGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  Data: PProjectData;
begin
  Data := Sender.GetNodeData(Node);
  if (dm.Group = nil) or (data.ProjectId = '') then exit;
  case Column of
    0:   // Name column
      CellText := dm.Group[data.ProjectId].Name;
    1:  // Build order column
      CellText := GetBuildOrderForProject(data.ProjectId);
  end;
end;

procedure TfrmProjectBuildOrder.vstProjectHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
begin
  if hhiOnCheckbox in HitInfo.HitPosition then
  begin
    if Sender.Columns[HitInfo.Column].CheckState = csCheckedNormal then
      SelectAll
    else if Sender.Columns[HitInfo.Column].CheckState = csUncheckedNormal then
      UnselectAll;
    vstProject.Refresh;
  end;
end;

procedure TfrmProjectBuildOrder.vstProjectInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Level: Integer;
  Data: PProjectData;
begin
  Level := Sender.GetNodeLevel(Node);
  if Level = 0 then
  begin
    Sender.CheckType[Node] := ctCheckBox;
    Data := Sender.GetNodeData(Node);
    if Data.Build then
      Sender.CheckState[Node] := csCheckedNormal
    else
      Sender.CheckState[Node] := csUncheckedNormal;
  end;
end;

procedure TfrmProjectBuildOrder.FormShow(Sender: TObject);
var
  i: Integer;
begin
  if not dm.IsThemeBright then
    vstProject.Colors.SelectionTextColor := clBlack;
  FBuildOrder.Clear;
  for i := 0 to dm.Group.BuildOrder.Count-1 do
  begin
    FBuildOrder.Add(dm.Group.BuildOrder[i]);
  end;
  Synchronize;
  finsihedStartingUp := true;
end;

procedure TfrmProjectBuildOrder.Synchronize;
var
  project: TProject;
  projectNode: PVirtualNode;
  data: PProjectData;
  i: integer;
  foundProject: boolean;
begin
  if dm.Group=nil then exit;
  if vstProject = nil then exit;

  vstProject.BeginUpdate;
  vstProject.Clear;

  for i := 0 to FBuildOrder.Count-1 do
  begin
    project := dm.Group.ProjectById[FBuildOrder[i]];
    if project <> nil then
      AddProjectToList(project);
  end;

  // Now add the projects that are not marked to be built
  for project in dm.Group.Projects.Values do
  begin
    foundProject := false;
    for i := 0 to FBuildOrder.Count-1 do
    begin
      if FBuildOrder[i] = project.Id then
      begin
        foundProject := true;
        break;
      end;
    end;
    if not foundProject then
      AddProjectToList(project);
  end;

  vstProject.Refresh;
  vstProject.FullExpand;
  vstProject.EndUpdate;
end;

procedure TfrmProjectBuildOrder.AddProjectToList(project: TProject);
var
  projectNode: PVirtualNode;
  data: PProjectData;
begin
  projectNode := vstProject.AddChild(nil);
  vstProject.Expanded[projectNode] := true;
  data := vstProject.GetNodeData(projectNode);
  data^.ProjectId := project.Id;
  data^.Name := project.Name;
  data^.Level := 0;
  data^.FileId := '';
  data^.FileSize := project.SizeInBytes;
  data^.ProjectIntId := project.IntId;
  data^.Build := project.Build;
end;

procedure TfrmProjectBuildOrder.SelectAll;
var
  node: PVirtualNode;
  Data: PProjectData;
begin
  if dm.Group=nil then exit;
  try
    node := vstProject.GetFirst;
    while Assigned(node) do
    begin
      Data := vstProject.GetNodeData(node);
      Data.Build := true;
      node.CheckState := csCheckedNormal;
      vstProject.InvalidateNode(node);
      node := vstProject.GetNext(node);
    end;
  finally
  end;
  UpdateBuildOrder;
end;

procedure TfrmProjectBuildOrder.UnselectAll;
var
  node: PVirtualNode;
  Data: PProjectData;
begin
  if dm.Group=nil then exit;
  try
    node := vstProject.GetFirst;
    while Assigned(node) do
    begin
      Data := vstProject.GetNodeData(node);
      Data.Build := false;
      node.CheckState := csUncheckedNormal;
      vstProject.InvalidateNode(node);
      node := vstProject.GetNext(node);
    end;
  finally
  end;
  UpdateBuildOrder;
end;

procedure TfrmProjectBuildOrder.UpdateBuildOrder;
var
  node: PVirtualNode;
  Data: PProjectData;
begin
  if not finsihedStartingUp then exit;
  if dm.Group=nil then exit;
  try
    BuildOrder.Clear;
    node := vstProject.GetFirst;
    while Assigned(node) do
    begin
      Data := vstProject.GetNodeData(node);
      if Data.Build then
        BuildOrder.Add(Data.ProjectId);
      node := vstProject.GetNext(node);
    end;
  finally
  end;
end;

function TfrmProjectBuildOrder.GetBuildOrderForProject(id: string): string;
var
  projectId: string;
  i: integer;
begin
  result := '0';
  if id = '' then exit;
  for i := 0 to FBuildorder.Count-1 do
  begin
    if id = FBuildorder.Items[i] then
    begin
      result := inttostr(i+1);
      exit;
    end;
  end;
end;

end.
