object frmGoToLineNumber: TfrmGoToLineNumber
  Left = 770
  Top = 306
  Width = 284
  Height = 126
  BorderIcons = [biSystemMenu]
  Caption = 'Go to Line Number'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    Left = 16
    Top = 24
    Width = 108
    Height = 21
    AutoSize = False
    Caption = 'Enter new line number:'
    Layout = tlCenter
  end
  object spnLine: TsSpinEdit
    Left = 136
    Top = 24
    Width = 113
    Height = 21
    Color = 1710618
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 10329501
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = '1'
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    MaxValue = 99999
    MinValue = 1
    Value = 1
  end
  object sButton1: TsButton
    Left = 192
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
    SkinData.SkinSection = 'BUTTON'
  end
  object sButton2: TsButton
    Left = 104
    Top = 64
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    SkinData.SkinSection = 'BUTTON'
  end
end
