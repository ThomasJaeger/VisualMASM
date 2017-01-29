unit uTheme;

interface

uses
  SysUtils, Classes, uSharedGlobals, uDomainObject, Graphics;

type
  TTheme = class(TDomainObject)
    private
      FASMSymbolAttriFG: TColor;
      FApiFG: TColor;
      FCommentFG: TColor;
      FCommentStyle: TFontStyles;
      FDirectivesFG: TColor;
      FDirectivesStyle: TFontStyles;
      FIdentifierFG: TColor;
      FKeyFG: TColor;
      FKeyStyle: TFontStyles;
      FNumberFG: TColor;
      FRegisterFG: TColor;
      FRegisterStyle: TFontStyles;
      FStringFG: TColor;
      FSymbolFG: TColor;
      procedure Initialize;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
      property ASMSymbolAttriFG: TColor read FASMSymbolAttriFG write FASMSymbolAttriFG;
      property ApiFG: TColor read FApiFG write FApiFG;
      property CommentFG: TColor read FCommentFG write FCommentFG;
      property CommentStyle: TFontStyles read FCommentStyle write FCommentStyle;
      property DirectivesFG: TColor read FDirectivesFG write FDirectivesFG;
      property DirectivesStyle: TFontStyles read FDirectivesStyle write FDirectivesStyle;
      property IdentifierFG: TColor read FIdentifierFG write FIdentifierFG;
      property KeyFG: TColor read FKeyFG write FKeyFG;
      property KeyStyle: TFontStyles read FKeyStyle write FKeyStyle;
      property NumberFG: TColor read FNumberFG write FNumberFG;
      property RegisterFG: TColor read FRegisterFG write FRegisterFG;
      property RegisterStyle: TFontStyles read FRegisterStyle write FRegisterStyle;
      property StringFG: TColor read FStringFG write FStringFG;
      property SymbolFG: TColor read FSymbolFG write FSymbolFG;
  end;

implementation

procedure TTheme.Initialize;
begin
  FASMSymbolAttriFG := $008CFF;
  FApiFG := clYellow;
  FCommentFG := $00949494;
  FCommentStyle := [fsItalic];
  FDirectivesFG := $00008CFF;
  FDirectivesStyle := [];
  FIdentifierFG := $00FFB76F;
  FKeyFG := clSkyBlue;
  FKeyStyle := [fsBold];
  FNumberFG := $008080FF;
  FRegisterFG := $0032CD32;
  FRegisterStyle := [fsBold];
  FStringFG := clMoneyGreen;
  FSymbolFG := clFuchsia;
end;

constructor TTheme.Create;
begin
  inherited Create;
  Initialize;
end;

constructor TTheme.Create(name: string);
begin
  inherited Create(name);
  Initialize;
end;

end.
 