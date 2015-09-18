unit AddValueUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask;

type
  TAddValueForm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ValueEdit: TMaskEdit;
    Label1: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure set_values(formName:String;LabelName:String; mask:string);
  end;

var
  AddValueForm: TAddValueForm;   

implementation

{$R *.dfm}

procedure TAddValueForm.BitBtn1Click(Sender: TObject);
begin
  if trim(ValueEdit.Text) = '' then
    ShowMessage('Значение параметра не введено.')
  else
    ModalResult := mrOk;
end;

procedure TAddValueForm.set_values(formName, LabelName, mask: string);
begin
  self.Caption := formName;
  label1.Caption := LabelName;
  ValueEdit.EditMask := mask;
end;



procedure TAddValueForm.FormShow(Sender: TObject);
begin
  ValueEdit.SetFocus;
  ValueEdit.SelectAll;
end;

procedure TAddValueForm.FormCreate(Sender: TObject);
begin
    //ставим форму по центру экрана
  self.Left := (screen.Width - self.Width) div 2;
  self.Top :=  (screen.Height - self.Height) div 2;
end;

end.
