unit uFrmVideo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, acWebBrowser, ActiveX;

type
  TfrmVideo = class(TForm)
    browser: TsWebBrowser;
  private
    procedure LoadHtml(html: string);
  public
    procedure Why;
  end;

var
  frmVideo: TfrmVideo;

implementation

{$R *.dfm}

procedure TfrmVideo.LoadHtml(html: string);
begin
  browser.Navigate(html);
end;

procedure TfrmVideo.Why;
begin
  LoadHtml('http://www.youtube.com/v/GnaeTDGWEzA&hl=en_US&feature=player_embedded&version=3');
  Show;
end;

end.
