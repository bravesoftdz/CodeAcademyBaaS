unit EmployeeTypes;

interface

type
  TEmployee = class(TObject)
  private
    FFullName : string;
    FPhone : string;
    FEmail : string;
    FId : string;
    FDepartment: string;
  public
    property Id : string read FId write FId;
    property FullName: string read FFullName write FFullName;
    property Department: string read FDepartment write FDepartment;
    property Phone: string read FPhone write FPhone;
    property Email: string read FEmail write FEmail;
end;

TEmployeeMetaData = record
  public
    const
      BackendType = 'Employees';
      FullNameColumn = 'fullname';
end;

implementation

end.
