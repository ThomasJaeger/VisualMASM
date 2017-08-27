inherited TextReplaceDialog: TTextReplaceDialog
  Caption = 'Replace Text'
  ClientHeight = 210
  Font.Height = -13
  OldCreateOrder = True
  ExplicitWidth = 338
  ExplicitHeight = 239
  PixelsPerInch = 96
  TextHeight = 16
  inherited Label1: TLabel
    Width = 64
    Height = 16
    ExplicitWidth = 64
    ExplicitHeight = 16
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 41
    Width = 80
    Height = 16
    Caption = '&Replace with:'
  end
  inherited cbSearchText: TComboBox
    Height = 24
    ExplicitHeight = 24
  end
  inherited gbSearchOptions: TGroupBox
    Top = 70
    TabOrder = 2
    ExplicitTop = 70
  end
  inherited rgSearchDirection: TRadioGroup
    Top = 70
    TabOrder = 3
    ExplicitTop = 70
  end
  inherited btnOK: TButton
    Top = 179
    TabOrder = 4
    ExplicitTop = 179
  end
  inherited btnCancel: TButton
    Top = 179
    TabOrder = 5
    ExplicitTop = 179
  end
  object cbReplaceText: TComboBox
    Left = 96
    Top = 37
    Width = 228
    Height = 24
    TabOrder = 1
  end
end
