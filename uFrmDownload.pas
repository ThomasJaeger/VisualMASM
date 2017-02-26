unit uFrmDownload;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, sButton, ComCtrls, acProgressBar, uSharedGlobals, sGauge;

type
  TfrmDownload = class(TForm)
    sGauge1: TsGauge;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDownload: TfrmDownload;

implementation

{$R *.dfm}

end.
