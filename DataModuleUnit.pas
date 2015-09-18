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
    //������ �������� ���� �������
    ages_list: TStringList;
    belts_list: TStringList;
    weights_list: TStringList;
    cities_list: TStringList;
    clubs_list: TStringList;
    function fulfill_list(tableName: string; colName: string; var list:TStringList):integer; //������� ���������� ������� ���������� �� ��
        //tableName: string - ��� ������� �� ������� ����� ��������; colName: string - ��� �������; var list:TStringList - ������ � ������� ����� ��������� ������; ���������� 0, ���� ��� ������ ������, 1 ���� �� ����������� � ��, 2, ���� ������ ��������
    function add_value_query(table,colName:string; value:variant): integer; //������ ��� ����������
    function add_weight_query(weight,age: variant): integer; //������ ��� ���������� ����
    function find_value_querry(table,colName,searchColName:string; param:variant; var value:variant):integer; //������� ������ �������� ������� ������
        //table - ��� ������� ������,colName - ������� � ������� �������� ��������,searchColName - �������, � ������� ������� ��������; param - �������� ��������; var value - ������ ��������

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
      While not DBQuery.Eof do  //�������� ������, �������, ��������� ����������
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
  //���������� ����������
  MainConnection.Close; //���������, �.�. �� ������� ������
  MainConnection.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=.\DB\Base.mdb;Mode=Share Deny None';
  try
    MainConnection.Open;
    MainQuery.Open;
  except
    showmessage('�������� � ��. ��������� ���� � ������������� ���������');
    Exit;
  end;
  //���������� � ��������� ������(��� �� ������, ������ ��� ��������� ��� ������� ��������)
  ages_list := TStringList.Create;
  if fulfill_list('t_ages', 'age', ages_list) <> 0 then
    ShowMessage('������� ��������� ����� ���� �����������');
  belts_list := TStringList.Create;
  if fulfill_list('t_belts', 'belt', belts_list) <> 0 then
    ShowMessage('������� ������ ����� ���� �����������');
  weights_list := TStringList.Create;
  {if fulfill_list('t_weights', 'weight', weights_list) <> 0 then
    ShowMessage('������� ����� ����� ���� �����������');}
  cities_list := TStringList.Create;
  if fulfill_list('t_cities', 'city', cities_list) <> 0 then
    ShowMessage('������� ������� ����� ���� �����������');
  clubs_list := TStringList.Create;
  if fulfill_list('t_clubs', 'club', clubs_list) <> 0 then
    ShowMessage('������� ������ ����� ���� �����������');
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
  if r <> 0 then  //�������, ���� �� �������� id
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
      result := r; //��� ��� 0
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
  MainConnection.Connected := false; //����������� �� ����
end;

end.
