object frmMain: TfrmMain
  Left = 264
  Top = 111
  Caption = 'Windows API Importer'
  ClientHeight = 881
  ClientWidth = 1955
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 84
    Height = 21
    AutoSize = False
    Caption = 'Folder to process:'
    Layout = tlCenter
  end
  object Label2: TLabel
    Left = 24
    Top = 96
    Width = 55
    Height = 13
    Caption = 'Total Lines:'
  end
  object lblTotalLines: TLabel
    Left = 88
    Top = 96
    Width = 49
    Height = 13
    AutoSize = False
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 24
    Top = 120
    Width = 44
    Height = 13
    Caption = 'Imported:'
  end
  object lblImported: TLabel
    Left = 88
    Top = 120
    Width = 49
    Height = 13
    AutoSize = False
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object txtFile: TEdit
    Left = 144
    Top = 16
    Width = 553
    Height = 21
    TabOrder = 0
    Text = 'C:\masm32\include\'
  end
  object btnImport: TButton
    Left = 24
    Top = 56
    Width = 113
    Height = 25
    Caption = 'Import WinAPI'
    Default = True
    TabOrder = 1
    OnClick = btnImportClick
  end
  object memResult: TMemo
    Left = 607
    Top = 56
    Width = 458
    Height = 281
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object lstProcessedFiles: TListBox
    Left = 144
    Top = 56
    Width = 457
    Height = 281
    ItemHeight = 13
    TabOrder = 3
  end
  object memDelphiSource: TMemo
    Left = 144
    Top = 343
    Width = 921
    Height = 266
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object btnImportEQU: TButton
    Left = 24
    Top = 144
    Width = 113
    Height = 25
    Caption = 'Import EQU'
    TabOrder = 5
    OnClick = btnImportEQUClick
  end
  object btnCreateWinAPIFile: TButton
    Left = 24
    Top = 176
    Width = 113
    Height = 25
    Caption = 'Create WinAPI File'
    TabOrder = 6
    OnClick = btnCreateWinAPIFileClick
  end
  object memParams: TMemo
    Left = 1071
    Top = 55
    Width = 431
    Height = 554
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 7
  end
  object memProto: TMemo
    Left = 144
    Top = 615
    Width = 1358
    Height = 258
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 8
  end
  object memFiles: TMemo
    Left = 1508
    Top = 55
    Width = 431
    Height = 818
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 9
  end
  object btnImportApis: TButton
    Left = 25
    Top = 207
    Width = 113
    Height = 25
    Caption = 'Import APIs'
    TabOrder = 10
    OnClick = btnImportApisClick
  end
end
