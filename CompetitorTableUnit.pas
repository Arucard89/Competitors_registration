unit CompetitorTableUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DataModuleUnit, ADODB;

type
  TCLubsCountArr = record
    count: integer;//количество участников
    club: string;//имя клуба
  end;

  TCountCompetitorsArr = array of TCLubsCountArr; //массив участников по клубам


  TCompetitorTableForm = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BeltBox: TComboBox;
    ageBox: TComboBox;
    weightBox: TComboBox;
    buildTableBtn: TBitBtn;
    TableHeadLabel: TLabel;
    BuildBracketsBtn: TBitBtn;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    CompetitorsQuery: TADOQuery;
    CompetitorsSource: TDataSource;
    cxGrid1DBTableView1DBColumn1: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn2: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn3: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn4: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn5: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn6: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn7: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn8: TcxGridDBColumn;
    ADOQuery1: TADOQuery;
    procedure cxGrid1DBTableView1DBColumn1GetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: String);
    procedure FormResize(Sender: TObject);
    procedure buildTableBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ageBoxChange(Sender: TObject);
    procedure BuildBracketsBtnClick(Sender: TObject);
  private
    { Private declarations }
    compArr: TCountCompetitorsArr; //массив клубов со списком участников
    groupsCount:integer; //количество подгрупп

    function build_weights_list(age: string; var list:TStringList):integer; //заполнение списка весов по возрасту/ 0-ок, 1-не удалось сделать запрос, 2-пустая таблица//стырено из формы участника
    function load_list_to_weight_combo(age:string):integer; //закгрузка в комбобокс весов
    function built_competitors_list:integer;//строим таблицу участников, удовлетворяющих критериям

    function build_club_list_in_category:integer; //построить массив клубов по названиям(количество участников выставляется в 0 для каждой записи)
    procedure get_clubs_count; //получаем количество участников по каждому клубу

    procedure qSort(var A: TCountCompetitorsArr; min, max: Integer); //быстрая сортировка для записей клубов

  public
    { Public declarations }
  end;

var
  CompetitorTableForm: TCompetitorTableForm;

implementation

{$R *.dfm}

procedure TCompetitorTableForm.cxGrid1DBTableView1DBColumn1GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  AText := IntToStr(Sender.GridView.DataController.GetRowIndexByRecordIndex(ARecord.RecordIndex, false)+1);
end;

procedure TCompetitorTableForm.FormResize(Sender: TObject);
begin
  //подстраиваем ячейки таблицы под измененный размер
  {cxGrid1DBTableView1.OptionsView.ColumnAutoWidth := true;
  cxGrid1DBTableView1.OptionsView.CellAutoHeight := true;}
end;

procedure TCompetitorTableForm.buildTableBtnClick(Sender: TObject);
var r:integer;
begin
  //проверяем, все ли выбраны параметры
  if BeltBox.Text = '' then
  begin
    ShowMessage('Не выбран пояс.');
    exit;
  end;

  if ageBox.Text = '' then
  begin
    ShowMessage('Не выбран возраст.');
    exit;
  end;

  if weightBox.Text = '' then
  begin
    ShowMessage('Не выбран вес.');
    exit;
  end;
  //если дошли до сбда, значит, все хорошо, начинаем строить таблицу.
  r := built_competitors_list;

  if r = 0 then   //все отлично и доступ к кнопке включаем
    BuildBracketsBtn.Enabled := true;

  if r = 1 then
  begin
     ShowMessage('Участников с заданными параметрами нет.');
     BuildBracketsBtn.Enabled := false;
  end;

  if r = 2 then
  begin
     ShowMessage('Произошла ошибка обращения к БД.');
     BuildBracketsBtn.Enabled := false;
  end;
end;

procedure TCompetitorTableForm.FormCreate(Sender: TObject);
begin
  //закрываем запрос, чтобы таблица была пустой
  CompetitorsQuery.Close;
  //грузим списки весовых и поясов
  with DataModule1 do
  begin
    if fulfill_list('t_ages', 'age', ages_list) <> 0 then
      ShowMessage('Таблица возрастов пуста либо отсутствует');
    ageBox.Items.Text := ages_list.Text;

    if fulfill_list('t_belts', 'belt', belts_list) <> 0 then
      ShowMessage('Таблица поясов пуста либо отсутствует');
    beltBox.Items.Text := belts_list.Text;
  end
  
end;

procedure TCompetitorTableForm.ageBoxChange(Sender: TObject);
begin
  if AgeBox.Text <> '' then
  begin
    if load_list_to_weight_combo(AgeBox.Text) <> 0 then
      ShowMessage('Список весов для данной возрастной категории пуст.');
  end;
end;


function TCompetitorTableForm.build_weights_list(age: string;
  var list: TStringList): integer;
