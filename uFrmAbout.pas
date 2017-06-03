unit uFrmAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, sButton, sLabel, ImgList,
  acAlphaImageList, acImage, uSharedGlobals, uFrmMain;

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
    sLabel1: TsLabel;
    btnClose: TsButton;
    lblVersion: TsLabel;
    lblCopyright: TsLabel;
    sWebLabel1: TsWebLabel;
    sImage1: TsImage;
    lblMD5: TsLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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

procedure TfrmAbout.FormShow(Sender: TObject);
begin
  sWebLabel1.URL := VISUAL_MASM_WEBSITE_URL;
  FThreadsRunning := 1;
  with TFileHashThread.Create(dm.VisualMASMOptions.AppFolder+VISUALMASM_FILENAME) do
    OnTerminate := ThreadDone;
  lblVersion.Caption := 'Version: '+VISUALMASM_VERSION_DISPLAY;
  lblCopyright.Caption := COPYRIGHT;
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
