unit addWeightUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons;

type
  TaddWeightForm = class(TForm)
    ageBox: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    weightEdit: TMaskEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  addWeightForm: TaddWeightForm;

implementation

{$R *.dfm}

procedure TaddWeightForm.BitBtn1Click(Sender: TObject);
begin
  if ageBox.Text = '' then
    ShowMessage('Не выбрана возрастная категория.')
  else
    if weightEdit.Text = '' then
      ShowMessage('Не заполнена весовая категория')
    else
      ModalResult := mrOk;
end;

procedure TaddWeightForm.FormCreate(Sender: TObject);
begin
    //ставим форму по центру экрана
  self.Left := (screen.Width - self.Width) div 2;
  self.Top :=  (screen.Height - self.Height) div 2;
end;

procedure TaddWeightForm.FormShow(Sender: TObject);
begin
  weightEdit.SetFocus;
  weightEdit.SelectAll;
end;

end.
