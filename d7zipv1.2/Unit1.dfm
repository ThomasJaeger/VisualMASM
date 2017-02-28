object Form1: TForm1
  Left = 554
  Top = 208
  Width = 715
  Height = 435
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 56
    Top = 112
    Width = 75
    Height = 25
    Caption = 'List'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 56
    Top = 152
    Width = 497
    Height = 209
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button2: TButton
    Left = 480
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Decompress'
    TabOrder = 2
    OnClick = Button2Click
  end
  object ProgressBar1: TProgressBar
    Left = 56
    Top = 24
    Width = 497
    Height = 16
    TabOrder = 3
  end
  object OpenDialog1: TOpenDialog
    Filter = '*.iso|*.ISO'
    Left = 88
    Top = 64
  end
end
