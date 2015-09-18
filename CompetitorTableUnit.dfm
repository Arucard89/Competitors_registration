object CompetitorTableForm: TCompetitorTableForm
  Left = 394
  Top = 195
  Width = 991
  Height = 675
  Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099' '#1091#1095#1072#1089#1090#1085#1080#1082#1086#1074
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 18
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 975
    Height = 169
    Align = alTop
    TabOrder = 0
    object TableHeadLabel: TLabel
      Left = 1
      Top = 150
      Width = 973
      Height = 18
      Align = alBottom
      Alignment = taCenter
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 409
      Height = 149
      Align = alLeft
      Caption = #1054#1090#1073#1086#1088' '#1091#1095#1072#1089#1090#1085#1080#1082#1086#1074
      TabOrder = 0
      object Label1: TLabel
        Left = 320
        Top = 24
        Width = 28
        Height = 18
        Caption = #1042#1077#1089
      end
      object Label2: TLabel
        Left = 224
        Top = 24
        Width = 60
        Height = 18
        Caption = #1042#1086#1079#1088#1072#1089#1090
      end
      object Label3: TLabel
        Left = 8
        Top = 24
        Width = 37
        Height = 18
        Caption = #1055#1086#1103#1089
      end
      object BeltBox: TComboBox
        Left = 8
        Top = 48
        Width = 201
        Height = 26
        ItemHeight = 18
        TabOrder = 0
      end
      object ageBox: TComboBox
        Left = 224
        Top = 48
        Width = 81
        Height = 26
        ItemHeight = 18
        TabOrder = 1
        OnChange = ageBoxChange
      end
      object weightBox: TComboBox
        Left = 320
        Top = 48
        Width = 81
        Height = 26
        ItemHeight = 18
        TabOrder = 2
      end
      object buildTableBtn: TBitBtn
        Left = 128
        Top = 96
        Width = 273
        Height = 41
        Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091' '#1091#1095#1072#1089#1090#1085#1080#1082#1086#1074
        TabOrder = 3
        OnClick = buildTableBtnClick
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
          33333333333F8888883F33330000324334222222443333388F3833333388F333
          000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
          F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
          223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
          3338888300003AAAAAAA33333333333888888833333333330000333333333333
          333333333333333333FFFFFF000033333333333344444433FFFF333333888888
          00003A444333333A22222438888F333338F3333800003A2243333333A2222438
          F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
          22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
          33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
          3333333333338888883333330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
    end
    object BuildBracketsBtn: TBitBtn
      Left = 552
      Top = 8
      Width = 409
      Height = 137
      Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1090#1091#1088#1085#1080#1088#1085#1091#1102' '#1089#1077#1090#1082#1091' '#1087#1086' '#1087#1086#1083#1091#1095#1077#1085#1085#1086#1081' '#1090#1072#1073#1083#1080#1094#1077
      Enabled = False
      TabOrder = 1
      WordWrap = True
      OnClick = BuildBracketsBtnClick
      Glyph.Data = {
        F2010000424DF201000000000000760000002800000024000000130000000100
        0400000000007C01000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333334433333
        3333333333388F3333333333000033334224333333333333338338F333333333
        0000333422224333333333333833338F33333333000033422222243333333333
        83333338F3333333000034222A22224333333338F33F33338F33333300003222
        A2A2224333333338F383F3338F33333300003A2A222A222433333338F8333F33
        38F33333000034A22222A22243333338833333F3338F333300004222A2222A22
        2433338F338F333F3338F3330000222A3A2224A22243338F3838F338F3338F33
        0000A2A333A2224A2224338F83338F338F3338F300003A33333A2224A2224338
        333338F338F3338F000033333333A2224A2243333333338F338F338F00003333
        33333A2224A2233333333338F338F83300003333333333A2224A333333333333
        8F338F33000033333333333A222433333333333338F338F30000333333333333
        A224333333333333338F38F300003333333333333A223333333333333338F8F3
        000033333333333333A3333333333333333383330000}
      NumGlyphs = 2
    end
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 169
    Width = 975
    Height = 468
    Align = alClient
    TabOrder = 1
    object cxGrid1DBTableView1: TcxGridDBTableView
      DataController.DataSource = CompetitorsSource
      DataController.Filter.Criteria = {00000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ExpandMasterRowOnDblClick = True
      object cxGrid1DBTableView1DBColumn1: TcxGridDBColumn
        Caption = #8470' '#1087'/'#1087
        OnGetDisplayText = cxGrid1DBTableView1DBColumn1GetDisplayText
        Options.Grouping = False
        Options.Sorting = False
      end
      object cxGrid1DBTableView1DBColumn2: TcxGridDBColumn
        Caption = 'id'
        DataBinding.FieldName = 't_main.id'
      end
      object cxGrid1DBTableView1DBColumn3: TcxGridDBColumn
        Caption = #1060#1048#1054
        DataBinding.FieldName = 'FIO'
      end
      object cxGrid1DBTableView1DBColumn4: TcxGridDBColumn
        Caption = #1042#1086#1079#1088#1072#1089#1090
        DataBinding.FieldName = 't_ages.age'
      end
      object cxGrid1DBTableView1DBColumn5: TcxGridDBColumn
        Caption = #1042#1077#1089#1086#1074#1072#1103' '#1082#1072#1090#1077#1075#1086#1088#1080#1103
        DataBinding.FieldName = 't_weights.weight'
      end
      object cxGrid1DBTableView1DBColumn6: TcxGridDBColumn
        Caption = #1055#1086#1103#1089
        DataBinding.FieldName = 't_belts.Belt'
      end
      object cxGrid1DBTableView1DBColumn7: TcxGridDBColumn
        Caption = #1043#1086#1088#1086#1076
        DataBinding.FieldName = 't_cities.city'
      end
      object cxGrid1DBTableView1DBColumn8: TcxGridDBColumn
        Caption = #1050#1083#1091#1073'/'#1090#1088#1077#1085#1077#1088
        DataBinding.FieldName = 't_clubs.club'
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object CompetitorsQuery: TADOQuery
    Connection = DataModule1.MainConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT * FROM ((((t_main INNER JOIN t_ages ON t_main.age = t_age' +
        's.id) INNER JOIN t_weights ON t_main.weight = t_weights.id) INNE' +
        'R JOIN t_belts ON t_main.belt = t_belts.id) INNER JOIN t_cities ' +
        'ON t_main.city = t_cities.id) INNER JOIN t_clubs ON t_main.club ' +
        '= t_clubs.id;'
      '')
    Left = 432
    Top = 40
  end
  object CompetitorsSource: TDataSource
    DataSet = CompetitorsQuery
    Left = 480
    Top = 40
  end
  object ADOQuery1: TADOQuery
    DataSource = CompetitorsSource
    Parameters = <>
    Left = 456
    Top = 96
  end
end
