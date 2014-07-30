object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 348
  Width = 347
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
end
