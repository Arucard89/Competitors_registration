object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 493
  Top = 155
  Height = 191
  Width = 259
  object MainConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=.\DB\' +
      'Base.mdb;Mode=Share Deny None;Jet OLEDB:System database="";Jet O' +
      'LEDB:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:E' +
      'ngine Type=5;Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global ' +
      'Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLED' +
      'B:New Database Password="";Jet OLEDB:Create System Database=Fals' +
      'e;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don'#39't Copy Locale o' +
      'n Compact=False;Jet OLEDB:Compact Without Replica Repair=False;J' +
      'et OLEDB:SFP=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 16
  end
  object MainQuery: TADOQuery
    Connection = MainConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT * FROM ((((t_main INNER JOIN t_ages ON t_main.age = t_age' +
        's.id) INNER JOIN t_weights ON t_main.weight = t_weights.id) INNE' +
        'R JOIN t_belts ON t_main.belt = t_belts.id) INNER JOIN t_cities ' +
        'ON t_main.city = t_cities.id) INNER JOIN t_clubs ON t_main.club ' +
        '= t_clubs.id;')
    Left = 104
    Top = 16
  end
  object MainDataSource: TDataSource
    DataSet = MainQuery
    Left = 176
    Top = 16
  end
  object DBQuery: TADOQuery
    Connection = MainConnection
    Parameters = <>
    Left = 32
    Top = 72
  end
end
