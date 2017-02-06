unit uFraSetupDownloadOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, sRadioButton, sLabel, sCheckBox;

type
  TfraDownloadOptions = class(TFrame)
    chkMASM32: TsCheckBox;
    sLabel2: TsLabel;
    sWebLabel1: TsWebLabel;
    chkMicrosoftSDK: TsCheckBox;
    sLabel4: TsLabel;
    sWebLabel2: TsWebLabel;
    optx86: TsRadioButton;
    optx64: TsRadioButton;
    optItanium: TsRadioButton;
    sLabel3: TsLabel;
    procedure chkMicrosoftSDKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfraDownloadOptions.chkMicrosoftSDKClick(Sender: TObject);
begin
  optx86.Enabled := chkMicrosoftSDK.Checked;
  optx64.Enabled := chkMicrosoftSDK.Checked;
  optItanium.Enabled := chkMicrosoftSDK.Checked;
end;

end.
