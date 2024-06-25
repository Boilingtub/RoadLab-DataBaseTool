program pPeriodEmployeeCount;

uses
  Forms,
  uFRM_PeridEmployeeCount in 'uFRM_PeridEmployeeCount.pas' {frmPeriodEmployeeCount},
  uDM_PeriodEmployeeCount in 'uDM_PeriodEmployeeCount.pas' {DM_PeriodEmplyeeCount: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPeriodEmployeeCount, frmPeriodEmployeeCount);
  Application.CreateForm(TDM_PeriodEmplyeeCount, DM_PeriodEmplyeeCount);
  Application.Run;
end.
