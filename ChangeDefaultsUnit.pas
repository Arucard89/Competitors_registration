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
    procedure add_new_value(formName,labelName,mask,colName:string;var query:TADOQuery); //���������� ������ �������� � ������� �������� ������(����� ����, �� ���������)
    //formName-��� ����,labelName-��� �����,mask-����� �����,colName - ��� ������� ���������;  query -��� �������, � ������� ������� �������
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
var str: string; //��������� ��������
begin
  AddValueForm := TAddValueForm.Create(self);

  //������������� ��������� ��������
  AddValueForm.set_values(formName,labelName,mask);

  if AddValueForm.ShowModal = mrOK then //������������ ���������� ����
  begin
    str := trim(AddValueForm.ValueEdit.Text);
    //��������� ��������
    query.Insert;
    query.FieldByName(colName).AsString := str;
    query.Post;
    //��������� ���������� �������
    Query.close;
    query.open;
  end;

  AddValueForm.Destroy;
end;

procedure TChangeDefaultsForm.FormCreate(Sender: TObject);
begin
  //�������� ��� �������
  ageQuery.Open;
  beltQuery.Open;
  cityQuery.Open;
  clubQuery.Open;
  weightQuery.Open;
  //������������ ��������
  //������������ ������ ������� ��� ���������� ������
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
  add_new_value('�������� ���������� ���������','���������� ���������','###','age',ageQuery);
end;

procedure TChangeDefaultsForm.beltAddBtnClick(Sender: TObject);
begin
  add_new_value('�������� ����','���� �����','','belt',beltQuery);
end;

procedure TChangeDefaultsForm.CityAddBtnClick(Sender: TObject);
begin
  add_new_value('�������� �����','�������� ������','','city',cityQuery);
end;

procedure TChangeDefaultsForm.ClubAddBtnClick(Sender: TObject);
begin
  add_new_value('�������� ����/�������','����/������','','club',clubQuery);
end;


procedure TChangeDefaultsForm.edit_value(formName, labelName, mask,
  colName: string; var query: TADOQuery);
  var str: string; //��������� ��������
begin
  AddValueForm := TAddValueForm.Create(self);

  //������������� ��������� ��������
  AddValueForm.set_values(formName,labelName,mask);
  AddValueForm.ValueEdit.Text := query.fieldByName(colName).AsString;

  if AddValueForm.ShowModal = mrOK then //������������ ���������� ����
  begin
    str := trim(AddValueForm.ValueEdit.Text);
    query.Edit;
    query.FieldByName(colName).AsString := str;
    query.Post;
    //��������� ���������� �������
    Query.close;
    query.open;
  end;

  AddValueForm.Destroy;
end;

procedure TChangeDefaultsForm.ageEditBtnClick(Sender: TObject);
begin
  edit_value('�������� ���������� ���������','���������� ���������','###','age',ageQuery);
end;

procedure TChangeDefaultsForm.beltEditBtnClick(Sender: TObject);
begin
  edit_value('�������� ����','���� �����','','belt',beltQuery);
end;

procedure TChangeDefaultsForm.CityEditBtnClick(Sender: TObject);
begin
  edit_value('�������� �����','�������� ������','','city',cityQuery);
end;

procedure TChangeDefaultsForm.ClubEditBtnClick(Sender: TObject);
begin
  edit_value('�������� ����/�������','����/������','','club',clubQuery);
end;

procedure TChangeDefaultsForm.ageDeleteBtnClick(Sender: TObject);
begin
  //������ �� ������
  ageQuery.Close;
  ageQuery.Open;
  if ageQuery.RecordCount <= 0 then
  begin
    ShowMessage('������ ��������� ����. �������� ����������.');
    Exit;
  end;
  if MessageDlg('������ �������� �������� � �������������� �������� ������ �� ��. �� �������, ��� ������ ������� ��?',
      mtWarning,mbOKCancel,0) = mrOk then
  ageQuery.Delete;
  //��������� �������
  ageQuery.close;
  ageQuery.open;
end;

