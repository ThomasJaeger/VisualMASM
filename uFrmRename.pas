unit uFrmRename;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmRename = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    txtCurrentName: TEdit;
    txtNewName: TEdit;
    btnCancel: TButton;
    btnRename: TButton;
    procedure FormShow(Sender: TObject);
  private
    FCurrentName: string;
    FNewName: string;
  public
    property CurrentName: string read FCurrentName write FCurrentName;
    property NewName: string read FNewName write FNewName;
  end;

var
  frmRename: TfrmRename;

implementation

{$R *.dfm}

procedure TfrmRename.FormShow(Sender: TObject);
begin
  txtCurrentName.Text := FCurrentName;
  txtNewName.Text := FNewName;

  txtNewName.SetFocus;
end;

end.
