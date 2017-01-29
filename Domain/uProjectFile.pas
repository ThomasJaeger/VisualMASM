unit uProjectFile;

interface

uses
  SysUtils, Classes, uSharedGlobals, uVisualMASMFile;

type
  PProjectFile = ^TProjectFile;
  TProjectFile = class(TVisualMASMFile)
    private
      FProjectFileType: TProjectFileType;
      FPath: string;
      FContent: string;
      FSizeInBytes: int64;
      FModified: boolean;
      FIsOpen: boolean;
      FAssembleFile: boolean;
      FAssemblyErrors: TStringList;
      procedure Initialize;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
      property ProjectFileType: TProjectFileType read FProjectFileType write FProjectFileType;
      property Content: string read FContent write FContent;
      property Path: string read FPath write FPath;
      property SizeInBytes: int64 read FSizeInBytes write FSizeInBytes;
      property IsOpen: boolean read FIsOpen write FIsOpen;
      property AssembleFile: boolean read FAssembleFile write FAssembleFile;
      property AssemblyErrors: TStringList read FAssemblyErrors write FAssemblyErrors; 
  end;

implementation

procedure TProjectFile.Initialize;
begin
  FProjectFileType := pftASM;
  FContent := '';
  FIsOpen := true;
  FAssembleFile := true;
  FAssemblyErrors := TStringList.Create;
end;

constructor TProjectFile.Create;
begin
  inherited Create;
  Initialize;
end;

constructor TProjectFile.Create(name: string);
begin
  inherited Create(name);
  Initialize;
end;

end.
