program EmployeeDirectoryMobile;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  MobileMainForm in 'MobileMainForm.pas' {frmMobileMain},
  kinveyDataModule in 'kinveyDataModule.pas' {dmBaaSUser: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMobileMain, frmMobileMain);
  Application.CreateForm(TdmBaaSUser, dmBaaSUser);
  Application.Run;
end.
