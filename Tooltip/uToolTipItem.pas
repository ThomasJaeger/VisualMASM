unit uToolTipItem;

interface

uses
  SysUtils, Classes;

type
  TToolTipItem = class(TObject)
    private
      FToken: string;
      FText: string;
    public
      constructor Create (token: string; text: string); overload;
      property Token: string read FToken write FToken;
      property Text: string read FText write FText;
    published
  end;

implementation

constructor TToolTipItem.Create (token: string; text: string);
begin
  FToken := token;
  FText := text;
end;

end.
