unit uVMButton;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls;

type
  vmButton = class(TButton)
  private

  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

// {$R VMBUTTON.RES}

constructor vmButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  Caption := 'Button';
//  ShowHint := true;
//  Hint := 'Button';
end;

procedure Register;
begin
  RegisterComponents('Standard', [vmButton]);
end;

end.
