unit MobileMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Edit, FMX.ListBox, FMX.StdCtrls, FMX.TabControl, System.Actions,
  FMX.ActnList, FMX.ListView.Types, FMX.ListView,
  System.Generics.Collections, EmployeeTypes, IPPeerClient,
  REST.Backend.PushTypes, System.JSON, REST.Backend.KinveyPushDevice,
  System.PushNotification, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Data.Bind.Components, FMX.Memo, Data.Bind.ObjectScope,
  REST.Backend.BindSource, REST.Backend.PushDevice, FMX.ScrollBox,
  FMX.Controls.Presentation;

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
    btnEmployeeBack: TButton;
    btnEmployeeRefresh: TButton;
    btnEmployeeAdd: TButton;
    tabctrlEmplyees: TTabControl;
    tabitemEmployeeList: TTabItem;
    tabItemEmployeeDetail: TTabItem;
    tabitemEmployeeNew: TTabItem;
    lvEmployees: TListView;
    lbEmpInfo: TListBox;
    flNewEmployeeActions: TFlowLayout;
    btnAddNewEmployee: TButton;
    btnCancelNewEmployee: TButton;
    flUpdate: TFlowLayout;
    btnUpdate: TButton;
    btnCancelUpdate: TButton;
    flEditEmployee: TFlowLayout;
    btnDelete: TButton;
    btnEdit: TButton;
    lbiFullName: TListBoxItem;
    lblFullName: TLabel;
    lbiEmail: TListBoxItem;
    edtEmail: TEdit;
    lblEmail: TLabel;
    lbiPhoneNumber: TListBoxItem;
    edtPhoneNumber: TEdit;
    lblPhoneNumber: TLabel;
    lbiDept: TListBoxItem;
    edtDept: TEdit;
    lblDept: TLabel;
    lbiID: TListBoxItem;
    lblID: TLabel;
    lbNewEmployee: TListBox;
    ListBoxItem10: TListBoxItem;
    edtNewFullname: TEdit;
    ListBoxItem11: TListBoxItem;
    edtNewEmail: TEdit;
    ListBoxItem12: TListBoxItem;
    edtNewPhone: TEdit;
    ListBoxItem13: TListBoxItem;
    edtNewDept: TEdit;
    edtFullName: TEdit;
    tabitmPushEvent: TTabItem;
    PushEvents1: TPushEvents;
    Memo1: TMemo;
    BindingsList1: TBindingsList;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure tabctrlLoginChange(Sender: TObject);
    procedure btnLoginGotoRegisterClick(Sender: TObject);
    procedure edtLoginExecClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure btnLoginBackClick(Sender: TObject);
    procedure btnRegisterExecClick(Sender: TObject);
    procedure lblLoginForgotPasswordClick(Sender: TObject);
    procedure tabctrlEmplyeesChange(Sender: TObject);
    procedure lvEmployeesItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnEmployeeBackClick(Sender: TObject);
    procedure btnEmployeeAddClick(Sender: TObject);
    procedure btnEmployeeRefreshClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnCancelUpdateClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure flNewEmployeeActionsClick(Sender: TObject);
    procedure btnCancelNewEmployeeClick(Sender: TObject);
    procedure btnAddNewEmployeeClick(Sender: TObject);
    procedure PushEvents1DeviceRegistered(Sender: TObject);
    procedure PushEvents1DeviceTokenReceived(Sender: TObject);
    procedure PushEvents1DeviceTokenRequestFailed(Sender: TObject;
      const AErrorMessage: string);
    procedure PushEvents1PushReceived(Sender: TObject; const AData: TPushData);
    procedure CheckBox1Change(Sender: TObject);
  private
    { Private declarations }
    // 3회차 추가
    EmployeeList: TList<TEmployee>;
    CurrentEmployee: TEmployee;

    procedure GotoAccountTab;
    procedure GotoEmployeeTab;
    procedure GotoLoginTab;
    procedure GotoRegisterTab;

    // 3회차 추가
    procedure GotoEmployeeList;
    procedure GotoEmployeeDetail;
    procedure GotoEmployeeNew;

    procedure RefreshEmployees;
    procedure ToggleEditMode(AEditable : Boolean);
  public
    { Public declarations }
  end;

