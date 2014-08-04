object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'VCL Kinvey '#54924#50896#44032#51077
  ClientHeight = 230
  ClientWidth = 360
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 35
    Width = 48
    Height = 13
    Caption = 'Username'
  end
  object Label2: TLabel
    Left = 8
    Top = 62
    Width = 48
    Height = 13
    Caption = #48708#48128#48264#54840
  end
  object Label3: TLabel
    Left = 8
    Top = 107
    Width = 60
    Height = 13
    Caption = #49324#50857#51088#51060#47492
  end
  object Label4: TLabel
    Left = 8
    Top = 134
    Width = 60
    Height = 13
    Caption = #51060#47700#51068#51452#49548
  end
  object edtUsername: TEdit
    Left = 80
    Top = 32
    Width = 257
    Height = 21
    TabOrder = 0
  end
  object edtPassword: TEdit
    Left = 80
    Top = 59
    Width = 257
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object edtFullname: TEdit
    Left = 80
    Top = 104
    Width = 257
    Height = 21
    TabOrder = 2
  end
  object edtEmail: TEdit
    Left = 80
    Top = 131
    Width = 257
    Height = 21
    TabOrder = 3
  end
  object Button1: TButton
    Left = 232
    Top = 158
    Width = 105
    Height = 51
    Caption = #54924#50896#44032#51077
    TabOrder = 4
    OnClick = Button1Click
  end
end
