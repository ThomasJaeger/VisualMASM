object frmGoToLineNumber: TfrmGoToLineNumber
  Left = 770
  Top = 306
  BorderIcons = [biSystemMenu]
  Caption = 'Go to Line Number'
  ClientHeight = 98
  ClientWidth = 268
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 28
    Width = 108
    Height = 13
    Caption = 'Enter new line number:'
  end
  object spnLine: TSpinEdit
    Left = 130
    Top = 25
    Width = 71
    Height = 22
    MaxValue = 99999
    MinValue = 1
    TabOrder = 0
    Value = 1
  end
  object btnOk: TButton
    Left = 185
    Top = 65
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 104
    Top = 65
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