var
  frmMobileMain: TfrmMobileMain;

implementation

{$R *.fmx}

uses kinveyDataModule;
procedure TfrmMobileMain.FormCreate(Sender: TObject);
begin
  // 메인 탭컨트롤 초기화 설정
  tabctrlMain.ActiveTab := tabitmAccount;
  tabItmEmployee.Enabled := False;

  // 로그인탭의 탭컨트롤 초기화 설정
  tabctrlLogin.TabPosition := TTabPosition.None;
  tabctrlLogin.ActiveTab := tabitmAccountLogin;

  btnLoginBack.Visible := False;

  // 사원정보탭의 탭컨트롤 초기화 설정
  tabctrlEmplyees.TabPosition := TTabPosition.None;
  tabctrlEmplyees.ActiveTab := tabitemEmployeeList;
end;

procedure TfrmMobileMain.btnAddNewEmployeeClick(Sender: TObject);
begin
  dmBaaSUser.InsertEmployee(edtNewFullName.Text, edtNewPhone.Text, edtNewEmail.Text, edtNewDept.Text);
  edtNewFullname.Text := '';
  edtNewEmail.Text := '';
  edtNewPhone.Text := '';
  edtNewDept.Text := '';

  ShowMessage(edtNewFullName.Text + ' 추가');
  RefreshEmployees;
  GotoEmployeeList;
end;

procedure TfrmMobileMain.btnCancelNewEmployeeClick(Sender: TObject);
begin
  GotoEmployeeList;
end;

procedure TfrmMobileMain.btnCancelUpdateClick(Sender: TObject);
begin
  ToggleEditMode(False);
end;

procedure TfrmMobileMain.btnDeleteClick(Sender: TObject);
begin
  dmBaaSUser.DeleteEmployee(lblID.Text);
  RefreshEmployees;
  GotoEmployeeList;
end;

procedure TfrmMobileMain.btnEditClick(Sender: TObject);
begin
  ToggleEditMode(True);
end;

procedure TfrmMobileMain.btnEmployeeAddClick(Sender: TObject);
begin
  GotoEmployeeNew;
end;

procedure TfrmMobileMain.btnEmployeeBackClick(Sender: TObject);
begin
  GotoEmployeeList;
end;

procedure TfrmMobileMain.btnEmployeeRefreshClick(Sender: TObject);
begin
  RefreshEmployees;
end;

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

procedure TfrmMobileMain.btnUpdateClick(Sender: TObject);
var
  UpdatedEmployee : TEmployee;
begin
  UpdatedEmployee := TEmployee.Create;
  UpdatedEmployee.FullName := edtFullName.Text;
  UpdatedEmployee.Phone := edtPhoneNumber.Text;
  UpdatedEmployee.Email := edtEmail.Text;
  UpdatedEmployee.Department := edtDept.Text;
  dmBaaSUser.UpdateEmployee(CurrentEmployee, UpdatedEmployee);

  flUpdate.Visible := false;
  RefreshEmployees;
  GotoEmployeeList;
  ToggleEditMode(False);
end;

procedure TfrmMobileMain.CheckBox1Change(Sender: TObject);
begin
  PushEvents1.Active := TCheckBox(Sender).IsChecked;
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

procedure TfrmMobileMain.flNewEmployeeActionsClick(Sender: TObject);
begin
  GotoEmployeeList;
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

  tabctrlEmplyees.ActiveTab := tabitemEmployeeList;
  tabctrlEmplyeesChange(nil);
  RefreshEmployees;
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

procedure TfrmMobileMain.GotoEmployeeList;
begin
  ChangeTabAction.Tab := tabitemEmployeeList;
  ChangeTabAction.ExecuteTarget(nil);
