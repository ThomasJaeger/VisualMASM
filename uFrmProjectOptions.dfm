object frmProjectOptions: TfrmProjectOptions
  Left = 620
  Top = 181
  Caption = 'Project Options'
  ClientHeight = 600
  ClientWidth = 813
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
  object Panel1: TPanel
    Left = 0
    Top = 559
    Width = 813
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnCancel: TButton
      Left = 617
      Top = 6
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnOk: TButton
      Left = 698
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Ok'
      Default = True
      TabOrder = 1
      OnClick = btnOkClick
    end
  end
  object tvTree: TTreeView
    Left = 0
    Top = 0
    Width = 166
    Height = 559
    Align = alLeft
    AutoExpand = True
    HideSelection = False
    Indent = 19
    RowSelect = True
    TabOrder = 1
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
  end
  object pagOptions: TPageControl
    Left = 166
    Top = 0
    Width = 647
    Height = 559
    ActivePage = tabGeneral
    Align = alClient
    TabOrder = 2
    object tabAssembleEvents: TTabSheet
      Caption = 'Assemble Events'
      TabVisible = False
    end
    object tabExclusiveAssemble: TTabSheet
      Caption = 'Exclusive Assemble'
      ImageIndex = 1
      TabVisible = False
      object Label3: TLabel
        Left = 20
        Top = 16
        Width = 549
        Height = 33
        AutoSize = False
        Caption = 
          'If you specify any assemble event command line(s), then you will' +
          ' need to specify all files and ML.EXE command line switches your' +
          'self.  You basically take over the enire assemble process yourse' +
          'lf.'
        WordWrap = True
      end
      object memAssembleEventCommandLine: TMemo
        Left = 20
        Top = 55
        Width = 573
        Height = 258
        Lines.Strings = (
          'memAssembleEventCommandLine')
        TabOrder = 0
      end
    end
    object tabGeneral: TTabSheet
      Caption = 'General'
      ImageIndex = 2
      TabVisible = False
      object Label4: TLabel
        Left = 20
        Top = 16
        Width = 65
        Height = 13
        Caption = 'Project name:'
      end
      object Label5: TLabel
        Left = 20
        Top = 35
        Width = 59
        Height = 13
        Caption = 'Project type:'
      end
      object Label6: TLabel
        Left = 20
        Top = 54
        Width = 40
        Height = 13
        Caption = 'Created:'
      end
      object lblGeneralProjectName: TLabel
        Left = 91
        Top = 16
        Width = 510
        Height = 13
        AutoSize = False
      end
      object lblGeneralProjectType: TLabel
        Left = 91
        Top = 35
        Width = 510
        Height = 13
        AutoSize = False
      end
      object lblGeneralCreated: TLabel
        Left = 91
        Top = 54
        Width = 510
        Height = 13
        AutoSize = False
      end
    end
    object tabFilesToAssemble: TTabSheet
      Caption = 'Files to Assemble'
      ImageIndex = 3
      TabVisible = False
      object Label7: TLabel
        Left = 12
        Top = 16
        Width = 549
        Height = 33
        AutoSize = False
        Caption = 
          'The following files will be assembled when the project is being ' +
          'assembled and/or run. Uncheck the files that you do not want to ' +
          'be assembled.'
        WordWrap = True
      end
      object lstAssembleFiles: TCheckListBox
        Left = 12
        Top = 55
        Width = 605
        Height = 402
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object tabAdditionalLink: TTabSheet
      Caption = 'Additional Switches'
      ImageIndex = 4
      TabVisible = False
      object Label2: TLabel
        Left = 20
        Top = 16
        Width = 529
        Height = 13
        Caption = 
          'Specify additional switches to be passed to the linker in additi' +
          'on to the project switches passed by Visual MASM.'
      end
      object memAdditionalLinkSwitches: TMemo
        Left = 20
        Top = 35
        Width = 525
        Height = 254
        Lines.Strings = (
          'memAdditionalLinkSwitches')
        TabOrder = 0
      end
    end
    object tabAdditionalLinkFiles: TTabSheet
      Caption = 'Additional Link Files'
      ImageIndex = 5
      TabVisible = False
      object Label1: TLabel
        Left = 11
        Top = 16
        Width = 483
        Height = 13
        Caption = 
          'Specify additional files to be passed to the linker in addition ' +
          'to the project files passed by Visual MASM.'
      end
      object memAdditionalLinkFiles: TMemo
        Left = 11
        Top = 35
        Width = 542
        Height = 254
        Lines.Strings = (
          'memAdditionalLinkFiles')
        TabOrder = 0
      end
    end
    object tabPreAssemble: TTabSheet
      Caption = 'Pre-Assemble'
      ImageIndex = 6
      TabVisible = False
      object Label8: TLabel
        Left = 20
        Top = 16
        Width = 549
        Height = 33
        AutoSize = False
        Caption = 
          'Command line(s) will be executed before any source files in the ' +
          'project will be assembled by MASM.'#13#10'This could be helpful if you' +
          ' need to copy certain files first or execute any batch files etc' +
          '.'
        WordWrap = True
      end
      object memPreAssembleEventCommandLine: TMemo
        Left = 20
        Top = 63
        Width = 589
        Height = 266
        TabOrder = 0
      end
    end
    object tabPostAssemble: TTabSheet
      Caption = 'Post Assemble'
      ImageIndex = 7
      TabVisible = False
      object Label9: TLabel
        Left = 12
        Top = 16
        Width = 549
        Height = 33
        AutoSize = False
        Caption = 
          'Command line(s) will be executed after all source files in the p' +
          'roject have been assembled by MASM.'
        WordWrap = True
      end
      object memPostAssembleEventCommandLine: TMemo
        Left = 12
        Top = 48
        Width = 581
        Height = 281
        Lines.Strings = (
          'memPostAssembleEventCommandLine')
        TabOrder = 0
      end
    end
    object tabExclusiveLink: TTabSheet
      Caption = 'Exclusive Link'
      ImageIndex = 8
      TabVisible = False
      object Label10: TLabel
        Left = 19
        Top = 8
        Width = 549
        Height = 33
        AutoSize = False
        Caption = 
          'If you specify any link event command line(s), then you will nee' +
          'd to specify all files yourself.  You basically take over the en' +
          'ire link process yourself.'
        WordWrap = True
      end
      object memLinkEventCommandLine: TMemo
        Left = 19
        Top = 40
        Width = 581
        Height = 281
        Lines.Strings = (
          'memPostAssembleEventCommandLine')
        TabOrder = 0
      end
    end
    object tabLibraryPath: TTabSheet
      Caption = 'Library Path'
      ImageIndex = 9
      TabVisible = False
      object Label11: TLabel
        Left = 11
        Top = 16
        Width = 549
        Height = 33
        AutoSize = False
        Caption = 
          'If you do not explicitly specify your libraries on your source c' +
          'ode, you will need to specify a library path so that the linker ' +
          'can find your libraries and objects files.'
        WordWrap = True
      end
      object SpeedButton2: TSpeedButton
        Left = 524
        Top = 55
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = txtLibraryPathButtonClick
      end
      object txtLibraryPath: TEdit
        Left = 11
        Top = 55
        Width = 507
        Height = 21
        TabOrder = 0
      end
    end
    object tabPreLink: TTabSheet
      Caption = 'Pre-link'
      ImageIndex = 10
      TabVisible = False
      object Label12: TLabel
        Left = 19
        Top = 8
        Width = 549
        Height = 33
        AutoSize = False
        Caption = 
          'Command line(s) will be executed before any files in the project' +
          ' will be linked by the Microsoft Linker.'
        WordWrap = True
      end
      object memPreLinkEventCommandLine: TMemo
        Left = 19
        Top = 40
        Width = 581
        Height = 281
        Lines.Strings = (
          'memPostAssembleEventCommandLine')
        TabOrder = 0
      end
    end
    object tabPostLink: TTabSheet
      Caption = 'Post-link'
      ImageIndex = 11
      TabVisible = False
      object Label13: TLabel
        Left = 19
        Top = 16
        Width = 549
        Height = 33
        AutoSize = False
        Caption = 
          'Command line(s) will be executed after all files in the project ' +
          'have been linked by the Microsoft Linker.'
        WordWrap = True
      end
      object memPostLinkEventCommandLine: TMemo
        Left = 19
        Top = 48
        Width = 581
        Height = 281
        Lines.Strings = (
          'memPostAssembleEventCommandLine')
        TabOrder = 0
      end
    end
    object tabLinkEvents: TTabSheet
      Caption = 'Link Events'
      ImageIndex = 12
      TabVisible = False
    end
  end
end
