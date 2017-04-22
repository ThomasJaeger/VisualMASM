unit uProject;

interface

uses
  SysUtils, Classes, uVisualMASMFile, uSharedGlobals, uProjectFile, System.Generics.Collections,
  uTFile, uVisualMASMOptions;

type
  PProject = ^TProject;
  TProject = class(TVisualMASMFile)
    private
      FProjectType: TProjectType;
      FProjectFiles: TDictionary<string, TProjectFile>;
      FActiveFile: TProjectFile;

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
      function GetProjectFileById(Index: string): TProjectFile;
      procedure SetProjectFile(Index: string; const Value: TProjectFile);
      procedure SetActiveFile(projectFile: TProjectFile);
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
      property ProjectFiles: TDictionary<string, TProjectFile> read FProjectFiles;
      property ProjectFile[Index: string]: TProjectFile read GetProjectFileById write SetProjectFile; default;
      property ActiveFile: TProjectFile read FActiveFile write SetActiveFile;
    published
      procedure DeleteProjectFile(id: string);
      procedure AddFile(projectFile: TProjectFile);
      function CreateProjectFile(name: string; options: TVisualMASMOptions; fileType: TProjectFileType = pftASM): TProjectFile;
  end;

implementation

procedure TProject.Initialize;
begin
  FProjectType := ptWin32;
  FProjectFiles := TDictionary<string, TProjectFile>.Create;
  self.Modified := true;
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

function TProject.GetProjectFileById(Index: string): TProjectFile;
begin
  result := nil;
  if FProjectFiles.ContainsKey(Index) then
    result := FProjectFiles[Index];
end;

procedure TProject.DeleteProjectFile(id: string);
begin
  FProjectFiles.Remove(id);
  self.Modified := true;
end;

procedure TProject.SetProjectFile(Index: string; const Value: TProjectFile);
begin
  FProjectFiles[Index] := Value;
  self.Modified := true;
end;

procedure TProject.SetActiveFile(projectFile: TProjectFile);
begin
  FActiveFile := projectFile;
  //self.Modified := true;
end;

procedure TProject.AddFile(projectFile: TProjectFile);
begin
  if projectFile = nil then exit;
  if FProjectFiles.ContainsKey(projectFile.Id) then
    SetProjectFile(projectFile.Id, projectFile)
  else
    FProjectFiles.Add(projectFile.Id, projectFile);
  self.Modified := true;
end;

function TProject.CreateProjectFile(name: string; options: TVisualMASMOptions; fileType: TProjectFileType = pftASM): TProjectFile;
var
  projectFile: TProjectFile;
begin
  projectFile := TProjectFile.Create;
  projectFile.Name := name;

  // If we add a path, then the initial saving will not
  // prompt the user where to save it to since it checks
  // the Path property = ''
  //projectFile.Path := AppFolder;

  // Do not give it a filename because we want the user to enter a new
  // filename via Save As... prompt.
  //projectFile.FileName := AppFolder+name;

  projectFile.ProjectFileType := fileType;
  projectFile.IsOpen := true;
  projectFile.SizeInBytes := 0;
  projectFile.Modified := true;
  if (fileType = pftASM) or (fileType = pftRC) then
    projectFile.AssembleFile := true
  else
    projectFile.AssembleFile := false;

  case FProjectType of
    ptWin32:
      begin
        if fileType = pftASM then
          projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+WIN_32_BIT_EXE_MASM32_FILENAME);
      end;
    ptWin64:
      begin
        if fileType = pftASM then
          projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+WIN_64_BIT_EXE_WINSDK64_FILENAME);
      end;
    ptDos16COM:
      begin
        if fileType = pftASM then
          projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+DOS_16_BIT_COM_STUB_FILENAME);
      end;
    ptDos16EXE:
      begin
        if fileType = pftASM then
          projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+DOS_16_BIT_EXE_STUB_FILENAME);
      end;
  end;

  AddFile(projectFile);
  FActiveFile := projectFile;
  result := projectFile;
end;

end.
