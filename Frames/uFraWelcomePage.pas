unit uFraWelcomePage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, sCheckBox,
  sLabel, ExtCtrls, sBevel, acImage;

type
  TfraWelcomePage = class(TFrame)
    sBevel1: TsBevel;
    sLabel1: TsLabel;
    sWebLabel2: TsWebLabel;
    sWebLabel3: TsWebLabel;
    sWebLabel1: TsWebLabel;
    lblCopyright: TsLabel;
    chkDoNotShowWelcomePage: TsCheckBox;
    sWebLabel4: TsWebLabel;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    sImage1: TsImage;
    sWebLabel5: TsWebLabel;
    procedure chkDoNotShowWelcomePageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  uFrmMain, uDM;

procedure TfraWelcomePage.chkDoNotShowWelcomePageClick(Sender: TObject);
begin
  dm.VisualMASMOptions.ShowWelcomePage := not chkDoNotShowWelcomePage.Checked;
end;

end.
