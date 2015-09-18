unit ChangeDefaultsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, Buttons, StdCtrls, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ADODB, DataModuleUnit, AddValueUnit, addWeightUnit;

type
  TChangeDefaultsForm = class(TForm)
    GroupBox1: TGroupBox;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    ageAddBtn: TButton;
    ageEditBtn: TButton;
    ageDeleteBtn: TButton;
    GroupBox2: TGroupBox;
    cxGrid2: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    beltAddBtn: TButton;
    beltEditBtn: TButton;
    beltDeleteBtn: TButton;
    GroupBox3: TGroupBox;
    cxGrid3: TcxGrid;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    CityAddBtn: TButton;
    CityEditBtn: TButton;
    CityDeleteBtn: TButton;
    GroupBox4: TGroupBox;
    cxGrid4: TcxGrid;
    cxGridDBTableView3: TcxGridDBTableView;
    cxGridLevel3: TcxGridLevel;
    ClubAddBtn: TButton;
    ClubEditBtn: TButton;
    ClubDeleteBtn: TButton;
    GroupBox5: TGroupBox;
    cxGrid5: TcxGrid;
    cxGridDBTableView4: TcxGridDBTableView;
    cxGridLevel4: TcxGridLevel;
    weightAddBtn: TButton;
    weightEditBtn: TButton;
    weightDeleteBtn: TButton;
    CloseBtn: TBitBtn;
    ageQuery: TADOQuery;
    beltQuery: TADOQuery;
    cityQuery: TADOQuery;
    clubQuery: TADOQuery;
    weightQuery: TADOQuery;
    ageSource: TDataSource;
    beltSource: TDataSource;
    citySource: TDataSource;
    clubSource: TDataSource;
    weightSource: TDataSource;
    cxGrid1DBTableView1DBColumn1: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn2: TcxGridDBColumn;
    cxGridDBTableView1DBColumn1: TcxGridDBColumn;
    cxGridDBTableView1DBColumn2: TcxGridDBColumn;
    cxGridDBTableView2DBColumn1: TcxGridDBColumn;
    cxGridDBTableView2DBColumn2: TcxGridDBColumn;
    cxGridDBTableView3DBColumn1: TcxGridDBColumn;
    cxGridDBTableView3DBColumn2: TcxGridDBColumn;
    cxGridDBTableView4DBColumn1: TcxGridDBColumn;
    cxGridDBTableView4DBColumn2: TcxGridDBColumn;
    cxGridDBTableView4DBColumn3: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn3: TcxGridDBColumn;
    cxGridDBTableView1DBColumn3: TcxGridDBColumn;
    cxGridDBTableView2DBColumn3: TcxGridDBColumn;
    cxGridDBTableView3DBColumn3: TcxGridDBColumn;
    cxGridDBTableView4DBColumn4: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure ageAddBtnClick(Sender: TObject);
    procedure beltAddBtnClick(Sender: TObject);
    procedure CityAddBtnClick(Sender: TObject);
    procedure ClubAddBtnClick(Sender: TObject);
    procedure ageEditBtnClick(Sender: TObject);
    procedure beltEditBtnClick(Sender: TObject);
    procedure CityEditBtnClick(Sender: TObject);
    procedure ClubEditBtnClick(Sender: TObject);
    procedure ageDeleteBtnClick(Sender: TObject);
    procedure beltDeleteBtnClick(Sender: TObject);
    procedure CityDeleteBtnClick(Sender: TObject);
    procedure ClubDeleteBtnClick(Sender: TObject);
    procedure cxGrid1DBTableView1DBColumn3GetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: String);
    procedure cxGridDBTableView1DBColumn3GetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: String);
    procedure cxGridDBTableView2DBColumn3GetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: String);
    procedure cxGridDBTableView3DBColumn3GetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: String);
    procedure cxGridDBTableView4DBColumn4GetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: String);
    procedure weightAddBtnClick(Sender: TObject);
    procedure weightEditBtnClick(Sender: TObject);
    procedure weightDeleteBtnClick(Sender: TObject);
  private
    { Private declarations }
    //addWeightForm: TaddWeightForm;
    //AddValueForm: TAddValueForm;
    procedure add_new_value(formName,labelName,mask,colName:string;var query:TADOQuery); //добавление нового значения в таблицы исходных данных(кроме веса, он отдельный)
    //formName-имя окна,labelName-имя метки,mask-маска ввода,colName - имя столбца изменений;  query -имя запроса, с которым связана таблица
    procedure edit_value(formName,labelName,mask,colName:string;var query:TADOQuery);
  public
    { Public declarations }
  end;

