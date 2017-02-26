unit uFrmThemePreview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SynEdit, SynMemo, StdCtrls, sButton, ExtCtrls, sPanel,
  sSkinProvider, sSkinManager, SynEditHighlighter, SynHighlighterAsmMASM;

type
  TfrmThemePreview = class(TForm)
    sPanel1: TsPanel;
    sButton1: TsButton;
    sButton2: TsButton;
    SynMemo1: TSynMemo;
    PreviewManager: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    synASMMASM: TSynAsmMASMSyn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmThemePreview: TfrmThemePreview;

implementation

{$R *.dfm}

end.
