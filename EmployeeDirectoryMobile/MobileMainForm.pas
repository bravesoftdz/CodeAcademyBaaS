unit MobileMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Edit, FMX.ListBox, FMX.StdCtrls, FMX.TabControl, System.Actions,
  FMX.ActnList;

type
  TfrmMobileMain = class(TForm)
    tabctrlMain: TTabControl;
    tabitmAccount: TTabItem;
    tabItmEmployee: TTabItem;
    ToolBar1: TToolBar;
    Label1: TLabel;
    btnLogout: TButton;
    ToolBar2: TToolBar;
    tabctrlLogin: TTabControl;
    tabitmAccountLogin: TTabItem;
    tabitmAccountRegister: TTabItem;
    ListBox1: TListBox;
    Label2: TLabel;
    btnLoginBack: TButton;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    edtLoginUsername: TEdit;
    edtLoginPassword: TEdit;
    ListBox2: TListBox;
    ListBoxItem5: TListBoxItem;
    edtRegisterUsername: TEdit;
    ListBoxItem6: TListBoxItem;
    edtRegisterPassword: TEdit;
    ListBoxItem7: TListBoxItem;
    ListBoxItem8: TListBoxItem;
    edtRegisterFullname: TEdit;
    edtRegisterEmail: TEdit;
    ListBoxItem9: TListBoxItem;
    btnRegisterExec: TButton;
    FlowLayout1: TFlowLayout;
    btnLoginGotoRegister: TButton;
    edtLoginExec: TButton;
    lblLoginForgotPassword: TLabel;
    ActionList1: TActionList;
    ChangeTabAction: TChangeTabAction;
    procedure FormCreate(Sender: TObject);
    procedure tabctrlLoginChange(Sender: TObject);
    procedure btnLoginGotoRegisterClick(Sender: TObject);
    procedure edtLoginExecClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure btnLoginBackClick(Sender: TObject);
    procedure btnRegisterExecClick(Sender: TObject);
    procedure lblLoginForgotPasswordClick(Sender: TObject);
  private
    { Private declarations }
    procedure GotoAccountTab;
    procedure GotoEmployeeTab;
    procedure GotoLoginTab;
    procedure GotoRegisterTab;
  public
    { Public declarations }
  end;

var
  frmMobileMain: TfrmMobileMain;

implementation

{$R *.fmx}

uses kinveyDataModule;

procedure TfrmMobileMain.btnLoginBackClick(Sender: TObject);
begin
  GotoLoginTab;
end;

procedure TfrmMobileMain.btnLoginGotoRegisterClick(Sender: TObject);
begin
  GotoRegisterTab;
end;

procedure TfrmMobileMain.btnRegisterExecClick(Sender: TObject);
begin

  dmBaaSUser.SignUp(
      edtRegisterUsername.Text, edtRegisterPassword.Text,
      edtRegisterFullname.Text, edtRegisterEmail.Text);

//  ShowMessage('회원가입이 완료되었습니다. 이메일을 확인해주세요.');
  GotoEmployeeTab;

  edtRegisterUsername.Text := '';
  edtRegisterPassword.Text := '';
  edtRegisterFullname.Text := '';
  edtRegisterEmail.Text := '';
end;

procedure TfrmMobileMain.btnLogoutClick(Sender: TObject);
begin
  dmBaaSUser.Logout;
  GotoAccountTab;
end;

procedure TfrmMobileMain.edtLoginExecClick(Sender: TObject);
begin
  if not dmBaaSUser.Login(edtLoginUsername.Text, edtLoginPassword.Text) then
  begin
    ShowMessage('아이디 또는 비밀번호가 맞지 않습니다.');
    Exit;
  End;

  GotoEmployeeTab;

  edtLoginUsername.Text := '';
  edtLoginPassword.Text := '';
end;

procedure TfrmMobileMain.FormCreate(Sender: TObject);
begin
  // 메인 탭컨트롤 초기화 설정
  tabctrlMain.ActiveTab := tabitmAccount;
  tabItmEmployee.Enabled := False;

  // 로그인탭의 탭컨트롤 초기화 설정
  tabctrlLogin.TabPosition := TTabPosition.None;
  tabctrlLogin.ActiveTab := tabitmAccountLogin;

  btnLoginBack.Visible := False;
end;

procedure TfrmMobileMain.GotoAccountTab;
begin
  ChangeTabAction.Tab := tabitmAccount;
  ChangeTabAction.ExecuteTarget(nil);
  tabitmAccount.Enabled := True;
  tabItmEmployee.Enabled := False;
end;

procedure TfrmMobileMain.GotoEmployeeTab;
begin
  ChangeTabAction.Tab := tabItmEmployee;
  ChangeTabAction.ExecuteTarget(nil);
  tabitmAccount.Enabled := False;
  tabItmEmployee.Enabled := True;
end;

procedure TfrmMobileMain.GotoLoginTab;
begin
  ChangeTabAction.Tab := tabitmAccountLogin;
  ChangeTabAction.ExecuteTarget(nil);
end;

procedure TfrmMobileMain.GotoRegisterTab;
begin
  ChangeTabAction.Tab := tabitmAccountRegister;
  ChangeTabAction.ExecuteTarget(nil);
end;

procedure TfrmMobileMain.lblLoginForgotPasswordClick(Sender: TObject);
begin
  if edtLoginUsername.Text = '' then
  begin
    ShowMessage('Username 항목을 입력해 주세요.');
    Exit;
  end;

  dmBaaSUser.ResetPassword(edtLoginUserName.Text);
  ShowMessage('비밀번호 초기화 요청했습니다. 회원가입 시 등록한 이메일을 확인해 주세요.');
end;

procedure TfrmMobileMain.tabctrlLoginChange(Sender: TObject);
begin
  btnLoginBack.Visible := (tabctrlLogin.ActiveTab = tabitmAccountRegister);
end;

end.
