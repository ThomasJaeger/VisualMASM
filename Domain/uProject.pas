unit uProject;

interface

uses
  SysUtils, Classes, uVisualMASMFile, uSharedGlobals, uProjectFile;

type
  PProject = ^TProject;
  TProject = class(TVisualMASMFile)
    private
      FProjectType: TProjectType;
      //FFiles: TDictionary<string, TProjectFile>;
      FFiles: TStringList;

      FPreAssembleEventCommandLine: string;
      FAssembleEventCommandLine: string;
      FPostAssembleEventCommandLine: string;

      FPreLinkEventCommandLine: string;
      FLinkEventCommandLine: string;
      FAdditionalLinkSwitches: string;
      FAdditionalLinkFiles: string;
      FPostLinkEventCommandLine: string;

      FLibraryPath: string;
      procedure Initialize;
      function GetProjectFile(Index: integer): TProjectFile;
      procedure SetProjectFile(Index: integer; const Value: TProjectFile);
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
      property LibraryPath: string read FLibraryPath write FLibraryPath;
      property PreAssembleEventCommandLine: string read FPreAssembleEventCommandLine write FPreAssembleEventCommandLine;
      property AssembleEventCommandLine: string read FAssembleEventCommandLine write FAssembleEventCommandLine;
      property PostAssembleEventCommandLine: string read FPostAssembleEventCommandLine write FPostAssembleEventCommandLine;
      property PreLinkEventCommandLine: string read FPreLinkEventCommandLine write FPreLinkEventCommandLine;
      property LinkEventCommandLine: string read FLinkEventCommandLine write FLinkEventCommandLine;
      property AdditionalLinkSwitches: string read FAdditionalLinkSwitches write FAdditionalLinkSwitches;
      property AdditionalLinkFiles: string read FAdditionalLinkFiles write FAdditionalLinkFiles;
      property PostLinkEventCommandLine: string read FPostLinkEventCommandLine write FPostLinkEventCommandLine;
      property ProjectType: TProjectType read FProjectType write FProjectType;
      property ProjectFiles: TStringList read FFiles write FFiles;
      property ProjectFile[Index: integer]: TProjectFile read GetProjectFile write SetProjectFile; default;
    published
      function GetProjectFileById(id: string): TProjectFile;
      procedure DeleteProjectFile(id: string);
  end;

implementation

procedure TProject.Initialize;
begin
  FProjectType := ptWin32;
  FFiles := TStringList.Create;
end;

constructor TProject.Create;
begin
  inherited Create;
  Initialize;
end;

constructor TProject.Create(name: string);
begin
  inherited Create(name);
  Initialize;
end;

function TProject.GetProjectFileById(id: string): TProjectFile;
var
  i: integer;
begin
  result := nil;
  if id = '' then exit;
  i:=FFiles.IndexOf(id);
  if i=-1 then exit;
  result := TProjectFile(FFiles.Objects[i]);
end;

procedure TProject.DeleteProjectFile(id: string);
var
  i: integer;
begin
  i:=FFiles.IndexOf(id);
  if i=-1 then exit;
  if id = '' then exit;
  FFiles.Delete(i);
  self.Modified := true;
end;

function TProject.GetProjectFile(Index: integer): TProjectFile;
begin
  result := TProjectFile(FFiles.Objects[Index]);
end;

procedure TProject.SetProjectFile(Index: integer; const Value: TProjectFile);
begin
  FFiles.Objects[Index] := Value;
end;

end.