var
  ChangeDefaultsForm: TChangeDefaultsForm;


implementation

{$R *.dfm}

procedure TChangeDefaultsForm.add_new_value(formName, labelName, mask,
  colName: string; var query:TAdoQuery);
var str: string; //введенное значение
begin
  AddValueForm := TAddValueForm.Create(self);

  //устанавливаем начальные значения
  AddValueForm.set_values(formName,labelName,mask);

  if AddValueForm.ShowModal = mrOK then //пользователь подтвердил ввод
  begin
    str := trim(AddValueForm.ValueEdit.Text);
    //Добавляем значение
    query.Insert;
    query.FieldByName(colName).AsString := str;
    query.Post;
    //обновляем содержимое таблицы
    Query.close;
    query.open;
  end;

  AddValueForm.Destroy;
end;

procedure TChangeDefaultsForm.FormCreate(Sender: TObject);
begin
  //включаем все запросы
  ageQuery.Open;
  beltQuery.Open;
  cityQuery.Open;
  clubQuery.Open;
  weightQuery.Open;
  //выравнивание столбцов
  //подстраиваем ячейки таблицы под измененный размер
  cxGrid1DBTableView1.OptionsView.ColumnAutoWidth := true;
  cxGrid1DBTableView1.OptionsView.CellAutoHeight := true;

  cxGridDBTableView1.OptionsView.ColumnAutoWidth := true;
  cxGridDBTableView1.OptionsView.CellAutoHeight := true;

  cxGridDBTableView2.OptionsView.ColumnAutoWidth := true;
  cxGridDBTableView2.OptionsView.CellAutoHeight := true;

  cxGridDBTableView3.OptionsView.ColumnAutoWidth := true;
  cxGridDBTableView3.OptionsView.CellAutoHeight := true;

  cxGridDBTableView4.OptionsView.ColumnAutoWidth := true;
  cxGridDBTableView4.OptionsView.CellAutoHeight := true;
end;

procedure TChangeDefaultsForm.ageAddBtnClick(Sender: TObject);
begin
  add_new_value('Добавить возрастную категорию','Возрастная категория','###','age',ageQuery);
end;

procedure TChangeDefaultsForm.beltAddBtnClick(Sender: TObject);
begin
  add_new_value('Добавить пояс','Цвет пояса','','belt',beltQuery);
end;

procedure TChangeDefaultsForm.CityAddBtnClick(Sender: TObject);
begin
  add_new_value('Добавить город','Название города','','city',cityQuery);
end;

procedure TChangeDefaultsForm.ClubAddBtnClick(Sender: TObject);
begin
  add_new_value('Добавить клуб/тренера','Клуб/тренер','','club',clubQuery);
end;


procedure TChangeDefaultsForm.edit_value(formName, labelName, mask,
  colName: string; var query: TADOQuery);
  var str: string; //введенное значение
begin
  AddValueForm := TAddValueForm.Create(self);

  //устанавливаем начальные значения
  AddValueForm.set_values(formName,labelName,mask);
  AddValueForm.ValueEdit.Text := query.fieldByName(colName).AsString;

  if AddValueForm.ShowModal = mrOK then //пользователь подтвердил ввод
  begin
    str := trim(AddValueForm.ValueEdit.Text);
    query.Edit;
    query.FieldByName(colName).AsString := str;
    query.Post;
    //обновляем содержимое таблицы
    Query.close;
    query.open;
  end;

  AddValueForm.Destroy;
