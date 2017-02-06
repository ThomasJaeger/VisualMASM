object fraWelcomePage: TfraWelcomePage
  Left = 0
  Top = 0
  Width = 774
  Height = 435
  TabOrder = 0
  DesignSize = (
    774
    435)
  object sBevel1: TsBevel
    Left = 0
    Top = 183
    Width = 774
    Height = 9
    Align = alTop
    Shape = bsBottomLine
  end
  object sLabel1: TsLabel
    Left = 20
    Top = 198
    Width = 164
    Height = 16
    Caption = 'Visual MASM Video Tutorials'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object sWebLabel2: TsWebLabel
    Left = 37
    Top = 235
    Width = 123
    Height = 13
    Caption = 'Lesson 1. Getting Started'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    HoverFont.Charset = DEFAULT_CHARSET
    HoverFont.Color = clWindowText
    HoverFont.Height = -11
    HoverFont.Name = 'Tahoma'
    HoverFont.Style = []
    URL = 'http://www.visualmasm.com'
  end
  object sWebLabel3: TsWebLabel
    Left = 37
    Top = 266
    Width = 157
    Height = 13
    Hint = 'Coming Soon'
    Caption = 'Lesson 3. Hello World (Windows)'
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    HoverFont.Charset = DEFAULT_CHARSET
    HoverFont.Color = clWindowText
    HoverFont.Height = -11
    HoverFont.Name = 'Tahoma'
    HoverFont.Style = []
    URL = 'http://www.visualmasm.com'
  end
  object sWebLabel1: TsWebLabel
    Left = 0
    Top = 403
    Width = 774
    Height = 13
    Align = alBottom
    Alignment = taCenter
    Caption = 'www.visualmasm.com'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    HoverFont.Charset = DEFAULT_CHARSET
    HoverFont.Color = clWindowText
    HoverFont.Height = -11
    HoverFont.Name = 'Tahoma'
    HoverFont.Style = []
    URL = 'http://www.visualmasm.com'
    ExplicitWidth = 105
  end
  object lblCopyright: TsLabel
    Left = 0
    Top = 416
    Width = 774
    Height = 19
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    Caption = 'Copyright (c) 2014 - 2017 by Thomas Jaeger. All Rights Reserved.'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object sWebLabel4: TsWebLabel
    Left = 37
    Top = 250
    Width = 153
    Height = 13
    Hint = 'Coming Soon'
    Caption = 'Lesson 2. Hello World (MS-DOS)'
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    HoverFont.Charset = DEFAULT_CHARSET
    HoverFont.Color = clWindowText
    HoverFont.Height = -11
    HoverFont.Name = 'Tahoma'
    HoverFont.Style = []
    URL = 'http://www.visualmasm.com'
  end
  object sLabel3: TsLabel
    Left = 364
    Top = 198
    Width = 196
    Height = 16
    Caption = 'Machine Language Video Tutorials'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object sLabel4: TsLabel
    Left = 364
    Top = 279
    Width = 203
    Height = 16
    Caption = 'Assembly Language Video Tutorials'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object sImage1: TsImage
    Left = 0
    Top = 0
    Width = 774
    Height = 183
    Align = alTop
    AutoSize = True
    Center = True
    Picture.Data = {07544269746D617000000000}
    Transparent = True
    ImageIndex = 0
    Images = dm.sAlphaImageList1
    SkinData.SkinSection = 'CHECKBOX'
  end
  object sWebLabel5: TsWebLabel
    Left = 37
    Top = 220
    Width = 154
    Height = 13
    Caption = 'Lesson 0. Installing Visual MASM'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    HoverFont.Charset = DEFAULT_CHARSET
    HoverFont.Color = clWindowText
    HoverFont.Height = -11
    HoverFont.Name = 'Tahoma'
    HoverFont.Style = []
    URL = 'http://www.visualmasm.com'
  end
  object chkDoNotShowWelcomePage: TsCheckBox
    Left = 555
    Top = 411
    Width = 199
    Height = 20
    Caption = 'Do not show welcome page next time'
    Anchors = [akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = chkDoNotShowWelcomePageClick
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
end
