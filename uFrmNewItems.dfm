object frmNewItems: TfrmNewItems
  Left = 609
  Top = 255
  BorderIcons = [biSystemMenu]
  Caption = 'New Items'
  ClientHeight = 400
  ClientWidth = 644
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 159
    Top = 0
    Height = 359
    ExplicitLeft = 184
    ExplicitTop = 8
  end
  object lstItems: TListView
    Left = 162
    Top = 0
    Width = 482
    Height = 359
    Align = alClient
    BevelInner = bvNone
    Columns = <>
    HideSelection = False
    LargeImages = dm.iml64x64
    ReadOnly = True
    TabOrder = 0
    OnDblClick = lstItemsDblClick
    ExplicitLeft = 165
    ExplicitTop = 4
  end
  object Panel1: TPanel
    Left = 0
    Top = 359
    Width = 644
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnCancel: TButton
      Left = 479
      Top = 10
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnOk: TButton
      Left = 560
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Ok'
      Default = True
      TabOrder = 1
      OnClick = btnOkClick
    end
  end
  object tvTree: TTreeView
    Left = 0
    Top = 0
    Width = 159
    Height = 359
    Align = alLeft
    Indent = 19
    TabOrder = 2
    OnChange = tvTreeChange
  end
end
