unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DataModuleUnit,
  StdCtrls, ExtCtrls, CompetitorFormUnit, ChangeDefaultsUnit,CompetitorTableUnit ;

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
  //  procedure RadioButton2Click(Sender: TObject);
  private
    { Private declarations }
    CompetitorForm: TCompetitorForm; //����� ���������� ���������� �� ���������
    function add_record:integer; //���������� ����������� ���������� �� ��������� � ����
    function edit_record:integer; //��������� ������� ������
    procedure prepare_form; //���������� ������ ��������� �����������
    function load_values_to_query: integer; //��������� ������ � ����� � ���������� �� � ������. ���������� ������(0-������, �� 0  - �����)
  //  procedure radio_changed; //��������� ��������� ������������
  public
    { Public declarations }
    procedure refresh_data; //���������� ������ � �������
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormResize(Sender: TObject);
begin
  //������������ ������ ������� ��� ���������� ������
  cxGrid1DBTableView1.OptionsView.ColumnAutoWidth := true;
  cxGrid1DBTableView1.OptionsView.CellAutoHeight := true;
end;

procedure TMainForm.refresh_data;
begin
  DataModule1.MainQuery.Close;
  DataModule1.MainQuery.Open;
end;

procedure TMainForm.AddBtnClick(Sender: TObject);
begin
  CompetitorForm := TCompetitorForm.Create(self);

  while CompetitorForm.ShowModal = mrOk do  //������ ���������� � �����,���� ������� ��������� �������
  begin
    if add_record <> 0 then
      ShowMessage('��� ������� �������� ������ � ���� �������� ������.');
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

procedure TMainForm.EditBtnClick(Sender: TObject); //��������� ������� ������
begin
  CompetitorForm := TCompetitorForm.Create(self);
  prepare_form; //��������� ��������� �������
  if CompetitorForm.ShowModal = mrOk then
    if edit_record <> 0 then
      ShowMessage('�������� ������ ��� ��������� ������');
  CompetitorForm.Destroy;
  //��������� ����
  refresh_data;
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
  //��������� ����� ������� ��� ��������������
  with DataModule1 do
  begin
    CompetitorForm.FIOEdit.Text := MainQuery.fieldByName('FIO').AsString;
    //�������
    str := MainQuery.fieldByName('t_ages.age').AsString;
    CompetitorForm.AgeBox.ItemIndex  := CompetitorForm.AgeBox.Items.IndexOf(str);

    //������ ���� ���������� ��������
    //���������� ������ ��������� ����� ��������, ����� ���������� ������ �����
    CompetitorForm.AgeBoxChange(nil);
    str := MainQuery.fieldByName('t_weights.weight').AsString;
    CompetitorForm.weightBox.ItemIndex := CompetitorForm.weightBox.Items.IndexOf(str);
    //����
    str := MainQuery.fieldByName('t_belts.belt').AsString;
    CompetitorForm.BeltBox.ItemIndex := CompetitorForm.BeltBox.Items.IndexOf(str);

    //�����
    str := MainQuery.fieldByName('t_cities.city').AsString;
    CompetitorForm.CityBox.ItemIndex := CompetitorForm.CityBox.Items.IndexOf(str);

    //����
    str := MainQuery.fieldByName('t_clubs.club').AsString;
    CompetitorForm.ClubBox.ItemIndex := CompetitorForm.ClubBox.Items.IndexOf(str);

    //������� ������
    CompetitorForm.ParticipationMark.Checked := MainQuery.fieldByName('participation').asBoolean;
  end
end;

procedure TMainForm.TemplateBtnClick(Sender: TObject);  //������������ ������� ������, ��� ������.
begin
//������ ���, ��� � ����, ������ ������ ����������� ��������� �����
CompetitorForm := TCompetitorForm.Create(self);
  prepare_form; //��������� ��������� �������
  while CompetitorForm.ShowModal = mrOk do
  begin
    if add_record <> 0 then
      ShowMessage('��� ������� �������� ������ � ���� �������� ������.');
    //��������� ����
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
  if CheckBox1.Checked then       //���/���� ���������� �� �������
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
  {cxGrid1DBTableView1DBColumn8.Options.Sorting := false; //��������� ��������� �� id (����������)  }
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
  if MessageDlg('������ �������� �������� � �������������� �������� ������ �� ��. �� �������, ��� ������ ������� ��?',
      mtWarning,mbOKCancel,0) = mrOk then
  begin
    with DataModule1 do
    begin
      //������ ������ �� ��������� ������ �� ��, ����� ��������
      DBQuery.Close;
      DBQuery.SQL.Text := 'SELECT * FROM t_main WHERE id = ' + MainQuery.fieldByName('t_main.id').AsString;
      try
        DBQuery.Open;
        DBQuery.Delete;
      except
        ShowMessage('�� ������� ��������� �������� ��������� ������. ���������� ��� ���.');
      end;
      DBQuery.Close;
    end
  end;
  refresh_data;
end;

procedure TMainForm.ChangeDefaultsBtnClick(Sender: TObject);
begin
  ChangeDefaultsForm := TChangeDefaultsForm.Create(self);
  ChangeDefaultsForm.ShowModal;
  ChangeDefaultsForm.Destroy;
  refresh_data;
end;

procedure TMainForm.CompetitorTableBtnClick(Sender: TObject);//������ ��������� �������
begin
  CompetitorTableForm := TCompetitorTableForm.Create(self);
  CompetitorTableForm.ShowModal;
end;

end.
