object frmAbout: TfrmAbout
  Left = 700
  Top = 250
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 408
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 18
  object sLabel1: TsLabel
    Left = 29
    Top = 234
    Width = 425
    Height = 19
    Alignment = taCenter
    AutoSize = False
    Caption = 'Visual MASM'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object lblVersion: TsLabel
    Left = 29
    Top = 266
    Width = 425
    Height = 19
    Alignment = taCenter
    AutoSize = False
    Caption = 'Version 2.0'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object lblCopyright: TsLabel
    Left = 8
    Top = 339
    Width = 465
    Height = 19
    Alignment = taCenter
    AutoSize = False
    Caption = 'Copyright (c) 2014 - 2017 by Thomas Jaeger. All Rights Reserved.'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object sWebLabel1: TsWebLabel
    Left = 29
    Top = 315
    Width = 425
    Height = 26
    Alignment = taCenter
    AutoSize = False
    Caption = 'www.visualmasm.com'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    HoverFont.Charset = DEFAULT_CHARSET
    HoverFont.Color = clWindowText
    HoverFont.Height = -15
    HoverFont.Name = 'Tahoma'
    HoverFont.Style = []
    URL = 'http://www.visualmasm.com'
  end
  object sImage1: TsImage
    Left = 105
    Top = 40
    Width = 256
    Height = 183
    AutoSize = True
    Picture.Data = {07544269746D617000000000}
    ImageIndex = 0
    Images = dm.sAlphaImageList1
    SkinData.SkinSection = 'CHECKBOX'
  end
  object lblMD5: TsLabel
    Left = 29
    Top = 290
    Width = 425
    Height = 19
    Alignment = taCenter
    AutoSize = False
    Caption = 'MD5: calculating...'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object btnClose: TsButton
    Left = 198
    Top = 376
    Width = 86
    Height = 25
    Cancel = True
    Caption = 'Close'
    Default = True
    TabOrder = 0
    OnClick = btnCloseClick
    SkinData.SkinSection = 'SPEEDBUTTON'
  end
end
