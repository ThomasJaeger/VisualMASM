object frmProjectBuildOrder: TfrmProjectBuildOrder
  Left = 0
  Top = 0
  ActiveControl = vstProject
  Caption = 'Project Build Order'
  ClientHeight = 539
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    AlignWithMargins = True
    Left = 15
    Top = 15
    Width = 331
    Height = 32
    Margins.Left = 15
    Margins.Top = 15
    Margins.Right = 15
    Margins.Bottom = 15
    Align = alTop
    Alignment = taCenter
    Caption = 
      'To change the build order, simply drag && drop the projects with' +
      'in the list.'
    WordWrap = True
    ExplicitWidth = 291
  end
  object vstProject: TVirtualStringTree
    Left = 0
    Top = 62
    Width = 361
    Height = 425
    Align = alClient
    Color = clWhite
    Colors.BorderColor = clWindowText
    Colors.GridLineColor = 2697513
    Colors.HotColor = clBlack
    Colors.TreeLineColor = clYellow
    DefaultNodeHeight = 20
    DragOperations = [doMove]
    EmptyListMessage = '< No Project Loaded >'
    Header.AutoSizeIndex = -1
    Header.Height = 21
    Header.Options = [hoAutoResize, hoColumnResize, hoShowImages, hoVisible, hoAutoSpring]
    Header.ParentFont = True
    HintMode = hmTooltip
    IncrementalSearch = isAll
    IncrementalSearchTimeout = 500
    Indent = 19
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TreeOptions.AnimationOptions = [toAnimatedToggle]
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoTristateTracking, toAutoHideButtons]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toInitOnSave, toReportMode, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowTreeLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnBeforeCellPaint = vstProjectBeforeCellPaint
    OnChecked = vstProjectChecked
    OnDragAllowed = vstProjectDragAllowed
    OnDragOver = vstProjectDragOver
    OnDragDrop = vstProjectDragDrop
    OnGetText = vstProjectGetText
    OnHeaderClick = vstProjectHeaderClick
    OnInitNode = vstProjectInitNode
    Columns = <
      item
        CheckBox = True
        MinWidth = 120
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coEditable]
        Position = 0
        Width = 242
        WideText = 'Project'
      end
      item
        Alignment = taRightJustify
        MaxWidth = 85
        MinWidth = 20
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus, coEditable]
        Position = 1
        Width = 85
        WideText = 'Build Order'
        WideHint = 'Build Order'
      end>
    WideDefaultText = ''
  end
  object Panel1: TPanel
    Left = 0
    Top = 487
    Width = 361
    Height = 52
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      361
      52)
    object btnOk: TButton
      Left = 276
      Top = 14
      Width = 75
      Height = 25
      Anchors = [akRight]
      Caption = 'Ok'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 195
      Top = 14
      Width = 75
      Height = 25
      Anchors = [akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
