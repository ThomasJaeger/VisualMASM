unit uEditors;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, VirtualTrees, ExtDlgs, ImgList, Buttons, ExtCtrls, ComCtrls,
  Mask, uSharedGlobals;

type
  TValueType = (
    vtNone,
    vtString,
    vtPickString,
    vtNumber,
    vtPickNumber,
    vtMemo,
    vtDate
  );

type
//  PPropertyData = ^TPropertyData;
//  TPropertyData = record
//    ValueType: TValueType;
//    Value: UnicodeString;
//    Changed: Boolean;
//  end;

  TPropertyEditLink = class(TInterfacedObject, IVTEditLink)
  private
    FEdit: TWinControl;        // One of the property editor classes.
    FTree: TVirtualStringTree; // A back reference to the tree calling.
    FNode: PVirtualNode;       // The node being edited.
    FColumn: Integer;          // The column of the node being edited.
  protected
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    destructor Destroy; override;

    function BeginEdit: Boolean; stdcall;
    function CancelEdit: Boolean; stdcall;
    function EndEdit: Boolean; stdcall;
    function GetBounds: TRect; stdcall;
    function PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean; stdcall;
    procedure ProcessMessage(var Message: TMessage); stdcall;
    procedure SetBounds(R: TRect); stdcall;
  end;

type
  TPropertyTextKind = (
    ptkText,
    ptkHint
  );

implementation

destructor TPropertyEditLink.Destroy;
begin
  if FEdit.HandleAllocated then
    PostMessage(FEdit.Handle, CM_RELEASE, 0, 0);
  inherited;
end;

procedure TPropertyEditLink.EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  CanAdvance: Boolean;
begin
  CanAdvance := true;

  case Key of
    VK_ESCAPE:
      begin
        Key := 0;//ESC will be handled in EditKeyUp()
      end;
    VK_RETURN:
      if CanAdvance then
      begin
        FTree.EndEditNode;
        Key := 0;
      end;
    VK_UP,
    VK_DOWN:
      begin
        // Consider special cases before finishing edit mode.
        CanAdvance := Shift = [];
        if FEdit is TComboBox then
          CanAdvance := CanAdvance and not TComboBox(FEdit).DroppedDown;
        if FEdit is TDateTimePicker then
          CanAdvance :=  CanAdvance and not TDateTimePicker(FEdit).DroppedDown;

        if CanAdvance then
        begin
          // Forward the keypress to the tree. It will asynchronously change the focused node.
          PostMessage(FTree.Handle, WM_KEYDOWN, Key, 0);
          Key := 0;
        end;
      end;
  end;
end;

procedure TPropertyEditLink.EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
      begin
        FTree.CancelEditNode;
        Key := 0;
      end;//VK_ESCAPE
    VK_RETURN:
      begin
        FTree.EndEditNode;
        Key := 0;
      end;
  end;//case
end;

function TPropertyEditLink.BeginEdit: Boolean;
begin
  Result := True;
  FEdit.Show;
  FEdit.SetFocus;
end;

function TPropertyEditLink.CancelEdit: Boolean;
begin
  Result := True;
  FEdit.Hide;
  FTree.SetFocus;
end;

function TPropertyEditLink.EndEdit: Boolean;
var
  //Data: PPropertyData;
  Data: PFunctionData;
  Buffer: array[0..1024] of Char;
  S: UnicodeString;
begin
  Result := True;

  Data := FTree.GetNodeData(FNode);
//  if FEdit is TComboBox then
//    S := TComboBox(FEdit).Text
//  else
//  begin
    GetWindowText(FEdit.Handle, Buffer, 1024);
    S := Buffer;
//  end;

  if S <> Data.ExportAs then
  begin
    Data.ExportAs := S;
//    Data.Changed := True;
    FTree.InvalidateNode(FNode);
  end;
  FEdit.Hide;
  FTree.SetFocus;
end;

