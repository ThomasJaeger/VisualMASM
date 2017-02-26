object frmOptions: TfrmOptions
  Left = 601
  Top = 218
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Options'
  ClientHeight = 511
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
    Height = 471
    ActivePage = tabThemes
    Align = alClient
    TabOrder = 0
    SkinData.SkinSection = 'PAGECONTROL'
    ExplicitWidth = 627
    ExplicitHeight = 483
    object tabGeneral: TsTabSheet
      Caption = 'General'
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object chkOpenLastUsedProject: TsCheckBox
        Left = 16
        Top = 16
        Width = 221
        Height = 20
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
        Height = 20
        Caption = 'Do not show tool tips'
        TabOrder = 1
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
    object tabFileLocations: TsTabSheet
      Caption = 'File Locations'
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grp32Bit: TsGroupBox
        Left = 16
        Top = 8
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
          Font.Color = 10329501
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
          Font.Color = 10329501
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
          Font.Color = 10329501
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
          Font.Color = 10329501
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
        Left = 16
        Top = 144
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
          Font.Color = 10329501
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
          Font.Color = 10329501
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
          Font.Color = 10329501
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
          Font.Color = 10329501
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
        Left = 16
        Top = 280
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
          Font.Color = 10329501
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
          Font.Color = 10329501
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
          Font.Color = 10329501
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
          Font.Color = 10329501
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
        Left = 16
        Top = 424
        Width = 177
        Height = 25
        Caption = 'Run Setup Wizard...'
        TabOrder = 3
        OnClick = btnRunSetupWizardClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object tabThemes: TsTabSheet
      Caption = 'Themes'
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblAvailableThemes: TsLabel
        Left = 40
        Top = 11
        Width = 87
        Height = 13
        Caption = 'Available Themes:'
      end
      object sLabel2: TsLabel
        Left = 312
        Top = 11
        Width = 60
        Height = 13
        Caption = 'Code Editor:'
      end
      object lstThemes: TsListBox
        Left = 40
        Top = 32
        Width = 201
        Height = 401
        Color = 1710618
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10329501
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = lstThemesClick
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'MS Sans Serif'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'EDIT'
      end
      object btnResetToDefaultTheme: TsButton
        Left = 40
        Top = 440
        Width = 201
        Height = 25
        Caption = 'Reset to Default (TV-b)'
        TabOrder = 1
        OnClick = btnResetToDefaultThemeClick
        SkinData.SkinSection = 'BUTTON'
      end
      object cmbCodeEditor: TsComboBox
        Left = 312
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
        Font.Color = 10329501
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        ParentFont = False
        TabOrder = 2
        OnChange = cmbCodeEditorChange
      end
      object chkDisplayExtendedWindowBorders: TsCheckBox
        Left = 312
        Top = 72
        Width = 190
        Height = 20
        Caption = 'Display extended window borders'
        TabOrder = 3
        OnClick = chkDisplayExtendedWindowBordersClick
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 471
    Width = 787
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'TRANSPARENT'
    ExplicitTop = 483
    ExplicitWidth = 795
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
    Height = 471
    Align = alLeft
    Color = 1710618
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 10329501
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
end
