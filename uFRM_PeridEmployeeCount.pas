unit uFRM_PeridEmployeeCount;

interface

uses
  Windows, Messages, SysUtils ,StrUtils , Variants, Classes, Graphics, Controls, Forms,
  Dialogs , Menus , DB, Grids, DBGrids , uDM_PeriodEmployeeCount, StdCtrls, TeCanvas,
  ExtCtrls, pngimage;

type
  TfrmPeriodEmployeeCount = class(TForm)
    dbgDisp: TDBGrid;
    btnSave: TButton;
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    procedure Startup(Sender: TObject);
    procedure CreateFilterComboBoxes(Sender : Tobject);
    procedure UpdateQueryInputBoxes(Sender : Tobject);
    procedure btnSaveClick(Sender: TObject);
    procedure Queryselect_etblPeriodEmplyeeCount(Sender:TObject);
    procedure QueryJoinTabels(Sender : Tobject);
    procedure ExecQuery(sQuery : String);
    procedure dbgSetColumWidth();

  private
   cdComboBoxArr : array[0..5] of TComboBox;
   bTable : byte;
  public

  end;

var
  frmPeriodEmployeeCount: TfrmPeriodEmployeeCount;

implementation

{$R *.dfm}



procedure TfrmPeriodEmployeeCount.Startup(Sender: TObject);
begin
  bTable := 255;
  CreateFilterComboBoxes(self);
  QueryJoinTabels(self);
end;





procedure TfrmPeriodEmployeeCount.QueryJoinTabels(Sender:TObject);
var
sQuery : string;
sicount : shortint;
begin
   sQuery := 'select cCode, cDescription,cYearDescription,dYearStartDate,dPeriodDate,EmployeeCount from _etblperiodEmployeeCount ' +
             'join _etblPeriod on FiscalPeriod = idPeriod ' +
	           'join _etblPeriodYear on FiscalYear = idYear ' +
             'join _etblGLSegment on BranchCode = idSegment ' +
             'where idPeriodEmployeeCount >= 1 ';

  if btable = 0 then
  for sicount := 0 to length(cdComboBoxArr)-1 do
     begin
      if Assigned(cdComboBoxArr[sicount]) then
        begin
         if (cdComboBoxArr[sicount].ItemIndex > 0) AND (cdComboBoxArr[sicount].Items[cdComboBoxArr[sicount].ItemIndex] <> '') then
            case sicount of
               0,5 : sQuery := sQuery + 'And ' + Copy(cdComboBoxArr[sicount].name,3,length(cdComboBoxArr[sicount].name)) + ' = ' + cdComboBoxArr[sicount].Items[cdComboBoxArr[sicount].ItemIndex];
               1,2,3,4 : sQuery := sQuery + 'And ' + Copy(cdComboBoxArr[sicount].name,3,length(cdComboBoxArr[sicount].name)) + ' = ' + ''''+ cdComboBoxArr[sicount].Items[cdComboBoxArr[sicount].ItemIndex] +'''';
            end;
         end;
      end;

  sQUery := sQUery + ' order by FiscalYear, FiscalPeriod, BranchCode ';


  ExecQuery(sQuery);

  if bTable <> 0 then
   begin
  bTable := 0;
  //ProcessingImgShow();
  CreateFilterComboBoxes(self);
   end;

  UpdateQUeryInputBoxes(self);
end;







procedure TfrmPeriodEmployeeCount.Queryselect_etblPeriodEmplyeeCount(Sender:TObject);
var
sQuery : string;
sicount : shortint;
begin
  sQuery  := 'select * from _etblperiodEmployeeCount ' +
             'where idPeriodEmployeeCount >= 1 ' ;

  if btable = 1 then
  for sicount := 0 to length(cdComboBoxArr)-1 do
   begin
     if Assigned(cdComboBoxArr[sicount]) then
        begin
          if (cdComboBoxArr[sicount].ItemIndex > 0) AND (cdComboBoxArr[sicount].Items[cdComboBoxArr[sicount].ItemIndex] <> '') then
             case sicount of
               0,5 : sQuery := sQuery + 'And ' + Copy(cdComboBoxArr[sicount].name,3,length(cdComboBoxArr[sicount].name)) + ' = ' + cdComboBoxArr[sicount].Items[cdComboBoxArr[sicount].ItemIndex];
               1,2,3,4 : sQuery := sQuery + 'And ' + Copy(cdComboBoxArr[sicount].name,3,length(cdComboBoxArr[sicount].name)) + ' = ' + ''''+ cdComboBoxArr[sicount].Items[cdComboBoxArr[sicount].ItemIndex] +'''';
             end;
        end;
   end;

  if bTable <> 1 then
   begin
  bTable := 1;
  ExecQuery(sQuery);
  //ProcessingImgShow();
  CreateFilterComboBoxes(self);
   end;
  ExecQuery(sQuery);
  UpdateQUeryInputBoxes(self);
end;



