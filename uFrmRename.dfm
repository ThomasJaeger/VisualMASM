object frmRename: TfrmRename
  Left = 828
  Top = 320
  Width = 351
  Height = 193
  BorderIcons = [biSystemMenu]
  Caption = 'Rename'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    343
    166)
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    Left = 16
    Top = 16
    Width = 66
    Height = 13
    Caption = 'Current name:'
  end
  object sLabel2: TsLabel
    Left = 16
    Top = 72
    Width = 54
    Height = 13
    Caption = 'New name:'
  end
  object btnRename: TsButton
    Left = 258
    Top = 133
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Rename'
    Default = True
    ModalResult = 1
    TabOrder = 2
    SkinData.SkinSection = 'BUTTON'
  end
  object btnCancel: TsButton
    Left = 170
    Top = 133
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    SkinData.SkinSection = 'BUTTON'
  end
  object txtCurrentName: TsEdit
    Left = 16
    Top = 32
    Width = 315
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Color = 1710618
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 10329501
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
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
  end
  object txtNewName: TsEdit
    Left = 16
    Top = 88
    Width = 315
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Color = 1710618
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 10329501
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
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
  end
end
