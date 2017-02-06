program WinApiImporter;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {frmMain},
  uTFile in '..\Domain\uTFile.pas',
  uSharedGlobals in '..\Domain\uSharedGlobals.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