procedure TfrmPeriodEmployeeCount.dbgSetColumWidth();
begin
   if bTable = 0 then
   begin
  dbgDisp.Columns[0].Width := 60;
  dbgDisp.Columns[1].Width := 200;
  dbgDisp.Columns[2].Width := 90;
  dbgDisp.Columns[3].Width := 85;
  dbgDisp.Columns[4].Width := 85;
  dbgDisp.Columns[5].Width := 85;
   end;
  if bTable = 1 then
   begin
  dbgDisp.Columns[0].Width := 120;
  dbgDisp.Columns[1].Width := 70;
  dbgDisp.Columns[2].Width := 60;
  dbgDisp.Columns[3].Width := 80;
  dbgDisp.Columns[4].Width := 85;
   end;
  dbgDisp.SetFocus;
end;



procedure TfrmPeriodEmployeeCount.btnSaveClick(Sender: TObject);
begin
   DM_PeriodEmplyeeCount.DMtbl_etblperiodEmployeeCount.Edit;
   DM_PeriodEmplyeeCount.DMtbl_etblperiodEmployeeCount.Post;
   dbgDisp.DataSource.DataSet.Edit;
   dbgDisp.DataSource.DataSet.Post;
   showmessage('Changes Saved');
end;





procedure TfrmPeriodEmployeeCount.CreateFilterComboBoxes(Sender : Tobject);
var
sicount : shortint;
begin
  for sicount := 0 to length(cdComboBoxArr) - 1 do
  begin

    if Assigned(cdComboBoxArr[sicount]) then
     begin
        FreeAndNil(cdComboBoxArr[sicount]);
     end;
  end;


  dbgDisp.DataSource := DM_PeriodEmplyeeCount.DataSource_Query_Join;

  dbgSetColumWidth();


  //--------COMBOBOXES---------------
  for sicount := 0 to dbgDisp.Columns.Count-1 do
  begin
  cdComboBoxArr[sicount] := TComboBox.Create(frmPeriodEmployeeCount);
  with cdComboBoxArr[sicount] do
  begin
   name := 'cb' + dbgDisp.Columns[sicount].FieldName;
   parent := frmPeriodEmployeeCount;
   Text := 'Filter';
   Height := 21;
   Top := dbgDisp.Top - 23;
   width := dbgDisp.Columns[sicount].Width-1;
   if sicount = 0 then
   LEft := dbgDisp.Left + 13
   else
   LEft := cdComboBoxArr[sicount-1].LEft + cdComboBoxArr[sicount-1].Width +2 ;

   Items.Add('No Filter');
   if bTable = 0 then
   OnChange :=  QueryJoinTabels;
   if bTable = 1 then
   OnChange := Queryselect_etblPeriodEmplyeeCount;
  end;
  end;



  dbgDISP.Width := 37;
  for sicount := 0 to dbgDisp.DataSource.DataSet.Fields.Count - 1 do
  dbgDISP.Width :=  dbgDISP.Width + dbgDISP.Columns[sicount].Width;
  if dbgDISP.Width > 1000 then
  dbgDISP.Width := 1000;
  frmPeriodEmployeeCount.Width := dbgDISP.Width+120;
  if frmPeriodEmployeeCount.Width < 455 then
  frmPeriodEmployeeCount.Width := 455;



  UpdateQueryInputBoxes(Self);

end;



procedure TfrmPeriodEmployeeCount.UpdateQueryInputBoxes(Sender : Tobject);
var
icount : integer;
begin
 dbgDisp.DataSource := nil;
  //cdComboBoxArr[icount].Items.Clear;
   for icount := 0 to DM_PeriodEmplyeeCount.DMQuery_Join.Fields.Count-1 do
  begin
      DM_PeriodEmplyeeCount.DMQuery_Join.First;
    while NOT DM_PeriodEmplyeeCount.DMQuery_Join.EOF do
       begin
         if cdComboBoxArr[icount].Items.IndexOf (   DM_PeriodEmplyeeCount.DMQuery_Join.Fields[icount].AsString  )  <= -1  then
          begin
            cdComboBoxArr[icount].Items.Add( DM_PeriodEmplyeeCount.DMQuery_Join.Fields[icount].AsString );
          end;
           DM_PeriodEmplyeeCount.DMQuery_Join.Next ;
       end;
  end;
  dbgDisp.DataSource := DM_PeriodEmplyeeCount.DataSource_Query_Join;
  dbgSetColumWidth();
end;





procedure TfrmPeriodEmployeeCount.ExecQuery(sQuery : String);
begin

  try
  DM_PeriodEmplyeeCount.DMQuery_Join.SQL.Text := sQuery;
  DM_PeriodEmplyeeCount.DMQuery_Join.Open;
  except
  DM_PeriodEmplyeeCount.DMQuery_Join.SQL.Text := DM_PeriodEmplyeeCount.SQLDefaultQuery;
  DM_PeriodEmplyeeCount.DMQuery_Join.Open;
  end;
  dbgSetColumWidth();

end;

end.

