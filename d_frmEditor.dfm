object frmEditor: TfrmEditor
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  Color = clBtnFace
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object DesignPanel: TLMDDesignPanel
    Left = 0
    Top = 32
    Width = 451
    Height = 273
    BorderStyle = bsNone
    AutoScroll = True
    Align = alClient
    Color = clWhite
    ParentColor = False
    TabOrder = 0
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 451
    Height = 32
    Align = alTop
    AutoSize = True
    Color = clBtnFace
    ParentColor = False
    RowSize = 30
    TabOrder = 1
    object ToolBar2: TToolBar
      Left = 16
      Top = 2
      Width = 62
      Height = 24
      AutoSize = True
      ButtonHeight = 24
      ButtonWidth = 24
      Caption = 'ToolBar2'
      Images = dm.ActionImages
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Action = dm.actDesignShowAlignPalette
      end
      object ToolButton2: TToolButton
        Left = 24
        Top = 0
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 13
        Style = tbsSeparator
      end
      object ToolButton11: TToolButton
        Left = 32
        Top = 0
        Action = dm.actDesignTestDialog
        ParentShowHint = False
        ShowHint = True
      end
    end
  end
  object Designer: TLMDDesigner
    ServiceProvider = frmMain.ServicePvdr
    Selection = Selection
    AllComponents = AllComps
    ShowRootResizers = True
    Module = Module
    DesignPanel = DesignPanel
    Grid.Color = 9803157
    HandleColor = 13400576
    HandleBorderColor = 13400576
    MultiSelectHandleColor = 16758122
    MultiSelectHandleBorderColor = 16758122
    InactiveHandleColor = 12961221
    InactiveHandleBorderColor = 12303291
    ShowNonvisualComponents = True
    ComponentCaptionsFont.Charset = DEFAULT_CHARSET
    ComponentCaptionsFont.Color = clWindowText
    ComponentCaptionsFont.Height = -11
    ComponentCaptionsFont.Name = 'MS Sans Serif'
    ComponentCaptionsFont.Style = []
    Left = 15
    Top = 73
  end
  object Module: TLMDModule
    OnCompsModified = ModuleCompsModified
    OnValidateEventHandlerName = ModuleValidateEventHandlerName
    OnGetEventHandlerName = ModuleGetEventHandlerName
    OnGetEventHandlerList = ModuleGetEventHandlerList
    OnEnsureEventHandlerSource = ModuleEnsureEventHandlerSource
    OnValidateEventHandler = ModuleValidateEventHandler
    OnLoadError = ModuleLoadError
    Left = 64
    Top = 72
  end
  object Selection: TLMDDesignObjects
    Left = 120
    Top = 72
  end
  object AllComps: TLMDDesignObjects
    Left = 192
    Top = 72
  end
end
