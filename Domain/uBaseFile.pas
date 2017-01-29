unit uBaseFile;

interface

uses
  SysUtils, Classes, uDomainObject, uSharedGlobals;

type
  PBaseFile = ^TBaseFile;
  TBaseFile = class(TDomainObject)
    private
      FPlatformType: TPlatformType;
      FOriginalFileName: string;
      FFoundFileName: string;
      FMD5Hash: string;
      FDownloadURL: string;
      FCopyright: string;
      FWebSiteURL: string;
      FWebSiteName: string;
      FProductName: string;
      procedure Initialize;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
      property PlatformType: TPlatformType read FPlatformType write FPlatformType;
      property MD5Hash: string read FMD5Hash write FMD5Hash;
      property DownloadURL: string read FDownloadURL write FDownloadURL;
      property Copyright: string read FCopyright write FCopyright;
      property WebSiteURL: string read FWebSiteURL write FWebSiteURL;
      property WebSiteName: string read FWebSiteName write FWebSiteName;
      property ProductName: string read FProductName write FProductName;
      property FoundFileName: string read FFoundFileName write FFoundFileName;
      property OriginalFileName: string read FOriginalFileName write FOriginalFileName;
  end;

implementation

procedure TBaseFile.Initialize;
begin
  FPlatformType := p32BitWin;
  FMD5Hash := '';
  FDownloadURL := '';
end;

constructor TBaseFile.Create;
begin
  inherited Create;
  Initialize;
end;

constructor TBaseFile.Create(name: string);
begin
  inherited Create(name);
  Initialize;
end;

end.
 