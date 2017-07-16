unit uFrmAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls,
  StdCtrls, ImgList, uSharedGlobals, uFrmMain, Vcl.Imaging.pngimage, Winapi.Shellapi;

type
  TFileHashThread = class(TThread)
  private
    FFileName: string;
    FFileHash: string;
    procedure UpdateUI;
  protected
    procedure Execute; override;
  public
    constructor Create(fileName: string);
  end;

  TfrmAbout = class(TForm)
    imgLogo: TImage;
    btnClose: TButton;
    Label1: TLabel;
    lblVersion: TLabel;
    lblMD5: TLabel;
    lblCopyright: TLabel;
    lblWebsite: TLabel;
    Label2: TLabel;
    btnDonate: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDonateClick(Sender: TObject);
    procedure lblWebsiteMouseEnter(Sender: TObject);
    procedure lblWebsiteMouseLeave(Sender: TObject);
    procedure lblWebsiteClick(Sender: TObject);
  private
    FThreadsRunning: Integer;
    procedure ThreadDone(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

uses
  uDM;

constructor TFileHashThread.Create(fileName: string);
begin
  FFileName := fileName;
  FFileHash := '';
  FreeOnTerminate := True;
  inherited Create(False);
end;

procedure TFileHashThread.Execute;
begin
  FFileHash := MD5FileHash(FFileName);
  Synchronize(UpdateUI);
end;

procedure TfrmAbout.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmAbout.btnDonateClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', DONATE_URL, nil,  nil, SW_SHOWNORMAL);
end;

procedure TfrmAbout.FormShow(Sender: TObject);
begin
  //sWebLabel1.URL := VISUAL_MASM_WEBSITE_URL;
  imgLogo.Picture.LoadFromFile(logoFile);
  FThreadsRunning := 1;
  with TFileHashThread.Create(dm.VisualMASMOptions.AppFolder+VISUALMASM_FILENAME) do
    OnTerminate := ThreadDone;
  lblVersion.Caption := 'Version: '+VISUALMASM_VERSION_DISPLAY;
  lblCopyright.Caption := COPYRIGHT;
end;

procedure TfrmAbout.lblWebsiteClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', VISUAL_MASM_WEBSITE_URL, nil,  nil, SW_SHOWNORMAL);
end;

procedure TfrmAbout.lblWebsiteMouseEnter(Sender: TObject);
begin
  lblWebsite.Font.Style := [fsUnderline];
end;

procedure TfrmAbout.lblWebsiteMouseLeave(Sender: TObject);
begin
  lblWebsite.Font.Style := [];
end;

procedure TfrmAbout.ThreadDone(Sender: TObject);
begin
  Dec(FThreadsRunning);
  if FThreadsRunning = 0 then
  begin
    //StartBtn.Enabled := True;
  end;
end;

procedure TFileHashThread.UpdateUI;
begin
  frmAbout.lblMD5.Caption := 'MD5: '+FFileHash;
end;

end.
