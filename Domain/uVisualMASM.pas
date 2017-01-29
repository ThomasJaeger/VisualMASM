unit uVisualMASM;

interface

uses
  SysUtils, Classes, uDomainObject, uSharedGlobals, uVisualMASMFile, uML;

type
  PVisualMASMOptions = ^TVisualMASMOptions;
  TVisualMASMOptions = class(TDomainObject)
    private
      FVersion: integer;
      FShowWelcomePage: boolean;
      FLasFilesUsedMax: integer;
      //FLastFilesUsed: TList<TVisualMASMFile>;
      FLastFilesUsed: TList;
      FML32: TML;
      FML64: TML;
      FML16: TML;
      procedure Initialize;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
      property Version: integer read FVersion write FVersion;
      property ShowWelcomePage: boolean read FShowWelcomePage write FShowWelcomePage;
      property LastFilesUsed: TList read FLastFilesUsed write FLastFilesUsed;
      property LasFilesUsedMax: integer read FLasFilesUsedMax write FLasFilesUsedMax;
      property ML32: TML read FML32 write FML32;
      property ML64: TML read FML64 write FML64;
      property ML16: TML read FML16 write FML16;
  end;

implementation

procedure TVisualMASMOptions.Initialize;
begin
  FShowWelcomePage := true;
  FVersion := 1;
  LasFilesUsedMax := 20;
  FLastFilesUsed := TList.Create;
  FML32 := TML.Create;
  FML64 := TML.Create;
  FML16 := TML.Create;
end;

constructor TVisualMASMOptions.Create;
begin
  inherited Create;
  Initialize;
end;

constructor TVisualMASMOptions.Create(name: string);
begin
  inherited Create(name);
  Initialize;
end;

end.
