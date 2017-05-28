program VisualMASM;







{$R *.dres}

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
  uFrmAbout in 'uFrmAbout.pas' {frmAbout},
  uFrmRename in 'uFrmRename.pas' {frmRename},
  uDebugSupportPlugin in 'uDebugSupportPlugin.pas',
  dlgConfirmReplace in 'dlgConfirmReplace.pas' {ConfirmReplaceDialog},
  dlgSearchText in 'dlgSearchText.pas' {TextSearchDialog},
  dlgReplaceText in 'dlgReplaceText.pas' {TextReplaceDialog},
  uFrmLineNumber in 'uFrmLineNumber.pas' {frmGoToLineNumber},
  uFrmOptions in 'uFrmOptions.pas' {frmOptions},
  uFrmThemePreview in 'uFrmThemePreview.pas' {frmThemePreview},
  uFrmSetup in 'uFrmSetup.pas' {frmSetup},
  uFrmDownload in 'uFrmDownload.pas' {frmDownload},
  uFrmProjectOptions in 'uFrmProjectOptions.pas' {frmProjectOptions},
  uFraDesign in 'uFraDesign.pas' {fraDesign: TFrame},
  uVMButton in 'Controls\uVMButton.pas',
  uVMCheckBox in 'Controls\uVMCheckBox.pas',
  uVMComboBox in 'Controls\uVMComboBox.pas',
  uVMEdit in 'Controls\uVMEdit.pas',
  uVMLabel in 'Controls\uVMLabel.pas',
  uVMListBox in 'Controls\uVMListBox.pas',
  uVMListView in 'Controls\uVMListView.pas',
  uVMRadioButton in 'Controls\uVMRadioButton.pas',
  uVMGroupBox in 'Controls\uVMGroupBox.pas',
  uVMScrollBar in 'Controls\uVMScrollBar.pas',
  uDebugger in 'uDebugger.pas',
  uFrmVideo in 'uFrmVideo.pas' {frmVideo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'VisualMASM';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSetup, frmSetup);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmNewItems, frmNewItems);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmRename, frmRename);
  Application.CreateForm(TConfirmReplaceDialog, ConfirmReplaceDialog);
  Application.CreateForm(TfrmGoToLineNumber, frmGoToLineNumber);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.CreateForm(TfrmThemePreview, frmThemePreview);
  Application.CreateForm(TfrmDownload, frmDownload);
  Application.CreateForm(TfrmProjectOptions, frmProjectOptions);
  Application.CreateForm(TfrmVideo, frmVideo);
  Application.Run;
end.
