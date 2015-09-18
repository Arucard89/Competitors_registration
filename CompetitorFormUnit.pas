unit CompetitorFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,DataModuleUnit, AddValueUnit;

type
  TCompetitorForm = class(TForm)
    ParticipationMark: TCheckBox;
    FIOEdit: TLabeledEdit;
    CancelBtn: TBitBtn;
    OKBtn: TBitBtn;
    GroupBox1: TGroupBox;
    AgeBox: TComboBox;
    GroupBox2: TGroupBox;
    weightBox: TComboBox;
    GroupBox4: TGroupBox;
    beltBox: TComboBox;
    GroupBox3: TGroupBox;
    cityBox: TComboBox;
    GroupBox5: TGroupBox;
    clubBox: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure AgeBoxChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
   // AddValueForm: TAddValueForm; //универсальная форма добавления
    function load_list_to_weight_combo(age:string):integer; //закгрузка в комбобокс весов
    procedure add_new_value(formName,labelName,mask,tableName,colName, mes:string; var combo:TCombobox); //добавление нового значения в таблицы исходных данных(кроме веса, он отдельный)
    //formName-имя окна,labelName-имя метки,mask-маска ввода,tableName-имя таблицы изменения,colName - имя столбца изменений, mes - текст сообщения при ошибке обновления набора данных в комбо;  combo -имя комбобокса в который добавится изменение
  public
    { Public declarations }
    Function load_list_to_combo(tableName, colName: string; var Combo: TComboBox): integer; //заполняем комбобоксы/имя таблицы, имя столбца, имя комбобокса

    function build_weights_list(age: string; var list:TStringList):integer; //заполнение списка весов по возрасту/ 0-ок, 1-не удалось сделать запрос, 2-пустая таблица

  end;

{var
  CompetitorForm: TCompetitorForm;   }

implementation

uses ADODB;

{$R *.dfm}

{ TCompetitorForm }

