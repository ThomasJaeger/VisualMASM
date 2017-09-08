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
    procedure MsgBoxApp;
    procedure DialogApp;
    procedure ConsoleApp;
    procedure DLLs;
    procedure Libraries;
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

procedure TfrmVideo.MsgBoxApp;
begin
  LoadHtml('http://www.youtube.com/v/JbptfOvADJg&hl=en_US&feature=player_embedded&version=3');
  Show;
end;

procedure TfrmVideo.DialogApp;
begin
  LoadHtml('http://www.youtube.com/v/sv_01giF8sg&hl=en_US&feature=player_embedded&version=3');
  Show;
end;

procedure TfrmVideo.ConsoleApp;
begin
  LoadHtml('http://www.youtube.com/v/eZQIrXMlUFk&hl=en_US&feature=player_embedded&version=3');
  Show;
end;

procedure TfrmVideo.DLLs;
begin
  LoadHtml('http://www.youtube.com/v/UmBttHXqBW0&hl=en_US&feature=player_embedded&version=3');
  Show;
end;

procedure TfrmVideo.Libraries;
begin
  LoadHtml('http://www.youtube.com/v/s2UjFGBY2bg&hl=en_US&feature=player_embedded&version=3');
  Show;
end;

end.
