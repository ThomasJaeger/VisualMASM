unit uLinker;

interface

uses
  SysUtils, Classes, uBaseFile, uSharedGlobals;

type
  PLinker = ^TLinker;
  TLinker = class(TBaseFile)
    private
      procedure Initialize;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
  end;

implementation

procedure TLinker.Initialize;
begin
  // init
end;

constructor TLinker.Create;
begin
  inherited Create;
  Initialize;
end;

constructor TLinker.Create(name: string);
begin
  inherited Create(name);
  Initialize;
end;

end.
 