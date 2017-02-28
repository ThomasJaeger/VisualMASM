unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sevenzip, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Memo1: TMemo;
    Button2: TButton;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function ProgressCallback(sender: Pointer; total: boolean; value: int64): HRESULT; stdcall;
begin
  if total then
    Form1.ProgressBar1.Max := value
  else
    Form1.ProgressBar1.Position := value;
  Result := S_OK;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  fileName: string;
  i: integer;
begin
  if OpenDialog1.Execute then
    fileName := OpenDialog1.FileName
  else
    exit;

  memo1.Clear;
//  with CreateInArchive(CLSID_CFormat7z) do
//  with CreateInArchive(CLSID_CFormatZip) do
//  with CreateInArchive(CLSID_CFormatUdf) do
  with CreateInArchive(CLSID_CFormatIso) do
  begin
    SetProgressCallback(nil, ProgressCallback);
    OpenFile(fileName);
    for i := 0 to NumberOfItems - 1 do
      if not ItemIsFolder[i] then
        memo1.Lines.Add(ItemPath[i]);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  fileName: string;
begin
  if OpenDialog1.Execute then
    fileName := OpenDialog1.FileName
  else
    exit;

  with CreateInArchive(CLSID_CFormatIso) do
  begin
    SetProgressCallback(nil, ProgressCallback);
    OpenFile(fileName);
    ExtractTo('c:\temp');
  end;
end;

end.
