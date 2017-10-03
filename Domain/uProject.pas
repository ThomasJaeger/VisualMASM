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
      FOutputFolder: string;
      FOutputFile: string;
      FSizeInBytes: int64;
      FBuild: boolean;
      FFunctions: TList<TFunctionData>;
      FSavedFunctions: TList<TFunctionData>;

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
      procedure SetSizeInBytes(value: int64);
      function GetSavedFunction(f: string; fileId: string): string;
      function CreateFile(name: string; fileType: TProjectFileType = pftASM): TProjectFile;
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
      property OutputFolder: string read FOutputFolder write FOutputFolder;
      property OutputFile: string read FOutputFile write FOutputFile;
      property SizeInBytes: int64 read FSizeInBytes write SetSizeInBytes;
      property Build: boolean read FBuild write FBuild;
      property Functions: TList<TFunctionData> read FFunctions write FFunctions;
      property SavedFunctions: TList<TFunctionData> read FSavedFunctions write FSavedFunctions;
      procedure ScanFunctions;
      procedure ExportFunction(name: string; exportAs: string; fileId: string);
      procedure MarkAllFunctionsNotToExport;
      function WasFunctionExported(f: string; fileId: string): boolean;
      procedure MarkAllFunctionsToExport;
      procedure UpdateSavedFunction;
      function GetFirstProjectFileByType(pft: TProjectFileType): TProjectFile;
      function GetProjectFileWithNoChildrenAndNoParent(pft: TProjectFileType): TProjectFile;
      function GetManifest: TProjectFile;
      function GetRCFile: TProjectFile;
    published
      procedure DeleteProjectFile(id: string);
      procedure AddProjectFile(projectFile: TProjectFile);
      function CreateProjectFile(name: string; options: TVisualMASMOptions; fileType: TProjectFileType = pftASM): TProjectFile;
      function AddFile(fn: string): TProjectFile;
  end;

implementation

procedure TProject.Initialize;
begin
  FProjectType := ptWin32;
  FProjectFiles := TDictionary<string, TProjectFile>.Create;
  FFunctions := TList<TFunctionData>.Create;
  FSavedFunctions := TList<TFunctionData>.Create;
  self.Modified := true;
  FBuild := true;
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

procedure TProject.AddProjectFile(projectFile: TProjectFile);
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
  rcFile,asmFile: TProjectFile;
  fn: string;
