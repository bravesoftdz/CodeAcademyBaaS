object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 241
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object edtTitle: TLabeledEdit
    Left = 24
    Top = 48
    Width = 361
    Height = 21
    EditLabel.Width = 24
    EditLabel.Height = 13
    EditLabel.Caption = #51228#47785
    TabOrder = 0
    Text = #54392#49884#47700#49884#51648' '#51228#47785#51077#45768#45796'.'
  end
  object edtMessage: TLabeledEdit
    Left = 24
    Top = 96
    Width = 361
    Height = 21
    EditLabel.Width = 36
    EditLabel.Height = 13
    EditLabel.Caption = #47700#49884#51648
    TabOrder = 1
    Text = #50504#45397#54616#49464#50836'. VCL '#50640#49436' '#48372#45236#45716' '#47700#49884#51648#51077#45768#45796'!!!'
  end
  object edtUsername: TLabeledEdit
    Left = 24
    Top = 144
    Width = 121
    Height = 21
    EditLabel.Width = 80
    EditLabel.Height = 13
    EditLabel.Caption = #45824#49345'(Username)'
    TabOrder = 2
    Text = 'testuser'
  end
  object CheckBox1: TCheckBox
    Left = 160
    Top = 146
    Width = 97
    Height = 17
    Caption = #45824#49345#51648#51221
    TabOrder = 3
  end
  object Button1: TButton
    Left = 248
    Top = 176
    Width = 137
    Height = 49
    Caption = #47700#49884#51648' '#51204#49569
    TabOrder = 4
    OnClick = Button1Click
  end
  object BackendPush1: TBackendPush
    Provider = KinveyProvider1
    Extras = <>
    Left = 312
    Top = 120
  end
  object KinveyProvider1: TKinveyProvider
    ApiVersion = '3'
    AppKey = 'kid_PeJlaHOaeC'
    AppSecret = '0f6219bedafa4dd3a8edd175ec4c6dd9'
    MasterSecret = '3fd605b1ca3f4a71b883ed7fdc4e3515'
    UserName = 'testuser'
    Password = 'test1234'
    AndroidPush.GCMAppID = '518526292750'
    PushEndpoint = 'pushMessageTargetUser'
    Left = 312
    Top = 24
  end
end
