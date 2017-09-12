unit uTFile;

interface

uses
  Classes, SysUtils, uSharedGlobals, Vcl.Dialogs;

type
  TFile = class
  private
    class function DoReadAllText(const Path: string): string;
    //class function DoReadAllBytes(const Path: string): TBytes;
    class function DoWriteAllText(const Path: string; const text: string): string;
  public
    class function ReadAllText(const Path: string): string;
    class function WriteAllText(const Path: string; const text: string): string;
    class function Exists(const path: string): boolean;
    class function Delete(const path: string): boolean;
  end;

implementation

class function TFile.ReadAllText(const Path: string): string;
begin
  Result := DoReadAllText(Path);
end;

class function TFile.DoReadAllText(const Path: string): string;
var
  fileText: TStringList;
begin
  if not Exists(Path) then exit;
  fileText := TStringList.Create;
  fileText.LoadFromFile(Path);
  result := fileText.Text;
  FreeAndNil(fileText);
end;

class function TFile.WriteAllText(const Path: string; const text: string): string;
begin
  result := DoWriteAllText(Path, text);
end;

class function TFile.DoWriteAllText(const Path: string; const text: string): string;
var
  fileText: TStringList;
begin
  fileText := TStringList.Create;
  fileText.Text := text;
  fileText.SaveToFile(path);
  result := fileText.Text;
  FreeAndNil(fileText);
  if not FileExistsStripped(Path) then
    ShowMessage('Unable to save file ' + Path);
end;
(*
class function TFile.DoReadAllText(const Path: string): string;
var
  Buff: TBytes;
  Encoding: TEncoding;
  BOMLength: Integer;
begin
  Encoding := nil;
  Buff := DoReadAllBytes(Path);
  BOMLength := TEncoding.GetBufferEncoding(Buff, Encoding);
  Result := Encoding.GetString(Buff, BOMLength, Length(Buff) - BOMLength);
end;

class function TFile.DoReadAllBytes(const Path: string): TBytes;
var
  LFileStream: TFileStream;
begin
  LFileStream := nil;
  try
    LFileStream := OpenRead(Path);
    SetLength(Result, LFileStream.Size);
    LFileStream.ReadBuffer(Result, Length(Result));
  finally
    LFileStream.Free;
  end;
end;
*)

class function TFile.Exists(const path: string): boolean;
begin
  result := FileExistsStripped(path);
end;

class function TFile.Delete(const path: string): boolean;
begin
  result := DeleteFile(path);
end;

end.

