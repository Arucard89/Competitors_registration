object addWeightForm: TaddWeightForm
  Left = 754
  Top = 313
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1074#1077#1089#1086#1074#1086#1081' '#1082#1072#1090#1077#1075#1086#1088#1080#1080
  ClientHeight = 137
  ClientWidth = 346
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 18
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 163
    Height = 18
    Caption = #1042#1086#1079#1088#1072#1089#1090#1085#1072#1103' '#1082#1072#1090#1077#1075#1086#1088#1080#1103
  end
  object Label2: TLabel
    Left = 192
    Top = 8
    Width = 141
    Height = 18
    Caption = #1042#1077#1089#1086#1074#1072#1103' '#1082#1072#1090#1077#1075#1086#1088#1080#1103
  end
  object ageBox: TComboBox
    Left = 8
    Top = 32
    Width = 169
    Height = 26
    Style = csDropDownList
    ItemHeight = 18
    Sorted = True
    TabOrder = 0
  end
  object weightEdit: TMaskEdit
    Left = 192
    Top = 32
    Width = 145
    Height = 26
    EditMask = '##c#'
    MaxLength = 4
    TabOrder = 1
    Text = '    '
  end
  object BitBtn1: TBitBtn
    Left = 144
    Top = 80
    Width = 89
    Height = 41
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = BitBtn1Click
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
  object BitBtn2: TBitBtn
    Left = 248
    Top = 80
    Width = 91
    Height = 41
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    Kind = bkCancel
  end
end
