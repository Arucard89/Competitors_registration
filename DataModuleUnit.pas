unit DataModuleUnit;

interface

uses
  SysUtils, Classes, DB, ADODB, Dialogs;

type
  TDataModule1 = class(TDataModule)
    MainConnection: TADOConnection;
    MainQuery: TADOQuery;
    MainDataSource: TDataSource;
    DBQuery: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //списки значений граф таблицы
    ages_list: TStringList;
    belts_list: TStringList;
    weights_list: TStringList;
    cities_list: TStringList;
    clubs_list: TStringList;
    function fulfill_list(tableName: string; colName: string; var list:TStringList):integer; //функция заполнения списков значениями их БД
        //tableName: string - имя таблицы из которой берем значения; colName: string - имя столбца; var list:TStringList - список в который будем выгружать данные; возвращает 0, если все прошло гладко, 1 если не подключился к БД, 2, если пустое значение
    function add_value_query(table,colName:string; value:variant): integer; //запрос для добавления
    function add_weight_query(weight,age: variant): integer; //запрос для добавления веса
    function find_value_querry(table,colName,searchColName:string; param:variant; var value:variant):integer; //функция поиска значения столбца записи
        //table - имя таблицы поиска,colName - столбец в котором исходное значение,searchColName - столбец, в котором искомое значение; param - исходное значение; var value - нужное значение

  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

{ TDataModule1 }

function TDataModule1.fulfill_list(tableName, colName: string;
  var list: TStringList): integer;
begin
  list.Clear;
  DBQuery.SQL.Text :='SELECT * FROM ' + tablename;
  try
    DBQuery.Open;
    if not DBQuery.IsEmpty then
    begin
      DBQuery.First;
      While not DBQuery.Eof do  //непустой запрос, знаычит, заполняем стринглист
      begin
        list.Add(DBQuery.FieldByName(colName).AsString);
        DBQuery.Next;
      end;
      result:= 0;
    end
    else
      result := 2;
  except
    result:= 1;
  end;
  DBQuery.Close;
end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  //орпеделяем соединение
  MainConnection.Close; //закрываем, т.к. на отладке открыт
  MainConnection.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=.\DB\Base.mdb;Mode=Share Deny None';
  try
    MainConnection.Open;
    MainQuery.Open;
  except
    showmessage('Проблемы с БД. Исправьте базу и перезапустите программу');
    Exit;
  end;
  //определяем и заполняем списки(Вес не входит, потому что отдельный для каждого возраста)
  ages_list := TStringList.Create;
  if fulfill_list('t_ages', 'age', ages_list) <> 0 then
    ShowMessage('Таблица возрастов пуста либо отсутствует');
  belts_list := TStringList.Create;
  if fulfill_list('t_belts', 'belt', belts_list) <> 0 then
    ShowMessage('Таблица поясов пуста либо отсутствует');
  weights_list := TStringList.Create;
  {if fulfill_list('t_weights', 'weight', weights_list) <> 0 then
    ShowMessage('Таблица весов пуста либо отсутствует');}
  cities_list := TStringList.Create;
  if fulfill_list('t_cities', 'city', cities_list) <> 0 then
    ShowMessage('Таблица городов пуста либо отсутствует');
  clubs_list := TStringList.Create;
  if fulfill_list('t_clubs', 'club', clubs_list) <> 0 then
    ShowMessage('Таблица клубов пуста либо отсутствует');
end;

function TDataModule1.add_value_query(table, colName: string;
  value: variant): integer;
begin
    DBQuery.Close;
    DBQuery.SQL.Text := 'SELECT * FROM ' + table;
    try
      DBQuery.Open;
      DBQuery.Insert;
      DBQuery.FieldByName(colName).AsVariant := value;
      DBQuery.Post;
      DBQuery.Close;
      result := 0;
    except
      result := 1;
    end
end;

function TDataModule1.add_weight_query(weight, age: variant): integer;
var id:variant;
  r:integer;
begin
  r := find_value_querry('t_ages','age','id',age, id);
  if r <> 0 then  //ВЫХОДИМ, ЕСЛИ НЕ ПОЛУЧИЛИ id
    result := r
  else
  begin
    DBQuery.Close;
    DBQuery.SQL.Text := 'SELECT * FROM t_weights';
    try
      DBQuery.Open;
      DBQuery.Insert;
      DBQuery.FieldByName('weight').AsVariant := weight;
      DBQuery.FieldByName('age').AsVariant := id;
      DBQuery.Post;
      result := r; //там уже 0
    except
      result := 3;
    end;
    DBQuery.Close;
  end

end;

function TDataModule1.find_value_querry(table, colName,
  searchColName: string; param: variant; var value: variant): integer;
begin
  DBQuery.Close;
  DBQuery.SQL.Text := 'SELECT * FROM ' + table + ' WHERE ' + colName + ' = ' + QuotedStr(param);
  try
    DBQuery.Open;
    if not DBQuery.IsEmpty then
    begin
      value := DBQuery.FieldByName(searchColName).AsVariant;
      result := 0;
    end
    else
      result := 2;
  except
    result := 1;
  end;
  DBQuery.Close;
end;

procedure TDataModule1.DataModuleDestroy(Sender: TObject);
begin
  MainConnection.Connected := false; //отключаемся от базы
end;

end.
