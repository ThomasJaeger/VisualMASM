unit uFrmLineNumber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Vcl.Samples.Spin;

type
  TfrmGoToLineNumber = class(TForm)
    spnLine: TSpinEdit;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGoToLineNumber: TfrmGoToLineNumber;

implementation

{$R *.dfm}

end.