end;

procedure TChangeDefaultsForm.ageEditBtnClick(Sender: TObject);
begin
  edit_value('Изменить возрастную категорию','Возрастная категория','###','age',ageQuery);
end;

procedure TChangeDefaultsForm.beltEditBtnClick(Sender: TObject);
begin
  edit_value('Изменить пояс','Цвет пояса','','belt',beltQuery);
end;

procedure TChangeDefaultsForm.CityEditBtnClick(Sender: TObject);
begin
  edit_value('Изменить город','Название города','','city',cityQuery);
end;

procedure TChangeDefaultsForm.ClubEditBtnClick(Sender: TObject);
begin
  edit_value('Добавить клуб/тренера','Клуб/тренер','','club',clubQuery);
end;

procedure TChangeDefaultsForm.ageDeleteBtnClick(Sender: TObject);
begin
  //защита от дурака
  ageQuery.Close;
  ageQuery.Open;
  if ageQuery.RecordCount <= 0 then
  begin
    ShowMessage('Список возрастов пуст. Удаление невозможно.');
    Exit;
  end;
  if MessageDlg('Данное действие приведет к безвозвратному удалению записи из БД. Вы уверены, что хотите удалить ее?',
      mtWarning,mbOKCancel,0) = mrOk then
  ageQuery.Delete;
  //обновляем таблицу
  ageQuery.close;
  ageQuery.open;
end;

procedure TChangeDefaultsForm.beltDeleteBtnClick(Sender: TObject);
begin
  //защита от дурака
  beltQuery.Close;
  beltQuery.Open;
  if beltQuery.RecordCount <= 0 then
  begin
    ShowMessage('Список возрастов пуст. Удаление невозможно.');
    Exit;
  end;
  if MessageDlg('Данное действие приведет к безвозвратному удалению записи из БД. Вы уверены, что хотите удалить ее?',
      mtWarning,mbOKCancel,0) = mrOk then
  beltQuery.Delete;
    //обновляем таблицу
  beltQuery.close;
  beltQuery.open;
end;

procedure TChangeDefaultsForm.CityDeleteBtnClick(Sender: TObject);
begin
    //защита от дурака
  cityQuery.Close;
  cityQuery.Open;
  if cityQuery.RecordCount <= 0 then
  begin
    ShowMessage('Список возрастов пуст. Удаление невозможно.');
    Exit;
  end;
  if MessageDlg('Данное действие приведет к безвозвратному удалению записи из БД. Вы уверены, что хотите удалить ее?',
      mtWarning,mbOKCancel,0) = mrOk then
  cityQuery.Delete;
    //обновляем таблицу
  cityQuery.close;
  cityQuery.open;
end;

procedure TChangeDefaultsForm.ClubDeleteBtnClick(Sender: TObject);
begin
    //защита от дурака
  clubQuery.Close;
  clubQuery.Open;
  if clubQuery.RecordCount <= 0 then
  begin
    ShowMessage('Список возрастов пуст. Удаление невозможно.');
    Exit;
  end;
  if MessageDlg('Данное действие приведет к безвозвратному удалению записи из БД. Вы уверены, что хотите удалить ее?',
      mtWarning,mbOKCancel,0) = mrOk then                     
  clubQuery.Delete;
    //обновляем таблицу
  clubQuery.close;
  clubQuery.open;
end;

//*********** столбики № п/п*********************
procedure TChangeDefaultsForm.cxGrid1DBTableView1DBColumn3GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  AText := IntToStr(Sender.GridView.DataController.GetRowIndexByRecordIndex(ARecord.RecordIndex, false)+1);
end;

procedure TChangeDefaultsForm.cxGridDBTableView1DBColumn3GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  AText := IntToStr(Sender.GridView.DataController.GetRowIndexByRecordIndex(ARecord.RecordIndex, false)+1);
end;

