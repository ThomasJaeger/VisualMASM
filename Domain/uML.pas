unit uML;

interface

uses
  SysUtils, Classes, uBaseFile, uSharedGlobals, uLinker;

type
  PML = ^TML;
  TML = class(TBaseFile)
    private
      FLinker32Bit: TLinker;
      FLinker16Bit: TLinker;
      FRC: TBaseFile;
      FLIB: TBaseFile;
      procedure Initialize;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
      property Linker32Bit: TLinker read FLinker32Bit write FLinker32Bit;
      property Linker16Bit: TLinker read FLinker16Bit write FLinker16Bit;
      property RC: TBaseFile read FRC write FRC;
      property LIB: TBaseFile read FLIB write FLIB;
  end;

implementation

procedure TML.Initialize;
begin
  FLinker32Bit := TLinker.Create;
  FLinker16Bit := TLinker.Create;
  FRC := TBaseFile.Create;
  FLIB := TBaseFile.Create;
end;

constructor TML.Create;
begin
  inherited Create;
  Initialize;
end;

constructor TML.Create(name: string);
begin
  inherited Create(name);
  Initialize;
end;

end.