begin
  case FProjectType of
    ptWin32:
      begin
        case fileType of
          pftASM:
            begin
              projectFile := CreateFile(name, fileType);
              projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+WIN_32_BIT_EXE_MASM32_FILENAME);
              AddProjectFile(projectFile);
            end;
          pftManifest:
            begin
              projectFile := CreateFile(name, fileType);
              projectFile.IsOpen := false;
              projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+WIN_STUB_MANIFEST_FILENAME);
              AddProjectFile(projectFile);
            end;
          pftRC:
            begin
              projectFile := CreateFile(name, fileType);
              projectFile.IsOpen := false;
              projectFile.Content := NEW_ITEM_RC_HEADER;
              AddProjectFile(projectFile);
            end;
          else
            begin
              projectFile := CreateFile(name, fileType);
              AddProjectFile(projectFile);
            end;
        end;
      end;
    ptWin32Dlg:
      begin
        case fileType of
          pftASM:
            begin
              projectFile := CreateFile(name, fileType);
              projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+WIN_32_BIT_DLG_MASM32_FILENAME);
              AddProjectFile(projectFile);
            end;
          pftDLG:
            begin
              fn := 'Dialog'+inttostr(ProjectFiles.Count+1);
              projectFile := CreateFile(fn+'.dlg', fileType);

              rcFile := CreateFile(fn+'.rc', pftRC);
              rcFile.ParentFileId := projectFile.Id;
              rcFile.IsOpen := true;
              rcFile.Content := NEW_ITEM_RC_HEADER;
              projectFile.ChildFileRCId := rcFile.Id;

              asmFile := CreateFile(fn+'.asm', pftASM);
              asmFile.ParentFileId := projectFile.Id;
              asmFile.IsOpen := true;
              asmFile.Content := CreateResourceCodeBehind(fileName);
              projectFile.ChildFileASMId := asmFile.Id;

              AddProjectFile(projectFile);
              AddProjectFile(rcFile);
              AddProjectFile(asmFile);
            end;
          pftManifest:
            begin
              projectFile := CreateFile(name, fileType);
              projectFile.IsOpen := false;
              projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+WIN_STUB_MANIFEST_FILENAME);
              AddProjectFile(projectFile);
            end;
          else
            begin
              projectFile := CreateFile(name, fileType);
              AddProjectFile(projectFile);
            end;
        end;
      end;
    ptWin32Con:
      begin
        projectFile := CreateFile(name, fileType);
        if fileType = pftASM then
          projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+WIN_32_BIT_CON_MASM32_FILENAME);
        AddProjectFile(projectFile);
      end;
    ptWin64:
      begin
        case fileType of
          pftASM:
            begin
              projectFile := CreateFile(name, fileType);
              projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+WIN_64_BIT_EXE_WINSDK64_FILENAME);
              AddProjectFile(projectFile);
            end;
          pftManifest:
            begin
              projectFile := CreateFile(name, fileType);
              projectFile.IsOpen := false;
              projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+WIN_STUB_MANIFEST_FILENAME);
              AddProjectFile(projectFile);
            end;
          pftRC:
            begin
              projectFile := CreateFile(name, fileType);
              projectFile.IsOpen := false;
              projectFile.Content := NEW_ITEM_RC_HEADER;
              AddProjectFile(projectFile);
            end;
          else
            begin
              projectFile := CreateFile(name, fileType);
              AddProjectFile(projectFile);
            end;
        end;
      end;
    ptDos16COM:
      begin
        projectFile := CreateFile(name, fileType);
        if fileType = pftASM then
          projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+DOS_16_BIT_COM_STUB_FILENAME);
        AddProjectFile(projectFile);
      end;
    ptDos16EXE:
      begin
        projectFile := CreateFile(name, fileType);
        if fileType = pftASM then
          projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+DOS_16_BIT_EXE_STUB_FILENAME);
        AddProjectFile(projectFile);
      end;
    ptLib:
      begin
        projectFile := CreateFile(name, fileType);
        if fileType = pftTXT then
          projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+LIB_STUB_FILENAME);
        AddProjectFile(projectFile);
      end;
    ptWin32DLL:
      begin
        projectFile := CreateFile(name, fileType);
        if fileType = pftASM then
          projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+WIN_32_BIT_DLL_MASM32_FILENAME);
        if fileType = pftDef then
          projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+WIN_DLL_DEF_FILENAME);
        AddProjectFile(projectFile);
      end;
    ptWin64DLL:
      begin
        projectFile := CreateFile(name, fileType);
        if fileType = pftASM then
          projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+WIN_64_BIT_DLL_MASM32_FILENAME);
        if fileType = pftDef then
          projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+WIN_DLL_DEF_FILENAME);
        AddProjectFile(projectFile);
      end;
    ptWin16DLL:
      begin
        projectFile := CreateFile(name, fileType);
        if fileType = pftASM then
          projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+WIN_16_BIT_DLL_MASM32_FILENAME);
        if fileType = pftDef then
          projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+WIN_DLL_DEF_FILENAME);
        AddProjectFile(projectFile);
      end;
    ptWin16:
      begin
        projectFile := CreateFile(name, fileType);
        if fileType = pftASM then
          projectFile.Content := TFile.ReadAllText(options.TemplatesFolder+WIN_16_BIT_EXE_MASM32_FILENAME);
        AddProjectFile(projectFile);
      end;
  end;

  FActiveFile := projectFile;
  result := projectFile;
end;

function TProject.CreateFile(name: string; fileType: TProjectFileType = pftASM): TProjectFile;
begin
  result := TProjectFile.Create;
  result.Name := name;

  // If we add a path, then the initial saving will not
  // prompt the user where to save it to since it checks
  // the Path property = ''
  //projectFile.Path := AppFolder;

  // Do not give it a filename because we want the user to enter a new
  // filename via Save As... prompt.
  //projectFile.FileName := AppFolder+name;

  result.ProjectFileType := fileType;
  result.IsOpen := true;
  result.SizeInBytes := 0;
  result.Modified := true;
  if (fileType = pftASM) or (fileType = pftRC) then
    result.AssembleFile := true
  else
    result.AssembleFile := false;
end;

function TProject.AddFile(fn: string): TProjectFile;
var
  projectFile: TProjectFile;
begin
  projectFile := TProjectFile.Create;
  projectFile.Name := ExtractFileName(fn);
  projectFile.Path := ExtractFilePath(fn);
  projectFile.FileName := fn;
  projectFile.IsOpen := true;
  projectFile.SizeInBytes := 0;

  if (projectFile.ProjectFileType = pftASM) or (projectFile.ProjectFileType = pftRC) then
    projectFile.AssembleFile := true
  else
    projectFile.AssembleFile := false;

  projectFile.Content := TFile.ReadAllText(fn);
  projectFile.SizeInBytes := length(projectFile.Content);
  projectFile.Modified := false;

  AddProjectFile(projectFile);
  FActiveFile := projectFile;
  result := projectFile;
end;

procedure TProject.SetSizeInBytes(value: int64);
begin
  FSizeInBytes := value;
