object fraDownloadOptions: TfraDownloadOptions
  Left = 0
  Top = 0
  Width = 548
  Height = 310
  TabOrder = 0
  object sLabel2: TsLabel
    Left = 35
    Top = 90
    Width = 506
    Height = 39
    Caption = 
      'MASM32 SDK Version 11 is a comlete package to create 32-bit Wind' +
      'ows applications. It includes Microsoft MASM 6.14.8444 and many ' +
      'other useful tools and libraries. Visual MASM will download from' +
      ' www.masm32.com. For more information, please visit: '
    WordWrap = True
  end
  object sWebLabel1: TsWebLabel
    Left = 307
    Top = 116
    Width = 90
    Height = 13
    Alignment = taCenter
    Caption = 'www.masm32.com'
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
    URL = 'http://www.masm32.com'
  end
  object sLabel4: TsLabel
    Left = 35
    Top = 194
    Width = 482
    Height = 39
    Caption = 
      'The Windows SDK provides tools, compilers, headers, libraries, c' +
      'ode samples, and a new help system that developers can use to cr' +
      'eate applications that run on Microsoft Windows. For more inform' +
      'ation, please visit: '
    WordWrap = True
  end
  object sWebLabel2: TsWebLabel
    Left = 99
    Top = 220
    Width = 95
    Height = 13
    Alignment = taCenter
    Caption = 'www.microsoft.com'
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
    URL = 'http://www.microsoft.com/en-us/download/details.aspx?id=8442'
  end
  object sLabel3: TsLabel
    Left = 3
    Top = 3
    Width = 184
    Height = 13
    Caption = 'Select where to download MASM from.'
    WordWrap = True
  end
  object chkMASM32: TsCheckBox
    Left = 3
    Top = 64
    Width = 269
    Height = 20
    Caption = 'MASM32 SDK Version 11 (apx. 5 MB download size)'
    TabOrder = 0
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object chkMicrosoftSDK: TsCheckBox
    Left = 3
    Top = 168
    Width = 346
    Height = 20
    Caption = 'Microsoft Windows SDK for Windows 7 and .NET Framework 4 (ISO)'
    TabOrder = 1
    OnClick = chkMicrosoftSDKClick
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object optx86: TsRadioButton
    Left = 35
    Top = 239
    Width = 216
    Height = 20
    Caption = 'x86 ISO File (apx. 567 MB download size)'
    Checked = True
    Enabled = False
    TabOrder = 2
    TabStop = True
    SkinData.SkinSection = 'CHECKBOX'
  end
  object optx64: TsRadioButton
    Left = 35
    Top = 260
    Width = 216
    Height = 20
    Caption = 'x64 ISO File (apx. 569 MB download size)'
    Enabled = False
    TabOrder = 3
    SkinData.SkinSection = 'CHECKBOX'
  end
  object optItanium: TsRadioButton
    Left = 35
    Top = 281
    Width = 233
    Height = 20
    Caption = 'Itanium ISO File (apx. 570 MB download size)'
    Enabled = False
    TabOrder = 4
    SkinData.SkinSection = 'CHECKBOX'
  end
end
