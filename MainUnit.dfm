object MainForm: TMainForm
  Left = 358
  Top = 183
  Width = 1305
  Height = 675
  Caption = 'MainForm'
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
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 1104
    Height = 637
    Align = alClient
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      DataController.DataSource = DataModule1.MainDataSource
      DataController.Filter.Criteria = {00000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <
        item
          Links = <
            item
              Column = cxGrid1DBTableView1DBColumn1
            end>
          SummaryItems = <
            item
              Kind = skCount
              Column = cxGrid1DBTableView1DBColumn1
            end>
        end
        item
          Links = <
            item
              Column = cxGrid1DBTableView1DBColumn2
            end>
          SummaryItems = <
            item
              Kind = skCount
              Column = cxGrid1DBTableView1DBColumn2
            end>
        end
        item
          Links = <
            item
              Column = cxGrid1DBTableView1DBColumn3
            end>
          SummaryItems = <
            item
              Kind = skCount
              Column = cxGrid1DBTableView1DBColumn3
            end>
        end
        item
          Links = <
            item
              Column = cxGrid1DBTableView1DBColumn4
            end>
          SummaryItems = <
            item
              Kind = skCount
              Column = cxGrid1DBTableView1DBColumn4
            end>
        end
        item
          Links = <
            item
              Column = cxGrid1DBTableView1DBColumn7
            end>
          SummaryItems = <
            item
              Kind = skCount
              Column = cxGrid1DBTableView1DBColumn7
            end>
        end
        item
          Links = <
            item
              Column = cxGrid1DBTableView1DBColumn5
            end>
          SummaryItems = <
            item
              Kind = skCount
              Column = cxGrid1DBTableView1DBColumn5
            end>
        end
        item
          Links = <
            item
              Column = cxGrid1DBTableView1DBColumn6
            end>
          SummaryItems = <
            item
              Kind = skCount
              Column = cxGrid1DBTableView1DBColumn6
            end>
        end>
      OptionsBehavior.ExpandMasterRowOnDblClick = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      object cxGrid1DBTableView1DBColumn9: TcxGridDBColumn
        Caption = #8470' '#1087'/'#1087
        DataBinding.FieldName = 't_main.id'
        OnGetDisplayText = cxGrid1DBTableView1DBColumn9GetDisplayText
        Options.Grouping = False
        Options.Sorting = False
        Width = 133
      end
      object cxGrid1DBTableView1DBColumn8: TcxGridDBColumn
        Caption = 'id'
        DataBinding.FieldName = 't_main.id'
        SortOrder = soAscending
      end
      object cxGrid1DBTableView1DBColumn1: TcxGridDBColumn
        Caption = #1054#1090#1084#1077#1090#1082#1072' '#1091#1095#1072#1089#1090#1080#1103
        DataBinding.FieldName = 'participation'
      end
      object cxGrid1DBTableView1DBColumn2: TcxGridDBColumn
        Caption = #1060#1048#1054
        DataBinding.FieldName = 'FIO'
      end
      object cxGrid1DBTableView1DBColumn3: TcxGridDBColumn
        Caption = #1042#1086#1079#1088#1072#1089#1090#1085#1072#1103' '#1082#1072#1090#1077#1075#1086#1088#1080#1103
        DataBinding.FieldName = 't_ages.age'
      end
      object cxGrid1DBTableView1DBColumn4: TcxGridDBColumn
        Caption = #1042#1077#1089#1086#1074#1072#1103' '#1082#1072#1090#1077#1075#1086#1088#1080#1103
        DataBinding.FieldName = 't_weights.weight'
      end
      object cxGrid1DBTableView1DBColumn7: TcxGridDBColumn
        Caption = #1055#1086#1103#1089
        DataBinding.FieldName = 't_belts.Belt'
      end
      object cxGrid1DBTableView1DBColumn5: TcxGridDBColumn
        Caption = #1043#1086#1088#1086#1076
        DataBinding.FieldName = 't_cities.city'
      end
      object cxGrid1DBTableView1DBColumn6: TcxGridDBColumn
        Caption = #1050#1083#1091#1073'/'#1090#1088#1077#1085#1077#1088
        DataBinding.FieldName = 't_clubs.club'
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object Panel1: TPanel
    Left = 1104
    Top = 0
    Width = 185
    Height = 637
    Align = alRight
    TabOrder = 1
    object AddBtn: TButton
      Left = 48
      Top = 8
      Width = 75
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 0
      OnClick = AddBtnClick
    end
    object EditBtn: TButton
      Left = 48
      Top = 56
      Width = 75
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 1
      OnClick = EditBtnClick
    end
    object DeleteBtn: TButton
      Left = 48
      Top = 152
      Width = 75
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 2
      OnClick = DeleteBtnClick
    end
    object TemplateBtn: TButton
      Left = 16
      Top = 96
      Width = 145
      Height = 41
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1082#1072#1082' '#1096#1072#1073#1083#1086#1085
      TabOrder = 3
      WordWrap = True
      OnClick = TemplateBtnClick
    end
    object ChangeDefaultsBtn: TButton
      Left = 16
      Top = 192
      Width = 145
      Height = 57
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1086#1089#1085#1086#1074#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      TabOrder = 4
      WordWrap = True
      OnClick = ChangeDefaultsBtnClick
    end
    object CompetitorTableBtn: TButton
      Left = 16
      Top = 264
      Width = 145
      Height = 65
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1087#1086#1089#1090#1088#1086#1077#1085#1080#1102' '#1090#1091#1088#1085#1080#1088#1085#1099#1093' '#1090#1072#1073#1083#1080#1094
      TabOrder = 5
      WordWrap = True
      OnClick = CompetitorTableBtnClick
    end
  end
end
