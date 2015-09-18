unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DataModuleUnit,
  StdCtrls, ExtCtrls, CompetitorFormUnit, ChangeDefaultsUnit,CompetitorTableUnit,
  Menus, cxExportGrid4Link;

type
  TMainForm = class(TForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    Panel1: TPanel;
    cxGrid1DBTableView1DBColumn1: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn2: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn3: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn4: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn5: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn6: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn7: TcxGridDBColumn;
    AddBtn: TButton;
    EditBtn: TButton;
    DeleteBtn: TButton;
    TemplateBtn: TButton;
    cxGrid1DBTableView1DBColumn8: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn9: TcxGridDBColumn;
    ChangeDefaultsBtn: TButton;
    CompetitorTableBtn: TButton;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    SearchEdit: TEdit;
    Button1: TButton;
    SearchLabel: TLabel;
    PopupMenu1: TPopupMenu;
    Export2Excel: TMenuItem;
    procedure FormResize(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
    procedure TemplateBtnClick(Sender: TObject);
   // procedure RadioButton1Click(Sender: TObject);
  //  procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxGrid1DBTableView1DBColumn9GetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: String);
    procedure DeleteBtnClick(Sender: TObject);
    procedure ChangeDefaultsBtnClick(Sender: TObject);
    procedure CompetitorTableBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SearchEditChange(Sender: TObject);
    procedure Export2ExcelClick(Sender: TObject);
  //  procedure RadioButton2Click(Sender: TObject);
  private
    { Private declarations }
    CompetitorForm: TCompetitorForm; //форма заполнения информации об цчастнике
    function add_record:integer; //добавление заполненной информации об учатснике в базу
    function edit_record:integer; //изменение готовой записи
    procedure prepare_form; //заполнение анкеты участника информацией
    function load_values_to_query: integer; //считывает данные с формы и записывает их в запрос. возвращает ошибуи(0-хорошо, не 0  - плохо)
  //  procedure radio_changed; //изменение состояния радиобатонов
  public
    { Public declarations }
    procedure refresh_data; //обновление данных в таблице
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormResize(Sender: TObject);
var h,b:integer;
begin
  //подстраиваем ячейки таблицы под измененный размер
  cxGrid1DBTableView1.OptionsView.ColumnAutoWidth := true;
  cxGrid1DBTableView1.OptionsView.CellAutoHeight := true;

  //изменяем высоту кнопок в зависимости от высоты окна
  b := 8; //промежуток между кнопками
  h := (panel1.Height - b*(6+1)) div 6;//6 кнопок

  AddBtn.Height := h;

  EditBtn.Height := h;
  EditBtn.Top := AddBtn.Top + h + b;

  TemplateBtn.Height := h;
  TemplateBtn.Top := EditBtn.Top + h + b;

  DeleteBtn.Height := h;
  DeleteBtn.Top := TemplateBtn.Top + h + b;

  ChangeDefaultsBtn.Height := h;
  ChangeDefaultsBtn.Top := DeleteBtn.Top + h + b;

  CompetitorTableBtn.Height := h;
  CompetitorTableBtn.Top := ChangeDefaultsBtn.Top + h + b;

  Button1.Width := Panel3.Width - (600+8);



end;

procedure TMainForm.refresh_data;
begin
  DataModule1.MainQuery.Close;
  DataModule1.MainQuery.Open;
end;

procedure TMainForm.AddBtnClick(Sender: TObject);
begin
  CompetitorForm := TCompetitorForm.Create(self);

  while CompetitorForm.ShowModal = mrOk do  //Вводим участников в цикле,чтоб быстрее заполнять таблицу
  begin
    if add_record <> 0 then
      ShowMessage('При попытке внесения данных в базу возникли ошибки.');
    refresh_data;
  end;

  CompetitorForm.Destroy;
end;

function TMainForm.add_record: integer;
var r:integer;
begin
  with DataModule1 do
  begin
    MainQuery.Insert;
    r := load_values_to_query;
    MainQuery.Post;
  end;
  result := r;
end;

procedure TMainForm.EditBtnClick(Sender: TObject); //изменение текущей записи
var num : integer; //номер текущей записи
begin
  CompetitorForm := TCompetitorForm.Create(self);
  prepare_form; //заполняем исходными данными
  if CompetitorForm.ShowModal = mrOk then
    if edit_record <> 0 then
      ShowMessage('Возникла ошибка при изменении записи');
  CompetitorForm.Destroy;
  //cxGrid1DBTableView1.datacontroller.Refresh;
  num := DataModule1.MainDataSource.DataSet.RecNo;
  //обновляем окно
  refresh_data;
  DataModule1.MainDataSource.DataSet.RecNo := num; 
end;

function TMainForm.edit_record: integer;
var r:integer;
begin
  with DataModule1 do
  begin
    MainQuery.Edit;
    r := load_values_to_query;
    MainQuery.Post;
  end;
  result := r;
end;

procedure TMainForm.prepare_form;
var str:string;
begin
  //заполняем форму данными для редактирования
  with DataModule1 do
  begin
    CompetitorForm.FIOEdit.Text := MainQuery.fieldByName('FIO').AsString;
    //аозраст
    str := MainQuery.fieldByName('t_ages.age').AsString;
    CompetitorForm.AgeBox.ItemIndex  := CompetitorForm.AgeBox.Items.IndexOf(str);

    //список веса подгружаем отдельно
    //инициируем сигнал изменения листа возраста, чтобы подгрузить список весов
    CompetitorForm.AgeBoxChange(nil);
    str := MainQuery.fieldByName('t_weights.weight').AsString;
    CompetitorForm.weightBox.ItemIndex := CompetitorForm.weightBox.Items.IndexOf(str);
    //Пояс
    str := MainQuery.fieldByName('t_belts.belt').AsString;
    CompetitorForm.BeltBox.ItemIndex := CompetitorForm.BeltBox.Items.IndexOf(str);

    //город
    str := MainQuery.fieldByName('t_cities.city').AsString;
    CompetitorForm.CityBox.ItemIndex := CompetitorForm.CityBox.Items.IndexOf(str);

    //клуб
    str := MainQuery.fieldByName('t_clubs.club').AsString;
    CompetitorForm.ClubBox.ItemIndex := CompetitorForm.ClubBox.Items.IndexOf(str);

    //отметка учатия
    CompetitorForm.ParticipationMark.Checked := MainQuery.fieldByName('participation').asBoolean;
  end
end;

procedure TMainForm.TemplateBtnClick(Sender: TObject);  //использовать текущую запись, как шаблон.
begin
//делаем все, как в эдит, только вместо исправления добавляем новое
CompetitorForm := TCompetitorForm.Create(self);
  prepare_form; //заполняем исходными данными
  while CompetitorForm.ShowModal = mrOk do
  begin
    if add_record <> 0 then
      ShowMessage('При попытке внесения данных в базу возникли ошибки.');
    //обновляем окно
    refresh_data;
  end;
  CompetitorForm.Destroy;
end;

function TMainForm.load_values_to_query: integer;
var r:integer;
  v: variant;
begin
  with DataModule1 do
  begin
    MainQuery.FieldByName('FIO').AsString := CompetitorForm.FIOEdit.Text;

    r := find_value_querry('t_ages','age','id',CompetitorForm.AgeBox.Text, v);
    MainQuery.FieldByName('t_main.age').AsVariant := v;

    r := r + find_value_querry('t_weights','weight','id',CompetitorForm.weightBox.Text, v);
    MainQuery.FieldByName('t_main.weight').AsVariant := v;

    r := r + find_value_querry('t_belts','belt','id',CompetitorForm.beltBox.Text, v);
    MainQuery.FieldByName('t_main.belt').AsVariant := v;

    r := r + find_value_querry('t_cities','city','id',CompetitorForm.cityBox.Text, v);
    MainQuery.FieldByName('t_main.city').AsVariant := v;

    r := r + find_value_querry('t_clubs','club','id',CompetitorForm.clubBox.Text, v);
    MainQuery.FieldByName('t_main.club').AsVariant := v;

    MainQuery.FieldByName('participation').AsBoolean := CompetitorForm.ParticipationMark.Checked;
  end;

  result := r;
end;

{procedure TMainForm.RadioButton1Click(Sender: TObject);
begin
  radio_changed;
end; }

{procedure TMainForm.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then       //вкл/выкл сортировку по времени
  begin
    cxGrid1DBTableView1DBColumn8.Options.Sorting := true;
    RadioButton1.Enabled := true;
    RadioButton2.Enabled := true;
  end
  else
  begin
    RadioButton1.Enabled := false;
    RadioButton2.Enabled := false;
    cxGrid1DBTableView1DBColumn8.Options.Sorting := false;
  end
end;     }

{procedure TMainForm.radio_changed;
begin
  if RadioButton1.Checked then
    cxGrid1DBTableView1DBColumn8.SortOrder := TcxDataSortOrder(soAscending);
  if RadioButton2.Checked then
    cxGrid1DBTableView1DBColumn8.SortOrder := TcxDataSortOrder(soDescending);
end;  }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  //ставим форму по центру экрана
  self.Left := (screen.Width - self.Width) div 2;
  self.Top :=  (screen.Height - self.Height) div 2;
end;

{procedure TMainForm.RadioButton2Click(Sender: TObject);
begin
  radio_changed;
end;   }

procedure TMainForm.cxGrid1DBTableView1DBColumn9GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  AText := IntToStr(Sender.GridView.DataController.GetRowIndexByRecordIndex(ARecord.RecordIndex, false)+1);
end;

procedure TMainForm.DeleteBtnClick(Sender: TObject);
begin
  if DataModule1.MainQuery.IsEmpty then
  begin
    ShowMessage('Список пуст, удаление невозможно.');
    Exit;
  end;

  if MessageDlg('Данное действие приведет к безвозвратному удалению записи из БД. Вы уверены, что хотите удалить ее?',
      mtWarning,mbOKCancel,0) = mrOk then
  begin
    with DataModule1 do
    begin
      //делаем запрос на получение записи из бд, ятобы кудалить
      DBQuery.Close;
      DBQuery.SQL.Text := 'SELECT * FROM t_main WHERE id = ' + MainQuery.fieldByName('t_main.id').AsString;
      try
        DBQuery.Open;
        DBQuery.Delete;
      except
        ShowMessage('Не удалось выполнить удаление выбранной записи. Попробуйте еще раз.');
      end;
      DBQuery.Close;
    end
  end;
  //cxGrid1DBTableView1.datacontroller.Refresh;   //не работает на удаление
  refresh_data;

end;

procedure TMainForm.ChangeDefaultsBtnClick(Sender: TObject);
begin
  ChangeDefaultsForm := TChangeDefaultsForm.Create(self);
  ChangeDefaultsForm.ShowModal;
  ChangeDefaultsForm.Destroy;
  refresh_data;
end;

procedure TMainForm.CompetitorTableBtnClick(Sender: TObject);//строим турнирную таблицу
begin
  CompetitorTableForm := TCompetitorTableForm.Create(self);
  CompetitorTableForm.ShowModal;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  DataModule1.MainQuery.Edit;
  DataModule1.MainQuery.FieldByName('participation').AsBoolean := not DataModule1.MainQuery.FieldByName('participation').AsBoolean;
  DataModule1.MainQuery.Post;
  cxGrid1DBTableView1.datacontroller.Refresh;
end;

//procedure TMainForm.SearchBtnClick(Sender: TObject);
//begin

 // cxGrid1DBTableView1.OptionsBehavior.IncSearch := true;
//  cxGrid1DBTableView1.OptionsBehavior.IncSearch.
//    cxGrid1DBTableView1.DataController.Search.


//end;

procedure TMainForm.SearchEditChange(Sender: TObject);
begin
  if Trim(SearchEdit.Text) <> '' then  //если поле поиска непустое
    if DataModule1.MainQuery.Locate('FIO',SearchEdit.Text,[loCaseInsensitive,loPartialKey]) = true then
    begin
      SearchLabel.Caption := 'Запись найдена';
      SearchLabel.Font.Color := clGreen;
    end
    else
    begin
      SearchLabel.Caption := 'Запись отсутствует';
      SearchLabel.Font.Color := clRed;
    end
  else        //если поле пустое
    SearchLabel.Caption := '';
end;

procedure TMainForm.Export2ExcelClick(Sender: TObject);
begin

  with TSaveDialog.Create(self) do
  try
    DefaultExt := 'xls';
    Filter := 'Excel files|*.xls';
    if Execute then
      if FileExists(FileName) = true then
      begin
        if MessageDlg('Файл с данным именем уже существует. Перезаписать?', mtWarning,mbOKCancel, 0) = mrOk then
          ExportGrid4ToExcel(FileName, cxGrid1, True, True, false);
      end
      else
        ExportGrid4ToExcel(FileName, cxGrid1, True, True, false);
  finally
    Free;
  end;

end;

end.