procedure TChangeDefaultsForm.beltDeleteBtnClick(Sender: TObject);
begin
  //������ �� ������
  beltQuery.Close;
  beltQuery.Open;
  if beltQuery.RecordCount <= 0 then
  begin
    ShowMessage('������ ��������� ����. �������� ����������.');
    Exit;
  end;
  if MessageDlg('������ �������� �������� � �������������� �������� ������ �� ��. �� �������, ��� ������ ������� ��?',
      mtWarning,mbOKCancel,0) = mrOk then
  beltQuery.Delete;
    //��������� �������
  beltQuery.close;
  beltQuery.open;
end;

procedure TChangeDefaultsForm.CityDeleteBtnClick(Sender: TObject);
begin
    //������ �� ������
  cityQuery.Close;
  cityQuery.Open;
  if cityQuery.RecordCount <= 0 then
  begin
    ShowMessage('������ ��������� ����. �������� ����������.');
    Exit;
  end;
  if MessageDlg('������ �������� �������� � �������������� �������� ������ �� ��. �� �������, ��� ������ ������� ��?',
      mtWarning,mbOKCancel,0) = mrOk then
  cityQuery.Delete;
    //��������� �������
  cityQuery.close;
  cityQuery.open;
end;

procedure TChangeDefaultsForm.ClubDeleteBtnClick(Sender: TObject);
begin
    //������ �� ������
  clubQuery.Close;
  clubQuery.Open;
  if clubQuery.RecordCount <= 0 then
  begin
    ShowMessage('������ ��������� ����. �������� ����������.');
    Exit;
  end;
  if MessageDlg('������ �������� �������� � �������������� �������� ������ �� ��. �� �������, ��� ������ ������� ��?',
      mtWarning,mbOKCancel,0) = mrOk then                     
  clubQuery.Delete;
    //��������� �������
  clubQuery.close;
  clubQuery.open;
end;

//*********** �������� � �/�*********************
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

  //������ ������ ���������
  if DataModule1.fulfill_list('t_ages', 'age', DataModule1.ages_list) <> 0 then
    ShowMessage('������� ��������� ����� ���� �����������');
  addWeightForm.ageBox.Items.Text := DataModule1.ages_list.Text;

  //��������� ���
  if addWeightForm.ShowModal = mrOK then
  begin
    str := trim(addWeightForm.weightEdit.Text);
    if DataModule1.add_weight_query(str,addWeightForm.AgeBox.Text) <> 0 then
        ShowMessage('�� ������� �������� �������� � ����. ���������� ��� ���.');
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

  //������ ������ ���������
  if DataModule1.fulfill_list('t_ages', 'age', DataModule1.ages_list) <> 0 then
    ShowMessage('������� ��������� ����� ���� �����������');
  addWeightForm.ageBox.Items.Text := DataModule1.ages_list.Text;
  //������ ��� � �������
  addWeightForm.weightEdit.Text := weightQuery.FieldByName('weight').AsString;
  addWeightForm.ageBox.ItemIndex := addWeightForm.ageBox.Items.IndexOf(weightQuery.FieldByName('t_ages.age').AsString);

  //��������� ���
  if addWeightForm.ShowModal = mrOK then
  begin
    str := trim(addWeightForm.weightEdit.Text);

    r := datamodule1.find_value_querry('t_ages','age','id',addWeightForm.ageBox.Text, id);
    if r <> 0 then  ShowMessage('�� �������� id ����.��������� �� �������')
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
  //������ �� ������
  weightQuery.Close;
  weightQuery.Open;
  if weightQuery.RecordCount <= 0 then
  begin
    ShowMessage('������ ������� ����. �������� ����������.');
    Exit;
  end;
  if MessageDlg('������ �������� �������� � �������������� �������� ������ �� ��. �� �������, ��� ������ ������� ��?',
      mtWarning,mbOKCancel,0) = mrOk then
    with DataModule1 do
    begin
      DBQuery.Close;
      DBQuery.SQL.Text := 'SELECT * FROM t_weights where id = ' + weightQuery.FieldByName('t_weights.id').AsString;
      DBQuery.Open;
      DBQuery.Delete;
      //���������
      weightQuery.Close;
      weightQuery.Open;
    end;

end;

end.



