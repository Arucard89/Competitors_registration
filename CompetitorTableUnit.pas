unit CompetitorTableUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DataModuleUnit, ADODB, ComObj, ClipBrd  ;

type

  TClubsCountArr = record //массив участников категории
    count: integer;//количество участников
    club: string;//имя клуба
    men: TStringList; // список участников данного клуба
  end;

  TCountCompetitorsArr = array of TClubsCountArr; //массив участников по клубам

  TCompetitorsInGroups = array of TStringList; //массив участников, разбитых на подгруппы

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
    CompetitorsInGroups: TCompetitorsInGroups; //массив подгрупп с участниками


    function build_weights_list(age: string; var list:TStringList):integer; //заполнение списка весов по возрасту/ 0-ок, 1-не удалось сделать запрос, 2-пустая таблица//стырено из формы участника
    function load_list_to_weight_combo(age:string):integer; //закгрузка в комбобокс весов
    function built_competitors_list:integer;//строим таблицу участников, удовлетворяющих критериям

    function build_club_list_in_category:integer; //построить массив клубов по названиям(количество участников выставляется в 0 для каждой записи)
    procedure get_clubs_count_and_men; //получаем количество участников по каждому клубу и самих участников
    procedure qSort(var A: TCountCompetitorsArr; min, max: Integer); //быстрая сортировка для записей клубов по уменьшению количества учатников
    procedure separating_on_subgroups; //разделяем людей по подгруппам
    procedure create_table_in_excel; //создание таблиц в экселе

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
  cxGrid1DBTableView1.OptionsView.ColumnAutoWidth := true;
  cxGrid1DBTableView1.OptionsView.CellAutoHeight := true;
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

  if r = 2 then
  begin
     ShowMessage('Участников с заданными параметрами нет.');
     BuildBracketsBtn.Enabled := false;
  end;

  if r = 1 then
  begin
     ShowMessage('Произошла ошибка обращения к БД.');
     BuildBracketsBtn.Enabled := false;
  end;
end;

procedure TCompetitorTableForm.FormCreate(Sender: TObject);
begin
  //ставим форму по центру экрана
  self.Left := (screen.Width - self.Width) div 2;
  self.Top :=  (screen.Height - self.Height) div 2;

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
  CompetitorsQuery.SQL.Text := 'SELECT * FROM ((((t_main INNER JOIN t_ages ON t_main.age = t_ages.id) '+
        'INNER JOIN t_weights ON t_main.weight = t_weights.id) INNER JOIN t_belts ON t_main.belt = t_belts.id)'+
        ' INNER JOIN t_cities ON t_main.city = t_cities.id) INNER JOIN t_clubs ON t_main.club = t_clubs.id'+
        ' WHERE t_belts.belt = ' + QuotedStr(BeltBox.Text) +
        ' AND t_ages.age = ' + QuotedStr(ageBox.Text) +
        ' AND t_weights.weight = ' + QuotedStr(weightBox.Text) +
        ' AND participation = true'; //выбираем только тех, кто с отметкой об участии
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
var i:integer;
begin
  BuildBracketsBtn.Enabled := false; //выключаем кнопку, чтоб руки не чесались 10 раз нажимать
  //находим количество разных команд в выборке
  //пока делаю в тупую, потому что по-другому не знаю еще как
  if build_club_list_in_category <> 0 then
  begin
    ShowMessage('Возникла ошибка при получении списка клубов.');
    exit;
  end;
  get_clubs_count_and_men; //получаем число участников от каждого клуба
  //сортируем элементы
  qSort(compArr,0, length(compArr)-1);
  //определяем количество подгрупп(в подгруппе 8 человек)
  groupsCount := CompetitorsQuery.RecordCount div 8;
  if  (CompetitorsQuery.RecordCount mod 8)<>0 then
    groupsCount := groupsCount + 1;

   //создаем массив участников по подгруппам
  SetLength(CompetitorsInGroups,groupsCount);
  for i := 0 to groupsCount - 1 do
    CompetitorsInGroups[i] := TStringList.Create;

  //делим людей на подгруппы
  separating_on_subgroups;
  //заносим данные в Excel
  create_table_in_excel;

  //удаляем динамику
  //массив участников по подгруппам
  for i := 0 to groupsCount - 1 do
    CompetitorsInGroups[i].Destroy;
  CompetitorsInGroups := nil;

  //удаляем массив участников по клубам
  for i := 0 to length(compArr) - 1 do
    compArr[i].men.Destroy;
  compArr := nil;

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
          ' AND t_weights.weight = ' + QuotedStr(weightBox.Text)+' AND participation = true'; //выбираем только тех, кто с отметкой об участии
    try
      DBQuery.Open;
      i:= DBQuery.RecordCount; //просто для проверки
      SetLength(compArr,DBQuery.RecordCount);//выставляем динамический массив
      i := 0;
      DBQuery.First;
      while not DBQuery.Eof do     //заполняем список
      begin
        compArr[i].club := DBQuery.FieldByName('club').AsString;
        compArr[i].count := 0;
        inc(i);
        DBQuery.Next;
      end;
      result := 0;
    except
      result := 1;
    end;
    DBQuery.Close;
  end;
end;

