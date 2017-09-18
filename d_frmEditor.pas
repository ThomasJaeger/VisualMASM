unit d_frmEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, TypInfo, Menus, ActnList, LMDTypes,
  LMDUnicodeStrings, LMDStrings, LMDDsgDesigner, LMDDsgObjects, LMDDsgModule,
  LMDSedView, LMDDckSite, Tabs, System.IOUtils, Vcl.ToolWin, Vcl.StdActns,
  System.Actions, Vcl.ImgList, uProjectFile;

type
  TfrmEditor = class(TFrame)
    Designer: TLMDDesigner;
    Module: TLMDModule;
    Selection: TLMDDesignObjects;
    AllComps: TLMDDesignObjects;
    DesignPanel: TLMDDesignPanel;
    ControlBar1: TControlBar;
    ToolBar2: TToolBar;
    ToolButton11: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure ModuleLoadError(Sender: TObject; const AMessage: TLMDString;
      var AHandled: Boolean);
    procedure ModuleCompsModified(Sender: TObject);
    procedure ModuleGetEventHandlerName(Sender: TObject; AInstance: TPersistent; const AEventName: TLMDString;
      AEventTypeInfo: PTypeInfo; var AName: TLMDString);
    procedure ModuleValidateEventHandlerName(Sender: TObject; const AName: TLMDString; var AIsValidName: Boolean);
    procedure ModuleValidateEventHandler(Sender: TObject; AInstance: TPersistent; APropInfo: PPropInfo;
      const AHandlerName: TLMDString; var ACancel: Boolean);
    procedure ModuleGetEventHandlerList(Sender: TObject; AEventTypeInfo: PTypeInfo; AResult: TStrings);
    procedure ModuleEnsureEventHandlerSource(Sender: TObject; const AName, AOldName: TLMDString;
      AEventTypeInfo: PTypeInfo; AShowSource: Boolean; var AIsRenamed: Boolean);
  private
    FIsForm:       Boolean;
    FUpdatingView: Boolean;
    FRCFile: TProjectFile;
    FProjectFile: TProjectFile;
  public
    property LMDMod: TLMDModule read Module;
    procedure SelectRoot;
    procedure Release;
    function  DockPanel: TLMDDockPanel;
    procedure Parse(pf: TProjectFile = nil);
    property RCFile: TProjectFile read FRCFile write FRCFile;
    property ProjectFile: TProjectFile read FProjectFile write FProjectFile;
  end;

implementation

{$R *.dfm}

uses
  uFrmMain, uDM;

procedure TfrmEditor.ModuleLoadError(Sender: TObject;
  const AMessage: TLMDString; var AHandled: Boolean);
begin
  AHandled := MessageDlg(
    AMessage + #13#10 + 'Click Ok to continue, click Cancel to abort',
    mtConfirmation, [mbOk, mbCancel], 0) = mrOk;
end;

procedure TfrmEditor.ModuleValidateEventHandler(Sender: TObject; AInstance: TPersistent; APropInfo: PPropInfo;
  const AHandlerName: TLMDString; var ACancel: Boolean);
begin
  ShowMessage('ModuleValidateEventHandler: '+AHandlerName);
end;

procedure TfrmEditor.ModuleValidateEventHandlerName(Sender: TObject; const AName: TLMDString;
  var AIsValidName: Boolean);
begin
  //ShowMessage('ModuleValidateEventHandlerName: '+AName);
  dm.CreateMethod(AName, dm.Group.ActiveProject.ActiveFile.ChildFileASMId);
  //dm.CreateMethod(EventProc, Instance, pInfo, dm.Group.ActiveProject.ActiveFile.ChildFileASMId);
end;

procedure TfrmEditor.ModuleCompsModified(Sender: TObject);
begin
  Parse;
end;

procedure TfrmEditor.Parse(pf: TProjectFile = nil);
var
  formName: string;
  lst: TList;
begin
  if pf = nil then
    pf := FProjectFile;
//    if dm.Group.ActiveProject <> nil then
//      pf := dm.Group.ActiveProject.ActiveFile;

  if (pf <> nil) and (Selection.Count > 0) then
  begin
    lst := TList.Create;
    Selection.GetComps(lst);   // in case we want to loop thru each changed control
    pf.Modified := true;
    dm.Parse(designer.Module.Root, FRCFile);
    if designer.Module.Root.Name = '' then
    begin
      formName := TPath.GetFileNameWithoutExtension(pf.Name);
      designer.Module.Root.Name := formName;
    end;
  end;
end;

procedure TfrmEditor.ModuleEnsureEventHandlerSource(Sender: TObject; const AName, AOldName: TLMDString;
  AEventTypeInfo: PTypeInfo; AShowSource: Boolean; var AIsRenamed: Boolean);
begin
//  ShowMessage('ModuleEnsureEventHandlerSource: AName:'+AName+' AOldName:'+AOldName);
end;

procedure TfrmEditor.ModuleGetEventHandlerList(Sender: TObject; AEventTypeInfo: PTypeInfo; AResult: TStrings);
begin
//  ShowMessage('ModuleGetEventHandlerList');
end;

procedure TfrmEditor.ModuleGetEventHandlerName(Sender: TObject; AInstance: TPersistent; const AEventName: TLMDString;
  AEventTypeInfo: PTypeInfo; var AName: TLMDString);
begin
//  ShowMessage('ModuleGetEventHandlerName: '+AName);
  //dm.CreateMethod(EventProc, Instance, pInfo, dm.Group.ActiveProject.ActiveFile.ChildFileASMId);
end;

function TfrmEditor.DockPanel: TLMDDockPanel;
begin
  Result := Parent as TLMDDockPanel;
end;

procedure TfrmEditor.Release;
begin
  DockPanel.Release;
end;

procedure TfrmEditor.SelectRoot;
begin
  Selection.SetOne(Module.Root);
end;

end.
