
CREATE TABLE _etblPeriodEmployeeCount (
    idPeriodEmployeeCount int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    BranchCode int NOT NULL,
    FiscalYear int NOT NULL,
    FiscalPeriod int NOT NULL,
	EmployeeCount int
	);

--drop table  _etblPeriodEmployeeCount

SET IDENTITY_INSERT [_etblPeriodEmployeeCount] Off;
insert into _etblPeriodEmployeeCount (FiscalYear,FiscalPeriod,BranchCode)
		select iyearid,idperiod,idsegment from _etblperiod
			join _etblGLSegment on _etblGLSegment_iBranchID = bPeriodProcessed
where iSegmentNo = 1

select * from _etblperiodEmployeeCount
select * from _etblPeriod
Select * from _etblPeriodYear
Select * from _etblGLSegment where iSegmentNo = 1

select cCode, cDescription,cYearDescription,dYearStartDate,dPeriodDate,EmployeeCount from _etblperiodEmployeeCount
	join _etblPeriod on FiscalPeriod = idPeriod
	join _etblPeriodYear on FiscalYear = idYear
	join _etblGLSegment on BranchCode = idSegment 
--where idPeriodEmployeeCount >= 1
 --and idYear = 7
 --and cCode = '00'
order by FiscalYear, FiscalPeriod, BranchCode
	



select concat(branchcode,'-',fiscalyear,'-',FiscalPeriod) from _etblPeriodEmployeeCount
group by concat(branchcode,'-',fiscalyear,'-',FiscalPeriod)
having count(concat(branchcode,'-',fiscalyear,'-',FiscalPeriod)) > 1	

BEGIN
   IF NOT EXISTS (SELECT * FROM EmailsRecebidos 
                   WHERE De = @_DE
                   AND Assunto = @_ASSUNTO
                   AND Data = @_DATA)
   BEGIN
       INSERT INTO EmailsRecebidos (De, Assunto, Data)
       VALUES (@_DE, @_ASSUNTO, @_DATA)
   END
END