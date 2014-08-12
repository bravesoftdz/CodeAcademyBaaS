unit kinveyDataModule;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.OpenSSL,
  REST.Backend.ServiceTypes, REST.Backend.MetaTypes, System.JSON,
  REST.Backend.KinveyServices, REST.Backend.Providers,
  REST.Backend.ServiceComponents, REST.Backend.KinveyProvider, REST.Client,
  REST.Authenticator.Basic, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Backend.KinveyAPI, REST.Types, REST.Backend.BindSource,
  System.Generics.Collections, EmployeeTypes;

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
    storageEmployeeDirectory: TBackendStorage;
    qryEmployeeDirectory: TBackendQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FKinveyAPI: TKinveyAPIExtend;
    FEmployeeBackendObjects : TBackendObjectList<TEmployee>;
  public
    { Public declarations }
    procedure SignUp(const AUsername, APassword, AFullname, AEmail: string);

    function Login(const AUsername, APassword: string): Boolean;
    procedure Logout;

    procedure ResetPassword(const AUsername: string);

    // 3회차 추가
    procedure InsertEmployee(AFullName, APhone, AEmail, ADepartment: string);
    procedure DeleteEmployee(AEmployeeId : String);
    procedure UpdateEmployee(AOriginalEmployee: TEmployee; AUpdatedEmployee: TEmployee);
    function GetEmployees : TList<TEmployee>;
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
  // #1 REST Client 사용
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

function TdmBaaSUser.GetEmployees: TList<TEmployee>;
var
  qryString : TArray<String>;
  Employee : TEmployee;
  EmployeeList : TList<TEmployee>;
begin
  FEmployeeBackendObjects := TBackendObjectList<TEmployee>.Create;

  qryString := TArray<String>.Create(Format('sort=%s', [TEmployeeMetaData.FullNameColumn]));
  storageEmployeeDirectory.Storage.QueryObjects<TEmployee>(
          TEmployeeMetaData.BackendType,
          qryString,
          FEmployeeBackendObjects
  );

  EmployeeList := TList<TEmployee>.Create;
  for Employee in FEmployeeBackendObjects do
  begin
    Employee.Id := FEmployeeBackendObjects.EntityValues[Employee].ObjectID;
    EmployeeList.Add(Employee);
  end;
  Result := EmployeeList;
end;

procedure TdmBaaSUser.InsertEmployee(AFullName, APhone, AEmail,
  ADepartment: string);
var
  Employee: TEmployee;
  CreatedObject: TBackendEntityValue;
begin
  Employee := TEmployee.Create;
  Employee.FullName := AFullName;
  Employee.Department := ADepartment;
  Employee.Phone := APhone;
  Employee.Email := AEmail;

  storageEmployeeDirectory.Storage.CreateObject<TEmployee>(
      TEmployeeMetaData.BackendType,
      Employee,
      CreatedObject);
end;

procedure TdmBaaSUser.DeleteEmployee(AEmployeeId: String);
begin
  storageEmployeeDirectory.Storage.DeleteObject(TEmployeeMetaData.BackendType, AEmployeeId);
end;

procedure TdmBaaSUser.UpdateEmployee(AOriginalEmployee,
  AUpdatedEmployee: TEmployee);
var
  KnvyEmployeeObject: TBackendEntityValue;
  UpdatedObject: TBackendEntityValue;
begin
  KnvyEmployeeObject := FEmployeeBackendObjects.EntityValues[AOriginalEmployee];
  storageEmployeeDirectory.Storage.UpdateObject<TEmployee>(KnvyEmployeeObject, AUpdatedEmployee, UpdatedObject);
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
