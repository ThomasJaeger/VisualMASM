unit uFrmSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ComCtrls, ExtCtrls, uSharedGlobals, VirtualTrees, uML, uTFile, sevenzip, uBundle, Mask,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdSSLOpenSSL, Vcl.Buttons;

type
  TfrmSetup = class(TForm)
    pagTabs: TPageControl;
    tabWelcome: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    tabConfirmDownloadSources: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    pagFileLocations: TTabSheet;
    tabCompleted: TTabSheet;
    GroupBox5: TGroupBox;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    txtSDKIncludePath: TEdit;
    GroupBox3: TGroupBox;
    Label11: TLabel;
    SpeedButton10: TSpeedButton;
    Label12: TLabel;
    SpeedButton11: TSpeedButton;
    Label13: TLabel;
    SpeedButton12: TSpeedButton;
    Label14: TLabel;
    SpeedButton13: TSpeedButton;
    txtML32: TEdit;
    txtLink32: TEdit;
    txtRC32: TEdit;
    txtLIB32: TEdit;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    SpeedButton6: TSpeedButton;
    Label8: TLabel;
    SpeedButton7: TSpeedButton;
    Label9: TLabel;
    SpeedButton8: TSpeedButton;
    Label10: TLabel;
    SpeedButton9: TSpeedButton;
    txtML64: TEdit;
    txtLink64: TEdit;
    txtRC64: TEdit;
    txtLIB64: TEdit;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    SpeedButton3: TSpeedButton;
    Label5: TLabel;
    SpeedButton4: TSpeedButton;
    Label6: TLabel;
    SpeedButton5: TSpeedButton;
    txtML16: TEdit;
    txtLink16: TEdit;
    txtRC16: TEdit;
    txtLIB16: TEdit;
    opnFile: TOpenDialog;
    Label1: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    panBottom2: TPanel;
    btnBack: TButton;
    btnClose: TButton;
    btnNext: TButton;
    Label25: TLabel;
    Label26: TLabel;
    lstDownloadSources: TListBox;
    Label27: TLabel;
    ProgressBar1: TProgressBar;
    Label28: TLabel;
    treMASM: TTreeView;
    Label29: TLabel;
    optDownload: TRadioButton;
    optLocate: TRadioButton;
    gagDecompress: TProgressBar;
    Label30: TLabel;
    chkMASM32: TCheckBox;
    lblMASM32Description: TLabel;
    chkMicrosoftSDK: TCheckBox;
    lblMicrosofSDKDescription: TLabel;
    optx86: TRadioButton;
    optx64: TRadioButton;
    optItanium: TRadioButton;
    lblDownloadCurrentAction: TLabel;
    lblDownloading: TLabel;
    tabFileAssociations: TTabSheet;
    Label31: TLabel;
    GroupBox7: TGroupBox;
    chkASM: TCheckBox;
    chkINC: TCheckBox;
    chkRC: TCheckBox;
    Label32: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure pagTabsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure vstMASMGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure btnBackClick(Sender: TObject);
    procedure chkMicrosoftSDKClick(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure HttpsClientProgress(Sender: TObject; Total, Current: Int64;
      var Cancel: Boolean);
    procedure vstMASMGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
      var HintText: WideString);
    procedure treMASMMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure optDownloadClick(Sender: TObject);
    procedure optLocateClick(Sender: TObject);
    procedure txtML32ButtonClick(Sender: TObject);
    procedure treMASMChange(Sender: TObject; Node: TTreeNode);
    procedure txtLink32ButtonClick(Sender: TObject);
    procedure txtRC32ButtonClick(Sender: TObject);
    procedure txtML64ButtonClick(Sender: TObject);
    procedure txtLink64ButtonClick(Sender: TObject);
    procedure txtRC64ButtonClick(Sender: TObject);
    procedure txtML16ButtonClick(Sender: TObject);
    procedure txtLink16ButtonClick(Sender: TObject);
    procedure txtRC16ButtonClick(Sender: TObject);
    procedure txtLIB32ButtonClick(Sender: TObject);
    procedure txtLIB64ButtonClick(Sender: TObject);
    procedure txtLIB16ButtonClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure txtSDKIncludePathButtonClick(Sender: TObject);
  private
    lastHintNode : TTreeNode;
    FDownloadMASM: boolean;
    FCurrentPage: integer;
    FFoundMASMs: TStringList;
    FSelectedMASM: TML;
    FDownloadSize: int64;
    function MapMLtoFoundML(ml: TML; foundML: TML): TML;
    procedure LocateMASMs;
    procedure Downloading;
    procedure DownloadFile(bundle: TBundle);
    procedure DecompressBundles;
    procedure Next;
    function NodeHint(tn: TTreeNode): string;
    procedure ProcessCurrentPage;
    procedure SearchForPossibleFiles(path: string);
    procedure AssignFilesToFileLocations(ml: TML);
    procedure SaveFileLocations;
    procedure HttpWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure DownloadDotNet;
    procedure AssociateFiles;
  public
    { Public declarations }
  end;

