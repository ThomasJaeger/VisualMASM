unit uFrmVideo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, ActiveX;

type
  TfrmVideo = class(TForm)
    browser: TWebBrowser;
  private
    procedure LoadHtml(html: string);
  public
    procedure Why;
    procedure Setup;
    procedure HelloWorld;
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

procedure TfrmVideo.Setup;
begin
  LoadHtml('http://www.youtube.com/v/efEF3q42I6E&hl=en_US&feature=player_embedded&version=3');
  Show;
end;

procedure TfrmVideo.HelloWorld;
begin
  LoadHtml('http://www.youtube.com/v/KUFGB2HEY5M&hl=en_US&feature=player_embedded&version=3');
  Show;
end;

end.
