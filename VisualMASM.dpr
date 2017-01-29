program VisualMASM;

uses
  Vcl.Forms,
  uFrmMain in 'uFrmMain.pas' {frmMain},
  uDM in 'uDM.pas' {dm: TDataModule},
  uBaseFile in 'Domain\uBaseFile.pas',
  uBundle in 'Domain\uBundle.pas',
  uDomainObject in 'Domain\uDomainObject.pas',
  uGroup in 'Domain\uGroup.pas',
  uLinker in 'Domain\uLinker.pas',
  uML in 'Domain\uML.pas',
  uProject in 'Domain\uProject.pas',
  uProjectFile in 'Domain\uProjectFile.pas',
  uSharedGlobals in 'Domain\uSharedGlobals.pas',
  uTFile in 'Domain\uTFile.pas',
  uVisualMASM in 'Domain\uVisualMASM.pas',
  uVisualMASMFile in 'Domain\uVisualMASMFile.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'VisualMASM';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
