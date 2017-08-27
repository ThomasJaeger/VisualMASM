object frmRename: TfrmRename
  Left = 828
  Top = 320
  BorderIcons = [biSystemMenu]
  Caption = 'Rename'
  ClientHeight = 166
  ClientWidth = 364
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 16
    Top = 13
    Width = 82
    Height = 16
    Caption = 'Current name:'
  end
  object Label2: TLabel
    Left = 16
    Top = 69
    Width = 67
    Height = 16
    Caption = 'New name:'
  end
  object txtCurrentName: TEdit
    Left = 16
    Top = 32
    Width = 329
    Height = 24
    TabOrder = 0
  end
  object txtNewName: TEdit
    Left = 16
    Top = 88
    Width = 329
    Height = 24
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 175
    Top = 133
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnRename: TButton
    Left = 270
    Top = 133
    Width = 75
    Height = 25
    Caption = 'Rename'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
end