end;

procedure TProject.ScanFunctions;
var
  x,i,p: integer;
  s: string;
  functionData: TFunctionData;
  comment: boolean;
  pf: TProjectFile;
  source: TStringList;
begin
  FFunctions.Clear;
  source := TStringList.Create;
  for pf in FProjectFiles.Values do
  begin
    source.Text := pf.Content;
    for x := 0 to source.Count-1 do begin
      p := pos(' PROC',Uppercase(source.Strings[x]));
      if p > 0 then begin
        s := trim(copy(source.Strings[x],0,p-1));
        if (length(s)>0) then begin
          comment := false;
          for i := p downto 1 do begin
            if s[i]=';' then begin
              comment := true;
              break;
            end;
          end;
          if (s[1] <> ';') and (not comment) then begin
            functionData.FileId := pf.Id;
            functionData.Name := s;
            functionData.ExportAs := GetSavedFunction(s, pf.Id);
            functionData.Line := x+1;
            functionData.FileName := ExtractFileName(pf.FileName);
            functionData.Export := WasFunctionExported(s, pf.Id);
            FFunctions.Add(functionData);
          end;
        end;
      end;
    end;
  end;
end;

function TProject.GetSavedFunction(f: string; fileId: string): string;
var
  i: Integer;
begin
  result := f;
  for i := 0 to FSavedFunctions.Count-1 do
  begin
    if (FSavedFunctions[i].FileId = fileId) and (FSavedFunctions[i].Name = f) then
    begin
      result := FSavedFunctions[i].ExportAs;
      exit;
    end;
  end;
end;

function TProject.WasFunctionExported(f: string; fileId: string): boolean;
var
  i: Integer;
begin
  result := false;
  for i := 0 to FSavedFunctions.Count-1 do
  begin
    if (FSavedFunctions[i].FileId = fileId) and (FSavedFunctions[i].Name = f) then
    begin
      result := true;
      exit;
    end;
  end;
end;

procedure TProject.ExportFunction(name: string; exportAs: string; fileId: string);
var
  i: Integer;
  fd: TFunctionData;
begin
  for i := 0 to FFunctions.Count-1 do
  begin
    if (FFunctions[i].FileId = fileId) and (FFunctions[i].Name = name) then
    begin
      fd := FFunctions[i];
      fd.Export := true;
      fd.ExportAs := exportAs;
      FFunctions[i] := fd;
      exit;
    end;
  end;
end;

procedure TProject.MarkAllFunctionsNotToExport;
var
  i: Integer;
  fd: TFunctionData;
begin
  for i := 0 to FFunctions.Count-1 do
  begin
    fd := FFunctions[i];
    fd.Export := false;
    FFunctions[i] := fd;
  end;
end;

procedure TProject.MarkAllFunctionsToExport;
var
  i: Integer;
  fd: TFunctionData;
begin
  FSavedFunctions.Clear;
  for i := 0 to FFunctions.Count-1 do
  begin
    fd := FFunctions[i];
    fd.Export := true;
    FFunctions[i] := fd;
    FSavedFunctions.Add(fd);
  end;
end;

procedure TProject.UpdateSavedFunction;
var
  i: Integer;
begin
  FSavedFunctions.Clear;
  for i := 0 to FFunctions.Count-1 do
  begin
    if FFunctions[i].Export then
      FSavedFunctions.Add(FFunctions[i]);
  end;
end;

function TProject.GetFirstProjectFileByType(pft: TProjectFileType): TProjectFile;
var
  pf: TProjectFile;
begin
  result := nil;
  for pf in FProjectFiles.Values do
  begin
    if pf.ProjectFileType = pft then
    begin
      result := pf;
      exit;
    end;
  end;
end;

function TProject.GetProjectFileWithNoChildrenAndNoParent(pft: TProjectFileType): TProjectFile;
var
  pf: TProjectFile;
begin
  result := nil;
  for pf in FProjectFiles.Values do
  begin
    if pf.ProjectFileType = pft then
    begin
      if (pf.ChildFileASMId = '') and (pf.ChildFileRCId = '') and (pf.ParentFileId = '') then
      begin
        result := pf;
        exit;
      end;
    end;
  end;
end;

function TProject.GetManifest: TProjectFile;
var
  pf: TProjectFile;
begin
  result := nil;
  for pf in FProjectFiles.Values do
  begin
    if pf.ProjectFileType = pftManifest then
    begin
      result := pf;
      exit;
    end;
  end;
end;

function TProject.GetRCFile: TProjectFile;
var
  pf: TProjectFile;
begin
  result := nil;
  for pf in FProjectFiles.Values do
  begin
    if pf.ProjectFileType = pftRC then
    begin
      result := pf;
      exit;
    end;
  end;
end;

end.
