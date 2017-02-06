object frmMain: TfrmMain
  Left = 264
  Top = 111
  Caption = 'Windows API Importer'
  ClientHeight = 782
  ClientWidth = 1323
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    1323
    782)
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
    Left = 704
    Top = 56
    Width = 609
    Height = 329
    Anchors = [akLeft, akTop, akRight]
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
    Width = 553
    Height = 329
    ItemHeight = 13
    TabOrder = 3
  end
  object memDelphiSource: TMemo
    Left = 144
    Top = 392
    Width = 1161
    Height = 393
    Anchors = [akLeft, akTop, akRight]
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
end
