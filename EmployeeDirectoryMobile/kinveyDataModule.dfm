object dmBaaSUser: TdmBaaSUser
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 442
  Width = 693
  object KinveyProvider1: TKinveyProvider
    ApiVersion = '3'
    AppKey = 'kid_PeJlaHOaeC'
    AppSecret = '0f6219bedafa4dd3a8edd175ec4c6dd9'
    MasterSecret = '3fd605b1ca3f4a71b883ed7fdc4e3515'
    Left = 96
    Top = 32
  end
  object BackendUsers1: TBackendUsers
    Provider = KinveyProvider1
    Left = 104
    Top = 128
  end
  object RESTClient1: TRESTClient
    Authenticator = HTTPBasicAuthenticator1
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    BaseURL = 'http://baas.kinvey.com'
    Params = <>
    HandleRedirects = True
    Left = 96
    Top = 248
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'appkey'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'username'
        Options = [poAutoCreated]
      end>
    Resource = 'rpc/{appkey}/{username}/user-password-reset-initiate'
    SynchronizedEvents = False
    Left = 96
    Top = 328
  end
  object HTTPBasicAuthenticator1: THTTPBasicAuthenticator
    Username = 'kid_PeJlaHOaeC'
    Password = '0f6219bedafa4dd3a8edd175ec4c6dd9'
    Left = 216
    Top = 328
  end
  object storageEmployeeDirectory: TBackendStorage
    Provider = KinveyProvider1
    Left = 336
    Top = 136
  end
  object qryEmployeeDirectory: TBackendQuery
    Provider = KinveyProvider1
    BackendClassName = 'Employees'
    BackendService = 'Storage'
    QueryLines.Strings = (
      'fields=email,fullName')
    Left = 336
    Top = 224
  end
end
