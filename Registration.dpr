program Registration;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  DataModuleUnit in 'DataModuleUnit.pas' {DataModule1: TDataModule},
  CompetitorFormUnit in 'CompetitorFormUnit.pas' {CompetitorForm},
  AddValueUnit in 'AddValueUnit.pas' {AddValueForm},
  ChangeDefaultsUnit in 'ChangeDefaultsUnit.pas' {ChangeDefaultsForm},
  addWeightUnit in 'addWeightUnit.pas' {addWeightForm},
  CompetitorTableUnit in 'CompetitorTableUnit.pas' {CompetitorTableForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Регистрация участников на соревнования';
  Application.CreateForm(TDataModule1, DataModule1);
  //Application.CreateForm(TCompetitorTableForm, CompetitorTableForm);
  //Application.CreateForm(TaddWeightForm, addWeightForm);
   Application.CreateForm(TMainForm, MainForm);
  //Application.CreateForm(TChangeDefaultsForm, ChangeDefaultsForm);
  //Application.CreateForm(TCompetitorForm, CompetitorForm);
  //Application.CreateForm(TAddValueForm, AddValueForm);
  Application.Run;
end.
