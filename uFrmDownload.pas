unit uFrmDownload;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, uSharedGlobals;

type
  TfrmDownload = class(TForm)
    ProgressBar1: TProgressBar;
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
