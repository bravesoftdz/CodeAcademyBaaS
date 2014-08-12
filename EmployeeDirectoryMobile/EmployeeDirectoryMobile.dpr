program EmployeeDirectoryMobile;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  EmployeeTypes in 'EmployeeTypes.pas',
  kinveyDataModule in 'kinveyDataModule.pas' {dmBaaSUser: TDataModule},
  MobileMainForm in 'MobileMainForm.pas' {frmMobileMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmBaaSUser, dmBaaSUser);
  Application.CreateForm(TfrmMobileMain, frmMobileMain);
  Application.Run;
end.