var
  frmSetup: TfrmSetup;

implementation

{$R *.dfm}

uses
  uDM, uProject, uBaseFile, uFrmDownload, uDomainObject, uFrmMain;

function ProgressCallback(sender: Pointer; total: boolean; value: int64): HRESULT; stdcall;
begin
  if total then
    frmSetup.gagDecompress.Max := value
  else
    frmSetup.gagDecompress.Position := value;
  Result := S_OK;
  Application.ProcessMessages;
end;

procedure TfrmSetup.btnCancelClick(Sender: TObject);
begin
//  close;
end;

procedure TfrmSetup.btnNextClick(Sender: TObject);
begin
  Next;
end;

procedure TfrmSetup.Next;
begin
  if (FCurrentPage = 1) and (FDownloadMASM) then
  begin
    FCurrentPage := 2;
  end;

  if (FCurrentPage = 2) and (not FDownloadMASM) then
  begin
    FCurrentPage := 6;
  end;

  if FCurrentPage+1 <= pagTabs.PageCount-1 then
    inc(FCurrentPage)
  else
    FCurrentPage := pagTabs.PageCount-1;

  ProcessCurrentPage;

  btnBack.Visible := FCurrentPage > 0;
  pagTabs.ActivePageIndex := FCurrentPage;
  pagTabs.OnChange(self);

  if pagTabs.ActivePage = tabConfirmDownloadSources then
  begin
    lstDownloadSources.Clear;
    if chkMASM32.Checked then
      lstDownloadSources.AddItem(TBundle(dm.Bundles.Objects[0]).Name,dm.Bundles.Objects[0]);
    if chkMicrosoftSDK.Checked then
      lstDownloadSources.AddItem(TBundle(dm.Bundles.Objects[1]).Name,dm.Bundles.Objects[1]);
  end;
  
  if pagTabs.ActivePage = tabCompleted then
  begin
    btnNext.Visible := false;
    btnClose.Visible := true;
  end;
end;

procedure TfrmSetup.ProcessCurrentPage;
begin
  case FCurrentPage of
    7:
      begin
        if FSelectedMASM <> nil then
          AssignFilesToFileLocations(FSelectedMASM);
      end;
  end;
end;

procedure TfrmSetup.AssignFilesToFileLocations(ml: TML);
var
  path: string;
  x,i,y: integer;
  foundML: TML;
  bundle: TBundle;
  mlInBundle: TML;
begin
  txtML32.Text := ml.FoundFileName;
  path := ExtractFilePath(ml.FoundFileName);

  // 32-bit
  if FileExistsStripped(path+ml.Linker32Bit.OriginalFileName) then
    ml.Linker32Bit.FoundFileName := path+ml.Linker32Bit.OriginalFileName;
  if length(ml.Linker32Bit.FoundFileName)>0 then
    txtLink32.Text := ml.Linker32Bit.FoundFileName
  else
    txtLink32.Text := ml.Linker32Bit.OriginalFileName;

  if FileExistsStripped(path+ml.RC.OriginalFileName) then
    ml.RC.FoundFileName := path+ml.RC.OriginalFileName;
  if length(ml.RC.FoundFileName)>0 then
    txtRC32.Text := ml.RC.FoundFileName
  else
    txtRC32.Text := ml.RC.OriginalFileName;

  if FileExistsStripped(path+ml.LIB.OriginalFileName) then
    ml.LIB.FoundFileName := path+ml.LIB.OriginalFileName;
  if length(ml.LIB.FoundFileName)>0 then
    txtLIB32.Text := ml.LIB.FoundFileName
  else
    txtLIB32.Text := ml.LIB.OriginalFileName;

  // 64-bit
  for x := 0 to dm.Bundles.Count-1 do
  begin
    bundle := TBundle(dm.Bundles.Objects[x]);

    if pos('MASM32',bundle.Name)=0 then
    begin
      for y:=0 to bundle.MASMFiles.Count-1 do
      begin
        mlInBundle := TML(bundle.MASMFiles.Objects[y]);

        if mlInBundle.PlatformType = p64BitWinX86amd64 then
        begin
          for i := 0 to FFoundMASMs.Count-1 do
          begin
            foundML := TML(FFoundMASMs.Objects[i]);
            if foundML.PlatformType = p64BitWinX86amd64 then begin
              txtML64.Text := foundML.FoundFileName;
              txtLink64.Text := foundML.Linker32Bit.FoundFileName;
              txtRC64.Text := foundML.RC.FoundFileName;
              txtLIB64.Text := foundML.LIB.FoundFileName;
            end;
          end;
        end;
      end;
    end;
  end;

  // 16-bit
  if FileExistsStripped(path+ml.Linker16Bit.OriginalFileName) then
    ml.Linker16Bit.FoundFileName := path+ml.Linker16Bit.OriginalFileName;
  if length(ml.Linker16Bit.FoundFileName)>0 then
    txtLink16.Text := ml.Linker16Bit.FoundFileName
  else
    txtLink16.Text := ml.Linker16Bit.OriginalFileName;