begin
  list.Clear;
  //делаем объединенную таблицу и выбираем только веса
  with DataModule1 do
  begin
    DBQuery.Close;
    DBQuery.SQL.Text := 'SELECT t_weights.weight FROM t_weights INNER JOIN t_ages ON t_weights.age = t_ages.id'+
        ' WHERE t_ages.age = ' +QuotedStr(age);
    try
      DBQuery.Open;
      if not DBQuery.IsEmpty then
      begin
        DBQuery.First;
        while not DBQuery.Eof do
        begin
          list.Add(DBQuery.FieldByName('weight').AsString);
          DBQuery.Next;
        end;
        result := 0;
      end
      else
        result := 2;
      except
        result := 1;
      end;
  end;
  DataModule1.DBQuery.Close;
end;

function TCompetitorTableForm.load_list_to_weight_combo(
  age: string): integer;
var list:TstringList;
begin
  list := TStringList.Create;
  result := build_weights_list(age,list);
  weightBox.Clear;
  weightBox.Items.Text := list.Text;
  list.Destroy;
end;

function TCompetitorTableForm.built_competitors_list: integer;
begin
  CompetitorsQuery.Close;
  CompetitorsQuery.SQL.Text := 'SELECT  FROM ((((t_main INNER JOIN t_ages ON t_main.age = t_ages.id) '+
        'INNER JOIN t_weights ON t_main.weight = t_weights.id) INNER JOIN t_belts ON t_main.belt = t_belts.id)'+
        ' INNER JOIN t_cities ON t_main.city = t_cities.id) INNER JOIN t_clubs ON t_main.club = t_clubs.id'+
        ' WHERE t_belts.belt = ' + QuotedStr(BeltBox.Text) +
        ' AND t_ages.age = ' + QuotedStr(ageBox.Text) +
        ' AND t_weights.weight = ' + QuotedStr(weightBox.Text);
  try
    CompetitorsQuery.Open;
    if CompetitorsQuery.IsEmpty then
      result := 2
    else
      result := 0;
  except
    result := 1;
  end;
end;

procedure TCompetitorTableForm.BuildBracketsBtnClick(Sender: TObject);
begin
  BuildBracketsBtn.Enabled := false; //выключаем кнопку, чтоб руки не чесались 10 раз нажимать
  //находим количество разных команд в выборке
  //пока делаю в тупую, потому что по-другому не знаю еще как
  if build_club_list_in_category <> 0 then
  begin
    ShowMessage('Возникла ошибка при получении списка клубов.');
    exit;
  end;
  get_clubs_count; //получаем число участников от каждого клуба
  //сортируем элементы
  qSort(compArr,0, length(compArr)-1);
  //определяем количество подгрупп(в подгруппе 8 человек)
  groupCount := trunc(CompetitorsQuery.RecordCount / 8 );
  //делим людей на подгруппы
  

end;

function TCompetitorTableForm.build_club_list_in_category: integer;
var i:integer;
begin
  //сначала определяем сколько всего разных клубов
  with DataModule1 do
  begin
    DBQuery.Close;
    DBQuery.SQL.Text := 'SELECT DISTINCT(t_clubs.club) FROM ((((t_main INNER JOIN t_ages ON t_main.age = t_ages.id) '+
          'INNER JOIN t_weights ON t_main.weight = t_weights.id) INNER JOIN t_belts ON t_main.belt = t_belts.id)'+
          ' INNER JOIN t_cities ON t_main.city = t_cities.id) INNER JOIN t_clubs ON t_main.club = t_clubs.id'+
          ' WHERE t_belts.belt = ' + QuotedStr(BeltBox.Text) +
          ' AND t_ages.age = ' + QuotedStr(ageBox.Text) +
          ' AND t_weights.weight = ' + QuotedStr(weightBox.Text);
    try
      DBQuery.ExecSQL;
      SetLength(compArr,DBQuery.RecordCount);//выставляем динамический массив
      i := 0;
      DBQuery.First;
      while not DBQuery.Eof do
      begin
        compArr[i].club := DBQuery.FieldByName('t_clubs.club').AsString;
        compArr[i].count := 0;
        inc(i);
      end;
      result := 0;
    except
      result := 1;
    end;
  end;
end;

procedure TCompetitorTableForm.get_clubs_count;
var i,j: integer;
begin
  CompetitorsQuery.First;
  while not CompetitorsQuery.Eof do
  begin
    for j := 0 to length(compArr) - 1 do
    begin
      if CompetitorsQuery.FieldByName('t_clubs.club').AsString = compArr[j].club then
        inc(compArr[j].count);
    end;
    CompetitorsQuery.Next;
  end
end;

procedure TCompetitorTableForm.qSort(var A: TCountCompetitorsArr; min, max: Integer);
var i, j, supp: Integer;
tmp : TCLubsCountArr;
begin
  supp:=A[max-((max-min) div 2)].count;
  i:=min;
  j:=max;
  while i<j do
    begin
      while A[i].count < supp do
        i := i + 1;
      while A[j].count >supp do
        j := j - 1;
      if i <= j then
      begin
        tmp := A[i];
        A[i] := A[j];
        A[j]:= tmp;
        i := i+1;
        j := j-1;
      end;
    end;
  if min<j then
    qSort(A, min, j);
  if i<max then
    qSort(A, i, max);
end;

end.
