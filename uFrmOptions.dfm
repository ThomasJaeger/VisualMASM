object frmOptions: TfrmOptions
  Left = 601
  Top = 218
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Options'
  ClientHeight = 680
  ClientWidth = 840
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
  object Panel1: TPanel
    Left = 0
    Top = 639
    Width = 840
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnCancel: TButton
      Left = 671
      Top = 6
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnOk: TButton
      Left = 752
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
    Height = 639
    Align = alLeft
    HideSelection = False
    Indent = 19
    RowSelect = True
    TabOrder = 1
    OnChange = tvTreeChange
    Items.NodeData = {
      03040000002C0000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      00000000000107470065006E006500720061006C003A00000000000000000000
      00FFFFFFFFFFFFFFFF000000000000000000000000010E460069006C00650020
      004C006F0063006100740069006F006E0073002A0000000000000000000000FF
      FFFFFFFFFFFFFF00000000000000000000000001065400680065006D00650073
      00280000000000000000000000FFFFFFFFFFFFFFFF0000000000000000000000
      00010544006500620075006700}
  end
  object pagOptions: TPageControl
    Left = 166
    Top = 0
    Width = 674
    Height = 639
    ActivePage = tabFileLocations
    Align = alClient
    TabOrder = 2
    object tabGeneral: TTabSheet
      Caption = 'General'
      TabVisible = False
      object chkOpenLastUsedProject: TCheckBox
        Left = 24
        Top = 16
        Width = 233
        Height = 17
        Caption = 'Open last used project when starting up'
        TabOrder = 0
      end
      object chkDoNotShowToolTips: TCheckBox
        Left = 24
        Top = 39
        Width = 193
        Height = 17
        Caption = 'Do not show tool tips'
        TabOrder = 1
      end
      object grpContextHelp2: TGroupBox
        Left = 20
        Top = 262
        Width = 257
        Height = 107
        Caption = 'Context Help'
        TabOrder = 2
        object lblContextHelpFont: TLabel
          Left = 16
          Top = 28
          Width = 62
          Height = 13
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
        Left = 368
        Top = 262
        Width = 257
        Height = 115
        Caption = 'Output Window'
        TabOrder = 3
        object lblOutputFont: TLabel
          Left = 16
          Top = 36
          Width = 62
          Height = 13
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
        Top = 96
        Width = 605
        Height = 129
        Caption = 'All Projects'
        TabOrder = 4
        object Label16: TLabel
          Left = 16
          Top = 24
          Width = 561
          Height = 33
          AutoSize = False
          Caption = 
            'Create new projects in this common projects folder. If you don'#39't' +
            ' specify a common projects folder, Visual MASM will use the defa' +
            'ult folder which is the folder where Visual MASM is running in.'
          WordWrap = True
        end
        object btnCommonProjectFolder: TSpeedButton
          Left = 547
          Top = 88
          Width = 23
          Height = 22
          Hint = 'Browse for folder'
          Caption = '...'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnCommonProjectFolderClick
        end
        object Label17: TLabel
          Left = 16
          Top = 69
          Width = 120
          Height = 13
          Caption = 'Common Projects Folder:'
        end
        object btnResetCommonProjectFolder: TSpeedButton
          Left = 576
          Top = 88
          Width = 17
          Height = 22
          Hint = 'Reset to default'
          Caption = '!'
          ParentShowHint = False
          ShowHint = True
          OnClick = btnResetCommonProjectFolderClick
        end
        object txtCommonProjectFolder: TEdit
          Left = 16
          Top = 88
          Width = 525
          Height = 21
          TabOrder = 0
        end
      end
    end
    object tabFileLocations: TTabSheet
      Caption = 'File Locations'
      ImageIndex = 1
      TabVisible = False
      object Panel2: TPanel
        AlignWithMargins = True
        Left = 20
        Top = 5
        Width = 626
        Height = 97
        Margins.Left = 20
        Margins.Top = 5
        Margins.Right = 20
        Margins.Bottom = 5
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 6
          Width = 618
          Height = 87
          Margins.Top = 5
          Align = alClient
          Alignment = taCenter
          AutoSize = False
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
          ExplicitLeft = 32
          ExplicitTop = 8
          ExplicitWidth = 265
          ExplicitHeight = 57
        end
      end
      object GroupBox4: TGroupBox
        AlignWithMargins = True
        Left = 20
        Top = 431
        Width = 626
        Height = 121
        Margins.Left = 20
        Margins.Top = 5
        Margins.Right = 20
        Margins.Bottom = 5
        Align = alTop
        Caption = '16-bit'
        TabOrder = 1
        object Label3: TLabel
          Left = 16
          Top = 19
          Width = 47
          Height = 13
          Caption = 'ML16.EXE'
        end
        object SpeedButton2: TSpeedButton
          Left = 599
          Top = 16
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = txtML16ButtonClick
        end
        object Label4: TLabel
          Left = 16
          Top = 44
          Width = 44
          Height = 13
          Caption = 'LINK.EXE'
        end
        object SpeedButton3: TSpeedButton
          Left = 599
          Top = 41
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = txtLink16ButtonClick
        end
        object Label5: TLabel
          Left = 16
          Top = 69
          Width = 36
          Height = 13
          Caption = 'RC.EXE'
        end
        object SpeedButton4: TSpeedButton
          Left = 599
          Top = 66
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = txtRC16ButtonClick
        end
        object Label6: TLabel
          Left = 16
          Top = 94
          Width = 37
          Height = 13
          Caption = 'LIB.EXE'
        end
        object SpeedButton5: TSpeedButton
          Left = 599
          Top = 91
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = txtLIB16ButtonClick
        end
        object txtML16: TEdit
          Left = 86
          Top = 16
          Width = 507
          Height = 21
          TabOrder = 0
        end
        object txtLink16: TEdit
          Left = 86
          Top = 41
          Width = 507
          Height = 21
          TabOrder = 1
        end
        object txtRC16: TEdit
          Left = 86
          Top = 66
          Width = 507
          Height = 21
          TabOrder = 2
        end
        object txtLIB16: TEdit
          Left = 86
          Top = 91
          Width = 507
          Height = 21
          TabOrder = 3
        end
      end
      object GroupBox5: TGroupBox
        AlignWithMargins = True
        Left = 20
        Top = 112
        Width = 626
        Height = 47
        Margins.Left = 20
        Margins.Top = 5
        Margins.Right = 20
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Microsoft SDK'
        TabOrder = 2
        object Label2: TLabel
          Left = 16
          Top = 19
          Width = 64
          Height = 13
          Caption = 'Include Path:'
        end
        object SpeedButton1: TSpeedButton
          Left = 599
          Top = 16
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = txtSDKIncludePathButtonClick
        end
        object txtSDKIncludePath: TEdit
          Left = 86
          Top = 16
          Width = 507
          Height = 21
          TabOrder = 0
        end
      end
      object btnRunSetupWizard: TButton
        Left = 16
        Top = 573
        Width = 185
        Height = 25
        Caption = 'Run Setup Wizard...'
        TabOrder = 3
        OnClick = btnRunSetupWizardClick
      end
      object GroupBox2: TGroupBox
        AlignWithMargins = True
        Left = 20
        Top = 300
        Width = 626
        Height = 121
        Margins.Left = 20
        Margins.Top = 5
        Margins.Right = 20
        Margins.Bottom = 5
        Align = alTop
        Caption = '64-bit'
        TabOrder = 4
        object Label7: TLabel
          Left = 16
          Top = 19
          Width = 47
          Height = 13
          Caption = 'ML64.EXE'
        end
        object SpeedButton6: TSpeedButton
          Left = 599
          Top = 16
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = txtML64ButtonClick
        end
        object Label8: TLabel
          Left = 16
          Top = 44
          Width = 44
          Height = 13
          Caption = 'LINK.EXE'
        end
        object SpeedButton7: TSpeedButton
          Left = 599
          Top = 38
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = txtLink64ButtonClick
        end
        object Label9: TLabel
          Left = 16
          Top = 69
          Width = 36
          Height = 13
          Caption = 'RC.EXE'
        end
        object SpeedButton8: TSpeedButton
          Left = 599
          Top = 66
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = txtRC64ButtonClick
        end
        object Label10: TLabel
          Left = 16
          Top = 94
          Width = 37
          Height = 13
          Caption = 'LIB.EXE'
        end
        object SpeedButton9: TSpeedButton
          Left = 599
          Top = 91
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = txtLIB64ButtonClick
        end
        object txtML64: TEdit
          Left = 86
          Top = 16
          Width = 507
          Height = 21
          TabOrder = 0
        end
        object txtLink64: TEdit
          Left = 86
          Top = 41
          Width = 507
          Height = 21
          TabOrder = 1
        end
        object txtRC64: TEdit
          Left = 86
          Top = 66
          Width = 507
          Height = 21
          TabOrder = 2
        end
        object txtLIB64: TEdit
          Left = 86
          Top = 91
          Width = 507
          Height = 21
          TabOrder = 3
        end
      end
      object GroupBox3: TGroupBox
        AlignWithMargins = True
        Left = 20
        Top = 169
        Width = 626
        Height = 121
        Margins.Left = 20
        Margins.Top = 5
        Margins.Right = 20
        Margins.Bottom = 5
        Align = alTop
        Caption = '32-bit'
        TabOrder = 5
        object Label11: TLabel
          Left = 16
          Top = 19
          Width = 35
          Height = 13
          Caption = 'ML.EXE'
        end
        object SpeedButton10: TSpeedButton
          Left = 599
          Top = 16
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = txtML32ButtonClick
        end
        object Label12: TLabel
          Left = 16
          Top = 44
          Width = 44
          Height = 13
          Caption = 'LINK.EXE'
        end
        object SpeedButton11: TSpeedButton
          Left = 599
          Top = 41
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = txtLink32ButtonClick
        end
        object Label13: TLabel
          Left = 16
          Top = 69
          Width = 36
          Height = 13
          Caption = 'RC.EXE'
        end
        object SpeedButton12: TSpeedButton
          Left = 599
          Top = 66
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = txtRC32ButtonClick
        end
        object Label14: TLabel
          Left = 16
          Top = 94
          Width = 37
          Height = 13
          Caption = 'LIB.EXE'
        end
        object SpeedButton13: TSpeedButton
          Left = 599
          Top = 91
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = txtLIB32ButtonClick
        end
        object txtML32: TEdit
          Left = 86
          Top = 16
          Width = 507
          Height = 21
          TabOrder = 0
        end
        object txtLink32: TEdit
          Left = 86
          Top = 41
          Width = 507
          Height = 21
          TabOrder = 1
        end
        object txtRC32: TEdit
          Left = 86
          Top = 66
          Width = 507
          Height = 21
          TabOrder = 2
        end
        object txtLIB32: TEdit
          Left = 86
          Top = 91
          Width = 507
          Height = 21
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
        Width = 56
        Height = 13
        Caption = 'Code Editor'
      end
      object cmbCodeEditor: TComboBox
        Left = 16
        Top = 28
        Width = 185
        Height = 21
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
        Top = 114
        Width = 51
        Height = 13
        Caption = 'Debugger:'
        Visible = False
      end
      object btnBrowseDebugger: TSpeedButton
        Left = 618
        Top = 111
        Width = 23
        Height = 22
        Caption = '...'
        Visible = False
        OnClick = btnBrowseDebuggerClick
      end
      object lblDebuggerDescription: TLabel
        Left = 105
        Top = 139
        Width = 485
        Height = 65
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
        Width = 257
        Height = 17
        Caption = 'Use Visual MASM Debugger (not ready, yet)'
        Enabled = False
        TabOrder = 1
        OnClick = radVisualMASMDebuggerClick
      end
      object txtDebugger: TEdit
        Left = 105
        Top = 111
        Width = 507
        Height = 21
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
