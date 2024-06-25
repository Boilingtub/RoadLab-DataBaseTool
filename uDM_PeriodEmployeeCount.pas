unit uDM_PeriodEmployeeCount;

interface

uses
  SysUtils, forms , messages ,Dialogs, Classes , DB , ADODB , SQLExpr;
//const CONSTR = 'Provider=SQLOLEDB.1;Password=P@ssw0rd;Persist Security Info=True;User ID=sa;Initial Catalog=LABS NEW;Data Source=DESKTOP-1FECIJH';


type
  TDM_PeriodEmplyeeCount = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);



 const
     SQLDefaultQuery =
      'select cCode, cDescription,cYearDescription,dYearStartDate,dPeriodDate,EmplyeeCount from _etblperiodEmployeeCount ' +
    	'join _etblPeriod on FiscalPeriod = idPeriod ' +
	    'join _etblPeriodYear on FiscalYear = idYear ' +
      'join _etblGLSegment on BranchCode = idSegment ' +
      //'where cCode = ''43''' +
      //'where iSegmentNo = 1 ' +
      //'and idYear = 7 ' +
      //'and cCode = ''00''' +
      'order by FiscalYear, FiscalPeriod, BranchCode ';


  private

  public
    DM_Connection : TADOConnection;
    DataSource_Query_Join , DataSource_Table_etlbPeriod : TDataSource;
    DMtbl_etblPeriod , DMtbl_etblPeriodYear ,DMtbl_etblGLSegment , DMtbl_etblperiodEmployeeCount : TADOTable;
    DMQuery_Join : TADOQuery;

  end;                                                                                                                                                                //   C:\SQL\Data\LABS NEW.mdf


var
  DM_PeriodEmplyeeCount : TDM_PeriodEmplyeeCount;


implementation
 uses
 uFRM_PeridEmployeeCount;
{$R *.dfm}

procedure TDM_PeriodEmplyeeCount.DataModuleCreate(Sender: TObject);
var
tf : TextFile;
ConStr : String;
begin
   AssignFile(tf , 'Config.txt');
   if FileExists('Config.txt') then
   begin
   Reset(tf);
   Readln(tf , ConStr);
   end
   else
   begin
     Rewrite(tf);
     Showmessage('The Config.txt File Does not Exist , Close the program and add a Connection String');

   end;


   DM_Connection := TADOConnection.Create(DM_PeriodEmplyeeCount);
   try
   DM_Connection.ConnectionString := ConStr ;
   except
   Showmessage('Config.txt Does not contain a valid Connection String');
   end;
   DM_Connection.LoginPrompt := false;
   DM_Connection.Open;


   DMtbl_etblPeriod := TADOTable.Create(DM_PeriodEmplyeeCount);
   DMtbl_etblPeriod.Connection := DM_Connection;
   DMtbl_etblPeriod.TableName := '_etblPeriod';
   DMtbl_etblPeriod.Open;






   DMtbl_etblPeriodYear := TADOTable.Create(DM_PeriodEmplyeeCount);
   DMtbl_etblPeriodYear.Connection := DM_Connection;
   DMtbl_etblPeriodYear.TableName := '_etblPeriodYear';
   DMtbl_etblPeriodYear.Open;





   DMtbl_etblGLSegment := TADOTable.Create(DM_PeriodEmplyeeCount);
   DMtbl_etblGLSegment.Connection := DM_Connection;
   DMtbl_etblGLSegment.TableName := '_etblGLSegment';
   DMtbl_etblGLSegment.Open;





   DMtbl_etblperiodEmployeeCount := TADOTable.Create(DM_PeriodEmplyeeCount);
   DMtbl_etblperiodEmployeeCount.Connection := DM_Connection;
   DMtbl_etblperiodEmployeeCount.TableName := '_etblperiodEmployeeCount';
   DMtbl_etblperiodEmployeeCount.Open;



   DMQuery_Join := TADOQuery.Create(DM_PeriodEmplyeeCount);
   DMQuery_Join.Connection :=  DM_Connection;

   DataSource_Query_Join := TDataSource.Create(DM_PeriodEmplyeeCount);
   DataSource_Query_Join.DataSet := DMQuery_Join;



end;

end.
