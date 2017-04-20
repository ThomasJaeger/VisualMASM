unit uFraDesign;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ed_dsncont, ed_DsnBase, ed_Designer,
  sPageControl, Vcl.ComCtrls, edcCompPal, eddObjTreeFrame, eddObjInspFrm, Vcl.ExtCtrls, sSplitter, sPanel, edcDsnEvents,
  edActns, Vcl.StdActns, System.Actions, Vcl.ActnList, Vcl.ImgList, Vcl.ToolWin, edUtils, edIOUtils,
  uProjectFile, Vcl.StdCtrls, DesignIntf, eduServObj, SynMemo;

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
    imgDesigner: TImageList;
    actDesigner: TActionList;
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
    sSplitter1: TsSplitter;
    DesignerEvents1: TDesignerEvents;
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
    procedure RunFormClose(Sender: TObject; var Action: TCloseAction);
    function GetOwningForm(Control: TComponent): TForm;
    function GetDialogStyle(f: TForm): string;
    function GetCommonProperties(c: TControl): string;
    function GetButtonStyle(btn: TButton): string;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    destructor Destroy; override;
    procedure Parse(c: TComponent);
  published
  end;

implementation

uses uFrmMain, edManager, uDM, uSharedGlobals;

{$R *.dfm}

procedure TfraDesign.DesignerEvents1ItemDeleted(Sender, AItem: TObject);
var
  comp: TComponent;
begin
  if not (AItem is TComponent) then Exit;
  comp := TComponent(AItem);
  if comp is TButton then
    ShowMessage(comp.Name);

//  if FProjectFile <> nil then
//  begin
    dm.Group.ActiveProject.ActiveFile.Modified := true;
    Parse(comp);
//  end;
end;

procedure TfraDesign.DesignerEvents1ItemInserted(Sender, AItem: TObject);
var
  comp: TComponent;
  form: TCustomForm;
begin
  if not (AItem is TComponent) then Exit;
//  if FProjectFile <> nil then
//  begin
    dm.Group.ActiveProject.ActiveFile.Modified := true;
    comp := TComponent(AItem);
    form := GetOwningForm(comp);
   // Parse(form);
//  end;
end;

function TfraDesign.GetOwningForm(Control: TComponent): TForm;
var
  LOwner: TComponent;
begin
  LOwner:= Control.Owner;
  while Assigned(LOwner) and not(LOwner is TCustomForm) do begin
    LOwner:= LOwner.Owner;
  end; {while}
  Result:= LOwner as TForm;
end;

procedure TfraDesign.DesignerEvents1ItemsModified(Sender: TObject; ADesigner: IInterface);
var
  impl: IImplementation;
  dsn: TzFormDesigner;
  i: integer;
  comp: TComponent;
begin
  if dm.Group.ActiveProject <> nil then
  begin
    dm.Group.ActiveProject.ActiveFile.Modified := true;
    if Supports(ADesigner, IImplementation, Impl) then
    begin
      dsn := Impl.GetInstance as TzFormDesigner;
      Parse(dsn.Form);
//      for i := 0 to dsn.SelCount-1 do
//      begin
//        if dsn.Selected[i] is TComponentIcon then
//          comp := TComponentIcon(dsn.Selected[i]).Component
//        else
//          comp := dsn.Selected[i];
//        ShowMessage(comp.Name);
//      end;
    end;
  end;
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

procedure TfraDesign.Parse(c: TComponent);
var
  sl: TStringList;
  f: TForm;
  comp: TComponent;
  i: integer;
  spaces: string;
  btn: TButton;
  memo: TSynMemo;
  rcFile: TProjectFile;
begin
//  if rcFile = nil then
//    FRCFile := dm.Group.GetProjectFileById(FProjectFile.ChildFileId);
  rcFile := dm.Group.GetProjectFileById(dm.Group.ActiveProject.ActiveFile.ChildFileId);
  if rcFile <> nil then
  begin
    if c is TForm then begin
      spaces := '   ';
      f := TForm(c);
      sl := TStringList.Create;
      sl.Add(NEW_ITEM_RC_HEADER);
      sl.Add('');

      // Dialog definition
      // https://msdn.microsoft.com/en-us/library/windows/desktop/aa381003(v=vs.85).aspx
      // https://msdn.microsoft.com/en-us/library/windows/desktop/aa381002(v=vs.85).aspx
      sl.Add(f.Name+' DIALOGEX '+inttostr(f.Left)+', '+inttostr(f.Top)+', '+inttostr(f.Width)+', '+inttostr(f.Height));
      sl.Add(GetDialogStyle(f));
      sl.Add('CAPTION "'+f.Caption+'"');
      sl.Add('{');
      for i:=0 to f.ComponentCount-1 do
      begin
        if f.Components[i] is TButton then begin
          btn := TButton(f.Components[i]);
          sl.Add(spaces+'CONTROL '+btn.Name+', PUSHBUTTON, "'+btn.Caption+'"'+GetCommonProperties(btn)+
            GetButtonStyle(btn));
        end;
      end;
      sl.Add('}');

      rcFile.Content := sl.Text;
      memo := dm.GetMemoFromProjectFile(rcFile);
      if memo <> nil then
        memo.Text := rcFile.Content;
      // IDD_DIALOG1 DIALOG 0, 0, 240, 120
    end;
  end;
end;

function TfraDesign.GetDialogStyle(f: TForm): string;
begin
  // https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  // https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  result := 'STYLE ';
  if f.Caption<>'' then result := result + ' WS_CAPTION';
  if f.BorderStyle = bsSingle then result := result + ' | WS_BORDER';
  if f.BorderStyle = bsSizeable then result := result + ' | WS_SIZEBOX';
  if f.BorderStyle = bsDialog then result := result + ' | WS_DLGFRAME';
  if biSystemMenu in f.BorderIcons then result := result + ' | WS_SYSMENU';
  if biMinimize in f.BorderIcons then result := result + ' | WS_MINIMIZEBOX';
  if biMaximize in f.BorderIcons then result := result + ' | WS_MAXIMIZEBOX';
  if biHelp in f.BorderIcons then result := result + ' | WS_EX_CONTEXTHELP';
  if f.WindowState = wsMinimized then result := result + ' | WS_MINIMIZE';
  if f.WindowState = wsMaximized then result := result + ' | WS_MAXIMIZE';
end;

function TfraDesign.GetCommonProperties(c: TControl): string;
begin
  // https://msdn.microsoft.com/en-us/library/windows/desktop/aa380902(v=vs.85).aspx
  result := ', '+inttostr(c.Left)+', '+
    inttostr(c.Top)+', '+
    inttostr(c.Width)+', '+
    inttostr(c.Height);
end;

function TfraDesign.GetButtonStyle(btn: TButton): string;
begin
  // https://msdn.microsoft.com/en-us/library/windows/desktop/bb775951(v=vs.85).aspx
  result := ', BS_PUSHBUTTON | BS_CENTER ';
end;

end.