function TPropertyEditLink.GetBounds: TRect;
begin
  Result := FEdit.BoundsRect;
end;

function TPropertyEditLink.PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean;
var
  //Data: PPropertyData;
  Data: PFunctionData;
begin
  Result := True;
  FTree := Tree as TVirtualStringTree;
  FNode := Node;
  FColumn := Column;

//  // determine what edit type actually is needed
  FEdit.Free;
  FEdit := nil;
  Data := FTree.GetNodeData(Node);

  FEdit := TEdit.Create(nil);
  with FEdit as TEdit do
  begin
    Visible := False;
    Parent := Tree;
    Text := Data.ExportAs;
    OnKeyDown := EditKeyDown;
    OnKeyUp := EditKeyUp;
  end;

//  case Data.ValueType of
//    vtString:
//      begin
//        FEdit := TEdit.Create(nil);
//        with FEdit as TEdit do
//        begin
//          Visible := False;
//          Parent := Tree;
//          Text := Data.Value;
//          OnKeyDown := EditKeyDown;
//          OnKeyUp := EditKeyUp;
//        end;
//      end;
//    vtPickString:
//      begin
//        FEdit := TComboBox.Create(nil);
//        with FEdit as TComboBox do
//        begin
//          Visible := False;
//          Parent := Tree;
//          Text := Data.Value;
//          Items.Add(Text);
//          Items.Add('Standard');
//          Items.Add('Additional');
//          Items.Add('Win32');
//          OnKeyDown := EditKeyDown;
//          OnKeyUp := EditKeyUp;
//        end;
//      end;
//    vtNumber:
//      begin
//        FEdit := TMaskEdit.Create(nil);
//        with FEdit as TMaskEdit do
//        begin
//          Visible := False;
//          Parent := Tree;
//          EditMask := '9999';
//          Text := Data.Value;
//          OnKeyDown := EditKeyDown;
//          OnKeyUp := EditKeyUp;
//        end;
//      end;
//    vtPickNumber:
//      begin
//        FEdit := TComboBox.Create(nil);
//        with FEdit as TComboBox do
//        begin
//          Visible := False;
//          Parent := Tree;
//          Text := Data.Value;
//          OnKeyDown := EditKeyDown;
//          OnKeyUp := EditKeyUp;
//        end;
//      end;
//    vtMemo:
//      begin
//        FEdit := TComboBox.Create(nil);
//        // In reality this should be a drop down memo but this requires
//        // a special control.
//        with FEdit as TComboBox do
//        begin
//          Visible := False;
//          Parent := Tree;
//          Text := Data.Value;
//          Items.Add(Data.Value);
//          OnKeyDown := EditKeyDown;
//          OnKeyUp := EditKeyUp;
//        end;
//      end;
//    vtDate:
//      begin
//        FEdit := TDateTimePicker.Create(nil);
//        with FEdit as TDateTimePicker do
//        begin
//          Visible := False;
//          Parent := Tree;
//          CalColors.MonthBackColor := clWindow;
//          CalColors.TextColor := clBlack;
//          CalColors.TitleBackColor := clBtnShadow;
//          CalColors.TitleTextColor := clBlack;
//          CalColors.TrailingTextColor := clBtnFace;
//          Date := StrToDate(Data.Value);
//          OnKeyDown := EditKeyDown;
//          OnKeyUp := EditKeyUp;
//        end;
//      end;
//  else
//    Result := False;
//  end;
end;

procedure TPropertyEditLink.ProcessMessage(var Message: TMessage);
begin
  FEdit.WindowProc(Message);
end;

procedure TPropertyEditLink.SetBounds(R: TRect);
var
  Dummy: Integer;
begin
  // Since we don't want to activate grid extensions in the tree (this would influence how the selection is drawn)
  // we have to set the edit's width explicitly to the width of the column.
  FTree.Header.Columns.GetColumnBounds(FColumn, Dummy, R.Right);
  FEdit.BoundsRect := R;
end;

end.
