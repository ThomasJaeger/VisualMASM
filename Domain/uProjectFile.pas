unit uProjectFile;

interface

uses
  SysUtils, Classes, uSharedGlobals, uVisualMASMFile, System.Generics.Collections;

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
      FAssemblyErrors: TList<TAssemblyError>;
      FChildFileRCId: string; // Used to refer to another file that is required and part
                              // of the original file. For example, a dialog (*.dlg) file
                              // requires a resource definition (*.rc) file. The
                              // resource definition file would be the dependent file.
                              // The resource definition file's ParentFileId would be emtpy.
      FChildFileASMId: string;
      FParentFileId: string;  // The equivalent file from the child file id above. The
                              // resource definition file would have the file id of the
                              // dialog file.
      FOutputFile: string;    // The filename of the output including path. E.g. for
                              // an assembly file, this would be c:\path\file.obj if the
                              // FFileName was file.asm
      procedure Initialize;
      procedure SetProjectFileType(value: TProjectFileType);
      procedure SetContent(value: string);
      procedure SetPath(value: string);
      procedure SetSizeInBytes(value: int64);
      procedure SetIsOpen(value: boolean);
      procedure SetAssembleFile(value: boolean);
      procedure SetFileName(value: string);
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
      property ProjectFileType: TProjectFileType read FProjectFileType write SetProjectFileType;
      property Content: string read FContent write SetContent;
      property Path: string read FPath write SetPath;
      property SizeInBytes: int64 read FSizeInBytes write SetSizeInBytes;
      property IsOpen: boolean read FIsOpen write SetIsOpen;
      property AssembleFile: boolean read FAssembleFile write SetAssembleFile;
      property AssemblyErrors: TList<TAssemblyError> read FAssemblyErrors write FAssemblyErrors;
      property ChildFileRCId: string read FChildFileRCId write FChildFileRCId;
      property ChildFileASMId: string read FChildFileASMId write FChildFileASMId;
      property ParentFileId: string read FParentFileId write FParentFileId;
      property OutputFile: string read FOutputFile write FOutputFile;
      property FileName: string read FFileName write SetFileName;
    published
      procedure MarkFileClosed;
  end;

implementation

procedure TProjectFile.Initialize;
begin
  FProjectFileType := pftASM;
  FContent := '';
  FIsOpen := true;
  FAssembleFile := true;
  FAssemblyErrors := TList<TAssemblyError>.Create;
  self.Modified := false;
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

procedure TProjectFile.SetProjectFileType(value: TProjectFileType);
begin
  FProjectFileType := value;
//  self.Modified := true;
end;

procedure TProjectFile.SetContent(value: string);
begin
  FContent := value;
//  self.Modified := true;
end;

procedure TProjectFile.SetPath(value: string);
begin
  FPath := value;
//  self.Modified := true;
end;

procedure TProjectFile.SetSizeInBytes(value: int64);
begin
  FSizeInBytes := value;
//  self.Modified := true;
end;

procedure TProjectFile.SetIsOpen(value: boolean);
begin
  FIsOpen := value;
//  self.Modified := true;
end;

procedure TProjectFile.SetAssembleFile(value: boolean);
begin
  FAssembleFile := value;
//  self.Modified := true;
end;

procedure TProjectFile.MarkFileClosed;
begin
  FIsOpen := false;
//  FModified := true;
end;

procedure TProjectFile.SetFileName(value: string);
var
  fileExt: string;
begin
  FFileName := value;

  if value = '' then exit;
  fileExt := UpperCase(ExtractFileExt(value));
  if (fileExt = '.ASM') then
    FProjectFileType := pftASM
  else if fileExt = '.INC' then
    FProjectFileType := pftINC
  else if fileExt = '.BAT' then
    FProjectFileType := pftBAT
  else if fileExt = '.TXT' then
    FProjectFileType := pftTXT
  else if fileExt = '.RC' then
    FProjectFileType := pftRC
  else if fileExt = '.INI' then
    FProjectFileType := pftINI
  else if (fileExt = '.C') or (fileExt = '.CPP') or (fileExt = '.CC') or (fileExt = '.H') or (fileExt = '.HPP') or (fileExt = '.HH') or (fileExt = '.CXX') or (fileExt = '.HXX') or (fileExt = '.CU') then
    FProjectFileType := pftCPP
  else if fileExt = '.DLG' then
    FProjectFileType := pftDLG
  else if fileExt = '.LIB' then
    FProjectFileType := pftLib
  else if fileExt = '.DEF' then
    FProjectFileType := pftDef
  else if fileExt = '.XML' then
    FProjectFileType := pftManifest
  else
    // FProjectFileType := pftOther;
    FProjectFileType := pftBinary;
end;

end.
