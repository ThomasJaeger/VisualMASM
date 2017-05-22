object frmOptions: TfrmOptions
  Left = 601
  Top = 218
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Options'
  ClientHeight = 680
  ClientWidth = 787
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pagOptions: TsPageControl
    Left = 168
    Top = 0
    Width = 619
    Height = 640
    ActivePage = tabGeneral
    Align = alClient
    TabOrder = 0
    SkinData.SkinSection = 'PAGECONTROL'
    object tabGeneral: TsTabSheet
      Caption = 'General'
      TabVisible = False
      object chkOpenLastUsedProject: TsCheckBox
        Left = 16
        Top = 16
        Width = 221
        Height = 18
        Caption = 'Open last used project when starting up'
        TabOrder = 0
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object chkDoNotShowToolTips: TsCheckBox
        Left = 16
        Top = 40
        Width = 129
        Height = 18
        Caption = 'Do not show tool tips'
        TabOrder = 1
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object grpContextHelp: TsGroupBox
        Left = 16
        Top = 72
        Width = 265
        Height = 121
        Caption = 'Context Help'
        TabOrder = 2
        object lblContextHelpFont: TsLabel
          Left = 16
          Top = 48
          Width = 217
          Height = 13
          AutoSize = False
          Caption = 'Current font'
        end
        object chkShowContextHelp: TsCheckBox
          Left = 16
          Top = 24
          Width = 117
          Height = 18
          Caption = 'Show context help'
          TabOrder = 0
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object btnChangeContextHelpFont: TsButton
          Left = 16
          Top = 67
          Width = 137
          Height = 25
          Caption = 'Change Font...'
          TabOrder = 1
          OnClick = btnChangeContextHelpFontClick
        end
      end
      object sGroupBox3: TsGroupBox
        Left = 16
        Top = 216
        Width = 265
        Height = 105
        Caption = 'Output Window'
        TabOrder = 3
        object lblOutputFont: TsLabel
          Left = 16
          Top = 32
          Width = 217
          Height = 13
          AutoSize = False
          Caption = 'Current font'
        end
        object btnChangeOutputWindowFont: TsButton
          Left = 16
          Top = 59
          Width = 137
          Height = 25
          Caption = 'Change Font...'
          TabOrder = 0
          OnClick = btnChangeOutputWindowFontClick
        end
      end
    end
    object tabFileLocations: TsTabSheet
      Caption = 'File Locations'
      TabVisible = False
      DesignSize = (
        611
        630)
      object sLabel30: TsLabel
        Left = 10
        Top = 10
        Width = 583
        Height = 105
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 10
        Alignment = taCenter
        AutoSize = False
        SkinSection = 'DRAGBAR'
        Caption = 
          #13#10'IMPORTANT'#13#10'Make sure you set the INCLUDE or other environment ' +
          'variables so that the below applications '#13#10'can find any dependen' +
          't files.'#13#10'For example, make sure that you set the INCLUDE enviro' +
          'nment variable to point to the '#13#10'Microsoft SDK Include path so t' +
          'hat RC.EXE can find dependnet header files.'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object grp32Bit: TsGroupBox
        Left = 10
        Top = 190
        Width = 585
        Height = 129
        Caption = '32-Bit'
        TabOrder = 0
        CaptionMargin.Left = 10
        CaptionMargin.Top = 1
        CaptionMargin.Right = 10
        CaptionMargin.Bottom = 2
        SkinData.SkinSection = 'GROUPBOX'
        CaptionSkin = 'MAINMENU'
        object sLabel10: TsLabel
          Left = 16
          Top = 29
          Width = 65
          Height = 13
          AutoSize = False
          Caption = 'ML.EXE'
          WordWrap = True
        end
        object sLabel11: TsLabel
          Left = 16
          Top = 53
          Width = 65
          Height = 13
          AutoSize = False
          Caption = 'LINK.EXE'
          WordWrap = True
        end
        object sLabel12: TsLabel
          Left = 16
          Top = 77
          Width = 65
          Height = 13
          AutoSize = False
          Caption = 'RC.EXE'
          WordWrap = True
        end
        object sLabel21: TsLabel
          Left = 16
          Top = 101
          Width = 65
          Height = 13
          AutoSize = False
          Caption = 'LIB.EXE'
          WordWrap = True
        end
        object txtML32: TsComboEdit
          Left = 88
          Top = 25
          Width = 481
          Height = 21
          AutoSize = False
          Color = 1710618
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 14013909
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = ''
          CheckOnExit = True
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
          OnButtonClick = txtML32ButtonClick
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
        object txtLink32: TsComboEdit
          Left = 88
          Top = 49
          Width = 481
          Height = 21
          AutoSize = False
          Color = 1710618
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 14013909
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = ''
          CheckOnExit = True
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
          OnButtonClick = txtLink32ButtonClick
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
        object txtRC32: TsComboEdit
          Left = 88
          Top = 73
          Width = 481
          Height = 21
          AutoSize = False
          Color = 1710618
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 14013909
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = ''
          CheckOnExit = True
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
          OnButtonClick = txtRC32ButtonClick
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
        object txtLIB32: TsComboEdit
          Left = 88
          Top = 97
          Width = 481
          Height = 21
          AutoSize = False
          Color = 1710618
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 14013909
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Text = ''
          CheckOnExit = True
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
          OnButtonClick = txtLIB32ButtonClick
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
      end
      object grp64Bit: TsGroupBox
        Left = 10
        Top = 326
        Width = 585
        Height = 129
        Caption = '64-Bit'
        TabOrder = 1
        CaptionMargin.Left = 10
        CaptionMargin.Top = 1
        CaptionMargin.Right = 10
        CaptionMargin.Bottom = 2
        SkinData.SkinSection = 'GROUPBOX'
        CaptionSkin = 'MAINMENU'
        object sLabel13: TsLabel
          Left = 16
          Top = 29
          Width = 65
          Height = 13
          AutoSize = False
          Caption = 'ML64.EXE'
          WordWrap = True
        end
        object sLabel14: TsLabel
          Left = 16
          Top = 53
          Width = 65
          Height = 13
          AutoSize = False
          Caption = 'LINK.EXE'
          WordWrap = True
        end
        object sLabel15: TsLabel
          Left = 16
          Top = 77
          Width = 65
          Height = 13
          AutoSize = False
          Caption = 'RC.EXE'
          WordWrap = True
        end
        object sLabel20: TsLabel
          Left = 16
          Top = 101
          Width = 65
          Height = 13
          AutoSize = False
          Caption = 'LIB.EXE'
          WordWrap = True
        end
        object txtML64: TsComboEdit
          Left = 88
          Top = 25
          Width = 481
          Height = 21
          AutoSize = False
          Color = 1710618
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 14013909
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = ''
          CheckOnExit = True
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
          OnButtonClick = txtML64ButtonClick
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
        object txtLink64: TsComboEdit
          Left = 88
          Top = 49
          Width = 481
          Height = 21
          AutoSize = False
          Color = 1710618
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 14013909
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = ''
          CheckOnExit = True
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
          OnButtonClick = txtLink64ButtonClick
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
        object txtRC64: TsComboEdit
          Left = 88
          Top = 73
          Width = 481
          Height = 21
          AutoSize = False
          Color = 1710618
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 14013909
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = ''
          CheckOnExit = True
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
          OnButtonClick = txtRC64ButtonClick
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
        object txtLIB64: TsComboEdit
          Left = 88
          Top = 97
          Width = 481
          Height = 21
          AutoSize = False
          Color = 1710618
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 14013909
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Text = ''
          CheckOnExit = True
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
          OnButtonClick = txtLIB64ButtonClick
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
      end
      object grp16Bit: TsGroupBox
        Left = 10
        Top = 461
        Width = 585
        Height = 129
        Caption = '16-Bit'
        TabOrder = 2
        CaptionMargin.Left = 10
        CaptionMargin.Top = 1
        CaptionMargin.Right = 10
        CaptionMargin.Bottom = 2
        SkinData.SkinSection = 'GROUPBOX'
        CaptionSkin = 'MAINMENU'
        object sLabel9: TsLabel
          Left = 16
          Top = 29
          Width = 65
          Height = 13
          AutoSize = False
          Caption = 'ML16.EXE'
          WordWrap = True
        end
        object sLabel16: TsLabel
          Left = 16
          Top = 53
          Width = 65
          Height = 13
          AutoSize = False
          Caption = 'LINK.EXE'
          WordWrap = True
        end
        object sLabel17: TsLabel
          Left = 16
          Top = 77
          Width = 65
          Height = 13
          AutoSize = False
          Caption = 'RC.EXE'
          WordWrap = True
        end
        object sLabel19: TsLabel
          Left = 16
          Top = 101
          Width = 65
          Height = 13
          AutoSize = False
          Caption = 'LIB.EXE'
          WordWrap = True
        end
        object txtML16: TsComboEdit
          Left = 88
          Top = 25
          Width = 481
          Height = 21
          AutoSize = False
          Color = 1710618
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 14013909
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = ''
          CheckOnExit = True
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
          OnButtonClick = txtML16ButtonClick
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
        object txtLink16: TsComboEdit
          Left = 88
          Top = 49
          Width = 481
          Height = 21
          AutoSize = False
          Color = 1710618
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 14013909
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = ''
          CheckOnExit = True
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
          OnButtonClick = txtLink16ButtonClick
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
        object txtRC16: TsComboEdit
          Left = 88
          Top = 73
          Width = 481
          Height = 21
          AutoSize = False
          Color = 1710618
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 14013909
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = ''
          CheckOnExit = True
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
          OnButtonClick = txtRC16ButtonClick
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
        object txtLIB16: TsComboEdit
          Left = 88
          Top = 97
          Width = 481
          Height = 21
          AutoSize = False
          Color = 1710618
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 14013909
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Text = ''
          CheckOnExit = True
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
          OnButtonClick = txtLIB16ButtonClick
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
      end
      object btnRunSetupWizard: TsButton
        Left = 26
        Top = 596
        Width = 177
        Height = 25
        Caption = 'Run Setup Wizard...'
        TabOrder = 3
        OnClick = btnRunSetupWizardClick
        SkinData.SkinSection = 'BUTTON'
      end
      object sGroupBox2: TsGroupBox
        Left = 10
        Top = 128
        Width = 593
        Height = 56
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Microsoft SDK'
        TabOrder = 4
        CaptionMargin.Left = 10
        CaptionMargin.Top = 1
        CaptionMargin.Right = 10
        CaptionMargin.Bottom = 2
        SkinData.SkinSection = 'GROUPBOX'
        CaptionSkin = 'MAINMENU'
        object sLabel31: TsLabel
          Left = 16
          Top = 29
          Width = 65
          Height = 13
          AutoSize = False
          Caption = 'Include Path'
          WordWrap = True
        end
        object txtSDKIncludePath: TsComboEdit
          Left = 88
          Top = 25
          Width = 481
          Height = 21
          AutoSize = False
          Color = 1710618
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 14013909
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = ''
          CheckOnExit = True
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
          OnButtonClick = txtSDKIncludePathButtonClick
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
      end
    end
    object tabThemes: TsTabSheet
      Caption = 'Themes'
      TabVisible = False
      object sLabel2: TsLabel
        Left = 360
        Top = 11
        Width = 60
        Height = 13
        Caption = 'Code Editor:'
      end
      object sLabel1: TsLabel
        Left = 344
        Top = 80
        Width = 29
        Height = 13
        Alignment = taRightJustify
        Caption = 'Scale:'
        ParentFont = False
        Visible = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4013373
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object sLabel3: TsLabel
        Left = 385
        Top = 110
        Width = 18
        Height = 13
        Caption = '100'
        ParentFont = False
        Visible = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4013373
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object sLabel4: TsLabel
        Left = 469
        Top = 111
        Width = 18
        Height = 13
        Caption = '125'
        ParentFont = False
        Visible = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4013373
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object sLabel5: TsLabel
        Left = 551
        Top = 111
        Width = 18
        Height = 13
        Caption = '150'
        ParentFont = False
        Visible = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4013373
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object btnResetToDefaultTheme: TsButton
        Left = 25
        Top = 315
        Width = 281
        Height = 25
        Caption = 'Reset to Default (TV-b)'
        TabOrder = 0
        OnClick = btnResetToDefaultThemeClick
        SkinData.SkinSection = 'BUTTON'
      end
      object cmbCodeEditor: TsComboBox
        Left = 360
        Top = 32
        Width = 169
        Height = 21
        Alignment = taLeftJustify
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'MS Sans Serif'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Style = csDropDownList
        Color = 1710618
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 14013909
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 1
        OnChange = cmbCodeEditorChange
      end
      object btnSelectSkin: TsButton
        Left = 25
        Top = 30
        Width = 281
        Height = 25
        Caption = 'Select Skin...'
        TabOrder = 2
        OnClick = btnSelectSkinClick
      end
      object sTrackBar4: TsTrackBar
        Left = 379
        Top = 76
        Width = 192
        Height = 29
        Max = 2
        PageSize = 1
        TabOrder = 3
        Visible = False
        BarOffsetV = 0
        BarOffsetH = 0
      end
      object sGroupBox1: TsGroupBox
        Left = 25
        Top = 96
        Width = 281
        Height = 213
        Caption = ' Skin colorization '
        TabOrder = 4
        CaptionLayout = clTopCenter
        SkinData.SkinSection = 'PANEL_LOW'
        SkinData.OuterEffects.Visibility = ovAlways
        CaptionSkin = 'PROGRESSH'
        CaptionWidth = 100
        CaptionYOffset = 6
        object sLabel6: TsLabel
          Left = 234
          Top = 98
          Width = 6
          Height = 13
          Caption = '0'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4013373
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel7: TsLabel
          Left = 234
          Top = 38
          Width = 6
          Height = 13
          Caption = '0'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4013373
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel8: TsLabel
          Left = 234
          Top = 154
          Width = 6
          Height = 13
          Caption = '0'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4013373
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel18: TsLabel
          Left = 51
          Top = 63
          Width = 6
          Height = 13
          Caption = '0'
          Enabled = False
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 1579032
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel22: TsLabel
          Left = 214
          Top = 63
          Width = 18
          Height = 13
          Caption = '360'
          Enabled = False
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 1579032
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel23: TsLabel
          Left = 42
          Top = 119
          Width = 22
          Height = 13
          Caption = '-100'
          Enabled = False
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 1579032
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel24: TsLabel
          Left = 214
          Top = 119
          Width = 18
          Height = 13
          Caption = '100'
          Enabled = False
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 1579032
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel25: TsLabel
          Left = 112
          Top = 63
          Width = 54
          Height = 13
          Caption = 'HUE Offset'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4013373
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel26: TsLabel
          Left = 113
          Top = 119
          Width = 50
          Height = 13
          Caption = 'Saturation'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4013373
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel27: TsLabel
          Left = 44
          Top = 175
          Width = 16
          Height = 13
          Alignment = taCenter
          Caption = '-50'
          Enabled = False
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 1579032
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel28: TsLabel
          Left = 214
          Top = 175
          Width = 12
          Height = 13
          Alignment = taCenter
          Caption = '50'
          Enabled = False
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 1579032
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel29: TsLabel
          Left = 112
          Top = 175
          Width = 50
          Height = 13
          Caption = 'Brightness'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4013373
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sTrackBar2: TsTrackBar
          Tag = 5
          Left = 40
          Top = 93
          Width = 193
          Height = 24
          Max = 100
          Min = -100
          PageSize = 24
          Frequency = 20
          TabOrder = 1
          TickStyle = tsNone
          OnChange = sTrackBar2Change
          SkinData.SkinSection = 'TRACKBAR'
          ShowProgress = True
          BarOffsetV = 0
          BarOffsetH = 0
          ShowProgressFrom = -100
        end
        object sTrackBar1: TsTrackBar
          Tag = 5
          Left = 40
          Top = 33
          Width = 193
          Height = 28
          Max = 360
          PageSize = 24
          Frequency = 36
          TabOrder = 0
          TickStyle = tsNone
          OnChange = sTrackBar1Change
          SkinData.SkinSection = 'TRACKBAR'
          ShowProgress = True
          OnSkinPaint = sTrackBar1SkinPaint
          BarOffsetV = 0
          BarOffsetH = 0
        end
        object sTrackBar3: TsTrackBar
          Tag = 5
          Left = 40
          Top = 149
          Width = 193
          Height = 24
          Max = 100
          Min = -100
          PageSize = 24
          Frequency = 20
          TabOrder = 2
          TickStyle = tsNone
          OnChange = sTrackBar3Change
          SkinData.SkinSection = 'TRACKBAR'
          ShowProgress = True
          BarOffsetV = 0
          BarOffsetH = 0
          ShowProgressFrom = -100
        end
      end
    end
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 640
    Width = 787
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'TRANSPARENT'
    DesignSize = (
      787
      40)
    object btnCancel: TsButton
      Left = 621
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object btnOk: TsButton
      Left = 712
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 1
      OnClick = btnOkClick
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object tvTree: TsTreeView
    Left = 0
    Top = 0
    Width = 168
    Height = 640
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
    Items.NodeData = {
      03030000002C0000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      00000000000107470065006E006500720061006C003A00000000000000000000
      00FFFFFFFFFFFFFFFF000000000000000000000000010E460069006C00650020
      004C006F0063006100740069006F006E0073002A0000000000000000000000FF
      FFFFFFFFFFFFFF00000000000000000000000001065400680065006D00650073
      00}
    SkinData.SkinSection = 'EDIT'
  end
  object dlgFont: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 520
    Top = 120
  end
end