end;

procedure TfrmSetup.FormCreate(Sender: TObject);
begin
  FDownloadMASM := true;
  FFoundMASMs := TStringList.Create;
end;

procedure TfrmSetup.FormShow(Sender: TObject);
var
  bundle: TBundle;
//  ml: TML;
begin
  FCurrentPage := 0;
  pagTabs.ActivePageIndex := FCurrentPage;
  //pagTabs.ActivePage := tabWelcome;
  btnNext.Visible := true;
  btnClose.Visible := false;

  bundle := TBundle(dm.Bundles.Objects[0]);
//  ml := TML(bundle.MASMFiles.Objects[0]);
  chkMASM32.Caption := bundle.ProductName;
  lblMASM32Description.Caption := bundle.Description;

  bundle := TBundle(dm.Bundles.Objects[1]);
  //ml := TML(bundle.Files.Objects[1]);
  chkMicrosoftSDK.Caption := bundle.ProductName;
  lblMicrosofSDKDescription.Caption := bundle.Description;
end;

procedure TfrmSetup.pagTabsChange(Sender: TObject);
begin
  case pagTabs.ActivePageIndex of
    2: LocateMASMs;
    5: Downloading;
    6:
      begin
        DecompressBundles;
        LocateMASMs;
      end;
  end;
end;

procedure TfrmSetup.LocateMASMs;
var
  path: string;
//  rootNode: PVirtualNode;
//  node: PVirtualNode;
//  childNode: PVirtualNode;
//  data: PGenericTreeData;
//  foundFiles: TStringlist;
//  fileOutput: TStringlist;
  i: Integer;
  ml: TML;
//  foundML: TML;
  vsDir: string;
  treeNode: TTreeNode;
  bundle: TBundle;
