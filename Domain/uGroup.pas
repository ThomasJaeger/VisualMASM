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
      FBuildOrder: TList<string>;
      FDisplayOrder: TList<string>;
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
      property BuildOrder: TList<string> read FBuildOrder write FBuildOrder;
      property DisplayOrder: TList<string> read FDisplayOrder write FDisplayOrder;
    published
      procedure AddProject(project: TProject);
      function CreateNewProject(projectType: TProjectType; options: TVisualMASMOptions): TProject;
      function GetProjectFileByIntId(intId: integer): TProjectFile;
      function GetProjectFileById(id: string): TProjectFile;
      function GetProjectByFileIntId(intId: integer): TProject;
      function GetProjectByIntId(intId: integer): TProject;
      function GetProjectByFileId(id: string): TProject;
      function GetBuildOrderForProject(id: string): integer;
  end;

implementation

procedure TGroup.Initialize;
begin
  FProjects := TDictionary<string,TPRoject>.Create;
  FBuildOrder := TList<string>.Create;
  FDisplayOrder := TList<string>.Create;
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
  else begin
    FProjects.Add(project.Id, project);
    FBuildOrder.Add(project.Id);
    FDisplayOrder.Add(project.Id);
  end;
  self.Modified := true;
end;

procedure TGroup.DeleteProject(id: string);
var
  project: TProject;
begin
  FProjects.Remove(id);
  FBuildOrder.Remove(id);
  FDisplayOrder.Remove(id);
  if FActiveProject.Id = id then
    FActiveProject := nil;
  self.Modified := true;
end;

procedure TGroup.SetActiveProject(project: TProject);
begin
  FActiveProject := project;
  //self.Modified := true;
end;

function TGroup.CreateNewProject(projectType: TProjectType; options: TVisualMASMOptions): TProject;
var
  project: TProject;
begin
  result := nil;

  case projectType of
    ptWin32:
      begin
        project := CreateProject('Win32App.exe',projectType);
        project.CreateProjectFile(WIN_MANIFEST_FILENAME, options, pftManifest);
        project.CreateProjectFile(WIN_RESOURCE_FILENAME, options, pftRC);
        project.CreateProjectFile(DEFAULT_FILE_NAME, options);
      end;
    ptWin32Dlg:
      begin
        project := CreateProject('Win32AppDlg.exe',projectType);
        project.CreateProjectFile(DEFAULT_FILE_NAME, options);
        project.CreateProjectFile(WIN_MANIFEST_FILENAME, options, pftManifest);
        project.CreateProjectFile('', options, pftDLG);
      end;
    ptWin32Con:
      begin
        project := CreateProject('Win32Con.exe',projectType);
        project.CreateProjectFile(DEFAULT_FILE_NAME, options);
      end;
    ptWin64:
      begin
        project := CreateProject('Win64App.exe',projectType);
        project.CreateProjectFile(WIN_MANIFEST_FILENAME, options, pftManifest);
        project.CreateProjectFile(WIN_RESOURCE_FILENAME, options, pftRC);
        project.CreateProjectFile(DEFAULT_FILE_NAME, options);
      end;
    ptDos16COM:
      begin
        project := CreateProject('Program.com',projectType);
        project.CreateProjectFile(DEFAULT_FILE_NAME, options);
      end;
    ptDos16EXE:
      begin
        project := CreateProject('Program.exe',projectType);
        project.CreateProjectFile(DEFAULT_FILE_NAME, options);
      end;
    ptLib:
      begin
        project := CreateProject('MyLibrary.lib',projectType);
        project.CreateProjectFile('readme.txt', options, pftTXT);
      end;
    ptWin32DLL:
      begin
        project := CreateProject('Win32.dll',projectType);
        project.CreateProjectFile(WIN_DLL_MODULE_FILENAME, options, pftDef);
        project.CreateProjectFile(DEFAULT_FILE_NAME, options);
      end;
    ptWin64DLL:
      begin
        project := CreateProject('Win64.dll',projectType);
        project.CreateProjectFile(WIN_DLL_MODULE_FILENAME, options, pftDef);
        project.CreateProjectFile(DEFAULT_FILE_NAME, options);
      end;
    ptWin16DLL:
      begin
        project := CreateProject('Win16.dll',projectType);
        project.CreateProjectFile(WIN_DLL_MODULE_FILENAME, options, pftDef);
        project.CreateProjectFile(DEFAULT_FILE_NAME, options);
      end;
    ptWin16:
      begin
        project := CreateProject('Win16App.exe',projectType);
        project.CreateProjectFile(DEFAULT_FILE_NAME, options);
      end;
  end;

  AddProject(project);
  SetActiveProject(project);
  result := project;
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

function TGroup.GetProjectByFileId(id: string): TProject;
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
        result := project;
        exit;
      end;
    end;
  end;
end;

function TGroup.GetProjectByIntId(intId: integer): TProject;
var
  project: TProject;
  projectFile: TProjectFile;
begin
  result := nil;
  for project in FProjects.Values do
  begin
    if project.IntId = intId then
    begin
      result := project;
      exit;
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
      if (projectFile.ChildFileASMId = id) or (projectFile.ChildFileRCId = id) then
      begin
        result := project.ProjectFile[id];
        exit;
      end;
    end;
  end;
end;

function TGroup.GetBuildOrderForProject(id: string): integer;
var
  projectId: string;
  i: integer;
begin
  result := 0;
  if id = '' then exit;
  for i := 0 to FBuildorder.Count-1 do
  begin
    if id = FBuildorder.Items[i] then
    begin
      result := i+1;
      exit;
    end;
  end;
end;

end.
