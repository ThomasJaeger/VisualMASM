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
      FChildFileRCId: string; // Used to refer to another file that is required and part
                              // of the original file. For example, a dialog (*.dlg) file
                              // requires a resource definition (*.rc) file. The
                              // resource definition file would be the dependent file.
                              // The resource definition file's ParentFileId would be emtpy.
      FChildFileASMId: string;
      FParentFileId: string;  // The equivalent file from the child file id above. The
                              // resource definition file would have the file id of the
                              // dialog file.
      procedure Initialize;
      procedure SetProjectFileType(value: TProjectFileType);
      procedure SetContent(value: string);
      procedure SetPath(value: string);
      procedure SetSizeInBytes(value: int64);
      procedure SetIsOpen(value: boolean);
      procedure SetAssembleFile(value: boolean);
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
      property ProjectFileType: TProjectFileType read FProjectFileType write SetProjectFileType;
      property Content: string read FContent write SetContent;
      property Path: string read FPath write SetPath;
      property SizeInBytes: int64 read FSizeInBytes write SetSizeInBytes;
      property IsOpen: boolean read FIsOpen write SetIsOpen;
      property AssembleFile: boolean read FAssembleFile write SetAssembleFile;
      property AssemblyErrors: TStringList read FAssemblyErrors write FAssemblyErrors;
      property ChildFileRCId: string read FChildFileRCId write FChildFileRCId;
      property ChildFileASMId: string read FChildFileASMId write FChildFileASMId;
      property ParentFileId: string read FParentFileId write FParentFileId;
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
  FAssemblyErrors := TStringList.Create;
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

end.
