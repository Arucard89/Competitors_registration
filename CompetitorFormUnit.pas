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
   // AddValueForm: TAddValueForm; //������������� ����� ����������
    function load_list_to_weight_combo(age:string):integer; //��������� � ��������� �����
    procedure add_new_value(formName,labelName,mask,tableName,colName, mes:string; var combo:TCombobox); //���������� ������ �������� � ������� �������� ������(����� ����, �� ���������)
    //formName-��� ����,labelName-��� �����,mask-����� �����,tableName-��� ������� ���������,colName - ��� ������� ���������, mes - ����� ��������� ��� ������ ���������� ������ ������ � �����;  combo -��� ���������� � ������� ��������� ���������
  public
    { Public declarations }
    Function load_list_to_combo(tableName, colName: string; var Combo: TComboBox): integer; //��������� ����������/��� �������, ��� �������, ��� ����������

    function build_weights_list(age: string; var list:TStringList):integer; //���������� ������ ����� �� ��������/ 0-��, 1-�� ������� ������� ������, 2-������ �������

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
  //������ ������������ ������� � �������� ������ ����
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
var list: TStringList; //����� ���� ��������� ������
begin
  if AgeBox.Text = '' then  //���� ������� ����������, �� ������ ��������� ���
    GroupBox2.Enabled := false
  else
    begin
      GroupBox2.Enabled := true;
      if load_list_to_weight_combo(AgeBox.Text) <> 0 then
        ShowMessage('������ ����� ��� ������ ���������� ��������� ����.');
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
        While not DBQuery.Eof do  //�������� ������, �������, ��������� ����������
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

procedure TCompetitorForm.Button1Click(Sender: TObject);  //���������� ��������
begin

  add_new_value('�������� ���������� ���������','���������� ���������','','t_ages', 'age',
      '�� ������� �������� ������ ������� ���������. �������� ��������� � �����.',ageBox);
  AgeBoxChange(nil); //���������� ��������� ����������


{  AddValueForm := TAddValueForm.Create(self);
  AddValueForm.set_values('�������� ���������� ���������','���������� ���������','###');
  if AddValueForm.ShowModal = mrOK then
  begin
    if DataModule1.add_value_query('t_ages', 'age', trim(AddValueForm.ValueEdit.Text)) <> 0 then
      ShowMessage('�� ������� �������� �������� � ����. ���������� ��� ���.')
    else
    begin
      //��������� ���������� ������ ���������� � ����
      if (load_list_to_combo('t_ages','age',ageBox) <> 0) then
        showmessage('�� ������� �������� ������ ���������. �������� ��������� � �����.');
      //if (load_list_to_weight_combo(trim(AddValueForm.ValueEdit.Text)) <> 0) then
      //  showmessage('�� ������� �������� ������ ������� ���������. �������� ��������� � �����.');
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
  weightBox.Clear;  //������ �� ������
  weightBox.Items.Text := list.Text;
  list.Destroy;
end;

procedure TCompetitorForm.Button2Click(Sender: TObject); //���������� ����
var str:string;
begin
  AddValueForm := TAddValueForm.Create(self);
  AddValueForm.set_values('�������� ������� ���������','������� ��������� �������� ' + AgeBox.Text,'##c#');
  if AddValueForm.ShowModal = mrOK then
  begin
    str := trim(AddValueForm.ValueEdit.Text);
    //������ �� ���������� �����
    if weightBox.Items.IndexOf(str) <> -1 then
    begin
      ShowMessage('��������� �������� ��� ������������ � ������');
      //������ ��� � ����� �����
      weightBox.ItemIndex := weightBox.Items.IndexOf(str);
    end
    else
      if DataModule1.add_weight_query(str,AgeBox.Text) <> 0 then
        ShowMessage('�� ������� �������� �������� � ����. ���������� ��� ���.')
      else
      begin
        //��������� ���������� ������ ���������� ����
        if (load_list_to_weight_combo(AgeBox.Text) <> 0) then
          showmessage('�� ������� �������� ������ ������� ���������. �������� ��������� � �����.')
        else //���� ������ ���, �� ���������� ��������� �������� ���������
          weightBox.ItemIndex := weightBox.Items.IndexOf(str);
      end
  end;
  AddValueForm.Destroy;
end;

procedure TCompetitorForm.Button3Click(Sender: TObject);       //���������� ��������� �����
begin
  add_new_value('�������� ����','���� �����','','t_belts', 'belt',
      '�� ������� �������� ������ ������. �������� ��������� � �����.',beltBox);
end;

procedure TCompetitorForm.Button4Click(Sender: TObject);      //���������� ������ ������
begin
  add_new_value('�������� �����','�������� ������','','t_cities', 'city',
      '�� ������� �������� ������ �������. �������� ��������� � �����.',cityBox);
end;

procedure TCompetitorForm.Button5Click(Sender: TObject);
begin
  add_new_value('�������� ����/�������','����/������','','t_clubs', 'club',
      '�� ������� �������� ������ ������. �������� ��������� � �����.',clubBox);

end;

procedure TCompetitorForm.FormCreate(Sender: TObject);
begin
  //������ ����� �� ������ ������
  self.Left := (screen.Width - self.Width) div 2;
  self.Top :=  (screen.Height - self.Height) div 2;
//������ ��� ����������
  load_list_to_combo('t_ages','age',ageBox);
  load_list_to_combo('t_belts','belt',beltBox);
  load_list_to_combo('t_cities', 'city', cityBox);
  load_list_to_combo('t_clubs', 'club',clubBox);
end;

procedure TCompetitorForm.OKBtnClick(Sender: TObject);
begin
  if Trim(FIOEdit.Text) = '' then
  begin
    ShowMessage('�� ��������� ��� ���������');
    Exit;
  end;
  if ageBox.Text = '' then
  begin
    ShowMessage('�� ������� ���������� ���������');
    Exit;
  end;
  if weightBox.Text = '' then
  begin
    ShowMessage('�� ������� ������� ���������');
    Exit;
  end;
  if BeltBox.Text = '' then
  begin
    ShowMessage('�� ������ ����');
   Exit;
  end;
  if cityBox.Text = '' then
  begin
    ShowMessage('�� ������ �����');
   Exit;
  end;
  if clubBox.Text = '' then
  begin
    ShowMessage('�� ������ ����');
   Exit;
  end;
  //���� ����� �� ����, �� ��� �������
  self.ModalResult := mrOk;
end;

procedure TCompetitorForm.add_new_value(formName, labelName, mask,
  tableName, colName, mes: string; var combo: TCombobox);
var str: string; //��������� ��������
begin
  AddValueForm := TAddValueForm.Create(self);

  //������������� ��������� ��������
  AddValueForm.set_values(formName,labelName,mask);

  if AddValueForm.ShowModal = mrOK then //������������ ���������� ����
  begin
    str := trim(AddValueForm.ValueEdit.Text);
    //������ �� ���������� �����
    if combo.Items.IndexOf(str) <> -1 then
    begin
      ShowMessage('��������� �������� ��� ������������ � ������');
      combo.ItemIndex := combo.Items.IndexOf(str);
    end
    else
      if DataModule1.add_value_query(tableName, colName, str) <> 0 then
        ShowMessage('�� ������� �������� �������� � ����. ���������� ��� ���.')
      else
      begin
        //��������� ���������� ������ ����������
        if (load_list_to_combo(tableName, colName, combo) <> 0) then   // ���� �������� ������ ����������
          showmessage(mes)
        else //���� ������ ���, �� ���������� ��������� �������� ���������
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