function TCompetitorForm.build_weights_list(age: string;
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

procedure TCompetitorForm.AgeBoxChange(Sender: TObject);
var list: TStringList; //через него перекинем список
begin
  if AgeBox.Text = '' then  //если выбрана возрастная, то делаем доступным вес
    GroupBox2.Enabled := false
  else
    begin
      GroupBox2.Enabled := true;
      if load_list_to_weight_combo(AgeBox.Text) <> 0 then
        ShowMessage('Список весов для данной возрастной категории пуст.');
    end;
end;

function TCompetitorForm.load_list_to_combo(tableName, colName: string;
  var Combo: TComboBox): integer;
begin
  with DataModule1 do
  begin
    Combo.Clear;
    DBQuery.Close;
    DBQuery.SQL.Text :='SELECT * FROM ' + tablename;
    try
      DBQuery.Open;
      if not DBQuery.IsEmpty then
      begin
        DBQuery.First;
        While not DBQuery.Eof do  //непустой запрос, знаычит, заполняем стринглист
        begin
          COMBO.Items.Add(DBQuery.FieldByName(colName).AsString);
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
  end
end;

procedure TCompetitorForm.Button1Click(Sender: TObject);  //добавление возраста
begin

  add_new_value('Добавить возрастную категорию','Возрастная категория','','t_ages', 'age',
      'Не удалось обновить список весовых категорий. Возможны неполадки с базой.',ageBox);
  AgeBoxChange(nil); //инициируем изменение комбобокса


{  AddValueForm := TAddValueForm.Create(self);
  AddValueForm.set_values('Добавить возрастную категорию','Возрастная категория','###');
  if AddValueForm.ShowModal = mrOK then
  begin
    if DataModule1.add_value_query('t_ages', 'age', trim(AddValueForm.ValueEdit.Text)) <> 0 then
      ShowMessage('Не удалось добавить значение в базу. Попробуйте еще раз.')
    else
    begin
      //обновляем содержимое своего комбобокса и веса
      if (load_list_to_combo('t_ages','age',ageBox) <> 0) then
        showmessage('Не удалось обновить список возрастов. Возможны неполадки с базой.');
      //if (load_list_to_weight_combo(trim(AddValueForm.ValueEdit.Text)) <> 0) then
      //  showmessage('Не удалось обновить список весовых категорий. Возможны неполадки с базой.');
    end
  end;
  AddValueForm.Destroy;
  }
end;


function TCompetitorForm.load_list_to_weight_combo(age: string): integer;
var list:TstringList;
begin
  list := TStringList.Create;
  result := build_weights_list(age,list);
  weightBox.Clear;  //чистим от старья
  weightBox.Items.Text := list.Text;
  list.Destroy;
end;

procedure TCompetitorForm.Button2Click(Sender: TObject); //добавление веса
var str:string;
begin
  AddValueForm := TAddValueForm.Create(self);
  AddValueForm.set_values('Добавить весовую категорию','Весовая категория возраста ' + AgeBox.Text,'##c#');
  if AddValueForm.ShowModal = mrOK then
  begin
    str := trim(AddValueForm.ValueEdit.Text);
    //защита от повторного ввода
    if weightBox.Items.IndexOf(str) <> -1 then
    begin
      ShowMessage('Введенное значение уже присутствеут в списке');
      //ставим его в текст комбо
      weightBox.ItemIndex := weightBox.Items.IndexOf(str);
    end
    else
      if DataModule1.add_weight_query(str,AgeBox.Text) <> 0 then
        ShowMessage('Не удалось добавить значение в базу. Попробуйте еще раз.')
      else
      begin
        //обновляем содержимое своего комбобокса веса
        if (load_list_to_weight_combo(AgeBox.Text) <> 0) then
          showmessage('Не удалось обновить список весовых категорий. Возможны неполадки с базой.')
        else //если ошибок нет, то выставляем введенное значение выбранным
          weightBox.ItemIndex := weightBox.Items.IndexOf(str);
      end
  end;
  AddValueForm.Destroy;
end;

procedure TCompetitorForm.Button3Click(Sender: TObject);       //добавление категории пояса
begin
  add_new_value('Добавить пояс','Цвет пояса','','t_belts', 'belt',
      'Не удалось обновить список поясов. Возможны неполадки с базой.',beltBox);
end;

procedure TCompetitorForm.Button4Click(Sender: TObject);      //добавление нового города
begin
  add_new_value('Добавить город','Название города','','t_cities', 'city',
      'Не удалось обновить список городов. Возможны неполадки с базой.',cityBox);
end;

procedure TCompetitorForm.Button5Click(Sender: TObject);
begin
  add_new_value('Добавить клуб/тренера','Клуб/тренер','','t_clubs', 'club',
      'Не удалось обновить список клубов. Возможны неполадки с базой.',clubBox);

end;

procedure TCompetitorForm.FormCreate(Sender: TObject);
begin
  //ставим форму по центру экрана
  self.Left := (screen.Width - self.Width) div 2;
  self.Top :=  (screen.Height - self.Height) div 2;
//Грузим все комбобоксы
  load_list_to_combo('t_ages','age',ageBox);
  load_list_to_combo('t_belts','belt',beltBox);
  load_list_to_combo('t_cities', 'city', cityBox);
  load_list_to_combo('t_clubs', 'club',clubBox);
end;

procedure TCompetitorForm.OKBtnClick(Sender: TObject);
begin
  if Trim(FIOEdit.Text) = '' then
  begin
    ShowMessage('Не заполнены ФИО участника');
    Exit;
  end;
  if ageBox.Text = '' then
  begin
    ShowMessage('Не выбрана возрастная категория');
    Exit;
  end;
  if weightBox.Text = '' then
  begin
    ShowMessage('Не выбрана весовая категория');
    Exit;
  end;
  if BeltBox.Text = '' then
  begin
    ShowMessage('Не выбран пояс');
   Exit;
  end;
  if cityBox.Text = '' then
  begin
    ShowMessage('Не выбран город');
   Exit;
  end;
  if clubBox.Text = '' then
  begin
    ShowMessage('Не выбран клуб');
   Exit;
  end;
  //если дошли до сюда, то все отлично
  self.ModalResult := mrOk;
end;

procedure TCompetitorForm.add_new_value(formName, labelName, mask,
  tableName, colName, mes: string; var combo: TCombobox);
var str: string; //введенное значение
begin
  AddValueForm := TAddValueForm.Create(self);

  //устанавливаем начальные значения
  AddValueForm.set_values(formName,labelName,mask);

  if AddValueForm.ShowModal = mrOK then //пользователь подтвердил ввод
  begin
    str := trim(AddValueForm.ValueEdit.Text);
    //защита от повторного ввода
    if combo.Items.IndexOf(str) <> -1 then
    begin
      ShowMessage('Введенное значение уже присутствеут в списке');
      combo.ItemIndex := combo.Items.IndexOf(str);
    end
    else
      if DataModule1.add_value_query(tableName, colName, str) <> 0 then
        ShowMessage('Не удалось добавить значение в базу. Попробуйте еще раз.')
      else
      begin
        //обновляем содержимое своего комбобокса
        if (load_list_to_combo(tableName, colName, combo) <> 0) then   // если возникла ошибка обновления
          showmessage(mes)
        else //если ошибок нет, то выставляем введенное значение выбранным
          combo.ItemIndex := combo.Items.IndexOf(str);
      end
  end;

  AddValueForm.Destroy;
end;

procedure TCompetitorForm.FormShow(Sender: TObject);
begin
  FIOEdit.SetFocus;
  FIOEdit.SelectAll;
end;

end.
