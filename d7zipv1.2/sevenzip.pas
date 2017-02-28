//This API use the 7-zip dll (7z.dll) to read and write all 7-zip supported archive formats.
//
//- Autor: Henri Gourvest <hgourvest@progdigy.com>
//- Licence: MPL1.1
//- Date: 15/04/2009
//- Version: 1.1
//
//Reading archive:
//
//Extract to path:
//
// with CreateInArchive(CLSID_CFormatZip) do
// begin
//   OpenFile('c:\test.zip');
//   ExtractTo('c:\test');
// end;
//
//Get file list:
//
// with CreateInArchive(CLSID_CFormat7z) do
// begin
//   OpenFile('c:\test.7z');
//   for i := 0 to NumberOfItems - 1 do
//    if not ItemIsFolder[i] then
//      Writeln(ItemPath[i]);
// end;
//
//Extract to stream
//
// with CreateInArchive(CLSID_CFormat7z) do
// begin
//   OpenFile('c:\test.7z');
//   for i := 0 to NumberOfItems - 1 do
//     if not ItemIsFolder[i] then
//       ExtractItem(i, stream, false);
// end;
//
//Extract "n" Items
//
//function GetStreamCallBack(sender: Pointer; index: Cardinal;
//  var outStream: ISequentialOutStream): HRESULT; stdcall;
//begin
//  case index of ...
//    outStream := T7zStream.Create(aStream, soReference);
//  Result := S_OK;
//end;
//
//procedure TMainForm.ExtractClick(Sender: TObject);
//var
//  i: integer;
//  items: array[0..2] of Cardinal;
//begin
//  with CreateInArchive(CLSID_CFormat7z) do
//  begin
//    OpenFile('c:\test.7z');
//    // items must be sorted by index!
//    items[0] := 0;
//    items[1] := 1;
//    items[2] := 2;
//    ExtractItems(@items, Length(items), false, nil, GetStreamCallBack);
//  end;
//end;
//
//Open stream
//
// with CreateInArchive(CLSID_CFormatZip) do
// begin
//   OpenStream(T7zStream.Create(TFileStream.Create('c:\test.zip', fmOpenRead), soOwned));
//   OpenStream(aStream, soReference);
//   ...
// end;
//
//Progress bar
//
// function ProgressCallback(sender: Pointer; total: boolean; value: int64): HRESULT; stdcall;
// begin
//   if total then
//     Mainform.ProgressBar.Max := value else
//     Mainform.ProgressBar.Position := value;
//   Result := S_OK;
// end;
//
// procedure TMainForm.ExtractClick(Sender: TObject);
// begin
//   with CreateInArchive(CLSID_CFormatZip) do
//   begin
//     OpenFile('c:\test.zip');
//     SetProgressCallback(nil, ProgressCallback);
//     ...
//   end;
// end;
//
//Password
//
// function PasswordCallback(sender: Pointer; var password: WideString): HRESULT; stdcall;
// begin
//   // call a dialog box ...
//   password := 'password';
//   Result := S_OK;
// end;
//
// procedure TMainForm.ExtractClick(Sender: TObject);
// begin
//   with CreateInArchive(CLSID_CFormatZip) do
//   begin
//     // using callback
//     SetPasswordCallback(nil, PasswordCallback);
//     // or setting password directly
//     SetPassword('password');
//     OpenFile('c:\test.zip');
//     ...
//   end;
// end;
//
//Writing archive
//
// procedure TMainForm.ExtractAllClick(Sender: TObject);
// var
//   Arch: I7zOutArchive;
// begin
//   Arch := CreateOutArchive(CLSID_CFormat7z);
//   // add a file
//   Arch.AddFile('c:\test.bin', 'folder\test.bin');
//   // add files using willcards and recursive search
//   Arch.AddFiles('c:\test', 'folder', '*.pas;*.dfm', true);
//   // add a stream
//   Arch.AddStream(aStream, soReference, faArchive, CurrentFileTime, CurrentFileTime, 'folder\test.bin', false, false);
//   // compression level
//   SetCompressionLevel(Arch, 5);
//   // compression method if <> LZMA
//   SevenZipSetCompressionMethod(Arch, m7BZip2);
//   // add a progress bar ...
//   Arch.SetProgressCallback(...);
//   // set a password if necessary
//   Arch.SetPassword('password');
//   // Save to file
//   Arch.SaveToFile('c:\test.zip');
//   // or a stream
//   Arch.SaveToStream(aStream);
// end;

