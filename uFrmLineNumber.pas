unit uFrmLineNumber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, sLabel, sButton, sEdit, sSpinEdit;

type
  TfrmGoToLineNumber = class(TForm)
    sLabel1: TsLabel;
    spnLine: TsSpinEdit;
    sButton1: TsButton;
    sButton2: TsButton;
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
