object frmOptions: TfrmOptions
  Left = 601
  Top = 218
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Options'
  ClientHeight = 736
  ClientWidth = 880
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 691
    Width = 880
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      880
      45)
    object btnCancel: TButton
      Left = 700
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akRight]
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnOk: TButton
      Left = 781
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akRight]
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
    Height = 691
    Align = alLeft
    HideSelection = False
    Indent = 19
    RowSelect = True
    TabOrder = 1
    OnChange = tvTreeChange
    Items.NodeData = {
      03050000002C0000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      00000000000107470065006E006500720061006C003A00000000000000000000
      00FFFFFFFFFFFFFFFF000000000000000000000000010E460069006C00650020
      004C006F0063006100740069006F006E0073002A0000000000000000000000FF
      FFFFFFFFFFFFFF00000000000000000000000001065400680065006D00650073
      00280000000000000000000000FFFFFFFFFFFFFFFF0000000000000000000000
      000105440065006200750067003E0000000000000000000000FFFFFFFFFFFFFF
      FF0000000000000000000000000110460069006C00650020004100730073006F
      00630069006100740069006F006E00}
  end
  object pagOptions: TPageControl
    Left = 166
    Top = 0
    Width = 714
    Height = 691
    ActivePage = tabDebug
    Align = alClient
    TabOrder = 2
    object tabGeneral: TTabSheet
      Caption = 'General'
      TabVisible = False
      DesignSize = (
        706
        681)
      object chkOpenLastUsedProject: TCheckBox
        Left = 24
        Top = 64
        Width = 265
        Height = 17
        Caption = 'Open last used project when starting up'
        TabOrder = 0
      end
      object chkDoNotShowToolTips: TCheckBox
        Left = 24
        Top = 87
        Width = 193
        Height = 17
        Caption = 'Do not show tool tips'
        TabOrder = 1
      end
      object grpContextHelp2: TGroupBox
        Left = 20
        Top = 422
        Width = 257
        Height = 107
        Caption = 'Context Help'
        TabOrder = 2
        object lblContextHelpFont: TLabel
          Left = 16
          Top = 28
          Width = 72
          Height = 16
          Caption = 'Current Font'
        end
        object btnChangeContextHelpFont: TButton
          Left = 16
          Top = 63
          Width = 129
          Height = 25
          Caption = 'Change Font...'
          TabOrder = 0
          OnClick = btnChangeContextHelpFontClick
        end
      end
      object GroupBox1: TGroupBox
        Left = 20
        Top = 285
        Width = 257
        Height = 115
        Caption = 'Output Window'
        TabOrder = 3
        object lblOutputFont: TLabel
          Left = 16
          Top = 36
          Width = 72
          Height = 16
          Caption = 'Current Font'
        end
        object btnChangeOutputWindowFont: TButton
          Left = 16
          Top = 71
          Width = 129
          Height = 25
          Caption = 'Change Font...'
          TabOrder = 0
          OnClick = btnChangeOutputWindowFontClick
        end
      end
      object GroupBox6: TGroupBox
        Left = 20
        Top = 143
        Width = 653
        Height = 129
        Anchors = [akLeft, akRight]
        Caption = 'All Projects'
        TabOrder = 4
        DesignSize = (
          653
          129)
        object Label16: TLabel
          Left = 16
          Top = 30
          Width = 617
          Height = 33
          AutoSize = False
          Caption = 
            'Create new projects in this common projects folder. If you don'#39't' +
            ' specify a common projects folder, Visual MASM will use the defa' +
            'ult folder which is the folder where Visual MASM is running in.'
          WordWrap = True
        end
        object btnCommonProjectFolder: TSpeedButton
          Left = 595
          Top = 88
          Width = 23
          Height = 22
          Hint = 'Browse for folder'
          Anchors = [akRight]
          Caption = '...'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnCommonProjectFolderClick
        end
        object Label17: TLabel
          Left = 16
          Top = 69
          Width = 146
          Height = 16
          Caption = 'Common Projects Folder:'
        end
        object btnResetCommonProjectFolder: TSpeedButton
          Left = 624
          Top = 88
          Width = 17
          Height = 22
          Hint = 'Reset to default'
          Anchors = [akRight]
          Caption = '!'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnResetCommonProjectFolderClick
        end
        object txtCommonProjectFolder: TEdit
          Left = 16
          Top = 88
          Width = 573
          Height = 24
          Anchors = [akLeft, akRight]
          TabOrder = 0
        end
      end
      object btnRunSetupWizard: TButton
        Left = 24
        Top = 20
        Width = 233
        Height = 25
        Caption = 'Run Setup Wizard...'
        TabOrder = 5
        OnClick = btnRunSetupWizardClick
      end
    end
    object tabFileLocations: TTabSheet
      Caption = 'File Locations'
      ImageIndex = 1
      TabVisible = False
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 5
        Width = 700
        Height = 80
        Margins.Top = 5
        Margins.Bottom = 10
        Align = alTop
        Alignment = taCenter
        Caption = 
          'IMPORTANT'#13#10'Make sure you set the INCLUDE or other environment va' +
          'riables so that the below applications '#13#10'can find any dependent ' +
          'files.'#13#10'For example, make sure that you set the INCLUDE environm' +
          'ent variable to point to the '#13#10'Microsoft SDK Include path so tha' +
          't RC.EXE can find dependnet header files.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        ExplicitWidth = 537
      end
      object GroupBox4: TGroupBox
        AlignWithMargins = True
        Left = 20
        Top = 509
        Width = 666
        Height = 157
        Margins.Left = 20
        Margins.Top = 5
        Margins.Right = 20
        Margins.Bottom = 5
        Align = alTop
        Anchors = [akRight]
        Caption = '16-bit'
        TabOrder = 0
        DesignSize = (
          666
          157)
        object Label3: TLabel
          Left = 16
          Top = 25
          Width = 56
          Height = 16
          Caption = 'ML16.EXE'
        end
        object SpeedButton2: TSpeedButton
          Left = 630
          Top = 24
          Width = 23
          Height = 22
          Anchors = [akRight]
          Caption = '...'
          OnClick = txtML16ButtonClick
          ExplicitLeft = 599
          ExplicitTop = 16
        end
        object Label4: TLabel
          Left = 16
          Top = 57
          Width = 51
          Height = 16
          Caption = 'LINK.EXE'
        end
        object SpeedButton3: TSpeedButton
          Left = 630
          Top = 56
          Width = 23
          Height = 22
          Anchors = [akRight]
          Caption = '...'
          OnClick = txtLink16ButtonClick
          ExplicitLeft = 599
          ExplicitTop = 41
        end
        object Label5: TLabel
          Left = 16
          Top = 89
          Width = 42
          Height = 16
          Caption = 'RC.EXE'
        end
        object SpeedButton4: TSpeedButton
          Left = 630
          Top = 88
          Width = 23
          Height = 22
          Anchors = [akRight]
          Caption = '...'
          OnClick = txtRC16ButtonClick
          ExplicitTop = 85
        end
        object Label6: TLabel
          Left = 16
          Top = 122
          Width = 43
          Height = 16
          Caption = 'LIB.EXE'
        end
        object SpeedButton5: TSpeedButton
          Left = 630
          Top = 121
          Width = 23
          Height = 22
          Anchors = [akRight]
          Caption = '...'
          OnClick = txtLIB16ButtonClick
          ExplicitLeft = 599
          ExplicitTop = 91
        end
        object txtML16: TEdit
          Left = 97
          Top = 22
          Width = 527
          Height = 24
          Anchors = [akLeft, akRight]
          TabOrder = 0
        end
        object txtLink16: TEdit
          Left = 97
          Top = 54
          Width = 527
          Height = 24
          Anchors = [akLeft, akRight]
          TabOrder = 1
        end
        object txtRC16: TEdit
          Left = 97
          Top = 86
          Width = 527
          Height = 24
          Anchors = [akLeft, akRight]
          TabOrder = 2
        end
        object txtLIB16: TEdit
          Left = 97
          Top = 119
          Width = 527
          Height = 24
          Anchors = [akLeft, akRight]
          TabOrder = 3
        end
      end
      object GroupBox5: TGroupBox
        AlignWithMargins = True
        Left = 20
        Top = 100
        Width = 666
        Height = 65
        Margins.Left = 20
        Margins.Top = 5
        Margins.Right = 20
        Margins.Bottom = 5
        Align = alTop
        Anchors = [akRight]
        Caption = 'Microsoft SDK'
        TabOrder = 1
        DesignSize = (
          666
          65)
        object Label2: TLabel
          Left = 16
          Top = 27
          Width = 75
          Height = 16
          Caption = 'Include Path:'
        end
        object SpeedButton1: TSpeedButton
          Left = 630
          Top = 26
          Width = 23
          Height = 22
          Anchors = [akRight]
          Caption = '...'
          OnClick = txtSDKIncludePathButtonClick
          ExplicitLeft = 599
          ExplicitTop = 16
        end
        object txtSDKIncludePath: TEdit
          Left = 97
          Top = 24
          Width = 527
          Height = 24
          Anchors = [akLeft, akRight]
          TabOrder = 0
        end
      end
      object GroupBox2: TGroupBox
        AlignWithMargins = True
        Left = 20
        Top = 342
        Width = 666
        Height = 157
        Margins.Left = 20
        Margins.Top = 5
        Margins.Right = 20
        Margins.Bottom = 5
        Align = alTop
        Anchors = [akRight]
        Caption = '64-bit'
        TabOrder = 2
        DesignSize = (
          666
          157)
        object Label7: TLabel
          Left = 16
          Top = 25
          Width = 56
          Height = 16
          Caption = 'ML64.EXE'
        end
        object SpeedButton6: TSpeedButton
          Left = 630
          Top = 24
          Width = 23
          Height = 22
          Anchors = [akRight]
          Caption = '...'
          OnClick = txtML64ButtonClick
          ExplicitLeft = 599
          ExplicitTop = 16
        end
        object Label8: TLabel
          Left = 16
          Top = 57
          Width = 51
          Height = 16
          Caption = 'LINK.EXE'
        end
        object SpeedButton7: TSpeedButton
          Left = 630
          Top = 56
          Width = 23
          Height = 22
          Anchors = [akRight]
          Caption = '...'
          OnClick = txtLink64ButtonClick
        end
        object Label9: TLabel
          Left = 16
          Top = 89
          Width = 42
          Height = 16
          Caption = 'RC.EXE'
        end
        object SpeedButton8: TSpeedButton
          Left = 630
          Top = 88
          Width = 23
          Height = 22
          Anchors = [akRight]
          Caption = '...'
          OnClick = txtRC64ButtonClick
        end
        object Label10: TLabel
          Left = 16
          Top = 122
          Width = 43
          Height = 16
          Caption = 'LIB.EXE'
        end
        object SpeedButton9: TSpeedButton
          Left = 630
          Top = 121
          Width = 23
          Height = 22
          Anchors = [akRight]
          Caption = '...'
          OnClick = txtLIB64ButtonClick
          ExplicitLeft = 599
          ExplicitTop = 91
        end
        object txtML64: TEdit
          Left = 97
          Top = 22
          Width = 527
          Height = 24
          Anchors = [akLeft, akRight]
          TabOrder = 0
        end
        object txtLink64: TEdit
          Left = 97
          Top = 54
          Width = 527
          Height = 24
          Anchors = [akLeft, akRight]
          TabOrder = 1
        end
        object txtRC64: TEdit
          Left = 97
          Top = 86
          Width = 527
          Height = 24
          Anchors = [akLeft, akRight]
          TabOrder = 2
        end
        object txtLIB64: TEdit
          Left = 97
          Top = 119
          Width = 527
          Height = 24
          Anchors = [akLeft, akRight]
          TabOrder = 3
        end
      end
      object GroupBox3: TGroupBox
        AlignWithMargins = True
        Left = 20
        Top = 175
        Width = 666
        Height = 157
        Margins.Left = 20
        Margins.Top = 5
        Margins.Right = 20
        Margins.Bottom = 5
        Align = alTop
        Anchors = [akRight]
        Caption = '32-bit'
        TabOrder = 3
        DesignSize = (
          666
          157)
        object Label11: TLabel
          Left = 17
          Top = 25
          Width = 42
          Height = 16
          Caption = 'ML.EXE'
        end
        object SpeedButton10: TSpeedButton
          Left = 630
          Top = 24
          Width = 23
          Height = 22
          Anchors = [akRight]
          Caption = '...'
          OnClick = txtML32ButtonClick
          ExplicitLeft = 599
          ExplicitTop = 16
        end
        object Label12: TLabel
          Left = 16
          Top = 57
          Width = 51
          Height = 16
          Caption = 'LINK.EXE'
        end
        object SpeedButton11: TSpeedButton
          Left = 630
          Top = 56
          Width = 23
          Height = 22
          Anchors = [akRight]
          Caption = '...'
          OnClick = txtLink32ButtonClick
          ExplicitLeft = 599
          ExplicitTop = 41
        end
        object Label13: TLabel
          Left = 16
          Top = 89
          Width = 42
          Height = 16
          Caption = 'RC.EXE'
        end
        object SpeedButton12: TSpeedButton
          Left = 630
          Top = 88
          Width = 23
          Height = 22
          Anchors = [akRight]
          Caption = '...'
          OnClick = txtRC32ButtonClick
        end
        object Label14: TLabel
          Left = 16
          Top = 122
          Width = 43
          Height = 16
          Caption = 'LIB.EXE'
        end
        object SpeedButton13: TSpeedButton
          Left = 630
          Top = 121
          Width = 23
          Height = 22
          Anchors = [akRight]
          Caption = '...'
          OnClick = txtLIB32ButtonClick
          ExplicitLeft = 599
          ExplicitTop = 91
        end
        object txtML32: TEdit
          Left = 97
          Top = 22
          Width = 527
          Height = 24
          Anchors = [akLeft, akRight]
          TabOrder = 0
        end
        object txtLink32: TEdit
          Left = 97
          Top = 54
          Width = 527
          Height = 24
          Anchors = [akLeft, akRight]
          TabOrder = 1
        end
        object txtRC32: TEdit
          Left = 97
          Top = 86
          Width = 527
          Height = 24
          Anchors = [akLeft, akRight]
          TabOrder = 2
        end
        object txtLIB32: TEdit
          Left = 97
          Top = 119
          Width = 527
          Height = 24
          Anchors = [akLeft, akRight]
          TabOrder = 3
        end
      end
    end
    object tabThemes: TTabSheet
      Caption = 'Themes'
      ImageIndex = 2
      TabVisible = False
      object Label15: TLabel
        Left = 16
        Top = 9
        Width = 66
        Height = 16
        Caption = 'Code Editor'
      end
      object cmbCodeEditor: TComboBox
        Left = 16
        Top = 28
        Width = 185
        Height = 24
        DropDownCount = 30
        TabOrder = 0
        Text = 'cmbCodeEditor'
        OnChange = cmbCodeEditorChange
      end
    end
    object tabDebug: TTabSheet
      Caption = 'Debug'
      ImageIndex = 3
      TabVisible = False
      object lblDebuggerPath: TLabel
        Left = 48
        Top = 128
        Width = 60
        Height = 16
        Caption = 'Debugger:'
        Visible = False
      end
      object btnBrowseDebugger: TSpeedButton
        Left = 627
        Top = 127
        Width = 23
        Height = 22
        Caption = '...'
        Visible = False
        OnClick = btnBrowseDebuggerClick
      end
      object lblDebuggerDescription: TLabel
        Left = 114
        Top = 155
        Width = 495
        Height = 112
        Caption = 
          'To debug the linker output, use the $OutputFile meta command to ' +
          'pass the file to the debugger. For example: "C:\Program Files\De' +
          'bugging Tools for Windows (x64)\windbg.exe" $OutputFile'#13#10#13#10'If yo' +
          'u wish to add any additional debugger options, pass them along o' +
          'n the command line above.'#13#10
        Visible = False
        WordWrap = True
      end
      object radUseExternalDebugger: TRadioButton
        Left = 32
        Top = 88
        Width = 257
        Height = 17
        Caption = 'Use External Debugger'
        TabOrder = 0
        OnClick = radUseExternalDebuggerClick
      end
      object radVisualMASMDebugger: TRadioButton
        Left = 32
        Top = 56
        Width = 305
        Height = 17
        Caption = 'Use Visual MASM Debugger (not ready, yet)'
        Enabled = False
        TabOrder = 1
        OnClick = radVisualMASMDebuggerClick
      end
      object txtDebugger: TEdit
        Left = 114
        Top = 125
        Width = 507
        Height = 24
        TabOrder = 2
        Visible = False
      end
      object radDoNottStartDebugger: TRadioButton
        Left = 32
        Top = 24
        Width = 321
        Height = 17
        Caption = 'Do not start the debugger when assembling in debug mode'
        Checked = True
        TabOrder = 3
        TabStop = True
        OnClick = radDoNottStartDebuggerClick
      end
    end
    object tabFileAssociation: TTabSheet
      Caption = 'tabFileAssociation'
      ImageIndex = 4
      TabVisible = False
      object Label18: TLabel
        Left = 16
        Top = 19
        Width = 604
        Height = 32
        Caption = 
          'Associate the following file types with Visual MASM. This will a' +
          'llow you to open files in Windows Explorer with Visual MASM.'
        WordWrap = True
      end
      object GroupBox7: TGroupBox
        Left = 16
        Top = 64
        Width = 217
        Height = 121
        Caption = 'File Extensions'
        TabOrder = 0
        object chkASM: TCheckBox
          Left = 16
          Top = 32
          Width = 177
          Height = 17
          Caption = '.ASM (assembly source files)'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object chkINC: TCheckBox
          Left = 16
          Top = 55
          Width = 177
          Height = 17
          Caption = '.INC (include files)'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object chkRC: TCheckBox
          Left = 16
          Top = 78
          Width = 177
          Height = 17
          Caption = '.RC (resource script files)'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
      end
      object btnAssociateFileTypes: TButton
        Left = 16
        Top = 216
        Width = 217
        Height = 25
        Caption = 'Associate file types now'
        TabOrder = 1
        OnClick = btnAssociateFileTypesClick
      end
    end
  end
  object dlgFont: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 40
    Top = 88
  end
end
