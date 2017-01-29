unit uHTML;

interface

uses
  Windows, Classes, Menus, ActnList, SysUtils, ShellApi, Forms, Registry,
  WinTypes, GraphUtil, Graphics;

const
  U: string = '<u>';
  U_E: string = '</u>';
  BR: string = '<br>';
  BR2: string = '<br><br>';
  BOLD: string = '<b>';
  BOLD_E: string = '</b>';
  FONT_E: string = '</font>';
  DIRECTIVE_COLOR: string = '#FF8C00';  // Orangeish
  REGISTER_COLOR: string = '#32CD32';   // Greenish
  MNEMONICS_COLOR: string = '#A6CAF0';   // Blueish
  TOKEN_TITLE_FONT_SIZE = 12;
  SUBTITLE_FONT_SIZE = 10;
  REGULAR_FONT_SIZE = 9;
  TAB: string = '     ';
  INDENT: string = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
  TABLE_CONTENT: string = '<font face="courier new" size=';
  FONT_NORMAL: string = '<font face="Tahoma" size=9>';

function TokenTitle(token: string; restOfLine: string = ''): string;
function TitleRegister(token: string; restOfLine: string = ''): string;
function TitleMnemonic(token: string; restOfLine: string = ''): string;
function TokenOnly(token: string): string;
function SubTitle(subtitle: string): string;
function TableHeader(header: string): string;
function Table(content: string): string;
function Usage(text: string): string;

implementation

function TokenTitle(token: string; restOfLine: string = ''): string;
begin
  result := BOLD+'<font face="courier new" color="'+DIRECTIVE_COLOR+'" size='+
    inttostr(TOKEN_TITLE_FONT_SIZE)+'>'+
    token+FONT_E+Usage(restOfLine)+FONT_E+BOLD_E+FONT_NORMAL;
end;

function TokenOnly(token: string): string;
begin
  result := BOLD+'<font face="courier new" color="'+DIRECTIVE_COLOR+'" size='+
    inttostr(TOKEN_TITLE_FONT_SIZE)+'>'+
    token+FONT_E+BOLD_E+FONT_NORMAL;
end;

function TitleRegister(token: string; restOfLine: string = ''): string;
begin
  result := BOLD+'<font face="courier new" color="'+REGISTER_COLOR+'" size='+
    inttostr(TOKEN_TITLE_FONT_SIZE)+'>'+
    token+FONT_E+Usage(restOfLine)+FONT_E+BOLD_E+FONT_NORMAL;
end;

function TitleMnemonic(token: string; restOfLine: string = ''): string;
begin
  result := BOLD+'<font face="courier new" color="'+MNEMONICS_COLOR+'" size='+
    inttostr(TOKEN_TITLE_FONT_SIZE)+'>'+
    token+FONT_E+Usage(restOfLine)+FONT_E+BOLD_E+FONT_NORMAL;
end;

function Usage(text: string): string;
begin
  result := '<font face="courier new" color="white" size='+inttostr(TOKEN_TITLE_FONT_SIZE)+'> '+
    text+
    FONT_E+BOLD_E+BR;
end;

function SubTitle(subtitle: string): string;
begin
  result := '<font size='+inttostr(SUBTITLE_FONT_SIZE)+'>'+BOLD+U+
    subtitle+
    BOLD_E+U_E+FONT_E+BR;
end;

function TableHeader(header: string): string;
begin
  result := TABLE_CONTENT + inttostr(REGULAR_FONT_SIZE+1)+'><u>'+
    header +
    '</u>'+BR;
end;

function Table(content: string): string;
begin
  result := TABLE_CONTENT + inttostr(REGULAR_FONT_SIZE+1)+'>'+ content + BR;
end;

end.
