unit uGroup;

interface

uses
  SysUtils, Classes, uVisualMASMFile, uSharedGlobals, uProject, System.Generics.Collections,
  uProjectFile, uTFile, uVisualMASMOptions;

type
  PGroup = ^TGroup;
  TGroup = class(TVisualMASMFile)
    private
      FProjects: TDictionary<string,TPRoject>;
      FActiveProject: TProject;
      FLastFileOpenId: string;
      procedure Initialize;
      function GetProjectById(Index: string): TProject;
      procedure SetProjectById(Index: string; const Value: TProject);
      function GetProjectCount: integer;
      procedure SetActiveProject(project: TProject);
      function CreateProject(name: string; projectType: TProjectType = ptWin32): TProject;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
      property ProjectById[Index: string]: TProject read GetProjectById write SetProjectById; default;
      property ProjectCount: integer read GetProjectCount;
      property ActiveProject: TProject read FActiveProject write SetActiveProject;
      procedure DeleteProject(id: string);
      property LastFileOpenId: string read FLastFileOpenId write FLastFileOpenId;
      property Projects: TDictionary<string,TPRoject> read FProjects;
    published
      procedure AddProject(project: TProject);
      procedure CreateNewProject(projectType: TProjectType; options: TVisualMASMOptions);
      function GetProjectFileByIntId(intId: integer): TProjectFile;
      function GetProjectFileById(id: string): TProjectFile;
      function GetProjectByFileIntId(intId: integer): TProject;
  end;

implementation

procedure TGroup.Initialize;
begin
  FProjects := TDictionary<string,TPRoject>.Create;
end;

constructor TGroup.Create;
begin
  inherited Create;
  Initialize;
end;

constructor TGroup.Create(name: string);
begin
  inherited Create(name);
  Initialize;
end;

function TGroup.GetProjectById(Index: string): TProject;
begin
  result := nil;
  if Index = '' then exit;
  if FProjects.ContainsKey(Index) then
    result := FProjects[Index];
end;

procedure TGroup.SetProjectById(Index: string; const Value: TProject);
begin
  FProjects[Index] := Value;
  self.Modified := true;
end;

function TGroup.GetProjectCount: integer;
begin
  result:=FProjects.Count;
end;

procedure TGroup.AddProject(project: TProject);
begin
  if project = nil then exit;
  if FProjects.ContainsKey(project.Id) then
    SetProjectById(project.Id, project)
  else
    FProjects.Add(project.Id, project);
  self.Modified := true;
end;

procedure TGroup.DeleteProject(id: string);
begin
  FProjects.Remove(id);
  if FActiveProject.Id = id then
    FActiveProject := nil;
  self.Modified := true;
end;

procedure TGroup.SetActiveProject(project: TProject);
begin
  FActiveProject := project;
  //self.Modified := true;
end;

procedure TGroup.CreateNewProject(projectType: TProjectType; options: TVisualMASMOptions);
var
  project: TProject;
begin
  case projectType of
    ptWin32:
      begin
        project := CreateProject('Win32App.exe',projectType);
      end;
    ptWin32Con:
      begin
        project := CreateProject('Win32Con.exe',projectType);
      end;
    ptWin64:
      begin
        project := CreateProject('Win64App.exe',projectType);
      end;
    ptDos16COM:
      begin
        project := CreateProject('Program.com',projectType);
      end;
    ptDos16EXE:
      begin
        project := CreateProject('Program.exe',projectType);
      end;
  end;

  project.CreateProjectFile(DEFAULT_FILE_NAME, options);
  AddProject(project);
  SetActiveProject(project);
end;

function TGroup.CreateProject(name: string; projectType: TProjectType = ptWin32): TProject;
var
  project: TProject;
begin
  project := TProject.Create;
  project.Name := name;
  project.ProjectType := projectType;
  project.Modified := true;

  // Do not give it a filename because we want the user to enter a new
  // filename via Save As... prompt.
  //project.FileName := AppFolder+project.Name;

  result := project;
end;

function TGroup.GetProjectFileByIntId(intId: integer): TProjectFile;
var
  project: TProject;
  projectFile: TProjectFile;
begin
  result := nil;
  for project in FProjects.Values do
  begin
    for projectFile in project.ProjectFiles.Values do
    begin
      if projectFile.IntId = intId then
      begin
        result := projectFile;
        exit;
      end;
    end;
  end;
end;

function TGroup.GetProjectByFileIntId(intId: integer): TProject;
var
  project: TProject;
  projectFile: TProjectFile;
begin
  result := nil;
  for project in FProjects.Values do
  begin
    for projectFile in project.ProjectFiles.Values do
    begin
      if projectFile.IntId = intId then
      begin
        result := project;
        exit;
      end;
    end;
  end;
end;

function TGroup.GetProjectFileById(id: string): TProjectFile;
var
  project: TProject;
  projectFile: TProjectFile;
begin
  result := nil;
  for project in FProjects.Values do
  begin
    for projectFile in project.ProjectFiles.Values do
    begin
      if projectFile.Id = id then
      begin
        result := projectFile;
        exit;
      end;
    end;
  end;
end;

end.
