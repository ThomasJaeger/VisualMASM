unit uFraDesign;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ed_dsncont, ed_DsnBase, ed_Designer,
  sPageControl, Vcl.ComCtrls, edcCompPal, eddObjTreeFrame, eddObjInspFrm, Vcl.ExtCtrls, sSplitter, sPanel, edcDsnEvents,
  edActns, Vcl.StdActns, System.Actions, Vcl.ActnList, Vcl.ImgList, Vcl.ToolWin, edUtils, edIOUtils,
  uProjectFile;

type
  TfraDesign = class(TFrame)
    FormDesigner: TzFormDesigner;
    DesignSurface1: TDesignSurface;
    panPDesign: TsPanel;
    sSplitter4: TsSplitter;
    ObjectInspectorFrame1: TObjectInspectorFrame;
    ObjectTreeFrame1: TObjectTreeFrame;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    PaletteTab2: TPaletteTab;
    ToolBar2: TToolBar;
    ToolButton11: TToolButton;
    ToolBar3: TToolBar;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton16: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton28: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ImageList1: TImageList;
    ActionList1: TActionList;
    FileNew: TAction;
    dsnAlignToGrid1: TdsnAlignToGrid;
    dsnBringToFront1: TdsnBringToFront;
    dsnSendToBack1: TdsnSendToBack;
    dsnAlignmentDlg1: TdsnAlignmentDlg;
    dsnSizeDlg1: TdsnSizeDlg;
    dsnScale1: TdsnScale;
    dsnTabOrderDlg1: TdsnTabOrderDlg;
    dsnCreationOrderDlg1: TdsnCreationOrderDlg;
    dsnFlipChildrenAll1: TdsnFlipChildrenAll;
    dsnFlipChildren1: TdsnFlipChildren;
    dsnCopy1: TdsnCopy;
    dsnCut1: TdsnCut;
    dsnDelete1: TdsnDelete;
    dsnPaste1: TdsnPaste;
    dsnLockControls1: TdsnLockControls;
    dsnSelectAll1: TdsnSelectAll;
    FileOpen: TAction;
    FileSave: TAction;
    FileMerge: TAction;
    DesignMode: TAction;
    DsnAbout: TAction;
    FileClose: TAction;
    FileCloseAll: TAction;
    actBDSStyle: TAction;
    actReadOnly: TAction;
    dsnUndo1: TdsnUndo;
    dsnRedo1: TdsnRedo;
    dsnTextEditMode1: TdsnTextEditMode;
    dsnGroupControls1: TdsnGroupControls;
    dsnUngroupControls1: TdsnUngroupControls;
    dsnShowTabOrder1: TdsnShowTabOrder;
    DesignerEvents1: TDesignerEvents;
    sSplitter1: TsSplitter;
    procedure FormDesignerCanRename(Sender: TObject; Component: TComponent;
      const NewName: String; var Accept: Boolean);
    procedure FrameEnter(Sender: TObject);
    procedure FormDesignerCanInsert(Sender: TObject; Component: TComponent;
      var Accept: Boolean);
    procedure DesignModeExecute(Sender: TObject);
    procedure FileSaveExecute(Sender: TObject);
    procedure DesignerEvents1ItemDeleted(Sender, AItem: TObject);
    procedure DesignerEvents1ItemInserted(Sender, AItem: TObject);
    procedure DesignerEvents1ItemsModified(Sender: TObject; ADesigner: IInterface);
  private
    FProjectFile: TProjectFile;
    procedure RunFormClose(Sender: TObject; var Action: TCloseAction);
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    destructor Destroy; override;
  published
    property ProjectFile: TProjectFile read FProjectFile write FProjectFile;
  end;

implementation

uses uFrmMain, edManager, uDM;

{$R *.dfm}

procedure TfraDesign.DesignerEvents1ItemDeleted(Sender, AItem: TObject);
begin
  if FProjectFile <> nil then
    FProjectFile.Modified := true;
end;

procedure TfraDesign.DesignerEvents1ItemInserted(Sender, AItem: TObject);
begin
  if FProjectFile <> nil then
    FProjectFile.Modified := true;
end;

procedure TfraDesign.DesignerEvents1ItemsModified(Sender: TObject; ADesigner: IInterface);
begin
  if FProjectFile <> nil then
    FProjectFile.Modified := true;
end;

procedure TfraDesign.DesignModeExecute(Sender: TObject);
var fm: TForm;
    Mem: TMemoryStream;
    events: TStringList;
begin
  if (FormDesigner <> nil) and FormDesigner.Active then
  begin
    Mem := TMemoryStream.Create;
    try
      DsnWriteCmpToStream(Mem, FormDesigner, False);
      fm := TForm.Create(Self);
      fm.OnClose := RunFormClose;
      Mem.Position := 0;
      events := TStringList.Create;
      try
        zReadCmpFromStream(Mem, fm, nil, nil, events);
      finally
        events.Free; // do not use assigned events
      end;
      fm.Show;
    finally
      Mem.Free;
    end;
  end;
end;

procedure TfraDesign.RunFormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

destructor TfraDesign.Destroy;
begin
  if FormDesigner.Target <> nil then
    FormDesigner.Target.Free;
  inherited;
end;

procedure TfraDesign.FileSaveExecute(Sender: TObject);
begin
//  if (CurDesigner <> nil) and SD.Execute then
    DsnWriteToFile(dm.Group.ActiveProject.ActiveFile.Path+
      dm.Group.ActiveProject.ActiveFile.FileName, FormDesigner, True);
end;

procedure TfraDesign.FormDesignerCanInsert(Sender: TObject;
  Component: TComponent; var Accept: Boolean);
begin
//  Accept := not (Component is TButton);
  if Component is TActionList then
    PostMessage(Handle, WM_USER + 1, 0, 0);
end;

procedure TfraDesign.FormDesignerCanRename(Sender: TObject;
  Component: TComponent; const NewName: String; var Accept: Boolean);
begin
  if (Component = FormDesigner.Root) or (Component = nil) then
    (Parent as TsTabSheet).Caption := NewName;
end;

procedure TfraDesign.FrameEnter(Sender: TObject);
begin
//  FormDesigner.Activate;
end;

procedure TfraDesign.WndProc(var Message: TMessage);
begin
  inherited;
  if (Message.Msg = WM_USER + 1) and (FormDesigner.SelCount = 1) then
    FormDesigner.Edit(FormDesigner.SelectedComponent);
end;

//function TfraDesign.GetCurDesigner: TzFormDesigner;
//begin
//  if PageControl1.ActivePage = nil then
//    Result := nil
//  else
//    Result := TfraDesign.(PageControl1.ActivePage.Controls[0]).FormDesigner;
//end;

end.
