unit uVisualMASMFile;

interface

uses
  SysUtils, Classes, uDomainObject;

type
  PVisualMASMFile = ^TVisualMASMFile;
  TVisualMASMFile = class(TDomainObject)
    private
      FModified: boolean;
      procedure Initialize;
    protected
      FFileName: string;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
      property FileName: string read FFileName write FFileName;
      property Modified: boolean read FModified write FModified;
  end;

implementation

procedure TVisualMASMFile.Initialize;
begin
  FModified := false;
end;

constructor TVisualMASMFile.Create;
begin
  inherited Create;
  Initialize;
end;

constructor TVisualMASMFile.Create(name: string);
begin
  inherited Create(name);
  Initialize;
end;

end.