procedure TChangeDefaultsForm.cxGridDBTableView2DBColumn3GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  AText := IntToStr(Sender.GridView.DataController.GetRowIndexByRecordIndex(ARecord.RecordIndex, false)+1);
end;

procedure TChangeDefaultsForm.cxGridDBTableView3DBColumn3GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  AText := IntToStr(Sender.GridView.DataController.GetRowIndexByRecordIndex(ARecord.RecordIndex, false)+1);
end;

procedure TChangeDefaultsForm.cxGridDBTableView4DBColumn4GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  AText := IntToStr(Sender.GridView.DataController.GetRowIndexByRecordIndex(ARecord.RecordIndex, false)+1);
end;
//***********************************************


procedure TChangeDefaultsForm.weightAddBtnClick(Sender: TObject);
var str:string;
begin
  addWeightForm := TaddWeightForm.Create(self);

  //грузим список возрастов
  if DataModule1.fulfill_list('t_ages', 'age', DataModule1.ages_list) <> 0 then
    ShowMessage('Таблица возрастов пуста либо отсутствует');
  addWeightForm.ageBox.Items.Text := DataModule1.ages_list.Text;

  //добавляем вес
  if addWeightForm.ShowModal = mrOK then
  begin
    str := trim(addWeightForm.weightEdit.Text);
    if DataModule1.add_weight_query(str,addWeightForm.AgeBox.Text) <> 0 then
        ShowMessage('Не удалось добавить значение в базу. Попробуйте еще раз.');
    weightQuery.Close;
    weightQuery.Open;
  end;

  addWeightForm.Destroy;
end;

procedure TChangeDefaultsForm.weightEditBtnClick(Sender: TObject);
var id:variant;
  r:integer;
  str:string;
begin
  addWeightForm := TaddWeightForm.Create(self);

  //грузим список возрастов
  if DataModule1.fulfill_list('t_ages', 'age', DataModule1.ages_list) <> 0 then
    ShowMessage('Таблица возрастов пуста либо отсутствует');
  addWeightForm.ageBox.Items.Text := DataModule1.ages_list.Text;
  //ставим вес и возраст
  addWeightForm.weightEdit.Text := weightQuery.FieldByName('weight').AsString;
  addWeightForm.ageBox.ItemIndex := addWeightForm.ageBox.Items.IndexOf(weightQuery.FieldByName('t_ages.age').AsString);

  //добавляем вес
  if addWeightForm.ShowModal = mrOK then
  begin
    str := trim(addWeightForm.weightEdit.Text);

    r := datamodule1.find_value_querry('t_ages','age','id',addWeightForm.ageBox.Text, id);
    if r <> 0 then  ShowMessage('Не получили id веса.Изменения не внесены')
    else
    begin
      weightQuery.Edit;
      weightQuery.FieldByName('weight').AsString := str;
      weightQuery.FieldByName('t_weights.age').AsVariant := id;
      weightQuery.Post;
    end;
    weightQuery.Close;
    weightQuery.Open;
  end;

  addWeightForm.Destroy;
end;

procedure TChangeDefaultsForm.weightDeleteBtnClick(Sender: TObject);
begin
  //хащита от дурака
  weightQuery.Close;
  weightQuery.Open;
  if weightQuery.RecordCount <= 0 then
  begin
    ShowMessage('Список весовых пуст. Удаление невозможно.');
    Exit;
  end;
  if MessageDlg('Данное действие приведет к безвозвратному удалению записи из БД. Вы уверены, что хотите удалить ее?',
      mtWarning,mbOKCancel,0) = mrOk then
    with DataModule1 do
    begin
      DBQuery.Close;
      DBQuery.SQL.Text := 'SELECT * FROM t_weights where id = ' + weightQuery.FieldByName('t_weights.id').AsString;
      DBQuery.Open;
      DBQuery.Delete;
      //обновляем
      weightQuery.Close;
      weightQuery.Open;
    end;

end;

end.



