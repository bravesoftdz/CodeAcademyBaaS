unit VCLMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, REST.Backend.PushTypes,
  REST.Backend.MetaTypes, System.JSON, REST.Backend.KinveyServices,
  REST.OpenSSL, REST.Backend.KinveyProvider, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Backend.BindSource,
  REST.Backend.ServiceComponents, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    edtTitle: TLabeledEdit;
    edtMessage: TLabeledEdit;
    edtUsername: TLabeledEdit;
    CheckBox1: TCheckBox;
    Button1: TButton;
    BackendPush1: TBackendPush;
    KinveyProvider1: TKinveyProvider;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  Data: TPushData;
begin
  Data := TPushData.Create;
  try
    Data.Message := edtMessage.Text;
    Data.GCM.Title := edtTitle.Text;
    Data.GCM.Message := edtMessage.Text;

    if CheckBox1.Checked then
      Data.Extras.Add('username', edtUsername.Text);

    BackEndPush1.PushData(Data);
  finally
    Data.Free;
  end;
end;

end.
