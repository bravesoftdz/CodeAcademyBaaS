unit kinveyDataModule;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.OpenSSL,
  REST.Backend.ServiceTypes, REST.Backend.MetaTypes, System.JSON,
  REST.Backend.KinveyServices, REST.Backend.Providers,
  REST.Backend.ServiceComponents, REST.Backend.KinveyProvider;

type
  TDataModule1 = class(TDataModule)
    KinveyProvider1: TKinveyProvider;
    BackendUsers1: TBackendUsers;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SignUp(const AUsername, APassword, AFullname, AEmail: string);
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TDataModule1.SignUp(const AUsername, APassword, AFullname,
  AEmail: string);
var
  UserData: TJSONObject;
  CreatedObject: TBackendEntityValue;
begin
  UserData := TJSONObject.Create;
  try
    UserData.AddPair('fullname', AFullname);
    UserData.AddPair('email', AEmail);

    BackendUsers1.Users.SignupUser(AUsername, APassword, UserData, CreatedObject);
  finally
    UserData.Free;
  end;
end;

end.
