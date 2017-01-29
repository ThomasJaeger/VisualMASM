unit uGroup;

interface

uses
  SysUtils, Classes, uVisualMASMFile, uSharedGlobals, uProject;

type
  PGroup = ^TGroup;
  TGroup = class(TVisualMASMFile)
    private
      FProjects: TStringList;
      FActiveProject: TProject;
      FLastFileOpenId: string;
      procedure Initialize;
      function GetProject(Index: integer): TProject;
      procedure SetProject(Index: integer; const Value: TProject);
      function GetProjectById(Index: string): TProject;
      procedure SetProjectById(Index: string; const Value: TProject);
      function GetProjectCount: integer;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
      property ProjectById[Index: string]: TProject read GetProjectById write SetProjectById; default;
      property ProjectByIndex[Index: integer]: TProject read GetProject write SetProject;
      property ProjectCount: integer read GetProjectCount;
      property ActiveProject: TProject read FActiveProject write FActiveProject;
      procedure DeleteProject(id: string);
      property LastFileOpenId: string read FLastFileOpenId write FLastFileOpenId;
    published
      procedure AddProject(project: TProject);
  end;

implementation

procedure TGroup.Initialize;
begin
  FProjects := TStringList.Create;
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
var
  i: integer;
begin
  result := nil;
  if Index = '' then exit;
  i:=FProjects.IndexOf(Index);
  if i=-1 then exit;
  result := TProject(FProjects.Objects[i]);
end;

function TGroup.GetProject(Index: integer): TProject;
var
  i: integer;
begin
  result := nil;
//  i:=FProjects.IndexOf(Index);
//  if i=-1 then exit;
  result := TProject(FProjects.Objects[Index]);
end;

procedure TGroup.SetProject(Index: integer; const Value: TProject);
begin
  FProjects.Objects[Index] := Value;
end;

procedure TGroup.SetProjectById(Index: string; const Value: TProject);
var
  project: TProject;
begin
  project:=GetProjectById(Index);
  project:=Value;
end;

function TGroup.GetProjectCount: integer;
begin
  result:=FProjects.Count;
end;

procedure TGroup.AddProject(project: TProject);
var
  p: TProject;
begin
  p:=GetProjectById(project.Id);
  if p=nil then
    FProjects.AddObject(project.Id, project)
  else
    SetProjectById(project.Id, project);
end;

procedure TGroup.DeleteProject(id: string);
var
  i: integer;
begin
  i:=FProjects.IndexOf(id);
  if i=-1 then exit;
  if id = '' then exit;
  FProjects.Delete(i);
  self.Modified := true;
end;

end.