end;

procedure TfrmMobileMain.GotoEmployeeDetail;
begin
  ChangeTabAction.Tab := tabItemEmployeeDetail;
  ChangeTabAction.ExecuteTarget(nil);
end;

procedure TfrmMobileMain.GotoEmployeeNew;
begin
  ChangeTabAction.Tab := tabitemEmployeeNew;
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

procedure TfrmMobileMain.lvEmployeesItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  CurrentEmployee := EmployeeList.Items[AItem.Index];

  edtFullName.Text    := CurrentEmployee.FullName;
  lblFullName.Text    := CurrentEmployee.FullName;
  edtPhoneNumber.Text := CurrentEmployee.Phone;
  lblPhoneNumber.Text := CurrentEmployee.Phone;
  edtEmail.Text       := CurrentEmployee.Email;
  lblEmail.Text       := CurrentEmployee.Email;
  edtDept.Text        := CurrentEmployee.Department;
  lblDept.Text        := CurrentEmployee.Department;
  lblId.Text          := CurrentEmployee.Id;

  GotoEmployeeDetail;
  ToggleEditMode(False);
end;

procedure TfrmMobileMain.tabctrlLoginChange(Sender: TObject);
begin
  btnLoginBack.Visible := (tabctrlLogin.ActiveTab = tabitmAccountRegister);
end;

procedure TfrmMobileMain.tabctrlEmplyeesChange(Sender: TObject);
begin
  btnEmployeeBack.Visible     := (tabctrlEmplyees.ActiveTab = tabItemEmployeeDetail);
  btnEmployeeRefresh.Visible  := (tabctrlEmplyees.ActiveTab = tabItemEmployeeList);
  btnEmployeeAdd.Visible      := (tabctrlEmplyees.ActiveTab = tabItemEmployeeList);
end;

procedure TfrmMobileMain.RefreshEmployees;
var
  I : Integer;
  Item: TListViewItem;
begin
  EmployeeList := dmBaaSUser.GetEmployees;
  lvEmployees.Items.Clear;
  for I := 0 to EmployeeList.Count - 1 do
  begin
    Item := lvEmployees.Items.Add;
    Item.Text := EmployeeList.Items[I].FullName;
  end;
end;

procedure TfrmMobileMain.ToggleEditMode(AEditable: Boolean);
begin
  lblFullName.Visible     := not AEditable;
  lblPhoneNumber.Visible  := not AEditable;
  lblEmail.Visible        := not AEditable;
  lblDept.Visible         := not AEditable;

  edtFullName.Visible     := AEditable;
  edtPhoneNumber.Visible  := AEditable;
  edtEmail.Visible        := AEditable;
  edtDept.Visible         := AEditable;

  flUpdate.Visible := AEditable;

  btnEdit.Enabled := not AEditable;
  btnDelete.Enabled := not AEditable;
  btnEmployeeBack.Enabled := not AEditable;
  btnLogout.Enabled := not AEditable;
end;

procedure TfrmMobileMain.PushEvents1DeviceRegistered(Sender: TObject);
begin
  Memo1.Lines.Add('장치 등록!');
  Memo1.Lines.Add('');
end;

procedure TfrmMobileMain.PushEvents1DeviceTokenReceived(Sender: TObject);
begin
  Memo1.Lines.Add('장치 토큰 수신!');
  Memo1.Lines.Add('');
end;

procedure TfrmMobileMain.PushEvents1DeviceTokenRequestFailed(Sender: TObject;
  const AErrorMessage: string);
begin
  Memo1.Lines.Add('장치 토큰 수신 실패!');
  Memo1.Lines.Add(AErrorMessage);
  Memo1.Lines.Add('');
end;

procedure TfrmMobileMain.PushEvents1PushReceived(Sender: TObject;
  const AData: TPushData);
begin
  Memo1.Lines.Add('푸시 데이터 수신');
  Memo1.Lines.Add(AData.Message);
  Memo1.Lines.Add('');
end;


end.