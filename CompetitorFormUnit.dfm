object CompetitorForm: TCompetitorForm
  Left = 194
  Top = 114
  Width = 653
  Height = 520
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1091#1095#1072#1089#1090#1085#1080#1082#1072' '
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
  object ParticipationMark: TCheckBox
    Left = 16
    Top = 400
    Width = 281
    Height = 17
    Caption = #1054#1090#1084#1077#1090#1082#1072' '#1086#1073' '#1091#1095#1072#1089#1090#1080#1080
    TabOrder = 0
  end
  object FIOEdit: TLabeledEdit
    Left = 16
    Top = 32
    Width = 609
    Height = 26
    EditLabel.Width = 110
    EditLabel.Height = 18
    EditLabel.Caption = #1060#1048#1054' '#1091#1095#1072#1089#1090#1085#1080#1082#1072
    TabOrder = 1
  end
  object CancelBtn: TBitBtn
    Left = 528
    Top = 424
    Width = 89
    Height = 41
    Caption = #1047#1072#1082#1088#1099#1090#1100' '
    TabOrder = 2
    Kind = bkCancel
  end
  object OKBtn: TBitBtn
    Left = 408
    Top = 424
    Width = 97
    Height = 41
    Caption = #1054#1050
    Default = True
    TabOrder = 3
    OnClick = OKBtnClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 72
    Width = 609
    Height = 57
    Caption = #1042#1086#1079#1088#1072#1089#1090#1085#1072#1103' '#1082#1072#1090#1077#1075#1086#1088#1080#1103
    TabOrder = 4
    object AgeBox: TComboBox
      Left = 8
      Top = 23
      Width = 417
      Height = 26
      Style = csDropDownList
      ItemHeight = 18
      Sorted = True
      TabOrder = 0
      OnChange = AgeBoxChange
    end
    object Button1: TButton
      Left = 464
      Top = 16
      Width = 129
      Height = 33
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1089#1087#1080#1089#1086#1082' '#1086#1090#1089#1091#1090#1089#1090#1074#1091#1102#1097#1080#1081' '#1101#1083#1077#1084#1077#1085#1090
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 136
    Width = 609
    Height = 57
    Hint = #1057#1087#1080#1089#1086#1082' '#1074#1077#1089#1086#1074' '#1087#1086#1103#1074#1083#1103#1077#1090#1089#1103' '#1090#1086#1083#1100#1082#1086' '#1087#1086#1089#1083#1077' '#1074#1099#1073#1086#1088#1072' '#1074#1086#1079#1088#1072#1089#1090#1072
    Caption = #1042#1077#1089#1086#1074#1072#1103' '#1082#1072#1090#1077#1075#1086#1088#1080#1103
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    object weightBox: TComboBox
      Left = 8
      Top = 23
      Width = 417
      Height = 26
      Hint = #1057#1087#1080#1089#1086#1082' '#1074#1077#1089#1086#1074' '#1087#1086#1103#1074#1083#1103#1077#1090#1089#1103' '#1090#1086#1083#1100#1082#1086' '#1087#1086#1089#1083#1077' '#1074#1099#1073#1086#1088#1072' '#1074#1086#1079#1088#1072#1089#1090#1072
      Style = csDropDownList
      ItemHeight = 18
      ParentShowHint = False
      ShowHint = True
      Sorted = True
      TabOrder = 0
    end
    object Button2: TButton
      Left = 464
      Top = 16
      Width = 129
      Height = 33
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1089#1087#1080#1089#1086#1082' '#1086#1090#1089#1091#1090#1089#1090#1074#1091#1102#1097#1080#1081' '#1101#1083#1077#1084#1077#1085#1090
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 16
    Top = 200
    Width = 609
    Height = 57
    Caption = #1055#1086#1103#1089
    TabOrder = 6
    object beltBox: TComboBox
      Left = 8
      Top = 23
      Width = 417
      Height = 26
      Style = csDropDownList
      ItemHeight = 18
      Sorted = True
      TabOrder = 0
    end
    object Button3: TButton
      Left = 464
      Top = 16
      Width = 129
      Height = 33
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1089#1087#1080#1089#1086#1082' '#1086#1090#1089#1091#1090#1089#1090#1074#1091#1102#1097#1080#1081' '#1101#1083#1077#1084#1077#1085#1090
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Button3Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 16
    Top = 264
    Width = 609
    Height = 57
    Caption = #1043#1086#1088#1086#1076
    TabOrder = 7
    object cityBox: TComboBox
      Left = 8
      Top = 23
      Width = 417
      Height = 26
      Style = csDropDownList
      ItemHeight = 18
      Sorted = True
      TabOrder = 0
    end
    object Button4: TButton
      Left = 464
      Top = 16
      Width = 129
      Height = 33
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1089#1087#1080#1089#1086#1082' '#1086#1090#1089#1091#1090#1089#1090#1074#1091#1102#1097#1080#1081' '#1101#1083#1077#1084#1077#1085#1090
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Button4Click
    end
  end
  object GroupBox5: TGroupBox
    Left = 16
    Top = 328
    Width = 609
    Height = 57
    Caption = #1050#1083#1091#1073'/'#1090#1088#1077#1085#1077#1088
    TabOrder = 8
    object clubBox: TComboBox
      Left = 8
      Top = 23
      Width = 417
      Height = 26
      Style = csDropDownList
      ItemHeight = 18
      Sorted = True
      TabOrder = 0
    end
    object Button5: TButton
      Left = 464
      Top = 16
      Width = 129
      Height = 33
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1089#1087#1080#1089#1086#1082' '#1086#1090#1089#1091#1090#1089#1090#1074#1091#1102#1097#1080#1081' '#1101#1083#1077#1084#1077#1085#1090
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Button5Click
    end
  end
end
