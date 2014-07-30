program EmployeeDirectory;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  kinveyDataModule in 'kinveyDataModule.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
