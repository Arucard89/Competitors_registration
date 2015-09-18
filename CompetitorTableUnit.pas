unit CompetitorTableUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DataModuleUnit, ADODB, ComObj, ClipBrd  ;

type

  TClubsCountArr = record //������ ���������� ���������
    count: integer;//���������� ����������
    club: string;//��� �����
    men: TStringList; // ������ ���������� ������� �����
  end;

  TCountCompetitorsArr = array of TClubsCountArr; //������ ���������� �� ������

  TCompetitorsInGroups = array of TStringList; //������ ����������, �������� �� ���������

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
    compArr: TCountCompetitorsArr; //������ ������ �� ������� ����������
    groupsCount:integer; //���������� ��������
    CompetitorsInGroups: TCompetitorsInGroups; //������ �������� � �����������


    function build_weights_list(age: string; var list:TStringList):integer; //���������� ������ ����� �� ��������/ 0-��, 1-�� ������� ������� ������, 2-������ �������//������� �� ����� ���������
    function load_list_to_weight_combo(age:string):integer; //��������� � ��������� �����
    function built_competitors_list:integer;//������ ������� ����������, ��������������� ���������

    function build_club_list_in_category:integer; //��������� ������ ������ �� ���������(���������� ���������� ������������ � 0 ��� ������ ������)
    procedure get_clubs_count_and_men; //�������� ���������� ���������� �� ������� ����� � ����� ����������
    procedure qSort(var A: TCountCompetitorsArr; min, max: Integer); //������� ���������� ��� ������� ������ �� ���������� ���������� ���������
    procedure separating_on_subgroups; //��������� ����� �� ����������
    procedure create_table_in_excel; //�������� ������ � ������

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
  //������������ ������ ������� ��� ���������� ������
  cxGrid1DBTableView1.OptionsView.ColumnAutoWidth := true;
  cxGrid1DBTableView1.OptionsView.CellAutoHeight := true;
end;

procedure TCompetitorTableForm.buildTableBtnClick(Sender: TObject);
var r:integer;
begin
  //���������, ��� �� ������� ���������
  if BeltBox.Text = '' then
  begin
    ShowMessage('�� ������ ����.');
    exit;
  end;

  if ageBox.Text = '' then
  begin
    ShowMessage('�� ������ �������.');
    exit;
  end;

  if weightBox.Text = '' then
  begin
    ShowMessage('�� ������ ���.');
    exit;
  end;
  //���� ����� �� ����, ������, ��� ������, �������� ������� �������.
  r := built_competitors_list;

  if r = 0 then   //��� ������� � ������ � ������ ��������
    BuildBracketsBtn.Enabled := true;

  if r = 2 then
  begin
     ShowMessage('���������� � ��������� ����������� ���.');
     BuildBracketsBtn.Enabled := false;
  end;

  if r = 1 then
  begin
     ShowMessage('��������� ������ ��������� � ��.');
     BuildBracketsBtn.Enabled := false;
  end;
end;

procedure TCompetitorTableForm.FormCreate(Sender: TObject);
begin
  //������ ����� �� ������ ������
  self.Left := (screen.Width - self.Width) div 2;
  self.Top :=  (screen.Height - self.Height) div 2;

  //��������� ������, ����� ������� ���� ������
  CompetitorsQuery.Close;
  //������ ������ ������� � ������
  with DataModule1 do
  begin
    if fulfill_list('t_ages', 'age', ages_list) <> 0 then
      ShowMessage('������� ��������� ����� ���� �����������');
    ageBox.Items.Text := ages_list.Text;

    if fulfill_list('t_belts', 'belt', belts_list) <> 0 then
      ShowMessage('������� ������ ����� ���� �����������');
    beltBox.Items.Text := belts_list.Text;
  end
  
end;

procedure TCompetitorTableForm.ageBoxChange(Sender: TObject);
begin
  if AgeBox.Text <> '' then
  begin
    if load_list_to_weight_combo(AgeBox.Text) <> 0 then
      ShowMessage('������ ����� ��� ������ ���������� ��������� ����.');
  end;
end;


