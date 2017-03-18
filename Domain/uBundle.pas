unit uBundle;

interface

uses
  SysUtils, Classes, uBaseFile, uSharedGlobals;

type
  PBundle = ^TBundle;
  TBundle = class(TBaseFile)
    private
      FDescription: string;
      FMASMFiles: TStringList;
      FSetupFile: string;
      FSetupFileSize: integer;
      FPackageDownloadFileName: string;
      procedure Initialize;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
      property Description: string read FDescription write FDescription;
      property MASMFiles: TStringList read FMASMFiles write FMASMFiles;
      property PackageDownloadFileName: string read FPackageDownloadFileName write FPackageDownloadFileName;
      property SetupFile: string read FSetupFile write FSetupFile;
      property SetupFileSize: integer read FSetupFileSize write FSetupFileSize;
  end;

implementation

procedure TBundle.Initialize;
begin
  FMASMFiles := TStringList.Create;
end;

constructor TBundle.Create;
begin
  inherited Create;
  Initialize;
end;

constructor TBundle.Create(name: string);
begin
  inherited Create(name);
  Initialize;
end;

end.
