unit uDomainObject;

interface

uses
  SysUtils, Classes, uSharedGlobals;

type
  PDomainObject = ^TDomainObject;
  TDomainObject = class(TPersistent)
    private
      FId: string;
      FName: string;
      FActive: boolean;
      FCreated: TDateTime;
      FLastUpdated: TDateTime;
      FChange: TChange;
      FIntId: integer;
      procedure Initialize;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
      function ToString: string; virtual;
      property Change: TChange read FChange write FChange;
      property Id: string read FId write FId;
      property Name: string read FName write FName;
      property Active: boolean read FActive write FActive;
      property Created: TDateTime read FCreated write FCreated;
      property LastUpdated: TDateTime read FLastUpdated write FLastUpdated;
      property IntId: integer read FIntId write FIntId;
  end;

implementation

procedure TDomainObject.Initialize;
var
  id: TGuid;
  i: integer;
begin
  CreateGUID(id);
  FId := GUIDToString(id);
  FId := copy(FId,2,36);   // Remove { and } characters
  FActive := true;
  FCreated := now;
  FLastUpdated := FCreated;
  //FChange := TChange.None;

  Randomize;
  FIntId := 1 + Random(MaxInt);
end;

constructor TDomainObject.Create;
begin
  inherited Create;
  Initialize;
end;

constructor TDomainObject.Create(Name: string);
begin
  inherited Create;
  Initialize;
  FName := Name;
end;

function TDomainObject.ToString: string;
begin
  Result := Name;
end;

end.
