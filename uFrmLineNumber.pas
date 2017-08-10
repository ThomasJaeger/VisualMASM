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
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGoToLineNumber: TfrmGoToLineNumber;

implementation

{$R *.dfm}

procedure TfrmGoToLineNumber.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if spnLine.Focused and (Key = #13) then
  begin
    Key := #0; // Cancels the keypress
    Perform(CM_DIALOGKEY, VK_RETURN, 0); // Invokes the default button
  end;
  if spnLine.Focused and (Key = #$1B) then
  begin
    Key := #0; // Cancels the keypress
    Perform(CM_DIALOGKEY, VK_ESCAPE, 0); // Invokes the cancel button
  end;
end;

procedure TfrmGoToLineNumber.FormShow(Sender: TObject);
begin
  spnLine.SelectAll;
end;

end.
