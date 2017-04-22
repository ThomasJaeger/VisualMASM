object frmProjectOptions: TfrmProjectOptions
  Left = 620
  Top = 181
  Caption = 'Project Options'
  ClientHeight = 517
  ClientWidth = 771
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pagOptions: TsPageControl
    Left = 168
    Top = 0
    Width = 603
    Height = 477
    ActivePage = tabFilesToAssemble
    Align = alClient
    TabOrder = 0
    SkinData.SkinSection = 'PAGECONTROL'
    object tabGeneral: TsTabSheet
      Caption = 'General'
      TabVisible = False
      object sLabel10: TsLabel
        Left = 16
        Top = 32
        Width = 59
        Height = 13
        Caption = 'Project type:'
        WordWrap = True
      end
      object lblGeneralProjectType: TsLabel
        Left = 88
        Top = 32
        Width = 361
        Height = 13
        AutoSize = False
        Caption = 'Win32'
        WordWrap = True
      end
      object sLabel11: TsLabel
        Left = 16
        Top = 16
        Width = 65
        Height = 13
        Caption = 'Project name:'
        WordWrap = True
      end
      object lblGeneralProjectName: TsLabel
        Left = 88
        Top = 16
        Width = 361
        Height = 13
        AutoSize = False
        Caption = 'Win32'
        WordWrap = True
      end
      object sLabel12: TsLabel
        Left = 16
        Top = 48
        Width = 40
        Height = 13
        Caption = 'Created:'
        WordWrap = True
      end
      object lblGeneralCreated: TsLabel
        Left = 88
        Top = 48
        Width = 361
        Height = 13
        AutoSize = False
        Caption = 'Win32'
        WordWrap = True
      end
    end
    object tabFilesToAssemble: TsTabSheet
      Caption = 'Files to Assemble'
      TabVisible = False
      object sLabel7: TsLabel
        Left = 16
        Top = 8
        Width = 569
        Height = 33
        AutoSize = False
        Caption = 
          'The following files will be assembled when the project is being ' +
          'assembled and/or run. Uncheck the files that you do not want to ' +
          'be assembled.'
        WordWrap = True
      end
      object lstAssembleFiles: TsCheckListBox
        Left = 32
        Top = 48
        Width = 537
        Height = 417
        BorderStyle = bsSingle
        Color = 1710618
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 14013909
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'MS Sans Serif'
        BoundLabel.Font.Style = []
        SkinData.SkinSection = 'EDIT'
      end
    end
    object tabAssembleEvents: TsTabSheet
      Caption = 'Assemble Events'
      TabVisible = False
    end
    object tabPreAssemble: TsTabSheet
      Caption = 'Pre-assemble'
      TabVisible = False
      object sGroupBox1: TsGroupBox
        Left = 8
        Top = 8
        Width = 585
        Height = 465
        Caption = 'Pre-assemble event command line'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        CaptionMargin.Left = 10
        CaptionMargin.Top = 1
        CaptionMargin.Right = 10
        CaptionMargin.Bottom = 2
        SkinData.SkinSection = 'GROUPBOX'
        CaptionSkin = 'MAINMENU'
        object sLabel1: TsLabel
          Left = 16
          Top = 24
          Width = 529
          Height = 13
          AutoSize = False
          Caption = 
            'Command line(s) will be executed before any source files in the ' +
            'project will be assembled by MASM.'
          WordWrap = True
        end
        object sLabel8: TsLabel
          Left = 16
          Top = 40
          Width = 529
          Height = 13
          AutoSize = False
          Caption = 
            'This could be helpful if you need to copy certain files first or' +
            ' execute any batch files etc.'
          WordWrap = True
        end
        object memPreAssembleEventCommandLine: TsMemo
          Left = 16
          Top = 64
          Width = 553
          Height = 385
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
        end
      end
    end
    object tabExclusiveAssemble: TsTabSheet
      Caption = 'Exclusive Assemble'
      TabVisible = False
      object sGroupBox2: TsGroupBox
        Left = 8
        Top = 8
        Width = 585
        Height = 465
        Caption = 'Exclusive assemble event command line'
        TabOrder = 0
        CaptionMargin.Left = 10
        CaptionMargin.Top = 1
        CaptionMargin.Right = 10
        CaptionMargin.Bottom = 2
        SkinData.SkinSection = 'GROUPBOX'
        CaptionSkin = 'MAINMENU'
        object sLabel3: TsLabel
          Left = 16
          Top = 24
          Width = 544
          Height = 33
          AutoSize = False
          Caption = 
            'If you specify any assemble event command line(s), then you will' +
            ' need to specify all files and ML.EXE command line switches your' +
            'self.  You basically take over the enire assemble process yourse' +
            'lf.'
          WordWrap = True
        end
        object memAssembleEventCommandLine: TsMemo
          Left = 16
          Top = 56
          Width = 553
          Height = 393
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
        end
      end
    end
    object tabPostAssemble: TsTabSheet
      Caption = 'Post Assemble'
      TabVisible = False
      object sGroupBox3: TsGroupBox
        Left = 8
        Top = 8
        Width = 585
        Height = 465
        Caption = 'Post-assemble event command line'
        TabOrder = 0
        CaptionMargin.Left = 10
        CaptionMargin.Top = 1
        CaptionMargin.Right = 10
        CaptionMargin.Bottom = 2
        SkinData.SkinSection = 'GROUPBOX'
        CaptionSkin = 'MAINMENU'
        object sLabel2: TsLabel
          Left = 16
          Top = 24
          Width = 529
          Height = 13
          AutoSize = False
          Caption = 
            'Command line(s) will be executed after all source files in the p' +
            'roject have been assembled by MASM.'
          WordWrap = True
        end
        object memPostAssembleEventCommandLine: TsMemo
          Left = 16
          Top = 40
          Width = 553
          Height = 409
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
        end
      end
    end
    object tabLinkEvents: TsTabSheet
      Caption = 'Link Events'
      TabVisible = False
      object sGroupBox8: TsGroupBox
        Left = 8
        Top = 8
        Width = 585
        Height = 97
        Caption = 'Library Path'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        CaptionMargin.Left = 10
        CaptionMargin.Top = 1
        CaptionMargin.Right = 10
        CaptionMargin.Bottom = 2
        SkinData.SkinSection = 'GROUPBOX'
        CaptionSkin = 'MAINMENU'
        object sLabel13: TsLabel
          Left = 16
          Top = 24
          Width = 529
          Height = 33
          AutoSize = False
          Caption = 
            'If you do not explicitly specify your libraries on your source c' +
            'ode, you will need to specify a library path so that the linker ' +
            'can find your libraries and objects files.'
          WordWrap = True
        end
        object txtLibraryPath: TsComboEdit
          Left = 16
          Top = 57
          Width = 553
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
          OnButtonClick = txtLibraryPathButtonClick
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
      end
    end
    object tabPreLink: TsTabSheet
      Caption = 'Pre-link'
      TabVisible = False
      object sGroupBox4: TsGroupBox
        Left = 8
        Top = 8
        Width = 585
        Height = 465
        Caption = 'Pre-link event command line'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        CaptionMargin.Left = 10
        CaptionMargin.Top = 1
        CaptionMargin.Right = 10
        CaptionMargin.Bottom = 2
        SkinData.SkinSection = 'GROUPBOX'
        CaptionSkin = 'MAINMENU'
        object sLabel4: TsLabel
          Left = 16
          Top = 24
          Width = 529
          Height = 13
          AutoSize = False
          Caption = 
            'Command line(s) will be executed before any files in the project' +
            ' will be linked by the Microsoft Linker.'
          WordWrap = True
        end
        object memPreLinkEventCommandLine: TsMemo
          Left = 16
          Top = 40
          Width = 553
          Height = 409
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
        end
      end
    end
    object tabExclusiveLink: TsTabSheet
      Caption = 'Exclusive Link'
      TabVisible = False
      object sGroupBox5: TsGroupBox
        Left = 8
        Top = 8
        Width = 585
        Height = 465
        Caption = 'Exclusive link event command line'
        TabOrder = 0
        CaptionMargin.Left = 10
        CaptionMargin.Top = 1
        CaptionMargin.Right = 10
        CaptionMargin.Bottom = 2
        SkinData.SkinSection = 'GROUPBOX'
        CaptionSkin = 'MAINMENU'
        object sLabel5: TsLabel
          Left = 16
          Top = 24
          Width = 544
          Height = 33
          AutoSize = False
          Caption = 
            'If you specify any link event command line(s), then you will nee' +
            'd to specify all files yourself.  You basically take over the en' +
            'ire link process yourself.'
          WordWrap = True
        end
        object memLinkEventCommandLine: TsMemo
          Left = 16
          Top = 56
          Width = 553
          Height = 393
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
        end
      end
    end
    object tabAdditionalLink: TsTabSheet
      Caption = 'Additional Link Switches'
      TabVisible = False
      object sGroupBox7: TsGroupBox
        Left = 8
        Top = 8
        Width = 585
        Height = 465
        Caption = 'Additional Switches'
        TabOrder = 0
        CaptionMargin.Left = 10
        CaptionMargin.Top = 1
        CaptionMargin.Right = 10
        CaptionMargin.Bottom = 2
        SkinData.SkinSection = 'GROUPBOX'
        CaptionSkin = 'MAINMENU'
        object sLabel9: TsLabel
          Left = 16
          Top = 24
          Width = 529
          Height = 33
          AutoSize = False
          Caption = 
            'Specify additional switches to be passed to the linker in additi' +
            'on to the project switches passed by Visual MASM.'
          WordWrap = True
        end
        object memAdditionalLinkSwitches: TsMemo
          Left = 16
          Top = 56
          Width = 553
          Height = 393
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
        end
      end
    end
    object tabAdditionalLinkFiles: TsTabSheet
      Caption = 'Additional Link Files'
      TabVisible = False
      object sGroupBox9: TsGroupBox
        Left = 8
        Top = 8
        Width = 585
        Height = 465
        Caption = 'Additional Files'
        TabOrder = 0
        CaptionMargin.Left = 10
        CaptionMargin.Top = 1
        CaptionMargin.Right = 10
        CaptionMargin.Bottom = 2
        SkinData.SkinSection = 'GROUPBOX'
        CaptionSkin = 'MAINMENU'
        object sLabel14: TsLabel
          Left = 16
          Top = 24
          Width = 529
          Height = 33
          AutoSize = False
          Caption = 
            'Specify additional files to be passed to the linker in addition ' +
            'to the project files passed by Visual MASM.'
          WordWrap = True
        end
        object memAdditionalLinkFiles: TsMemo
          Left = 16
          Top = 56
          Width = 553
          Height = 393
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
        end
      end
    end
    object tabPostLink: TsTabSheet
      Caption = 'Post-link'
      TabVisible = False
      object sGroupBox6: TsGroupBox
        Left = 8
        Top = 8
        Width = 585
        Height = 465
        Caption = 'Post-link event command line'
        TabOrder = 0
        CaptionMargin.Left = 10
        CaptionMargin.Top = 1
        CaptionMargin.Right = 10
        CaptionMargin.Bottom = 2
        SkinData.SkinSection = 'GROUPBOX'
        CaptionSkin = 'MAINMENU'
        object sLabel6: TsLabel
          Left = 16
          Top = 24
          Width = 529
          Height = 13
          AutoSize = False
          Caption = 
            'Command line(s) will be executed after all files in the project ' +
            'have been linked by the Microsoft Linker.'
          WordWrap = True
        end
        object memPostLinkEventCommandLine: TsMemo
          Left = 16
          Top = 40
          Width = 553
          Height = 409
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'MS Sans Serif'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
        end
      end
    end
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 477
    Width = 771
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'TRANSPARENT'
    DesignSize = (
      771
      40)
    object btnCancel: TsButton
      Left = 605
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
      Left = 696
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
    Height = 477
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
      03040000002C0000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      00000000000107470065006E006500720061006C004000000000000000000000
      00FFFFFFFFFFFFFFFF0000000000000000000000000111460069006C00650073
      00200074006F00200041007300730065006D0062006C0065003C000000000000
      0000000000FFFFFFFFFFFFFFFF000000000000000003000000010F4100730073
      0065006D0062006C00650020004500760065006E007400730036000000000000
      0000000000FFFFFFFFFFFFFFFF000000000000000000000000010C5000720065
      002D0061007300730065006D0062006C006500420000000000000000000000FF
      FFFFFFFFFFFFFF00000000000000000000000001124500780063006C00750073
      00690076006500200041007300730065006D0062006C00650038000000000000
      0000000000FFFFFFFFFFFFFFFF000000000000000000000000010D50006F0073
      0074002D0061007300730065006D0062006C0065003400000000000000000000
      00FFFFFFFFFFFFFFFF000000000000000005000000010B4C0069006E006B0020
      004500760065006E00740073002E0000000000000000000000FFFFFFFFFFFFFF
      FF00000000000000000000000001085000720065002D006C0069006E006B003A
      0000000000000000000000FFFFFFFFFFFFFFFF00000000000000000000000001
      0E4500780063006C007500730069007600650020004C0069006E006B00440000
      000000000000000000FFFFFFFFFFFFFFFF000000000000000000000000011341
      00640064006900740069006F006E0061006C0020005300770069007400630068
      00650073003E0000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      000000000001104100640064006900740069006F006E0061006C002000460069
      006C0065007300300000000000000000000000FFFFFFFFFFFFFFFF0000000000
      00000000000000010950006F00730074002D006C0069006E006B00}
    SkinData.SkinSection = 'EDIT'
  end
end
