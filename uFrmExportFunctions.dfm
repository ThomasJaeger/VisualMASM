object frmExportFunctions: TfrmExportFunctions
  Left = 0
  Top = 0
  Caption = 'Export Functions'
  ClientHeight = 637
  ClientWidth = 795
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    AlignWithMargins = True
    Left = 15
    Top = 15
    Width = 765
    Height = 64
    Margins.Left = 15
    Margins.Top = 15
    Margins.Right = 15
    Margins.Bottom = 15
    Align = alTop
    Caption = 
      'Sekect the functions you would like to export in the DLL and mak' +
      'e available for other applications or DLLs be able to acess. '#13#10#13 +
      #10'You can rename the functions in the Export As column by clickin' +
      'g on it or pressing F2 to edit. Visual MASM will manage the mapp' +
      'ings for you.'
    WordWrap = True
    ExplicitWidth = 762
  end
  object vstFunctions: TVirtualStringTree
    Left = 0
    Top = 94
    Width = 795
    Height = 491
    Align = alClient
    Color = clWhite
    Colors.BorderColor = clWindowText
    Colors.GridLineColor = 2697513
    Colors.HotColor = clBlack
    Colors.TreeLineColor = clYellow
    DefaultNodeHeight = 20
    DragOperations = [doMove]
    EmptyListMessage = '< No Files Analyzed >'
    Header.AutoSizeIndex = -1
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -13
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoShowImages, hoVisible, hoAutoSpring]
    HintMode = hmTooltip
    IncrementalSearch = isAll
    IncrementalSearchTimeout = 500
    Indent = 19
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TreeOptions.AnimationOptions = [toAnimatedToggle]
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toGridExtensions, toInitOnSave, toReportMode, toWheelPanning, toEditOnClick, toEditOnDblClick]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowTreeLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toExtendedFocus, toCenterScrollIntoView, toAlwaysSelectNode]
    TreeOptions.StringOptions = [toAutoAcceptEditChange]
    OnChange = vstFunctionsChange
    OnChecked = vstFunctionsChecked
    OnCreateEditor = vstFunctionsCreateEditor
    OnEditing = vstFunctionsEditing
    OnFreeNode = vstFunctionsFreeNode
    OnGetText = vstFunctionsGetText
    OnHeaderClick = vstFunctionsHeaderClick
    OnInitNode = vstFunctionsInitNode
    Columns = <
      item
        CheckBox = True
        MaxWidth = 400
        MinWidth = 20
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
        Position = 0
        Width = 250
        WideText = 'Function'
        WideHint = 'Build Order'
      end
      item
        Position = 1
        Width = 290
        WideText = 'Export As'
      end
      item
        MinWidth = 120
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment]
        Position = 2
        Width = 251
        WideText = 'File'
      end>
    WideDefaultText = ''
  end
  object Panel1: TPanel
    Left = 0
    Top = 585
    Width = 795
    Height = 52
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      795
      52)
    object btnExport: TButton
      Left = 710
      Top = 14
      Width = 75
      Height = 25
      Anchors = [akRight]
      Caption = 'Export'
      ModalResult = 1
      TabOrder = 0
      OnClick = btnExportClick
    end
    object btnCancel: TButton
      Left = 629
      Top = 14
      Width = 75
      Height = 25
      Anchors = [akRight]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
end
