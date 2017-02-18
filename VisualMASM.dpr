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
  uVisualMASMFile in 'Domain\uVisualMASMFile.pas',
  uHTML in 'Domain\uHTML.pas',
  uToolTip in 'Tooltip\uToolTip.pas',
  uToolTipDirectives in 'Tooltip\uToolTipDirectives.pas',
  uToolTipItem in 'Tooltip\uToolTipItem.pas',
  uToolTipMnemonics in 'Tooltip\uToolTipMnemonics.pas',
  uToolTipRegisters in 'Tooltip\uToolTipRegisters.pas',
  uFrmNewItems in 'uFrmNewItems.pas' {frmNewItems},
  uVisualMASMOptions in 'Domain\uVisualMASMOptions.pas',
  JsonDataObjects in 'JsonDataObjects.pas',
  uFraSetupDownloadOptions in 'Frames\uFraSetupDownloadOptions.pas' {fraDownloadOptions: TFrame},
  uFraSetupWelcome in 'Frames\uFraSetupWelcome.pas' {fraSetupWelcome: TFrame},
  uFraWelcomePage in 'Frames\uFraWelcomePage.pas' {fraWelcomePage: TFrame},
  uFrmAbout in 'uFrmAbout.pas' {frmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'VisualMASM';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmNewItems, frmNewItems);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
