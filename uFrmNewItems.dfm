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
  object sSplitter1: TsSplitter
    Left = 168
    Top = 0
    Height = 360
    SkinData.SkinSection = 'SPLITTER'
    ExplicitHeight = 372
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 360
    Width = 644
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'TRANSPARENT'
    DesignSize = (
      644
      40)
    object btnOk: TsButton
      Left = 568
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Ok'
      TabOrder = 0
      OnClick = btnOkClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnCancel: TsButton
      Left = 481
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object tvTree: TsTreeView
    Left = 0
    Top = 0
    Width = 168
    Height = 360
    Align = alLeft
    Color = 1710618
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 14013909
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    HideSelection = False
    Indent = 19
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    OnChange = tvTreeChange
    SkinData.SkinSection = 'EDIT'
  end
  object lstItems: TListView
    Left = 174
    Top = 0
    Width = 470
    Height = 360
    Align = alClient
    BevelInner = bvNone
    Columns = <>
    HideSelection = False
    LargeImages = dm.iml64x64Icons
    ReadOnly = True
    TabOrder = 0
    OnDblClick = lstItemsDblClick
  end
end