begin
  try
    Screen.Cursor := crHourGlass;

    FFoundMASMs.Clear;

    path := GetEnvVarValue('path');
    SearchForPossibleFiles(path);

    path := 'c:\masm32\bin\';
    SearchForPossibleFiles(path);

    path := 'C:\Program Files\Microsoft Visual Studio 10.0\VC\bin\';
    SearchForPossibleFiles(path);

    // Search Visual Studio bin folder
    vsDir := ReadRegistryValue('SOFTWARE\Wow6432Node\Microsoft\VisualStudio\10.0\','InstallDir');
    //  HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\Microsoft\\VisualStudio\\10.0\\

    // HKEY_LOCAL_MACHINE\\SOFTWARE  \\Microsoft\\VisualStudio\\10.0\\
    //vsDir := ReadRegistryValue('SOFTWARE\Microsoft\VisualStudio\10.0\','InstallDir');
    vsDir := ReadRegistryValue('SOFTWARE\Microsoft\VisualStudio\10.0\Setup\VC\','ProductDir');
    path := vsDir + 'bin\';
    SearchForPossibleFiles(path);

    path := path + 'x86_amd64\';
    SearchForPossibleFiles(path);

  //    rootNode := vstMASM.AddChild(nil);
  //    data := vstMASM.GetNodeData(rootNode);
  //    data^.Name := 'Root';

  //  vstMASM.BeginUpdate;
  //  for i := 0 to FFoundMASMs.Count-1 do
  //  begin
  //    ml:=TML(FFoundMASMs.Objects[i]);
  //
  //    node := vstMASM.AddChild(nil);
  //    data := vstMASM.GetNodeData(node);
  //    data^.Name := ml.ProductName;
  //    data^.FileName := ml.FoundFileName;
  //    data^.Level := 0;
  //
  //    if i = 0 then
  //      vstMASM.Selected[node] := true;
  //
  //    childNode := vstMASM.AddChild(node);
  //    data := vstMASM.GetNodeData(childNode);
  //    data^.Name := ml.ProductName;
  //    data^.FileName := ml.FoundFileName;
  //    data^.Level := 1;
  //
  //    vstMASM.Expanded[node] := true;
  //  end;
  //  vstMASM.EndUpdate;

    treMASM.Items.BeginUpdate;
    treMASM.Items.Clear;
    for i := 0 to FFoundMASMs.Count-1 do
    begin
      ml:=TML(FFoundMASMs.Objects[i]);

      treeNode := treMASM.Items.AddObject(nil, ml.ProductName, ml);

      bundle:=dm.GetBundle(ml.MD5Hash);
      if bundle <> nil then
        treMASM.Items.AddChild(treeNode, 'Bundle: '+bundle.Name);

      treMASM.Items.AddChild(treeNode, 'Platform: ' + dm.PlatformString(ml.PlatformType));
      treMASM.Items.AddChild(treeNode, ml.FoundFileName);
      if length(ml.Linker32Bit.FoundFileName) > 0 then
        treMASM.Items.AddChild(treeNode, ml.Linker32Bit.FoundFileName);
      if length(ml.Linker16Bit.FoundFileName) > 0 then
        treMASM.Items.AddChild(treeNode, ml.Linker16Bit.FoundFileName);
      if length(ml.RC.FoundFileName) > 0 then
        treMASM.Items.AddChild(treeNode, ml.RC.FoundFileName);
      if length(ml.LIB.FoundFileName) > 0 then
        treMASM.Items.AddChild(treeNode, ml.LIB.FoundFileName);

      if i = 0 then
        treeNode.Selected := true;
    end;
    treMASM.Items.EndUpdate;
    //treMASM.SetFocus;
  finally
    Screen.Cursor := crArrow;
  end;
end;

procedure TfrmSetup.SearchForPossibleFiles(path: string);
var
  foundFiles: TStringlist;
  i,x,y,bundleIndex: Integer;
  ml: TML;
  foundML: TML;
  foundDir: string;
  exists: bool;
  bundle: TBundle;
begin
  for bundleIndex:=0 to dm.Bundles.Count-1 do
  begin
    bundle := TBundle(dm.Bundles.Objects[bundleIndex]);
    for i:=0 to bundle.MASMFiles.Count-1 do
    begin
      ml:=TML(bundle.MASMFiles.Objects[i]);
      foundFiles := FileSearch(ml.OriginalFileName, path);
      for x := 0 to foundFiles.Count-1 do
      begin
        if MD5FileHash(foundFiles[x]) = ml.MD5Hash then
        begin
          foundML := TML.Create();
          foundML.FoundFileName := foundFiles[x];
          foundDir := ExtractFilePath(foundML.FoundFileName);
          if FileExistsStripped(foundDir+ml.Linker32Bit.OriginalFileName) then
            foundML.Linker32Bit.FoundFileName := foundDir+ml.Linker32Bit.OriginalFileName;
          if FileExistsStripped(foundDir+ml.Linker16Bit.OriginalFileName) then
            foundML.Linker16Bit.FoundFileName := foundDir+ml.Linker16Bit.OriginalFileName;
          if FileExistsStripped(foundDir+ml.RC.OriginalFileName) then
            foundML.RC.FoundFileName := foundDir+ml.RC.OriginalFileName;
          if FileExistsStripped(foundDir+ml.LIB.OriginalFileName) then
            foundML.LIB.FoundFileName := foundDir+ml.LIB.OriginalFileName;
          foundML.MD5Hash := MD5FileHash(foundML.FoundFileName);
          foundML := MapMLtoFoundML(ml, foundML);
          foundML.PlatformType := ml.PlatformType;

          // Make sure we don't add the same ML
          exists := false;
          for y:=0 to FFoundMASMs.Count-1 do
          begin
            if TML(FFoundMASMs.Objects[y]).MD5Hash = foundML.MD5Hash then
            begin
              exists := true;
              break;
            end;
          end;
          if exists = false then
            FFoundMASMs.AddObject(foundML.Id,foundML);
        end;
      end;
    end;
  end;
end;

function TfrmSetup.MapMLtoFoundML(ml: TML; foundML: TML): TML;
var
  i,bundleIndex: integer;
  bundle: TBundle;
begin
  result := foundML;
  for bundleIndex:=0 to dm.Bundles.Count-1 do
  begin
    bundle := TBundle(dm.Bundles.Objects[bundleIndex]);
    for i:=0 to bundle.MASMFiles.Count-1 do
    begin
      ml:=TML(bundle.MASMFiles.Objects[i]);
      if ml.MD5Hash=foundML.MD5Hash then
      begin
        foundML.PlatformType := ml.PlatformType;
        foundML.OriginalFileName := ml.OriginalFileName;
        foundML.DownloadURL := ml.DownloadURL;
        foundML.Copyright := ml.Copyright;
        foundML.WebSiteURL := ml.WebSiteURL;
        foundML.WebSiteName := ml.WebSiteName;
        foundML.ProductName := ml.ProductName;
        foundML.Linker32Bit.OriginalFileName := ml.Linker32Bit.OriginalFileName;
        foundML.Linker16Bit.OriginalFileName := ml.Linker16Bit.OriginalFileName;
        foundML.RC.OriginalFileName := ml.RC.OriginalFileName;
        foundML.LIB.OriginalFileName := ml.LIB.OriginalFileName;
        result := foundML;
        exit;
      end;
    end;
  end;
end;

procedure TfrmSetup.vstMASMGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGenericTreeData;
//  project: TProject;
  ml: TML;
begin
  Data := Sender.GetNodeData(Node);
  case Sender.GetNodeLevel(Node) of
    0: CellText := Data.Name;
    1: CellText := Data.FileName;
  end;
  case Column of
    0:   // Name column
      if Node.Parent = Sender.RootNode then
      begin
        // root nodes
        if (Node.Index = 0) and (dm.Group <> nil) then
        begin
          CellText := dm.Group.Name;
          if dm.Group.Modified then
            CellText := CellText+MODIFIED_CHAR;
        end else
          CellText := DEFAULT_PROJECTGROUP_NAME+MODIFIED_CHAR;
      end else begin
        case Sender.GetNodeLevel(Node) of
          0: CellText := Data.Name;
          1: CellText := Data.FileName;
          2:
            begin
              ml:=TML(FFoundMASMs.Objects[Node.Index]);
              CellText := ml.FoundFileName+' Level 2';
//              if (dm.Group = nil) or (data.ProjectId = '') then exit;
//              dm.Group.Projects.TryGetValue(data.ProjectId, project);
//              if project <> nil then
//              begin
//                CellText := project.Name;
//                if dm.Group.Projects[data.ProjectId].Modified then
//                  CellText := CellText+MODIFIED_CHAR;
//              end;
            end;
        end;
      end;
    1:  // Size column
      begin
//        if (dm.Group = nil) or (data.ProjectId = '') or (data.FileId = '') then exit;
//        dm.Group.Projects.TryGetValue(data.ProjectId, project);
//        if project <> nil then
//        begin
//          project.Files.TryGetValue(data.FileId, projectFile);
//          if projectFile <> nil then
//            CellText := dm.FormatByteSize(projectFile.SizeInBytes);
//        end;
      end;
  end;
end;

procedure TfrmSetup.btnBackClick(Sender: TObject);
begin
  if (FCurrentPage = 3) and (optDownload.Checked) then
  begin
    FCurrentPage := 2;
  end;

  if (FCurrentPage = 7) and (not FDownloadMASM) then
  begin
    FCurrentPage := 3;
  end;

  if FCurrentPage-1 >= 0 then
    dec(FCurrentPage)
  else
    FCurrentPage := 0;
  btnBack.Visible := FCurrentPage > 0;
  pagTabs.ActivePageIndex := FCurrentPage;
  pagTabs.OnChange(self);

  if pagTabs.ActivePage <> tabCompleted then
  begin
    btnNext.Visible := true;
    btnClose.Visible := false;
  end;
end;

procedure TfrmSetup.chkMicrosoftSDKClick(Sender: TObject);
begin
  optx86.Enabled := chkMicrosoftSDK.Checked;
  optx64.Enabled := chkMicrosoftSDK.Checked;
  optItanium.Enabled := chkMicrosoftSDK.Checked;
end;

procedure TfrmSetup.sButton1Click(Sender: TObject);
begin
  frmDownload.ShowModal;
end;

procedure TfrmSetup.HttpsClientProgress(Sender: TObject; Total,
  Current: Int64; var Cancel: Boolean);
begin
//  sGauge1.MaxValue := Total;
  ProgressBar1.Position := Current;
  Application.ProcessMessages;
end;

procedure TfrmSetup.Downloading;
var
//  error: string;
//  fs: TFileStream;
//  saveFileAs: string;
  bundle: TBundle;
//  ml: TML;
//  headers: TStringList;
begin
//  FCertificateValidator := certificateValidator;
//  MMLog := log;

//  FHttpsClient := TElHTTPSClient.Create(nil);
//  FHttpsClient.SSLEnabled := false;
//  FHttpsClient.UseHTTPProxy := False;
//  FHttpsClient.Versions := [sbSSL2,sbSSL3,sbTLS1];
//  FHttpsClient.UseSSLSessionResumption := false;
//  FHttpsClient.PreferKeepAlive := true;
//  headers := TStringList.Create;
//  FHttpsClient.RequestParameters.Authorization := 'Bearer '+accessToken.Token;
//  FHttpsClient.RequestParameters.ContentType := 'application/json';
//  FHttpsClient.SetRequestHeader('Content-Type', 'application/json');
//  FHttpsClient.SetRequestHeader('Authorization', 'Bearer '+accessToken.Token);
//  FHttpsClient.SetHeaderByName(headers, 'Content-Type', 'application/json');
//  FHttpsClient.SetHeaderByName(headers, 'Authorization', 'Bearer '+accessToken.Token);

//  FHttpsClient.OnCertificateValidate := HttpsClientCertificateValidate;
//  FHttpsClient.OnData := HttpsClientData;
//  FHttpsClient.OnSendData := HttpsClientSendData;
//  FHttpsClient.OnPreparedHeaders := HttpsClientPreparedHeaders;

  lblDownloadCurrentAction.Caption := '';
  lblDownloadCurrentAction.Update;

  if chkMASM32.Checked then
  begin
    bundle := TBundle(dm.Bundles.Objects[0]);
//    ml := TML(bundle.MASMFiles.Objects[0]);
    DownloadFile(bundle);
  end;

  if chkMicrosoftSDK.Checked then
  begin
    bundle := TBundle(dm.Bundles.Objects[1]);
    if MessageDlg(bundle.Name+' requires the .NET framework to be installed for some components. Download the .NET Framework?',
      mtInformation,[mbYes,mbNo], 0) = mrYes then
    begin
      DownloadDotNet;
    end;
//    ml := TML(bundle.MASMFiles.Objects[0]);
    DownloadFile(bundle);
  end;

  Next;
end;

procedure TfrmSetup.DownloadFile(bundle: TBundle);
var
  error: string;
  saveFileAs: string;
  Http: TIdHTTP;
  fs: TFileStream;
//  LHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  if not DirectoryExists(dm.VisualMASMOptions.AppFolder+DOWNLOAD_FOLDER) then
    ForceDirectories(dm.VisualMASMOptions.AppFolder+DOWNLOAD_FOLDER);

  saveFileAs := dm.VisualMASMOptions.AppFolder+DOWNLOAD_FOLDER+bundle.PackageDownloadFileName;

  if TFile.Exists(saveFileAs) then
  begin
    if MessageDlg(bundle.Name+' has already been dowloaded. Download again?',
      mtInformation,[mbYes,mbNo], 0) = mrNo then exit;
  end;

  FDownloadSize := bundle.SetupFileSize;
  ProgressBar1.Max := FDownloadSize;

  Update;
  lblDownloadCurrentAction.Caption := '';
  lblDownloadCurrentAction.Update;

  lblDownloading.Caption := bundle.ProductName;
  lblDownloading.Refresh;
  try
    fs := TFileStream.Create(saveFileAs, fmCreate);
    Http := TIdHTTP.Create(nil);
    Http.BeginWork(wmRead);
    try
      Http.OnWork:= HttpWork;
      Http.Get(bundle.DownloadURL, fs);
    finally
      fs.Free;
      Http.Free;
    end;

    if TFile.Exists(saveFileAs) then
    begin
      lblDownloadCurrentAction.Caption := 'Verifying file...one moment';
      lblDownloadCurrentAction.Refresh;
      if length(bundle.MD5Hash)>2 then
        if MD5FileHash(saveFileAs) <> bundle.MD5Hash then begin
          if MessageDlg('The downloaded file ' +saveFileAs+' appears to be corrupted. Delete file?',
            mtInformation,[mbYes,mbNo], 0) = mrYes then
            DeleteFile(saveFileAs);
        end;
      lblDownloadCurrentAction.Caption := 'Verifyied';
    end;
  except
    on E : Exception do
    begin
      error := E.Message;
    end;
  end;
end;

// http://chapmanworld.com/2015/06/08/elevated-privileges-for-delphi-applications/

// To not have top download the .net runtime, do this hack:
// http://stackoverflow.com/a/32322920/32453
//
// Microft f*cked us here by forcing this hack and not let the SDK 7.1 install
// correctly under Windows 10! F Microsoft!

procedure TfrmSetup.DownloadDotNet;
var
  error: string;
  saveFileAs,setupFile: string;
  Http: TIdHTTP;
  fs: TFileStream;
  LHandler: TIdSSLIOHandlerSocketOpenSSL;
  downloadAgain: boolean;
begin
  if not DirectoryExists(dm.VisualMASMOptions.AppFolder+DOWNLOAD_FOLDER) then
    ForceDirectories(dm.VisualMASMOptions.AppFolder+DOWNLOAD_FOLDER);

  saveFileAs := dm.VisualMASMOptions.AppFolder+DOWNLOAD_FOLDER+DOT_NET_URL_FILE;

  downloadAgain := true;
  if TFile.Exists(saveFileAs) then
  begin
    if MessageDlg('.NET has already been dowloaded. Download again?',
      mtInformation,[mbYes,mbNo], 0) = mrNo then downloadAgain := false;
  end;

  FDownloadSize := DOT_NET_URL_FILE_SIZE;
  ProgressBar1.Max := FDownloadSize;

  Update;

  if downloadAgain then
  begin
    lblDownloadCurrentAction.Caption := '';
    lblDownloadCurrentAction.Update;

    lblDownloading.Caption := 'Downloading .NET';
    lblDownloading.Refresh;
    try
      fs := TFileStream.Create(saveFileAs, fmCreate);
      Http := TIdHTTP.Create(nil);
      Http.BeginWork(wmRead);
      try
        Http.OnWork:= HttpWork;
        LHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
        Http.IOHandler := LHandler;
        Http.Get(DOT_NET_URL, fs);
      finally
        LHandler.Free;
        fs.Free;
        Http.Free;
      end;
    except
      on E : Exception do
      begin
        error := E.Message;
      end;
    end;
  end;

  if TFile.Exists(saveFileAs) then
  begin
    setupFile := dm.VisualMASMOptions.AppFolder+DOWNLOAD_FOLDER+DOT_NET_URL_FILE;
    ExecuteAndWait(setupFile);
  end;

end;

procedure TfrmSetup.DecompressBundles;
var
  fileName: string;
  setupFile: string;
  bundle: TBundle;
  //ml: TML;
begin
  if chkMASM32.Checked then
  begin
    bundle := TBundle(dm.Bundles.Objects[0]);
    //ml := TML(bundle.Files.Objects[0]);
    fileName := dm.VisualMASMOptions.AppFolder+DOWNLOAD_FOLDER+bundle.PackageDownloadFileName;
    if FileExistsStripped(fileName) then
    begin
      ShowMessage('Visual MASM will now decompress the MASM32 package.');
      Application.ProcessMessages;
      Update;
      with CreateInArchive(CLSID_CFormatZip) do
      begin
        SetProgressCallback(nil, ProgressCallback);
        OpenFile(fileName);
        ExtractTo(dm.VisualMASMOptions.AppFolder+DOWNLOAD_FOLDER+'masm32');
        setupFile := dm.VisualMASMOptions.AppFolder+DOWNLOAD_FOLDER+'masm32\'+bundle.SetupFile;
        if TFile.Exists(setupFile) then
        begin
          ShowMessage('Visual MASM will now run the setup program for '+CRLF+CRLF+
            bundle.Name+CRLF+CRLF+'as administrator. Windows might prompt you for admin privilages.'+CRLF+
            'When the setup is completed, Visual MASM will continue.');
          RunAsAdminAndWaitForCompletion(Handle, setupFile, '');
        end;
      end;
    end;
  end;

  if chkMicrosoftSDK.Checked then
  begin
    bundle := TBundle(dm.Bundles.Objects[1]);
    fileName := dm.VisualMASMOptions.AppFolder+DOWNLOAD_FOLDER+bundle.PackageDownloadFileName;
    if FileExistsStripped(fileName) then
    begin
      ShowMessage('Visual MASM will now decompress the MS SDK package.');
      TabSheet7.Update;
      Update;
      pagTabs.Update;
      Application.ProcessMessages;
      with CreateInArchive(CLSID_CFormatUdf) do
      begin
        SetProgressCallback(nil, ProgressCallback);
        OpenFile(fileName);
        ExtractTo(dm.VisualMASMOptions.AppFolder+DOWNLOAD_FOLDER+'MSSDK');
        setupFile := dm.VisualMASMOptions.AppFolder+DOWNLOAD_FOLDER+'MSSDK\'+bundle.SetupFile;
        if TFile.Exists(setupFile) then
        begin
          ShowMessage('Visual MASM will now run the setup program for '+CRLF+CRLF+
            bundle.Name+CRLF+CRLF+'as administrator. Windows might prompt you for admin privilages.'+CRLF+
            'When the setup is completed, Visual MASM will continue.');
          //RunAsAdminAndWaitForCompletion(Handle, setupFile, '');
          ExecuteAndWait(setupFile);
        end;
      end;
    end;
  end;
end;

procedure TfrmSetup.vstMASMGetHint(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex;
  var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: WideString);
begin
  HintText := 'Test Hint';
end;

procedure TfrmSetup.treMASMMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  tree: TTreeView;
  hoverNode: TTreeNode;
  hitTest : THitTests;
  //ht : THitTest;
begin
  if (Sender is TTreeView) then
    tree := TTreeView(Sender)
  else
    Exit;
  hoverNode := tree.GetNodeAt(X, Y);
  hitTest := tree.GetHitTestInfoAt(X, Y);

  (*   //list the hitTest values
  Caption := '';
  for ht in hitTest do
  begin
    Caption := Caption + GetEnumName(TypeInfo(THitTest), integer(ht)) + ', ';
  end;
  *)

  if (lastHintNode <> hoverNode) then
  begin
    Application.CancelHint;
    if (hitTest <= [htOnItem, htOnIcon, htOnLabel, htOnStateIcon]) then
    begin
      lastHintNode := hoverNode;
      tree.Hint := NodeHint(hoverNode);
    end;
  end;
end;

function TfrmSetup.NodeHint(tn: TTreeNode): string;
//var
//  bundle: TBundle;
//  ml: TML;
//  description: string;
begin
  if tn.Level = 0 then
  begin
    //bundle := TBundle(dm.Bundles.Objects[tn.AbsoluteIndex]);
    //ml := TML(bundle.Files.Objects[tn.AbsoluteIndex]);
    //result := 'Bundle: <b>'+bundle.Name+'</b><br>';
    //description := StringReplace(bundle.Description, CRLF, '<br>', [rfReplaceAll, rfIgnoreCase]);
    result := TML(treMASM.Items[tn.AbsoluteIndex].Data).FoundFileName + '<br>';
    result := result + TML(treMASM.Items[tn.AbsoluteIndex].Data).Copyright;
    //result := result + description;
  end;
end;

procedure TfrmSetup.optDownloadClick(Sender: TObject);
begin
  FDownloadMASM := optDownload.Checked;
end;

procedure TfrmSetup.optLocateClick(Sender: TObject);
begin
  FDownloadMASM := not optLocate.Checked;
end;

procedure TfrmSetup.txtML32ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('ML.EXE',txtML32);
end;

procedure TfrmSetup.treMASMChange(Sender: TObject; Node: TTreeNode);
begin
  if Node.Level = 0 then
    FSelectedMASM := TML(Node.Data);
  if Node.Level = 1 then
    FSelectedMASM := TML(Node.Parent.Data);
//  FSelectedMASM := TML(treMASM.Selected.Data);
end;

procedure TfrmSetup.txtLink32ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LINK.EXE',txtLink32);
end;

procedure TfrmSetup.txtRC32ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('RC.EXE',txtRC32);
end;

procedure TfrmSetup.txtML64ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('ML64.EXE',txtML64);
end;

procedure TfrmSetup.txtLink64ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LINK.EXE',txtLink64);
end;

procedure TfrmSetup.txtRC64ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('RC.EXE',txtRC64);
end;

procedure TfrmSetup.txtSDKIncludePathButtonClick(Sender: TObject);
begin
  dm.PromptForPath('Microsoft SDK Include Path',txtSDKIncludePath);
end;

procedure TfrmSetup.txtML16ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('ML.EXE',txtML16);
end;

procedure TfrmSetup.txtLink16ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LINK.EXE',txtLink16);
end;

procedure TfrmSetup.txtRC16ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('RC.EXE',txtRC16);
end;

procedure TfrmSetup.txtLIB32ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LIB.EXE',txtLIB32);
end;

procedure TfrmSetup.txtLIB64ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LIB.EXE',txtLIB64);
end;

procedure TfrmSetup.txtLIB16ButtonClick(Sender: TObject);
begin
  dm.PromptForFile('LIB.EXE',txtLIB16);
end;

procedure TfrmSetup.SaveFileLocations;
begin
  if length(txtML32.Text) > 0 then
    dm.VisualMASMOptions.ML32.FoundFileName := txtML32.Text;
  if length(txtLink32.Text) > 0 then
    dm.VisualMASMOptions.ML32.Linker32Bit.FoundFileName := txtLink32.Text;
  if length(txtLIB32.Text) > 0 then
    dm.VisualMASMOptions.ML32.LIB.FoundFileName := txtLIB32.Text;
  if length(txtRC32.Text) > 0 then
    dm.VisualMASMOptions.ML32.RC.FoundFileName := txtRC32.Text;

//  if length(txtML64.Text) > 0 then
    dm.VisualMASMOptions.ML64.FoundFileName := txtML64.Text;
//  if length(txtLink64.Text) > 0 then
    dm.VisualMASMOptions.ML64.Linker32Bit.FoundFileName := txtLink64.Text;
//  if length(txtLIB64.Text) > 0 then
    dm.VisualMASMOptions.ML64.LIB.FoundFileName := txtLIB64.Text;
//  if length(txtRC64.Text) > 0 then
    dm.VisualMASMOptions.ML64.RC.FoundFileName := txtRC64.Text;

  if length(txtML16.Text) > 0 then
    dm.VisualMASMOptions.ML16.FoundFileName := txtML16.Text;
  if length(txtLink16.Text) > 0 then
    dm.VisualMASMOptions.ML16.Linker16Bit.FoundFileName := txtLink16.Text;
  if length(txtLIB16.Text) > 0 then
    dm.VisualMASMOptions.ML16.LIB.FoundFileName := txtLIB16.Text;
  if length(txtRC16.Text) > 0 then
    dm.VisualMASMOptions.ML16.RC.FoundFileName := txtRC16.Text;

  dm.VisualMASMOptions.SaveFile;
end;

procedure TfrmSetup.btnCloseClick(Sender: TObject);
begin
  SaveFileLocations;
  AssociateFiles;
  Close;
end;

procedure TfrmSetup.HttpWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  with ASender as TIdHTTP do
  begin
    ProgressBar1.Position := AWorkCount;
  end;
end;

procedure TfrmSetup.AssociateFiles;
begin
  if chkASM.Checked then
    RegisterFileType(pftASM);
  if chkINC.Checked then
    RegisterFileType(pftINC);
  if chkRC.Checked then
    RegisterFileType(pftRC);
end;

end.
