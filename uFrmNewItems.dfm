object frmNewItems: TfrmNewItems
  Left = 609
  Top = 255
  BorderIcons = [biSystemMenu]
  Caption = 'New Items'
  ClientHeight = 479
  ClientWidth = 668
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Splitter1: TSplitter
    Left = 193
    Top = 0
    Height = 438
    ExplicitLeft = 184
    ExplicitTop = 8
    ExplicitHeight = 359
  end
  object lstItems: TListView
    Left = 196
    Top = 0
    Width = 472
    Height = 438
    Align = alClient
    BevelInner = bvNone
    Columns = <>
    HideSelection = False
    LargeImages = dm.iml64x64
    ReadOnly = True
    TabOrder = 0
    OnDblClick = lstItemsDblClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 438
    Width = 668
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      668
      41)
    object btnCancel: TButton
      Left = 504
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight]
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnOk: TButton
      Left = 585
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight]
      Caption = 'Ok'
      Default = True
      TabOrder = 1
      OnClick = btnOkClick
    end
  end
  object tvTree: TTreeView
    Left = 0
    Top = 0
    Width = 193
    Height = 438
    Align = alLeft
    Indent = 19
    TabOrder = 2
    OnChange = tvTreeChange
  end
end
