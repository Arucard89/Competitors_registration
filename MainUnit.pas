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
var h,b:integer;
begin
  //������������ ������ ������� ��� ���������� ������
  cxGrid1DBTableView1.OptionsView.ColumnAutoWidth := true;
  cxGrid1DBTableView1.OptionsView.CellAutoHeight := true;

  //�������� ������ ������ � ����������� �� ������ ����
  b := 8; //���������� ����� ��������
  h := (panel1.Height - b*(6+1)) div 6;//6 ������

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
var num : integer; //����� ������� ������
begin
  CompetitorForm := TCompetitorForm.Create(self);
  prepare_form; //��������� ��������� �������
  if CompetitorForm.ShowModal = mrOk then
    if edit_record <> 0 then
      ShowMessage('�������� ������ ��� ��������� ������');
  CompetitorForm.Destroy;
  //cxGrid1DBTableView1.datacontroller.Refresh;
  num := DataModule1.MainDataSource.DataSet.RecNo;
  //��������� ����
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
  //������ ����� �� ������ ������
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
    ShowMessage('������ ����, �������� ����������.');
    Exit;
  end;

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
  //cxGrid1DBTableView1.datacontroller.Refresh;   //�� �������� �� ��������
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
  if Trim(SearchEdit.Text) <> '' then  //���� ���� ������ ��������
    if DataModule1.MainQuery.Locate('FIO',SearchEdit.Text,[loCaseInsensitive,loPartialKey]) = true then
    begin
      SearchLabel.Caption := '������ �������';
      SearchLabel.Font.Color := clGreen;
    end
    else
    begin
      SearchLabel.Caption := '������ �����������';
      SearchLabel.Font.Color := clRed;
    end
  else        //���� ���� ������
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
        if MessageDlg('���� � ������ ������ ��� ����������. ������������?', mtWarning,mbOKCancel, 0) = mrOk then
          ExportGrid4ToExcel(FileName, cxGrid1, True, True, false);
      end
      else
        ExportGrid4ToExcel(FileName, cxGrid1, True, True, false);
  finally
    Free;
  end;

end;

end.
