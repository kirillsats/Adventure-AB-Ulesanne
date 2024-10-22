
--32. Mitme avaldisega tabeliväärtusega funktsioonid
--funktsioon e Inline Table Valued function (ILTVF) 

Create Function fn_ILTVF_GetEmployees() 
Returns Table 
AS
Return (SELECT EmployeeKey, FirstName, Cast(BirthDate as Date) AS DOB
FROM DimEmployee)
SELECT * FROM fn_ILTVF_GetEmployees();

--Mitme avaldisega tabeliväärtusega funktsioonid
CREATE Function fn_MSTVF_GetEmployees() 
Returns @Table Table (EmployeeKey int, FirstName nvarchar(20), DOB Date)
AS
BEGIN
INSERT INTO @Table
Select EmployeeKey, FirstName, CAST (BirthDate AS Date)
FROM DimEmployee
Return 
END;

SELECT * FROM fn_ILTVF_GetEmployees();
SELECT * FROM fn_MSTVF_GetEmployees();

--Uuendame allasuvat tabelit ja kasutame selleks ILTVF funktsiooni.
Update fn_ILTVF_GetEmployees() set FirstName= 'Sam1' WHERE EmployeeKey=1;

--33. Funktsiooniga seotud tähtsad kontseptsioonid

--Skaleeritav funktsioon ilma krüpteerimata
Create Function fn_GetEmployeeNameByld(@EmployeeKey int) 
Returns nvarchar(20)
AS
BEGIN 
Return (Select FirstName from DimEmployee Where EmployeeKey = @EmployeeKey)
END;

--Funktsiooni sisu vaatamise
sp_helptext fn_GetEmployeeNameByld

--muudame funktsiooni ja krüpteerime selle ära
Alter Function fn_GetEmployeeNameByld (@EmployeeKey int)
Returns nvarchar(20)
With Encryption
AS
BEGIN
Return (Select FirstName from DimEmployee Where EmployeeKey = @EmployeeKey)
END;
sp_helptext fn_GetEmployeeNameByld

--Loome funktsiooni WITH SCHEMABINDING valikuga
Alter Function fn_GetEmployeeNameByld (@EmployeeKey int)
Returns nvarchar(20)
With SchemaBinding
AS
BEGIN 
RETURN (SELECT FirstName from dbo.DimEmployee WHERE EmployeeKey = @EmployeeKey)
END;

--#PersonDetails on local temporary tabel koos Id ja Name veeruga.
Create Table #PersonDetails(Id int, Name nvarchar(20))
insert into #PersonDetails values(1,'Mike');
insert into #PersonDetails values(2,'John');
insert into #PersonDetails values(3,'Todd');
select * from #PersonDetails;

-- luuakse TEMPDB alla. Päri sysobjects käsuga TEMPDB alt.  kasutama LIKE operaatorit.
select name from tempdb..sysobjects
where name like '#PersonDetails%'

DROP TABLE #PersonDetails
-- luuakse ajutine tabel #PersonsDetails ja edastab andmeid ja lõhub ajutise tabeli automaatselt peale käsu lõpule jõudmist.
Create Procedure spCreateLocalTempTable
AS
BEGIN
create table #PersonDetails(Id int, Name nvarchar(20))
insert into #PersonDetails values(1,'Mike');
insert into #PersonDetails values(2,'John');
insert into #PersonDetails values(3,'Todd');
select * from #PersonDetails
END;

--Selleks tuleb tuleb ajuitse tabeli ette panna kaks # märki. EmployeeDetails table on globaalne ajutine tabel.
CREATE TABLE ##EmployeeDetails (Id int, Name nvarchar(20))



