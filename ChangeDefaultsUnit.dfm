object ChangeDefaultsForm: TChangeDefaultsForm
  Left = 406
  Top = 14
  BorderStyle = bsDialog
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1089#1087#1077#1094#1080#1072#1083#1100#1085#1099#1093' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 634
  ClientWidth = 793
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 18
  object GroupBox1: TGroupBox
    Left = 16
    Top = 8
    Width = 369
    Height = 169
    Caption = #1042#1086#1079#1088#1072#1089#1090#1085#1072#1103' '#1082#1072#1090#1077#1075#1086#1088#1080#1103
    TabOrder = 0
    object cxGrid1: TcxGrid
      Left = 8
      Top = 24
      Width = 257
      Height = 137
      TabOrder = 0
      object cxGrid1DBTableView1: TcxGridDBTableView
        DataController.DataSource = ageSource
        DataController.Filter.Criteria = {00000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ExpandMasterRowOnDblClick = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        object cxGrid1DBTableView1DBColumn3: TcxGridDBColumn
          Caption = #8470' '#1087'/'#1087
          OnGetDisplayText = cxGrid1DBTableView1DBColumn3GetDisplayText
        end
        object cxGrid1DBTableView1DBColumn1: TcxGridDBColumn
          DataBinding.FieldName = 'id'
        end
        object cxGrid1DBTableView1DBColumn2: TcxGridDBColumn
          Caption = #1042#1086#1079#1088#1072#1089#1090
          DataBinding.FieldName = 'age'
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
    object ageAddBtn: TButton
      Left = 280
      Top = 24
      Width = 75
      Height = 41
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 1
      OnClick = ageAddBtnClick
    end
    object ageEditBtn: TButton
      Left = 280
      Top = 72
      Width = 75
      Height = 41
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 2
      OnClick = ageEditBtnClick
    end
    object ageDeleteBtn: TButton
      Left = 280
      Top = 120
      Width = 75
      Height = 41
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 3
      OnClick = ageDeleteBtnClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 408
    Top = 8
    Width = 369
    Height = 169
    Caption = #1055#1086#1103#1089#1072
    TabOrder = 1
    object cxGrid2: TcxGrid
      Left = 8
      Top = 24
      Width = 257
      Height = 137
      TabOrder = 0
      object cxGridDBTableView1: TcxGridDBTableView
        DataController.DataSource = beltSource
        DataController.Filter.Criteria = {00000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ExpandMasterRowOnDblClick = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        object cxGridDBTableView1DBColumn3: TcxGridDBColumn
          Caption = #8470' '#1087'/'#1087
          OnGetDisplayText = cxGridDBTableView1DBColumn3GetDisplayText
        end
        object cxGridDBTableView1DBColumn1: TcxGridDBColumn
          DataBinding.FieldName = 'id'
        end
        object cxGridDBTableView1DBColumn2: TcxGridDBColumn
          Caption = #1055#1086#1103#1089
          DataBinding.FieldName = 'Belt'
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
    object beltAddBtn: TButton
      Left = 280
      Top = 24
      Width = 75
      Height = 41
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 1
      OnClick = beltAddBtnClick
    end
    object beltEditBtn: TButton
      Left = 280
      Top = 72
      Width = 75
      Height = 41
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 2
      OnClick = beltEditBtnClick
    end
    object beltDeleteBtn: TButton
      Left = 280
      Top = 120
      Width = 75
      Height = 41
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 3
      OnClick = beltDeleteBtnClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 16
    Top = 192
    Width = 369
    Height = 169
    Caption = #1043#1086#1088#1086#1076#1072
    TabOrder = 2
    object cxGrid3: TcxGrid
      Left = 8
      Top = 24
      Width = 257
      Height = 137
      TabOrder = 0
      object cxGridDBTableView2: TcxGridDBTableView
        DataController.DataSource = citySource
        DataController.Filter.Criteria = {00000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ExpandMasterRowOnDblClick = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        object cxGridDBTableView2DBColumn3: TcxGridDBColumn
          Caption = #8470' '#1087'/'#1087
          OnGetDisplayText = cxGridDBTableView2DBColumn3GetDisplayText
        end
        object cxGridDBTableView2DBColumn1: TcxGridDBColumn
          DataBinding.FieldName = 'id'
        end
        object cxGridDBTableView2DBColumn2: TcxGridDBColumn
          Caption = #1043#1086#1088#1086#1076
          DataBinding.FieldName = 'city'
        end
      end
      object cxGridLevel2: TcxGridLevel
        GridView = cxGridDBTableView2
      end
    end
    object CityAddBtn: TButton
      Left = 280
      Top = 24
      Width = 75
      Height = 41
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 1
      OnClick = CityAddBtnClick
    end
    object CityEditBtn: TButton
      Left = 280
      Top = 72
      Width = 75
      Height = 41
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 2
      OnClick = CityEditBtnClick
    end
    object CityDeleteBtn: TButton
      Left = 280
      Top = 120
      Width = 75
      Height = 41
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 3
      OnClick = CityDeleteBtnClick
    end
  end
  object GroupBox4: TGroupBox
    Left = 408
    Top = 192
    Width = 369
    Height = 169
    Caption = #1050#1083#1091#1073#1099'/'#1090#1088#1077#1085#1077#1088#1099
    TabOrder = 3
    object cxGrid4: TcxGrid
      Left = 8
      Top = 24
      Width = 257
      Height = 137
      TabOrder = 0
      object cxGridDBTableView3: TcxGridDBTableView
        DataController.DataSource = clubSource
        DataController.Filter.Criteria = {00000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ExpandMasterRowOnDblClick = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        object cxGridDBTableView3DBColumn3: TcxGridDBColumn
          Caption = #8470' '#1087'/'#1087
          OnGetDisplayText = cxGridDBTableView3DBColumn3GetDisplayText
        end
        object cxGridDBTableView3DBColumn1: TcxGridDBColumn
          DataBinding.FieldName = 'id'
        end
        object cxGridDBTableView3DBColumn2: TcxGridDBColumn
          Caption = #1050#1083#1091#1073'/'#1090#1088#1077#1085#1077#1088
          DataBinding.FieldName = 'club'
        end
      end
      object cxGridLevel3: TcxGridLevel
        GridView = cxGridDBTableView3
      end
    end
    object ClubAddBtn: TButton
      Left = 280
      Top = 24
      Width = 75
      Height = 41
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 1
      OnClick = ClubAddBtnClick
    end
    object ClubEditBtn: TButton
      Left = 280
      Top = 72
      Width = 75
      Height = 41
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 2
      OnClick = ClubEditBtnClick
    end
    object ClubDeleteBtn: TButton
      Left = 280
      Top = 120
      Width = 75
      Height = 41
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 3
      OnClick = ClubDeleteBtnClick
    end
  end
  object GroupBox5: TGroupBox
    Left = 16
    Top = 376
    Width = 505
    Height = 249
    Caption = #1042#1077#1089#1086#1074#1099#1077' '#1082#1072#1090#1077#1075#1086#1088#1080#1080
    TabOrder = 4
    object cxGrid5: TcxGrid
      Left = 8
      Top = 24
      Width = 393
      Height = 217
      TabOrder = 0
      object cxGridDBTableView4: TcxGridDBTableView
        DataController.DataSource = weightSource
        DataController.Filter.Criteria = {00000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ExpandMasterRowOnDblClick = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        object cxGridDBTableView4DBColumn4: TcxGridDBColumn
          Caption = #8470' '#1087'/'#1087
          OnGetDisplayText = cxGridDBTableView4DBColumn4GetDisplayText
          Options.Grouping = False
          Options.Sorting = False
        end
        object cxGridDBTableView4DBColumn1: TcxGridDBColumn
          Caption = 'id'
          DataBinding.FieldName = 't_weights.id'
        end
        object cxGridDBTableView4DBColumn2: TcxGridDBColumn
          Caption = #1042#1077#1089#1086#1074#1072#1103' '#1082#1072#1090#1077#1075#1086#1088#1080#1103
          DataBinding.FieldName = 'weight'
        end
        object cxGridDBTableView4DBColumn3: TcxGridDBColumn
          Caption = #1042#1086#1079#1088#1072#1089#1090
          DataBinding.FieldName = 't_ages.age'
        end
      end
      object cxGridLevel4: TcxGridLevel
        GridView = cxGridDBTableView4
      end
    end
    object weightAddBtn: TButton
      Left = 416
      Top = 24
      Width = 75
      Height = 41
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 1
      OnClick = weightAddBtnClick
    end
    object weightEditBtn: TButton
      Left = 416
      Top = 72
      Width = 75
      Height = 41
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 2
      OnClick = weightEditBtnClick
    end
    object weightDeleteBtn: TButton
      Left = 416
      Top = 120
      Width = 75
      Height = 41
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 3
      OnClick = weightDeleteBtnClick
    end
  end
  object CloseBtn: TBitBtn
    Left = 656
    Top = 552
    Width = 113
    Height = 65
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 5
    Kind = bkClose
  end
  object ageQuery: TADOQuery
    Connection = DataModule1.MainConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM t_ages')
    Left = 40
    Top = 32
  end
  object beltQuery: TADOQuery
    Active = True
    Connection = DataModule1.MainConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM t_belts')
    Left = 424
    Top = 32
  end
  object cityQuery: TADOQuery
    Active = True
    Connection = DataModule1.MainConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM t_cities')
    Left = 40
    Top = 216
  end
  object clubQuery: TADOQuery
    Active = True
    Connection = DataModule1.MainConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM t_clubs')
    Left = 432
    Top = 216
  end
  object weightQuery: TADOQuery
    Active = True
    Connection = DataModule1.MainConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT * FROM t_weights INNER JOIN t_ages ON t_weights.age = t_a' +
        'ges.id')
    Left = 32
    Top = 408
  end
  object ageSource: TDataSource
    DataSet = ageQuery
    Left = 72
    Top = 32
  end
  object beltSource: TDataSource
    DataSet = beltQuery
    Left = 456
    Top = 32
  end
  object citySource: TDataSource
    DataSet = cityQuery
    Left = 72
    Top = 216
  end
  object clubSource: TDataSource
    DataSet = clubQuery
    Left = 464
    Top = 216
  end
  object weightSource: TDataSource
    DataSet = weightQuery
    Left = 64
    Top = 408
  end
end
