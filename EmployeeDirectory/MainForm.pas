unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    edtUsername: TEdit;
    edtPassword: TEdit;
    edtFullname: TEdit;
    edtEmail: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses kinveyDataModule;

procedure TForm1.Button1Click(Sender: TObject);
begin
  DataModule1.SignUp(edtUsername.Text, edtPassword.Text, edtFullname.Text, edtEmail.Text);
  ShowMessage('회원가입이 완료되었습니다.');
end;

end.
