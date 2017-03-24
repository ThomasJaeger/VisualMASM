unit uVMListView;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ComCtrls;

type
  vmListView = class(TListView)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Standard', [vmListView]);
end;

end.