procedure TCompetitorTableForm.get_clubs_count_and_men;
var i,j: integer;
begin
  //инициализируем все списки
  for i := 0 to length(compArr) - 1 do
    compArr[i].men := TStringList.Create;

  CompetitorsQuery.First;
  while not CompetitorsQuery.Eof do
  begin
    for j := 0 to length(compArr) - 1 do
    begin
      if CompetitorsQuery.FieldByName('t_clubs.club').AsString = compArr[j].club then
      begin
        inc(compArr[j].count);
        compArr[j].men.Add(CompetitorsQuery.FieldByName('FIO').AsString + ' (' + compArr[j].club + ')'); //заполняем список записями типа "ФИО клуб"
      end
    end;
    CompetitorsQuery.Next;
  end
end;

procedure TCompetitorTableForm.qSort(var A: TCountCompetitorsArr; min, max: Integer);
var i, j, supp: Integer;
tmp : TClubsCountArr;
begin
  supp:=A[max-((max-min) div 2)].count;
  i:=min;
  j:=max;
  while i<j do
    begin
      while A[i].count > supp do
        i := i + 1;
      while A[j].count < supp do
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

procedure TCompetitorTableForm.separating_on_subgroups;
var i, j,k,l,m,n: integer;
  group:integer; //число людей в данной подгруппе
  compCount:integer; //число участников, оставшихся нераспределенными
  iterDelim:integer; //специальный делитель, зависимый от итерации
begin
  compCount := CompetitorsQuery.RecordCount; //изначально все нераспределены
  for n := 1 to groupsCount do  //цикл подгруп
  begin
    m := 0; //выставляем количество принятых людей
    iterDelim := groupsCount-(n-1);//вычисляем делитель
    //определяем число участников в группе
    group := compCount div iterDelim; //делим оставшееся число участников на число групп - (номер итерации - 1)
    if  (compCount mod iterDelim) <> 0 then
      group := group + 1;
    for i := 0 to length(compArr) - 1 do //идем по клубам
    begin
      l := compArr[i].men.Count div iterDelim; // вычисляем количество людей, требующихся от данного клуба
      if (compArr[i].men.Count mod iterDelim) <> 0 then //округляем до большего целого
        l := l + 1;
      for j := 0 to l - 1 do //выдергиваем из группы нужное число людей и записываем
      begin
        if m < group then //есщи группа еще не заполнена, то добавляем
        begin
          CompetitorsInGroups[n-1].Add(compArr[i].men.Strings[0]); //тут запись  в массив стринг-листов)
          m := m + 1;
          compArr[i].men.Delete(0); //всегда нулевой элемент, потому что он первый списке(мы его использовали и удалили!)
        end;
      end;
    end;
    compCount := compCount - group;
  end;
end;

procedure TCompetitorTableForm.create_table_in_excel;
var templ,w : Variant; //шаблон книги и рабочая книга
  c: array [1..8] of integer;// = (1,15,5,11,3,13,7,9); //массив адресов клеток
  i,j: integer;
  source,dest: OleVariant;
begin
  //массив адресов клеток
  {c[1]:=1;
  c[2]:=15;
  c[3]:=5;
  c[4]:=11;
  c[5]:=3;
  c[6]:=13;
  c[7]:=7;
  c[8]:=9;  }

  c[1]:=1;
  c[2]:=9;
  c[3]:=5;
  c[4]:=13;
  c[5]:=3;
  c[6]:=11;
  c[7]:=7;
  c[8]:=15;


  //шаблон
  templ := CreateOleObject('Excel.Application');//создаем OLE объект
  templ.Workbooks.Open(ExtractFileDir(Application.ExeName)+'\xls_template\template.xls',0,True);  //"D:\??????????\??????????? ??????????\xls_template\template.xls"

  w := CreateOleObject('Excel.Application');
  w.Workbooks.Add;
  dest := w.worksheets[1];
  //выставляем нужный размер ячеек
  dest.rows.rowheight := 31.5;
 // dest.columns.columnwidth := 22;

  dest.range['a1'].columnwidth := 43;
  dest.range['c1'].columnwidth := 25.3;
  dest.range['e1'].columnwidth := 25.3;
  dest.range['g1'].columnwidth := 25.3;

  dest.range['f1'].columnwidth := 6;
  dest.range['b1'].columnwidth := 6;
  dest.range['d1'].columnwidth := 6;
  //выставляем альбомную ориентацию
  dest.pageSetup.Orientation := 2;
  //масштаб
  dest.pageSetup.zoom := 92;

  try
    //строим шаблоны под нужное количество групп
    for i := 1 to groupsCount do
    begin
      templ.worksheets[1].range['a1','g15'].copy(EmptyParam);
      dest.Range['a'+ intToStr(1 + 15*(i-1)),'g' + intToStr(15 + 15*(i-1))].PasteSpecial(-4163,,,); //только так копируется
      Clipboard.Clear;
      dest.Range['d' + intToStr(1 + 15*(i-1))] := 'Пояс: ' + BeltBox.Text + ', возраст: '+ ageBox.Text + ', вес: ' + weightBox.Text;
      if groupsCount > 1 then
        dest.Range['g' + intToStr(2 + 15*(i-1))] := 'Подгруппа ' + IntToStr(i);
    end;

    //Вносим информацию в таблицу
    for i := 0 to groupsCount - 1 do
    begin
      for j := 0 to CompetitorsInGroups[i].Count - 1 do
      begin
        dest.Range['a'+ intToStr(c[j+1] + 15*(i))] := CompetitorsInGroups[i].Strings[j];
      end
    end;

    templ.displayAlerts := false;
    templ.quit;
    w.visible := true;
  except
    showMessage('Не удалось выгрузить данные в Excel.');
    w.quit;
    templ.quit;
  end;
end;

end.