function TCompetitorTableForm.build_weights_list(age: string;
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
        ' AND participation = true'; //�������� ������ ���, ��� � �������� �� �������
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
  BuildBracketsBtn.Enabled := false; //��������� ������, ���� ���� �� �������� 10 ��� ��������
  //������� ���������� ������ ������ � �������
  //���� ����� � �����, ������ ��� ��-������� �� ���� ��� ���
  if build_club_list_in_category <> 0 then
  begin
    ShowMessage('�������� ������ ��� ��������� ������ ������.');
    exit;
  end;
  get_clubs_count_and_men; //�������� ����� ���������� �� ������� �����
  //��������� ��������
  qSort(compArr,0, length(compArr)-1);
  //���������� ���������� ��������(� ��������� 8 �������)
  groupsCount := CompetitorsQuery.RecordCount div 8;
  if  (CompetitorsQuery.RecordCount mod 8)<>0 then
    groupsCount := groupsCount + 1;

   //������� ������ ���������� �� ����������
  SetLength(CompetitorsInGroups,groupsCount);
  for i := 0 to groupsCount - 1 do
    CompetitorsInGroups[i] := TStringList.Create;

  //����� ����� �� ���������
  separating_on_subgroups;
  //������� ������ � Excel
  create_table_in_excel;

  //������� ��������
  //������ ���������� �� ����������
  for i := 0 to groupsCount - 1 do
    CompetitorsInGroups[i].Destroy;
  CompetitorsInGroups := nil;

  //������� ������ ���������� �� ������
  for i := 0 to length(compArr) - 1 do
    compArr[i].men.Destroy;
  compArr := nil;

end;

function TCompetitorTableForm.build_club_list_in_category: integer;
var i:integer;
begin
  //������� ���������� ������� ����� ������ ������
  with DataModule1 do
  begin
    DBQuery.Close;
    DBQuery.SQL.Text := 'SELECT DISTINCT(t_clubs.club) FROM ((((t_main INNER JOIN t_ages ON t_main.age = t_ages.id) '+
          'INNER JOIN t_weights ON t_main.weight = t_weights.id) INNER JOIN t_belts ON t_main.belt = t_belts.id)'+
          ' INNER JOIN t_cities ON t_main.city = t_cities.id) INNER JOIN t_clubs ON t_main.club = t_clubs.id'+
          ' WHERE t_belts.belt = ' + QuotedStr(BeltBox.Text) +
          ' AND t_ages.age = ' + QuotedStr(ageBox.Text) +
          ' AND t_weights.weight = ' + QuotedStr(weightBox.Text)+' AND participation = true'; //�������� ������ ���, ��� � �������� �� �������
    try
      DBQuery.Open;
      i:= DBQuery.RecordCount; //������ ��� ��������
      SetLength(compArr,DBQuery.RecordCount);//���������� ������������ ������
      i := 0;
      DBQuery.First;
      while not DBQuery.Eof do     //��������� ������
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
  //�������������� ��� ������
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
        compArr[j].men.Add(CompetitorsQuery.FieldByName('FIO').AsString + ' (' + compArr[j].club + ')'); //��������� ������ �������� ���� "��� ����"
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
  group:integer; //����� ����� � ������ ���������
  compCount:integer; //����� ����������, ���������� �����������������
  iterDelim:integer; //����������� ��������, ��������� �� ��������
begin
  compCount := CompetitorsQuery.RecordCount; //���������� ��� ��������������
  for n := 1 to groupsCount do  //���� �������
  begin
    m := 0; //���������� ���������� �������� �����
    iterDelim := groupsCount-(n-1);//��������� ��������
    //���������� ����� ���������� � ������
    group := compCount div iterDelim; //����� ���������� ����� ���������� �� ����� ����� - (����� �������� - 1)
    if  (compCount mod iterDelim) <> 0 then
      group := group + 1;
    for i := 0 to length(compArr) - 1 do //���� �� ������
    begin
      l := compArr[i].men.Count div iterDelim; // ��������� ���������� �����, ����������� �� ������� �����
      if (compArr[i].men.Count mod iterDelim) <> 0 then //��������� �� �������� ������
        l := l + 1;
      for j := 0 to l - 1 do //����������� �� ������ ������ ����� ����� � ����������
      begin
        if m < group then //���� ������ ��� �� ���������, �� ���������
        begin
          CompetitorsInGroups[n-1].Add(compArr[i].men.Strings[0]); //��� ������  � ������ ������-������)
          m := m + 1;
          compArr[i].men.Delete(0); //������ ������� �������, ������ ��� �� ������ ������(�� ��� ������������ � �������!)
        end;
      end;
    end;
    compCount := compCount - group;
  end;
end;

procedure TCompetitorTableForm.create_table_in_excel;
var templ,w : Variant; //������ ����� � ������� �����
  c: array [1..8] of integer;// = (1,15,5,11,3,13,7,9); //������ ������� ������
  i,j: integer;
  source,dest: OleVariant;
begin
  //������ ������� ������
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


  //������
  templ := CreateOleObject('Excel.Application');//������� OLE ������
  templ.Workbooks.Open(ExtractFileDir(Application.ExeName)+'\xls_template\template.xls',0,True);  //"D:\??????????\??????????? ??????????\xls_template\template.xls"

  w := CreateOleObject('Excel.Application');
  w.Workbooks.Add;
  dest := w.worksheets[1];
  //���������� ������ ������ �����
  dest.rows.rowheight := 31.5;
 // dest.columns.columnwidth := 22;

  dest.range['a1'].columnwidth := 43;
  dest.range['c1'].columnwidth := 25.3;
  dest.range['e1'].columnwidth := 25.3;
  dest.range['g1'].columnwidth := 25.3;

  dest.range['f1'].columnwidth := 6;
  dest.range['b1'].columnwidth := 6;
  dest.range['d1'].columnwidth := 6;
  //���������� ��������� ����������
  dest.pageSetup.Orientation := 2;
  //�������
  dest.pageSetup.zoom := 92;

  try
    //������ ������� ��� ������ ���������� �����
    for i := 1 to groupsCount do
    begin
      templ.worksheets[1].range['a1','g15'].copy(EmptyParam);
      dest.Range['a'+ intToStr(1 + 15*(i-1)),'g' + intToStr(15 + 15*(i-1))].PasteSpecial(-4163,,,); //������ ��� ����������
      Clipboard.Clear;
      dest.Range['d' + intToStr(1 + 15*(i-1))] := '����: ' + BeltBox.Text + ', �������: '+ ageBox.Text + ', ���: ' + weightBox.Text;
      if groupsCount > 1 then
        dest.Range['g' + intToStr(2 + 15*(i-1))] := '��������� ' + IntToStr(i);
    end;

    //������ ���������� � �������
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
    showMessage('�� ������� ��������� ������ � Excel.');
    w.quit;
    templ.quit;
  end;
end;

end.
