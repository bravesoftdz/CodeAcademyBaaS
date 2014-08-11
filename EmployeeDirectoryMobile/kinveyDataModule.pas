unit kinveyDataModule;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.OpenSSL,
  REST.Backend.ServiceTypes, REST.Backend.MetaTypes, System.JSON,
  REST.Backend.KinveyServices, REST.Backend.Providers,
  REST.Backend.ServiceComponents, REST.Backend.KinveyProvider, REST.Client,
  REST.Authenticator.Basic, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Backend.KinveyAPI, REST.Types;

type
  TKinveyAPIExtend = class(TKinveyAPI)
  public
    procedure ResetPassword(const AUsername: string);
  end;

  TdmBaaSUser = class(TDataModule)
    KinveyProvider1: TKinveyProvider;
    BackendUsers1: TBackendUsers;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    HTTPBasicAuthenticator1: THTTPBasicAuthenticator;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FKinveyAPI: TKinveyAPIExtend;
  public
    { Public declarations }
    procedure SignUp(const AUsername, APassword, AFullname, AEmail: string);

    function Login(const AUsername, APassword: string): Boolean;
    procedure Logout;

    procedure ResetPassword(const AUsername: string);
  end;

var
  dmBaaSUser: TdmBaaSUser;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TdmBaaSUser.DataModuleCreate(Sender: TObject);
begin
  FKinveyAPI := TKinveyAPIExtend.Create(nil);
  KinveyProvider1.UpdateApi(FKinveyAPI);
end;

function TdmBaaSUser.Login(const AUsername, APassword: string): Boolean;
var
  Login: TBackendEntityValue;
begin
  try
    BackendUsers1.Users.LoginUser(AUsername, APassword, Login);
    Result := (Login.AuthToken <> '');
  except
    Exit(False);
  end;
end;

procedure TdmBaaSUser.Logout;
begin
  BackendUsers1.Users.Logout;
end;

procedure TdmBaaSUser.ResetPassword(const AUsername: string);
begin
{
  // #1 REST Client »ç¿ë
  RESTRequest1.Params.ParameterByName('appkey').Value := KinveyProvider1.AppKey;
  RESTRequest1.Params.ParameterByName('username').Value := AUsername;
  RESTRequest1.Execute;
}
  FKinveyAPI.ResetPassword(AUsername);
end;

procedure TdmBaaSUser.SignUp(const AUsername, APassword, AFullname,
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
    BackendUsers1.Users.Login(CreatedObject);
  finally
    UserData.Free;
  end;
end;

{ TKinveyAPIExtend }

procedure TKinveyAPIExtend.ResetPassword(const AUsername: string);
var
  LConnectionInfo: TConnectionInfo;
begin
  Request.ResetToDefaults;
  // Basic Auth
  LConnectionInfo := Self.ConnectionInfo;
  LConnectionInfo.UserName := AUsername;
  ConnectionInfo := LConnectionInfo;
  AddAuthParameter(TAuthentication.UserName);
  // App credentials
  AddAuthParameter(TAuthentication.AppSecret);
  Request.Method := TRESTRequestMethod.rmPOST;
  Request.Resource := 'rpc/{appkey}/{username}/user-password-reset-initiate';
  Request.AddParameter('username', AUsername, TRESTRequestParameterKind.pkURLSEGMENT );
  Request.Execute;
  CheckForResponseError([201]);
end;

end.
