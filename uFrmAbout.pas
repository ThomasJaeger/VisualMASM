unit uFrmAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls,
  StdCtrls, ImgList, uSharedGlobals, uFrmMain, Vcl.Imaging.pngimage;

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
    Label3: TLabel;
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
  //sWebLabel1.URL := VISUAL_MASM_WEBSITE_URL;
  imgLogo.Picture.LoadFromFile(logoFile);
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
