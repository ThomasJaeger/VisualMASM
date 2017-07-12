unit uToolTip;

interface

uses
  Windows, Classes, Menus, ActnList, SysUtils, ShellApi, Forms, Registry,
  WinTypes, GraphUtil, Graphics, uHTML, uToolTipItem;

type
  TToolTip = class(TObject)
    private
      FName: string;
      FIntId: integer;
      procedure Initialize;
    protected
      FList: TStringList;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
      function ToString: string; virtual;
      function GetToolTip(token: string): TToolTipItem;
      function Exists(token: string): boolean;
      property Name: string read FName write FName;
      property IntId: integer read FIntId write FIntId;
      property List: TStringList read FList write FList;
  end;

implementation

procedure TToolTip.Initialize;
begin
  Randomize;
  FIntId := 1 + Random(MaxInt);
  FList := TStringList.Create;
end;

constructor TToolTip.Create;
begin
  inherited Create;
  Initialize;
end;

constructor TToolTip.Create(Name: string);
begin
  inherited Create;
  Initialize;
  FName := Name;
end;

function TToolTip.ToString: string;
begin
  Result := Name;
end;

function TToolTip.Exists(token: string): boolean;
begin
  result := FList.IndexOf(token) >-1;
end;

function TToolTip.GetToolTip(token: string): TToolTipItem;
begin
//  if Exists(token) then
    result := TToolTipItem(FList.Objects[FList.IndexOf(token)]);
end;

end.