(********************************************************************************)
(*                        7-ZIP DELPHI API                                      *)
(*                                                                              *)
(* The contents of this file are subject to the Mozilla Public License Version  *)
(* 1.1 (the "License"); you may not use this file except in compliance with the *)
(* License. You may obtain a copy of the License at http://www.mozilla.org/MPL/ *)
(*                                                                              *)
(* Software distributed under the License is distributed on an "AS IS" basis,   *)
(* WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for *)
(* the specific language governing rights and limitations under the License.    *)
(*                                                                              *)
(* Unit owner : Henri Gourvest <hgourvest@gmail.com>                            *)
(* V1.2                                                                         *)
(********************************************************************************)

unit sevenzip;
{$ALIGN ON}
{$MINENUMSIZE 4}
{$WARN SYMBOL_PLATFORM OFF}	

interface
uses SysUtils, Windows, ActiveX, Classes, Contnrs;

type
  PVarType = ^TVarType;
  PCardArray = ^TCardArray;
  TCardArray = array[0..MaxInt div SizeOf(Cardinal) - 1] of Cardinal;

{$IFNDEF UNICODE}
  UnicodeString = WideString;
{$ENDIF}

//******************************************************************************
// PropID.h
//******************************************************************************

const
  kpidNoProperty       = 0;

  kpidHandlerItemIndex = 2;
  kpidPath             = 3;  // VT_BSTR
  kpidName             = 4;  // VT_BSTR
  kpidExtension        = 5;  // VT_BSTR
  kpidIsFolder         = 6;  // VT_BOOL
  kpidSize             = 7;  // VT_UI8
  kpidPackedSize       = 8;  // VT_UI8
  kpidAttributes       = 9;  // VT_UI4
  kpidCreationTime     = 10; // VT_FILETIME
  kpidLastAccessTime   = 11; // VT_FILETIME
  kpidLastWriteTime    = 12; // VT_FILETIME
  kpidSolid            = 13; // VT_BOOL
  kpidCommented        = 14; // VT_BOOL
  kpidEncrypted        = 15; // VT_BOOL
  kpidSplitBefore      = 16; // VT_BOOL
  kpidSplitAfter       = 17; // VT_BOOL
  kpidDictionarySize   = 18; // VT_UI4
  kpidCRC              = 19; // VT_UI4
  kpidType             = 20; // VT_BSTR
  kpidIsAnti           = 21; // VT_BOOL
  kpidMethod           = 22; // VT_BSTR
  kpidHostOS           = 23; // VT_BSTR
  kpidFileSystem       = 24; // VT_BSTR
  kpidUser             = 25; // VT_BSTR
  kpidGroup            = 26; // VT_BSTR
  kpidBlock            = 27; // VT_UI4
  kpidComment          = 28; // VT_BSTR
  kpidPosition         = 29; // VT_UI4
  kpidPrefix           = 30; // VT_BSTR
  kpidNumSubDirs       = 31; // VT_UI4
  kpidNumSubFiles      = 32; // VT_UI4
  kpidUnpackVer        = 33; // VT_UI1
  kpidVolume           = 34; // VT_UI4
  kpidIsVolume         = 35; // VT_BOOL
  kpidOffset           = 36; // VT_UI8
  kpidLinks            = 37; // VT_UI4
  kpidNumBlocks        = 38; // VT_UI4
  kpidNumVolumes       = 39; // VT_UI4
  kpidTimeType         = 40; // VT_UI4
  kpidBit64            = 41; // VT_BOOL
  kpidBigEndian        = 42; // VT_BOOL
  kpidCpu              = 43; // VT_BSTR
  kpidPhySize          = 44; // VT_UI8
  kpidHeadersSize      = 45; // VT_UI8
  kpidChecksum         = 46; // VT_UI4
  kpidCharacts         = 47; // VT_BSTR
  kpidVa               = 48; // VT_UI8


  kpidTotalSize        = $1100; // VT_UI8
  kpidFreeSpace        = kpidTotalSize + 1; // VT_UI8
  kpidClusterSize      = kpidFreeSpace + 1; // VT_UI8
  kpidVolumeName       = kpidClusterSize + 1; // VT_BSTR

  kpidLocalName        = $1200; // VT_BSTR
  kpidProvider         = kpidLocalName + 1; // VT_BSTR

  kpidUserDefined      = $10000;

//******************************************************************************
// IProgress.h
//******************************************************************************
type
  IProgress = interface(IUnknown)
  ['{23170F69-40C1-278A-0000-000000050000}']
    function SetTotal(total: Int64): HRESULT; stdcall;
    function SetCompleted(completeValue: PInt64): HRESULT; stdcall;
  end;

//******************************************************************************
// IPassword.h
//******************************************************************************

  ICryptoGetTextPassword = interface(IUnknown)
  ['{23170F69-40C1-278A-0000-000500100000}']
    function CryptoGetTextPassword(var password: TBStr): HRESULT; stdcall;
  end;

  ICryptoGetTextPassword2 = interface(IUnknown)
  ['{23170F69-40C1-278A-0000-000500110000}']
    function CryptoGetTextPassword2(passwordIsDefined: PInteger; var password: TBStr): HRESULT; stdcall;
  end;

//******************************************************************************
// IStream.h
// "23170F69-40C1-278A-0000-000300xx0000"
//******************************************************************************

  ISequentialInStream = interface(IUnknown)
  ['{23170F69-40C1-278A-0000-000300010000}']
    function Read(data: Pointer; size: Cardinal; processedSize: PCardinal): HRESULT; stdcall;
    (*
    Out: if size != 0, return_value = S_OK and (*processedSize == 0),
      then there are no more bytes in stream.
    if (size > 0) && there are bytes in stream,
    this function must read at least 1 byte.
    This function is allowed to read less than number of remaining bytes in stream.
    You must call Read function in loop, if you need exact amount of data
    *)
  end;

  ISequentialOutStream = interface(IUnknown)
  ['{23170F69-40C1-278A-0000-000300020000}']
    function Write(data: Pointer; size: Cardinal; processedSize: PCardinal): HRESULT; stdcall;
    (*
    if (size > 0) this function must write at least 1 byte.
    This function is allowed to write less than "size".
    You must call Write function in loop, if you need to write exact amount of data
    *)
  end;

  IInStream = interface(ISequentialInStream)
  ['{23170F69-40C1-278A-0000-000300030000}']
    function Seek(offset: Int64; seekOrigin: Cardinal; newPosition: PInt64): HRESULT; stdcall;
  end;

  IOutStream = interface(ISequentialOutStream)
  ['{23170F69-40C1-278A-0000-000300040000}']
    function Seek(offset: Int64; seekOrigin: Cardinal; newPosition: PInt64): HRESULT; stdcall;
    function SetSize(newSize: Int64): HRESULT; stdcall;
  end;

  IStreamGetSize = interface(IUnknown)
  ['{23170F69-40C1-278A-0000-000300060000}']
    function GetSize(size: PInt64): HRESULT; stdcall;
  end;

  IOutStreamFlush = interface(IUnknown)
  ['{23170F69-40C1-278A-0000-000300070000}']
    function Flush: HRESULT; stdcall;
  end;

//******************************************************************************
// IArchive.h
//******************************************************************************

// MIDL_INTERFACE("23170F69-40C1-278A-0000-000600xx0000")
//#define ARCHIVE_INTERFACE_SUB(i, base,  x) \
//DEFINE_GUID(IID_ ## i, \
//0x23170F69, 0x40C1, 0x278A, 0x00, 0x00, 0x00, 0x06, 0x00, x, 0x00, 0x00); \
//struct i: public base

//#define ARCHIVE_INTERFACE(i, x) ARCHIVE_INTERFACE_SUB(i, IUnknown, x)

type
// NFileTimeType
  NFileTimeType = (
    kWindows = 0,
    kUnix,
    kDOS
  );

// NArchive::
  NArchive = (
    kName = 0,          // string
    kClassID,           // GUID
    kExtension,         // string  zip rar gz
    kAddExtension,      // sub archive: tar 
    kUpdate,            // bool
    kKeepName,          // bool
    kStartSignature,    // string[4] ex: PK.. 7z.. Rar!
    kFinishSignature,
    kAssociate
  );

// NArchive::NExtract::NAskMode
  NAskMode = (
    kExtract = 0,
    kTest,
    kSkip
  );

// NArchive::NExtract::NOperationResult
  NExtOperationResult = (
    kOK = 0,
    kUnSupportedMethod,
    kDataError,
    kCRCError
  );

// NArchive::NUpdate::NOperationResult
  NUpdOperationResult = (
    kOK_   = 0,
    kError
  );

  IArchiveOpenCallback = interface
  ['{23170F69-40C1-278A-0000-000600100000}']
    function SetTotal(files, bytes: PInt64): HRESULT; stdcall;
    function SetCompleted(files, bytes: PInt64): HRESULT; stdcall;
  end;

  IArchiveExtractCallback = interface(IProgress)
  ['{23170F69-40C1-278A-0000-000600200000}']
    function GetStream(index: Cardinal; var outStream: ISequentialOutStream;
        askExtractMode: NAskMode): HRESULT; stdcall;
    // GetStream OUT: S_OK - OK, S_FALSE - skeep this file
    function PrepareOperation(askExtractMode: NAskMode): HRESULT; stdcall;
    function SetOperationResult(resultEOperationResult: NExtOperationResult): HRESULT; stdcall;
  end;

  IArchiveOpenVolumeCallback = interface
  ['{23170F69-40C1-278A-0000-000600300000}']
    function GetProperty(propID: PROPID; var value: OleVariant): HRESULT; stdcall;
    function GetStream(const name: PWideChar; var inStream: IInStream): HRESULT; stdcall;
  end;

  IInArchiveGetStream = interface
  ['{23170F69-40C1-278A-0000-000600400000}']
    function GetStream(index: Cardinal; var stream: ISequentialInStream ): HRESULT; stdcall;
  end;

  IArchiveOpenSetSubArchiveName = interface
  ['{23170F69-40C1-278A-0000-000600500000}']
    function SetSubArchiveName(name: PWideChar): HRESULT; stdcall;
  end;

  IInArchive = interface
  ['{23170F69-40C1-278A-0000-000600600000}']
    function Open(stream: IInStream; const maxCheckStartPosition: PInt64;
        openArchiveCallback: IArchiveOpenCallback): HRESULT; stdcall;
    function Close: HRESULT; stdcall;
    function GetNumberOfItems(var numItems: CArdinal): HRESULT; stdcall;
    function GetProperty(index: Cardinal; propID: PROPID; var value: OleVariant): HRESULT; stdcall;
    function Extract(indices: PCardArray; numItems: Cardinal;
        testMode: Integer; extractCallback: IArchiveExtractCallback): HRESULT; stdcall;
    // indices must be sorted
    // numItems = 0xFFFFFFFF means all files
    // testMode != 0 means "test files operation"

    function GetArchiveProperty(propID: PROPID; var value: OleVariant): HRESULT; stdcall;

    function GetNumberOfProperties(numProperties: PCardinal): HRESULT; stdcall;
    function GetPropertyInfo(index: Cardinal;
        name: PBSTR; propID: PPropID; varType: PVarType): HRESULT; stdcall;

    function GetNumberOfArchiveProperties(var numProperties: Cardinal): HRESULT; stdcall;
    function GetArchivePropertyInfo(index: Cardinal;
        name: PBSTR; propID: PPropID; varType: PVARTYPE): HRESULT; stdcall;
  end;

  IArchiveUpdateCallback = interface(IProgress)
  ['{23170F69-40C1-278A-0000-000600800000}']
    function GetUpdateItemInfo(index: Cardinal;
        newData: PInteger; // 1 - new data, 0 - old data
        newProperties: PInteger; // 1 - new properties, 0 - old properties
        indexInArchive: PCardinal // -1 if there is no in archive, or if doesn't matter
        ): HRESULT; stdcall;
    function GetProperty(index: Cardinal; propID: PROPID; var value: OleVariant): HRESULT; stdcall;
    function GetStream(index: Cardinal; var inStream: ISequentialInStream): HRESULT; stdcall;
    function SetOperationResult(operationResult: Integer): HRESULT; stdcall;
  end;

  IArchiveUpdateCallback2 = interface(IArchiveUpdateCallback)
  ['{23170F69-40C1-278A-0000-000600820000}']
    function GetVolumeSize(index: Cardinal; size: PInt64): HRESULT; stdcall;
    function GetVolumeStream(index: Cardinal; var volumeStream: ISequentialOutStream): HRESULT; stdcall;
  end;

  IOutArchive = interface
  ['{23170F69-40C1-278A-0000-000600A00000}']
    function UpdateItems(outStream: ISequentialOutStream; numItems: Cardinal;
      updateCallback: IArchiveUpdateCallback): HRESULT; stdcall;
    function GetFileTimeType(type_: PCardinal): HRESULT; stdcall;
  end;

  ISetProperties = interface
  ['{23170F69-40C1-278A-0000-000600030000}']
    function SetProperties(names: PPWideChar; values: PPROPVARIANT; numProperties: Integer): HRESULT; stdcall;
  end;

//******************************************************************************
// ICoder.h
// "23170F69-40C1-278A-0000-000400xx0000"
//******************************************************************************

  ICompressProgressInfo = interface
  ['{23170F69-40C1-278A-0000-000400040000}']
    function SetRatioInfo(inSize, outSize: PInt64): HRESULT; stdcall;
  end;

  ICompressCoder = interface
  ['{23170F69-40C1-278A-0000-000400050000}']
  function Code(inStream, outStream: ISequentialInStream;
      inSize, outSize: PInt64;
      progress: ICompressProgressInfo): HRESULT; stdcall;
  end;

  ICompressCoder2 = interface
  ['{23170F69-40C1-278A-0000-000400180000}']
  function Code(var inStreams: ISequentialInStream;
      var inSizes: PInt64;
      numInStreams: Cardinal;
      var outStreams: ISequentialOutStream;
      var outSizes: PInt64;
      numOutStreams: Cardinal;
      progress: ICompressProgressInfo): HRESULT; stdcall;
  end;

const
//NCoderPropID::
  kDictionarySize    = $400;
  kUsedMemorySize    = kDictionarySize + 1;
  kOrder             = kUsedMemorySize + 1;
  kPosStateBits      = $440;
  kLitContextBits    = kPosStateBits + 1;
  kLitPosBits        = kLitContextBits + 1;
  kNumFastBytes      = $450;
  kMatchFinder       = kNumFastBytes + 1;
  kMatchFinderCycles = kMatchFinder + 1;
  kNumPasses         = $460;
  kAlgorithm         = $470;
  kMultiThread       = $480;
  kNumThreads        = kMultiThread + 1;
  kEndMarker         = $490;

type
  ICompressSetCoderProperties = interface
  ['{23170F69-40C1-278A-0000-000400200000}']
    function SetCoderProperties(propIDs: PPropID;
      properties: PROPVARIANT; numProperties: Cardinal): HRESULT; stdcall;
  end;

(*
CODER_INTERFACE(ICompressSetCoderProperties, 0x21)
{
  STDMETHOD(SetDecoderProperties)(ISequentialInStream *inStream) PURE;
};
*)

  ICompressSetDecoderProperties2 = interface
  ['{23170F69-40C1-278A-0000-000400220000}']
    function SetDecoderProperties2(data: PByte; size: Cardinal): HRESULT; stdcall;
  end;

  ICompressWriteCoderProperties = interface
  ['{23170F69-40C1-278A-0000-000400230000}']
    function WriteCoderProperties(outStreams: ISequentialOutStream): HRESULT; stdcall;
  end;

  ICompressGetInStreamProcessedSize = interface
  ['{23170F69-40C1-278A-0000-000400240000}']
    function GetInStreamProcessedSize(value: PInt64): HRESULT; stdcall;
  end;

  ICompressSetCoderMt = interface
  ['{23170F69-40C1-278A-0000-000400250000}']
    function SetNumberOfThreads(numThreads: Cardinal): HRESULT; stdcall;
  end;

  ICompressGetSubStreamSize = interface
  ['{23170F69-40C1-278A-0000-000400300000}']
    function GetSubStreamSize(subStream: Int64; value: PInt64): HRESULT; stdcall;
  end;

  ICompressSetInStream = interface
  ['{23170F69-40C1-278A-0000-000400310000}']
    function SetInStream(inStream: ISequentialInStream): HRESULT; stdcall;
    function ReleaseInStream: HRESULT; stdcall;
  end;

  ICompressSetOutStream = interface
  ['{23170F69-40C1-278A-0000-000400320000}']
    function SetOutStream(outStream: ISequentialOutStream): HRESULT; stdcall;
    function ReleaseOutStream: HRESULT; stdcall;
  end;

  ICompressSetInStreamSize = interface
  ['{23170F69-40C1-278A-0000-000400330000}']
    function SetInStreamSize(inSize: PInt64): HRESULT; stdcall;
  end;

  ICompressSetOutStreamSize = interface
  ['{23170F69-40C1-278A-0000-000400340000}']
    function SetOutStreamSize(outSize: PInt64): HRESULT; stdcall;
  end;

  ICompressFilter = interface
  ['{23170F69-40C1-278A-0000-000400400000}']
    function Init: HRESULT; stdcall;
    function Filter(data: PByte; size: Cardinal): Cardinal; stdcall;
    // Filter return outSize (Cardinal)
    // if (outSize <= size): Filter have converted outSize bytes
    // if (outSize > size): Filter have not converted anything.
    //      and it needs at least outSize bytes to convert one block
    //      (it's for crypto block algorithms).
  end;

  ICryptoProperties = interface
  ['{23170F69-40C1-278A-0000-000400800000}']
    function SetKey(Data: PByte; size: Cardinal): HRESULT; stdcall;
    function SetInitVector(data: PByte; size: Cardinal): HRESULT; stdcall;
  end;

  ICryptoSetPassword = interface
  ['{23170F69-40C1-278A-0000-000400900000}']
    function CryptoSetPassword(data: PByte; size: Cardinal): HRESULT; stdcall;
  end;

  ICryptoSetCRC = interface
  ['{23170F69-40C1-278A-0000-000400A00000}']
    function CryptoSetCRC(crc: Cardinal): HRESULT; stdcall;
  end;

//////////////////////
// It's for DLL file
//NMethodPropID::
  NMethodPropID = (
    kID = 0,
    kName_,
    kDecoder,
    kEncoder,
    kInStreams,
    kOutStreams,
    kDescription,
    kDecoderIsAssigned,
    kEncoderIsAssigned
  );

//******************************************************************************
// CLASSES
//******************************************************************************

  T7zPasswordCallback = function(sender: Pointer; var password: UnicodeString): HRESULT; stdcall;
  T7zGetStreamCallBack = function(sender: Pointer; index: Cardinal;
    var outStream: ISequentialOutStream): HRESULT; stdcall;
  T7zProgressCallback = function(sender: Pointer; total: boolean; value: int64): HRESULT; stdcall;

  I7zInArchive = interface
  ['{022CF785-3ECE-46EF-9755-291FA84CC6C9}']
    procedure OpenFile(const filename: string); stdcall;
    procedure OpenStream(stream: IInStream); stdcall;
    procedure Close; stdcall;
    function GetNumberOfItems: Cardinal; stdcall;
    function GetItemPath(const index: integer): UnicodeString; stdcall;
    function GetItemName(const index: integer): UnicodeString; stdcall;
    function GetItemSize(const index: integer): Cardinal; stdcall;
    function GetItemIsFolder(const index: integer): boolean; stdcall;
    function GetInArchive: IInArchive;
    procedure ExtractItem(const item: Cardinal; Stream: TStream; test: longbool); stdcall;
    procedure ExtractItems(items: PCardArray; count: cardinal; test: longbool;
      sender: pointer; callback: T7zGetStreamCallBack); stdcall;
    procedure ExtractAll(test: longbool; sender: pointer; callback: T7zGetStreamCallBack); stdcall;
    procedure ExtractTo(const path: string); stdcall;
    procedure SetPasswordCallback(sender: Pointer; callback: T7zPasswordCallback); stdcall;
    procedure SetPassword(const password: UnicodeString); stdcall;
    procedure SetProgressCallback(sender: Pointer; callback: T7zProgressCallback); stdcall;
    procedure SetClassId(const classid: TGUID);
    function GetClassId: TGUID;
    property ClassId: TGUID read GetClassId write SetClassId;
    property NumberOfItems: Cardinal read GetNumberOfItems;
    property ItemPath[const index: integer]: UnicodeString read GetItemPath;
    property ItemName[const index: integer]: UnicodeString read GetItemName;
    property ItemSize[const index: integer]: Cardinal read GetItemSize;
    property ItemIsFolder[const index: integer]: boolean read GetItemIsFolder;
    property InArchive: IInArchive read GetInArchive;
  end;

  I7zOutArchive = interface
  ['{BAA9D5DC-9FF4-4382-9BFD-EC9065BD0125}']
    procedure AddStream(Stream: TStream; Ownership: TStreamOwnership; Attributes: Cardinal;
      CreationTime, LastWriteTime: TFileTime; const Path: UnicodeString;
      IsFolder, IsAnti: boolean); stdcall;
    procedure AddFile(const Filename: TFileName; const Path: UnicodeString); stdcall;
    procedure AddFiles(const Dir, Path, Willcards: string; recurse: boolean); stdcall;
    procedure SaveToFile(const FileName: TFileName); stdcall;
    procedure SaveToStream(stream: TStream); stdcall;
    procedure SetProgressCallback(sender: Pointer; callback: T7zProgressCallback); stdcall;
    procedure CrearBatch; stdcall;
    procedure SetPassword(const password: UnicodeString); stdcall;
    procedure SetPropertie(name: UnicodeString; value: OleVariant); stdcall;
    procedure SetClassId(const classid: TGUID);
    function GetClassId: TGUID;
    property ClassId: TGUID read GetClassId write SetClassId;
  end;

  I7zCodec = interface
  ['{AB48F772-F6B1-411E-907F-1567DB0E93B3}']

  end;


  T7zStream = class(TInterfacedObject, IInStream, IStreamGetSize,
    ISequentialOutStream, ISequentialInStream, IOutStream, IOutStreamFlush)
  private
    FStream: TStream;
    FOwnership: TStreamOwnership;
  protected
    function Read(data: Pointer; size: Cardinal; processedSize: PCardinal): HRESULT; stdcall;
    function Seek(offset: Int64; seekOrigin: Cardinal; newPosition: Pint64): HRESULT; stdcall;
    function GetSize(size: PInt64): HRESULT; stdcall;
    function SetSize(newSize: Int64): HRESULT; stdcall;
    function Write(data: Pointer; size: Cardinal; processedSize: PCardinal): HRESULT; stdcall;
    function Flush: HRESULT; stdcall;
  public
    constructor Create(Stream: TStream; Ownership: TStreamOwnership = soReference);
    destructor Destroy; override;
  end;

  // I7zOutArchive property setters
type
  TZipCompressionMethod = (mzCopy, mzDeflate, mzDeflate64, mzBZip2);
  T7zCompressionMethod = (m7Copy, m7LZMA, m7BZip2, m7PPMd, m7Deflate, m7Deflate64);
                                                                                              //  ZIP 7z GZIP BZ2
  procedure SetCompressionLevel(Arch: I7zOutArchive; level: Cardinal);                        //   X   X   X   X
  procedure SetMultiThreading(Arch: I7zOutArchive; ThreadCount: Cardinal);                    //   X   X       X

  procedure SetCompressionMethod(Arch: I7zOutArchive; method: TZipCompressionMethod);         //   X
  procedure SetDictionnarySize(Arch: I7zOutArchive; size: Cardinal); // < 32                  //   X           X
  procedure SetDeflateNumPasses(Arch: I7zOutArchive; pass: Cardinal);                         //   X       X   X
  procedure SetNumFastBytes(Arch: I7zOutArchive; fb: Cardinal);                               //   X       X
  procedure SetNumMatchFinderCycles(Arch: I7zOutArchive; mc: Cardinal);                       //   X       X

  procedure SevenZipSetCompressionMethod(Arch: I7zOutArchive; method: T7zCompressionMethod);  //       X
  procedure SevenZipSetBindInfo(Arch: I7zOutArchive; const bind: UnicodeString);                 //       X
  procedure SevenZipSetSolidSettings(Arch: I7zOutArchive; solid: boolean);                    //       X
  procedure SevenZipRemoveSfxBlock(Arch: I7zOutArchive; remove: boolean);                     //       X
  procedure SevenZipAutoFilter(Arch: I7zOutArchive; auto: boolean);                           //       X
  procedure SevenZipCompressHeaders(Arch: I7zOutArchive; compress: boolean);                  //       X
  procedure SevenZipCompressHeadersFull(Arch: I7zOutArchive; compress: boolean);              //       X
  procedure SevenZipEncryptHeaders(Arch: I7zOutArchive; Encrypt: boolean);                    //       X
  procedure SevenZipVolumeMode(Arch: I7zOutArchive; Mode: boolean);                           //       X

  // filetime util functions
  function DateTimeToFileTime(dt: TDateTime): TFileTime;
  function FileTimeToDateTime(ft: TFileTime): TDateTime;
  function CurrentFileTime: TFileTime;

  // constructors

  function CreateInArchive(const classid: TGUID): I7zInArchive;
  function CreateOutArchive(const classid: TGUID): I7zOutArchive;

const
  CLSID_CFormatZip      : TGUID = '{23170F69-40C1-278A-1000-000110010000}'; // zip jar xpi
  CLSID_CFormatBZ2      : TGUID = '{23170F69-40C1-278A-1000-000110020000}'; // bz2 bzip2 tbz2 tbz
  CLSID_CFormatRar      : TGUID = '{23170F69-40C1-278A-1000-000110030000}'; // rar r00
  CLSID_CFormatArj      : TGUID = '{23170F69-40C1-278A-1000-000110040000}'; // arj
  CLSID_CFormatZ        : TGUID = '{23170F69-40C1-278A-1000-000110050000}'; // z taz
  CLSID_CFormatLzh      : TGUID = '{23170F69-40C1-278A-1000-000110060000}'; // lzh lha
  CLSID_CFormat7z       : TGUID = '{23170F69-40C1-278A-1000-000110070000}'; // 7z
  CLSID_CFormatCab      : TGUID = '{23170F69-40C1-278A-1000-000110080000}'; // cab
  CLSID_CFormatNsis     : TGUID = '{23170F69-40C1-278A-1000-000110090000}';
  CLSID_CFormatLzma     : TGUID = '{23170F69-40C1-278A-1000-0001100A0000}'; // lzma lzma86
  CLSID_CFormatPe       : TGUID = '{23170F69-40C1-278A-1000-000110DD0000}';
  CLSID_CFormatElf      : TGUID = '{23170F69-40C1-278A-1000-000110DE0000}';
  CLSID_CFormatMacho    : TGUID = '{23170F69-40C1-278A-1000-000110DF0000}';
  CLSID_CFormatUdf      : TGUID = '{23170F69-40C1-278A-1000-000110E00000}'; // iso
  CLSID_CFormatXar      : TGUID = '{23170F69-40C1-278A-1000-000110E10000}'; // xar
  CLSID_CFormatMub      : TGUID = '{23170F69-40C1-278A-1000-000110E20000}';
  CLSID_CFormatHfs      : TGUID = '{23170F69-40C1-278A-1000-000110E30000}';
  CLSID_CFormatDmg      : TGUID = '{23170F69-40C1-278A-1000-000110E40000}'; // dmg
  CLSID_CFormatCompound : TGUID = '{23170F69-40C1-278A-1000-000110E50000}'; // msi doc xls ppt
  CLSID_CFormatWim      : TGUID = '{23170F69-40C1-278A-1000-000110E60000}'; // wim swm
  CLSID_CFormatIso      : TGUID = '{23170F69-40C1-278A-1000-000110E70000}'; // iso
  CLSID_CFormatBkf      : TGUID = '{23170F69-40C1-278A-1000-000110E80000}';
  CLSID_CFormatChm      : TGUID = '{23170F69-40C1-278A-1000-000110E90000}'; // chm chi chq chw hxs hxi hxr hxq hxw lit
  CLSID_CFormatSplit    : TGUID = '{23170F69-40C1-278A-1000-000110EA0000}'; // 001
  CLSID_CFormatRpm      : TGUID = '{23170F69-40C1-278A-1000-000110EB0000}'; // rpm
  CLSID_CFormatDeb      : TGUID = '{23170F69-40C1-278A-1000-000110EC0000}'; // deb
  CLSID_CFormatCpio     : TGUID = '{23170F69-40C1-278A-1000-000110ED0000}'; // cpio
  CLSID_CFormatTar      : TGUID = '{23170F69-40C1-278A-1000-000110EE0000}'; // tar
  CLSID_CFormatGZip     : TGUID = '{23170F69-40C1-278A-1000-000110EF0000}'; // gz gzip tgz tpz

implementation

const
  MAXCHECK : int64 = (1 shl 20);
  ZipCompressionMethod: array[TZipCompressionMethod] of UnicodeString = ('COPY', 'DEFLATE', 'DEFLATE64', 'BZIP2');
  SevCompressionMethod: array[T7zCompressionMethod] of UnicodeString = ('COPY', 'LZMA', 'BZIP2', 'PPMD', 'DEFLATE', 'DEFLATE64');

function DateTimeToFileTime(dt: TDateTime): TFileTime;
var
  st: TSystemTime;
begin
  DateTimeToSystemTime(dt, st);
  if not (SystemTimeToFileTime(st, Result) and LocalFileTimeToFileTime(Result, Result))
    then RaiseLastOSError;
end;

function FileTimeToDateTime(ft: TFileTime): TDateTime;
var
  st: TSystemTime;
begin
  if not (FileTimeToLocalFileTime(ft, ft) and FileTimeToSystemTime(ft, st)) then
    RaiseLastOSError;
  Result := SystemTimeToDateTime(st);
end;

function CurrentFileTime: TFileTime;
begin
  GetSystemTimeAsFileTime(Result);
end;

procedure RINOK(const hr: HRESULT);
begin
  if hr <> S_OK then
    raise Exception.Create(SysErrorMessage(hr));
end;

procedure SetCardinalProperty(arch: I7zOutArchive; const name: UnicodeString; card: Cardinal);
var
  value: OleVariant;
begin
  TPropVariant(value).vt := VT_UI4;
  TPropVariant(value).ulVal := card;
  arch.SetPropertie(name, value);
end;

procedure SetBooleanProperty(arch: I7zOutArchive; const name: UnicodeString; bool: boolean);
begin
  case bool of
    true: arch.SetPropertie(name, 'ON');
    false: arch.SetPropertie(name, 'OFF');
  end;
end;

procedure SetCompressionLevel(Arch: I7zOutArchive; level: Cardinal);
begin
  SetCardinalProperty(arch, 'X', level);
end;

procedure SetMultiThreading(Arch: I7zOutArchive; ThreadCount: Cardinal);
begin
  SetCardinalProperty(arch, 'MT', ThreadCount);
end;

procedure SetCompressionMethod(Arch: I7zOutArchive; method: TZipCompressionMethod);
begin
  Arch.SetPropertie('M', ZipCompressionMethod[method]);
end;

procedure SetDictionnarySize(Arch: I7zOutArchive; size: Cardinal);
begin
  SetCardinalProperty(arch, 'D', size);
end;

procedure SetDeflateNumPasses(Arch: I7zOutArchive; pass: Cardinal);
begin
  SetCardinalProperty(arch, 'PASS', pass);
end;

procedure SetNumFastBytes(Arch: I7zOutArchive; fb: Cardinal);
begin
  SetCardinalProperty(arch, 'FB', fb);
end;

procedure SetNumMatchFinderCycles(Arch: I7zOutArchive; mc: Cardinal);
begin
  SetCardinalProperty(arch, 'MC', mc);
end;

procedure SevenZipSetCompressionMethod(Arch: I7zOutArchive; method: T7zCompressionMethod);
begin
  Arch.SetPropertie('0', SevCompressionMethod[method]);
end;

procedure SevenZipSetBindInfo(Arch: I7zOutArchive; const bind: UnicodeString);
begin
  arch.SetPropertie('B', bind);
end;

procedure SevenZipSetSolidSettings(Arch: I7zOutArchive; solid: boolean);
begin
  SetBooleanProperty(Arch, 'S', solid);
end;

procedure SevenZipRemoveSfxBlock(Arch: I7zOutArchive; remove: boolean);
begin
  SetBooleanProperty(arch, 'RSFX', remove);
end;

procedure SevenZipAutoFilter(Arch: I7zOutArchive; auto: boolean);
begin
  SetBooleanProperty(arch, 'F', auto);
end;

procedure SevenZipCompressHeaders(Arch: I7zOutArchive; compress: boolean);
begin
  SetBooleanProperty(arch, 'HC', compress);
end;

procedure SevenZipCompressHeadersFull(Arch: I7zOutArchive; compress: boolean);
begin
  SetBooleanProperty(arch, 'HCF', compress);
end;

procedure SevenZipEncryptHeaders(Arch: I7zOutArchive; Encrypt: boolean);
begin
  SetBooleanProperty(arch, 'HE', Encrypt);
end;

procedure SevenZipVolumeMode(Arch: I7zOutArchive; Mode: boolean);
begin
  SetBooleanProperty(arch, 'V', Mode);
end;

type
  T7zPlugin = class(TInterfacedObject)
  private
    FHandle: THandle;
    FCreateObject: function(const clsid, iid :TGUID; var outObject): HRESULT; stdcall;
  public
    constructor Create(const lib: string); virtual;
    destructor Destroy; override;
    procedure CreateObject(const clsid, iid :TGUID; var obj);
  end;

  T7zCodec = class(T7zPlugin, I7zCodec, ICompressProgressInfo)
  private
    FGetMethodProperty: function(index: Cardinal; propID: NMethodPropID; var value: OleVariant): HRESULT; stdcall;
    FGetNumberOfMethods: function(numMethods: PCardinal): HRESULT; stdcall;
    function GetNumberOfMethods: Cardinal;
    function GetMethodProperty(index: Cardinal; propID: NMethodPropID): OleVariant;
    function GetName(const index: integer): string;
  protected
    function SetRatioInfo(inSize, outSize: PInt64): HRESULT; stdcall;
  public
    function GetDecoder(const index: integer): ICompressCoder;
    function GetEncoder(const index: integer): ICompressCoder;
    constructor Create(const lib: string); override;
    property MethodProperty[index: Cardinal; propID: NMethodPropID]: OleVariant read GetMethodProperty;
    property NumberOfMethods: Cardinal read GetNumberOfMethods;
    property Name[const index: integer]: string read GetName;
  end;

  T7zArchive = class(T7zPlugin)
  private
    FGetHandlerProperty: function(propID: NArchive; var value: OleVariant): HRESULT; stdcall;
    FClassId: TGUID;
    procedure SetClassId(const classid: TGUID);
    function GetClassId: TGUID;
  public
    function GetHandlerProperty(const propID: NArchive): OleVariant;
    function GetLibStringProperty(const Index: NArchive): string;
    function GetLibGUIDProperty(const Index: NArchive): TGUID;
    constructor Create(const lib: string); override;
    property HandlerProperty[const propID: NArchive]: OleVariant read GetHandlerProperty;
    property Name: string index kName read GetLibStringProperty;
    property ClassID: TGUID read GetClassId write SetClassId;
    property Extension: string index kExtension read GetLibStringProperty;
  end;

  T7zInArchive = class(T7zArchive, I7zInArchive, IProgress, IArchiveOpenCallback,
    IArchiveExtractCallback, ICryptoGetTextPassword, IArchiveOpenVolumeCallback,
    IArchiveOpenSetSubArchiveName)
  private
    FInArchive: IInArchive;
    FPasswordCallback: T7zPasswordCallback;
    FPasswordSender: Pointer;
    FProgressCallback: T7zProgressCallback;
    FProgressSender: Pointer;
    FStream: TStream;
    FPasswordIsDefined: Boolean;
    FPassword: UnicodeString;
    FSubArchiveMode: Boolean;
    FSubArchiveName: UnicodeString;
    FExtractCallBack: T7zGetStreamCallBack;
    FExtractSender: Pointer;
    FExtractPath: string;
    function GetInArchive: IInArchive;
    function GetItemProp(const Item: Cardinal; prop: PROPID): OleVariant;
  protected
    // I7zInArchive
    procedure OpenFile(const filename: string); stdcall;
    procedure OpenStream(stream: IInStream); stdcall;
    procedure Close; stdcall;
    function GetNumberOfItems: Cardinal; stdcall;
    function GetItemPath(const index: integer): UnicodeString; stdcall;
    function GetItemName(const index: integer): UnicodeString; stdcall;
    function GetItemSize(const index: integer): Cardinal; stdcall; stdcall;
    function GetItemIsFolder(const index: integer): boolean; stdcall;
    procedure ExtractItem(const item: Cardinal; Stream: TStream; test: longbool); stdcall;
    procedure ExtractItems(items: PCardArray; count: cardinal; test: longbool; sender: pointer; callback: T7zGetStreamCallBack); stdcall;
    procedure SetPasswordCallback(sender: Pointer; callback: T7zPasswordCallback); stdcall;
    procedure SetProgressCallback(sender: Pointer; callback: T7zProgressCallback); stdcall;
    procedure ExtractAll(test: longbool; sender: pointer; callback: T7zGetStreamCallBack); stdcall;
    procedure ExtractTo(const path: string); stdcall;
    procedure SetPassword(const password: UnicodeString); stdcall;
    // IArchiveOpenCallback
    function SetTotal(files, bytes: PInt64): HRESULT; overload; stdcall;
    function SetCompleted(files, bytes: PInt64): HRESULT; overload; stdcall;
    // IProgress
    function SetTotal(total: Int64): HRESULT;  overload; stdcall;
    function SetCompleted(completeValue: PInt64): HRESULT; overload; stdcall;
    // IArchiveExtractCallback
    function GetStream(index: Cardinal; var outStream: ISequentialOutStream;
      askExtractMode: NAskMode): HRESULT; overload; stdcall;
    function PrepareOperation(askExtractMode: NAskMode): HRESULT; stdcall;
    function SetOperationResult(resultEOperationResult: NExtOperationResult): HRESULT; overload; stdcall;
    // ICryptoGetTextPassword
    function CryptoGetTextPassword(var password: TBStr): HRESULT; stdcall;
    // IArchiveOpenVolumeCallback
    function GetProperty(propID: PROPID; var value: OleVariant): HRESULT; overload; stdcall;
    function GetStream(const name: PWideChar; var inStream: IInStream): HRESULT; overload; stdcall;
    // IArchiveOpenSetSubArchiveName
    function SetSubArchiveName(name: PWideChar): HRESULT; stdcall;

  public
    constructor Create(const lib: string); override;
    destructor Destroy; override;
    property InArchive: IInArchive read GetInArchive;
  end;

  T7zOutArchive = class(T7zArchive, I7zOutArchive, IArchiveUpdateCallback, ICryptoGetTextPassword2)
  private
    FOutArchive: IOutArchive;
    FBatchList: TObjectList;
    FProgressCallback: T7zProgressCallback;
    FProgressSender: Pointer;
    FPassword: UnicodeString;
    function GetOutArchive: IOutArchive;
  protected
    // I7zOutArchive
    procedure AddStream(Stream: TStream; Ownership: TStreamOwnership;
      Attributes: Cardinal; CreationTime, LastWriteTime: TFileTime;
      const Path: UnicodeString; IsFolder, IsAnti: boolean); stdcall;
    procedure AddFile(const Filename: TFileName; const Path: UnicodeString); stdcall;
    procedure AddFiles(const Dir, Path, Willcards: string; recurse: boolean); stdcall;
    procedure SaveToFile(const FileName: TFileName); stdcall;
    procedure SaveToStream(stream: TStream); stdcall;
    procedure SetProgressCallback(sender: Pointer; callback: T7zProgressCallback); stdcall;
    procedure CrearBatch; stdcall;
    procedure SetPassword(const password: UnicodeString); stdcall;
    procedure SetPropertie(name: UnicodeString; value: OleVariant); stdcall;
    // IProgress
    function SetTotal(total: Int64): HRESULT; stdcall;
    function SetCompleted(completeValue: PInt64): HRESULT; stdcall;
    // IArchiveUpdateCallback
    function GetUpdateItemInfo(index: Cardinal;
        newData: PInteger; // 1 - new data, 0 - old data
        newProperties: PInteger; // 1 - new properties, 0 - old properties
        indexInArchive: PCardinal // -1 if there is no in archive, or if doesn't matter
        ): HRESULT; stdcall;
    function GetProperty(index: Cardinal; propID: PROPID; var value: OleVariant): HRESULT; stdcall;
    function GetStream(index: Cardinal; var inStream: ISequentialInStream): HRESULT; stdcall;
    function SetOperationResult(operationResult: Integer): HRESULT; stdcall;
    // ICryptoGetTextPassword2
    function CryptoGetTextPassword2(passwordIsDefined: PInteger; var password: TBStr): HRESULT; stdcall;
  public
    constructor Create(const lib: string); override;
    destructor Destroy; override;
    property OutArchive: IOutArchive read GetOutArchive;
  end;

function CreateInArchive(const classid: TGUID): I7zInArchive;
begin
  Result := T7zInArchive.Create('7z.dll');
  Result.ClassId := classid;
end;

function CreateOutArchive(const classid: TGUID): I7zOutArchive;
begin
  Result := T7zOutArchive.Create('7z.dll');
  Result.ClassId := classid;
end;


{ T7zPlugin }

constructor T7zPlugin.Create(const lib: string);
begin
  FHandle := LoadLibrary(PChar(lib));
  if FHandle = 0 then
    raise exception.CreateFmt('Error loading library %s', [lib]);
  FCreateObject := GetProcAddress(FHandle, 'CreateObject');
  if not (Assigned(FCreateObject)) then
  begin
    FreeLibrary(FHandle);
    raise Exception.CreateFmt('%s is not a 7z library', [lib]);
  end;
end;

destructor T7zPlugin.Destroy;
begin
  FreeLibrary(FHandle);
  inherited;
end;

procedure T7zPlugin.CreateObject(const clsid, iid: TGUID; var obj);
var
  hr: HRESULT;
begin
  hr := FCreateObject(clsid, iid, obj);
  if failed(hr) then
    raise Exception.Create(SysErrorMessage(hr));
end;

{ T7zCodec }

constructor T7zCodec.Create(const lib: string);
begin
  inherited;
  FGetMethodProperty := GetProcAddress(FHandle, 'GetMethodProperty');
  FGetNumberOfMethods := GetProcAddress(FHandle, 'GetNumberOfMethods');
  if not (Assigned(FGetMethodProperty) and Assigned(FGetNumberOfMethods)) then
  begin
    FreeLibrary(FHandle);
    raise Exception.CreateFmt('%s is not a codec library', [lib]);
  end;
end;

function T7zCodec.GetDecoder(const index: integer): ICompressCoder;
var
  v: OleVariant;
begin
  v := MethodProperty[index, kDecoder];
  CreateObject(TPropVariant(v).puuid^, ICompressCoder, Result);
end;

function T7zCodec.GetEncoder(const index: integer): ICompressCoder;
var
  v: OleVariant;
begin
  v := MethodProperty[index, kEncoder];
  CreateObject(TPropVariant(v).puuid^, ICompressCoder, Result);
end;

function T7zCodec.GetMethodProperty(index: Cardinal;
  propID: NMethodPropID): OleVariant;
var
  hr: HRESULT;
begin
  hr := FGetMethodProperty(index, propID, Result);
  if Failed(hr) then
    raise Exception.Create(SysErrorMessage(hr));
end;

function T7zCodec.GetName(const index: integer): string;
begin
  Result := MethodProperty[index, kName_];
end;

function T7zCodec.GetNumberOfMethods: Cardinal;
var
  hr: HRESULT;
begin
  hr := FGetNumberOfMethods(@Result);
  if Failed(hr) then
    raise Exception.Create(SysErrorMessage(hr));
end;


function T7zCodec.SetRatioInfo(inSize, outSize: PInt64): HRESULT;
begin
  Result := S_OK;
end;

{ T7zInArchive }

procedure T7zInArchive.Close; stdcall;
begin
  FPasswordIsDefined := false;
  FSubArchiveMode := false;
  FInArchive.Close;
  FInArchive := nil;
end;

constructor T7zInArchive.Create(const lib: string);
begin
  inherited;
  FPasswordCallback := nil;
  FPasswordSender := nil;
  FPasswordIsDefined := false;
  FSubArchiveMode := false;
  FExtractCallBack := nil;
  FExtractSender := nil;
end;

destructor T7zInArchive.Destroy;
begin
  FInArchive := nil;
  inherited;
end;

function T7zInArchive.GetInArchive: IInArchive;
begin
  if FInArchive = nil then
    CreateObject(ClassID, IInArchive, FInArchive);
  Result := FInArchive;
end;

function T7zInArchive.GetItemPath(const index: integer): UnicodeString; stdcall;
begin
  Result := UnicodeString(GetItemProp(index, kpidPath));
end;

function T7zInArchive.GetNumberOfItems: Cardinal; stdcall;
begin
  RINOK(FInArchive.GetNumberOfItems(Result));
end;

procedure T7zInArchive.OpenFile(const filename: string); stdcall;
var
  strm: IInStream;
begin
  strm := T7zStream.Create(TFileStream.Create(filename, fmOpenRead or fmShareDenyNone), soOwned);
  try
    RINOK(
      InArchive.Open(
        strm,
          @MAXCHECK, self as IArchiveOpenCallBack
        )
      );
  finally
    strm := nil;
  end;
end;

procedure T7zInArchive.OpenStream(stream: IInStream); stdcall;
begin
  RINOK(InArchive.Open(stream, @MAXCHECK, self as IArchiveOpenCallBack));
end;

function T7zInArchive.GetItemIsFolder(const index: integer): boolean; stdcall;
begin
  Result := Boolean(GetItemProp(index, kpidIsFolder));
end;

function T7zInArchive.GetItemProp(const Item: Cardinal;
  prop: PROPID): OleVariant;
begin
  FInArchive.GetProperty(Item, prop, Result);
end;

procedure T7zInArchive.ExtractItem(const item: Cardinal; Stream: TStream; test: longbool); stdcall;
begin
  FStream := Stream;
  try
    if test then
      RINOK(FInArchive.Extract(@item, 1, 1, self as IArchiveExtractCallback)) else
      RINOK(FInArchive.Extract(@item, 1, 0, self as IArchiveExtractCallback));
  finally
    FStream := nil;
  end;
end;

function T7zInArchive.GetStream(index: Cardinal;
  var outStream: ISequentialOutStream; askExtractMode: NAskMode): HRESULT;
var
  path: string;
begin
  if askExtractMode = kExtract then
    if FStream <> nil then
      outStream := T7zStream.Create(FStream, soReference) as ISequentialOutStream else
    if assigned(FExtractCallback) then
    begin
      Result := FExtractCallBack(FExtractSender, index, outStream);
      Exit;
    end else
    if FExtractPath <> '' then
    begin
      if not GetItemIsFolder(index) then
      begin
        path := FExtractPath + GetItemPath(index);
        ForceDirectories(ExtractFilePath(path));
        outStream := T7zStream.Create(TFileStream.Create(path, fmCreate), soOwned);
      end;
    end;
  Result := S_OK;
end;

function T7zInArchive.PrepareOperation(askExtractMode: NAskMode): HRESULT;
begin
  Result := S_OK;
end;

function T7zInArchive.SetCompleted(completeValue: PInt64): HRESULT;
begin
  if Assigned(FProgressCallback) and (completeValue <> nil) then
    Result := FProgressCallback(FProgressSender, false, completeValue^) else
    Result := S_OK;
end;

function T7zInArchive.SetCompleted(files, bytes: PInt64): HRESULT;
begin
  Result := S_OK;
end;

function T7zInArchive.SetOperationResult(
  resultEOperationResult: NExtOperationResult): HRESULT;
begin
  Result := S_OK;
end;

function T7zInArchive.SetTotal(total: Int64): HRESULT;
begin
  if Assigned(FProgressCallback) then
    Result := FProgressCallback(FProgressSender, true, total) else
    Result := S_OK;
end;

function T7zInArchive.SetTotal(files, bytes: PInt64): HRESULT;
begin
  Result := S_OK;
end;

function T7zInArchive.CryptoGetTextPassword(var password: TBStr): HRESULT;
var
  wpass: UnicodeString;
begin
  if FPasswordIsDefined then
  begin
    password := SysAllocString(PWideChar(FPassword));
    Result := S_OK;
  end else
  if Assigned(FPasswordCallback) then
  begin
    Result := FPasswordCallBack(FPasswordSender, wpass);
    if Result = S_OK then
    begin
      password := SysAllocString(PWideChar(wpass));
      FPasswordIsDefined := True;
      FPassword := wpass;
    end;
  end else
    Result := S_FALSE;
end;

function T7zInArchive.GetProperty(propID: PROPID;
  var value: OleVariant): HRESULT;
begin
  Result := S_OK;
end;

function T7zInArchive.GetStream(const name: PWideChar;
  var inStream: IInStream): HRESULT;
begin
  Result := S_OK;
end;

procedure T7zInArchive.SetPasswordCallback(sender: Pointer;
  callback: T7zPasswordCallback); stdcall;
begin
  FPasswordSender := sender;
  FPasswordCallback := callback;
end;

function T7zInArchive.SetSubArchiveName(name: PWideChar): HRESULT;
begin
  FSubArchiveMode := true;
  FSubArchiveName := name;
  Result := S_OK;
end;

function T7zInArchive.GetItemName(const index: integer): UnicodeString; stdcall;
begin
  Result := UnicodeString(GetItemProp(index, kpidName));
end;

function T7zInArchive.GetItemSize(const index: integer): Cardinal; stdcall;
begin
  Result := Cardinal(GetItemProp(index, kpidSize));
end;

procedure T7zInArchive.ExtractItems(items: PCardArray; count: cardinal; test: longbool;
  sender: pointer; callback: T7zGetStreamCallBack); stdcall;
begin
  FExtractCallBack := callback;
  FExtractSender := sender;
  try
    if test then
      RINOK(FInArchive.Extract(items, count, 1, self as IArchiveExtractCallback)) else
      RINOK(FInArchive.Extract(items, count, 0, self as IArchiveExtractCallback));
  finally
    FExtractCallBack := nil;
    FExtractSender := nil;
  end;
end;

procedure T7zInArchive.SetProgressCallback(sender: Pointer;
  callback: T7zProgressCallback); stdcall;
begin
  FProgressSender := sender;
  FProgressCallback := callback;
end;

procedure T7zInArchive.ExtractAll(test: longbool; sender: pointer;
  callback: T7zGetStreamCallBack);
begin
  FExtractCallBack := callback;
  FExtractSender := sender;
  try
    if test then
      RINOK(FInArchive.Extract(nil, $FFFFFFFF, 1, self as IArchiveExtractCallback)) else
      RINOK(FInArchive.Extract(nil, $FFFFFFFF, 0, self as IArchiveExtractCallback));
  finally
    FExtractCallBack := nil;
    FExtractSender := nil;
  end;
end;

procedure T7zInArchive.ExtractTo(const path: string);
begin
  FExtractPath := IncludeTrailingPathDelimiter(path);
  try
    RINOK(FInArchive.Extract(nil, $FFFFFFFF, 0, self as IArchiveExtractCallback));
  finally
    FExtractPath := '';
  end;
end;

procedure T7zInArchive.SetPassword(const password: UnicodeString);
begin
  FPassword := password;
  FPasswordIsDefined :=  FPassword <> '';
end;

{ T7zArchive }

constructor T7zArchive.Create(const lib: string);
begin
  inherited;
  FGetHandlerProperty := GetProcAddress(FHandle, 'GetHandlerProperty');
  if not Assigned(FGetHandlerProperty) then
  begin
    FreeLibrary(FHandle);
    raise Exception.CreateFmt('%s is not a Format library', [lib]);
  end;
  FClassId := GUID_NULL;
end;

function T7zArchive.GetClassId: TGUID;
begin
  Result := FClassId;
end;

function T7zArchive.GetHandlerProperty(const propID: NArchive): OleVariant;
var
  hr: HRESULT;
begin
  hr := FGetHandlerProperty(propID, Result);
  if Failed(hr) then
    raise Exception.Create(SysErrorMessage(hr));
end;

function T7zArchive.GetLibGUIDProperty(const Index: NArchive): TGUID;
var
  v: OleVariant;
begin
  v := HandlerProperty[index];
  Result := TPropVariant(v).puuid^;
end;

function T7zArchive.GetLibStringProperty(const Index: NArchive): string;
begin
  Result := HandlerProperty[Index];
end;

procedure T7zArchive.SetClassId(const classid: TGUID);
begin
  FClassId := classid;
end;

{ T7zStream }

constructor T7zStream.Create(Stream: TStream; Ownership: TStreamOwnership);
begin
  inherited Create;
  FStream := Stream;
  FOwnership := Ownership;
end;

destructor T7zStream.destroy;
begin
  if FOwnership = soOwned then
  begin
    FStream.Free;
    FStream := nil;
  end;
  inherited;
end;

function T7zStream.Flush: HRESULT;
begin
  Result := S_OK;
end;

function T7zStream.GetSize(size: PInt64): HRESULT;
begin
  if size <> nil then
    size^ := FStream.Size;
  Result := S_OK;
end;

function T7zStream.Read(data: Pointer; size: Cardinal;
  processedSize: PCardinal): HRESULT;
var
  len: integer;
begin
  len := FStream.Read(data^, size);
  if processedSize <> nil then
    processedSize^ := len;
  Result := S_OK;
end;

function T7zStream.Seek(offset: Int64; seekOrigin: Cardinal;
  newPosition: PInt64): HRESULT;
begin
  FStream.Seek(offset, TSeekOrigin(seekOrigin));
  if newPosition <> nil then
    newPosition^ := FStream.Position;
  Result := S_OK;
end;

function T7zStream.SetSize(newSize: Int64): HRESULT;
begin
  FStream.Size := newSize;
  Result := S_OK;
end;

function T7zStream.Write(data: Pointer; size: Cardinal;
  processedSize: PCardinal): HRESULT;
var
  len: integer;
begin
  len := FStream.Write(data^, size);
  if processedSize <> nil then
    processedSize^ := len;
  Result := S_OK;
end;

type
  TSourceMode = (smStream, smFile);

  T7zBatchItem = class
    SourceMode: TSourceMode;
    Stream: TStream;
    Attributes: Cardinal;
    CreationTime, LastWriteTime: TFileTime;
    Path: UnicodeString;
    IsFolder, IsAnti: boolean;
    FileName: TFileName;
    Ownership: TStreamOwnership;
    Size: Cardinal;
    destructor Destroy; override;
  end;

destructor T7zBatchItem.Destroy;
begin
  if (Ownership = soOwned) and (Stream <> nil) then
    Stream.Free;
  inherited;
end;

{ T7zOutArchive }

procedure T7zOutArchive.AddFile(const Filename: TFileName; const Path: UnicodeString);
var
  item: T7zBatchItem;
  Handle: THandle;
begin
  if not FileExists(Filename) then exit;
  item := T7zBatchItem.Create;
  Item.SourceMode := smFile;
  item.Stream := nil;
  item.FileName := Filename;
  item.Path := Path;
  Handle := FileOpen(Filename, fmOpenRead or fmShareDenyNone);
  GetFileTime(Handle, @item.CreationTime, nil, @item.LastWriteTime);
  item.Size := GetFileSize(Handle, nil);
  CloseHandle(Handle);
  item.Attributes := GetFileAttributes(PChar(Filename));
  item.IsFolder := false;
  item.IsAnti := False;
  item.Ownership := soOwned;
  FBatchList.Add(item);
end;

procedure T7zOutArchive.AddFiles(const Dir, Path, Willcards: string; recurse: boolean);
var
  lencut: integer;
  willlist: TStringList;
  zedir: string;
  procedure Traverse(p: string);
  var
    f: TSearchRec;
    i: integer;
    item: T7zBatchItem;
  begin
    if recurse then
    begin
      if FindFirst(p + '*.*', faDirectory, f) = 0 then
      repeat
        if (f.Name[1] <> '.') then
          Traverse(IncludeTrailingPathDelimiter(p + f.Name));
      until FindNext(f) <> 0;
      SysUtils.FindClose(f);
    end;

    for i := 0 to willlist.Count - 1 do
    begin
      if FindFirst(p + willlist[i], faReadOnly or faHidden or faSysFile or faArchive, f) = 0 then
      repeat
        item := T7zBatchItem.Create;
        Item.SourceMode := smFile;
        item.Stream := nil;
        item.FileName := p + f.Name;
        item.Path := copy(item.FileName, lencut, length(item.FileName) - lencut + 1);
        if path <> '' then
          item.Path := IncludeTrailingPathDelimiter(path) + item.Path;
        item.CreationTime := f.FindData.ftCreationTime;
        item.LastWriteTime := f.FindData.ftLastWriteTime;
        item.Attributes := f.FindData.dwFileAttributes;
        item.Size := f.Size;
        item.IsFolder := false;
        item.IsAnti := False;
        item.Ownership := soOwned;
        FBatchList.Add(item);
      until FindNext(f) <> 0;
      SysUtils.FindClose(f);
    end;
  end;
begin
  willlist := TStringList.Create;
  try
    willlist.Delimiter := ';';
    willlist.DelimitedText := Willcards;
    zedir := IncludeTrailingPathDelimiter(Dir);
    lencut := Length(zedir) + 1;
    Traverse(zedir);
  finally
    willlist.Free;
  end;
end;

procedure T7zOutArchive.AddStream(Stream: TStream; Ownership: TStreamOwnership;
  Attributes: Cardinal; CreationTime, LastWriteTime: TFileTime;
  const Path: UnicodeString; IsFolder, IsAnti: boolean); stdcall;
var
  item: T7zBatchItem;
begin
  item := T7zBatchItem.Create;
  Item.SourceMode := smStream;
  item.Attributes := Attributes;
  item.CreationTime := CreationTime;
  item.LastWriteTime := LastWriteTime;
  item.Path := Path;
  item.IsFolder := IsFolder;
  item.IsAnti := IsAnti;
  item.Stream := Stream;
  item.Size := Stream.Size;
  item.Ownership := Ownership;
  FBatchList.Add(item);
end;

procedure T7zOutArchive.CrearBatch;
begin
  FBatchList.Clear;
end;

constructor T7zOutArchive.Create(const lib: string);
begin
  inherited;
  FBatchList := TObjectList.Create;
  FProgressCallback := nil;
  FProgressSender := nil;
end;

function T7zOutArchive.CryptoGetTextPassword2(passwordIsDefined: PInteger;
  var password: TBStr): HRESULT;
begin
  if FPassword <> '' then
  begin
   passwordIsDefined^ := 1;
   password := SysAllocString(PWideChar(FPassword));
  end else
    passwordIsDefined^ := 0;
  Result := S_OK;
end;

destructor T7zOutArchive.Destroy;
begin
  FOutArchive := nil;
  FBatchList.Free;
  inherited;
end;

function T7zOutArchive.GetOutArchive: IOutArchive;
begin
  if FOutArchive = nil then
    CreateObject(ClassID, IOutArchive, FOutArchive);
  Result := FOutArchive;
end;

function T7zOutArchive.GetProperty(index: Cardinal; propID: PROPID;
  var value: OleVariant): HRESULT;
var
  item: T7zBatchItem;
begin
  item := T7zBatchItem(FBatchList[index]);
  case propID of
    kpidAttributes:
      begin
        TPropVariant(Value).vt := VT_UI4;
        TPropVariant(Value).ulVal := item.Attributes;
      end;
    kpidLastWriteTime:
      begin
        TPropVariant(value).vt := VT_FILETIME;
        TPropVariant(value).filetime := item.LastWriteTime;
      end;
    kpidPath:
      begin
        if item.Path <> '' then
          value := item.Path;
      end;
    kpidIsFolder: Value := item.IsFolder;
    kpidSize:
      begin
        TPropVariant(Value).vt := VT_UI8;
        TPropVariant(Value).uhVal.QuadPart := item.Size;
      end;
    kpidCreationTime:
      begin
        TPropVariant(value).vt := VT_FILETIME;
        TPropVariant(value).filetime := item.CreationTime;
      end;
    kpidIsAnti: value := item.IsAnti;
  else
   // beep(0,0);
  end;
  Result := S_OK;
end;

function T7zOutArchive.GetStream(index: Cardinal;
  var inStream: ISequentialInStream): HRESULT;
var
  item: T7zBatchItem;
begin
  item := T7zBatchItem(FBatchList[index]);
  case item.SourceMode of
    smFile: inStream := T7zStream.Create(TFileStream.Create(item.FileName, fmOpenRead or fmShareDenyNone), soOwned);
    smStream:
      begin
        item.Stream.Seek(0, soFromBeginning);
        inStream := T7zStream.Create(item.Stream);
      end;
  end;
  Result := S_OK;
end;

function T7zOutArchive.GetUpdateItemInfo(index: Cardinal; newData,
  newProperties: PInteger; indexInArchive: PCardinal): HRESULT;
begin
  newData^ := 1;
  newProperties^ := 1;
  indexInArchive^ := CArdinal(-1);
  Result := S_OK;
end;

procedure T7zOutArchive.SaveToFile(const FileName: TFileName);
var
  f: TFileStream;
begin
  f := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(f);
  finally
    f.free;
  end;
end;

procedure T7zOutArchive.SaveToStream(stream: TStream);
var
  strm: ISequentialOutStream;
begin
  strm := T7zStream.Create(stream);
  try
    RINOK(OutArchive.UpdateItems(strm, FBatchList.Count, self as IArchiveUpdateCallback));
  finally
    strm := nil;
  end;
end;

function T7zOutArchive.SetCompleted(completeValue: PInt64): HRESULT;
begin
  if Assigned(FProgressCallback) and (completeValue <> nil) then
    Result := FProgressCallback(FProgressSender, false, completeValue^) else
    Result := S_OK;
end;

function T7zOutArchive.SetOperationResult(
  operationResult: Integer): HRESULT;
begin
  Result := S_OK;
end;

procedure T7zOutArchive.SetPassword(const password: UnicodeString);
begin
  FPassword := password;
end;

procedure T7zOutArchive.SetProgressCallback(sender: Pointer;
  callback: T7zProgressCallback);
begin
  FProgressCallback := callback;
  FProgressSender := sender;
end;

procedure T7zOutArchive.SetPropertie(name: UnicodeString;
  value: OleVariant);
var
  intf: ISetProperties;
  p: PWideChar;
begin
  intf := OutArchive as ISetProperties;
  p := PWideChar(name);
  RINOK(intf.SetProperties(@p, @TPropVariant(value), 1));
end;

function T7zOutArchive.SetTotal(total: Int64): HRESULT;
begin
  if Assigned(FProgressCallback) then
    Result := FProgressCallback(FProgressSender, true, total) else
    Result := S_OK;
end;

end.










