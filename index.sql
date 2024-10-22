--35. Ineksid serveris
Select * From DimEmployee where BaseRate>50 and BaseRate<70

--indeksi loomine  veerule BaseRate 
CREATE Index IX_tblEmployee_BaseRate
ON DimEmployee (BaseRate ASC)
Execute sp_helptext DimEmployee

--kustutada indeksit
Drop Index DimEmployee.IX_tblEmployee_BaseRate

--36. Klastreeritud ja mitte-klastreeritud indeksid

-- rühmitatud indeks veerus Id.
-- SQL server ei luba tabeli kohta luua rohkem kui ühte rühmitatud indeksit.
Create Clustered Index IX_tblEmployee_Name
ON DimEmployee(FirstName)

-- kustutage praegune rühmitatud indeksi ID veerus
Drop index DimEmployee.PK_DimEmployee_EmployeeKey

--uue klastreeritud ühendindeksi loomine Gender ja BaseRate veeru põhjal
Create Clustered Index IX_tblEmployee_Gender_Salary
ON DimEmployee (Gender DESC, BaseRate ASC)

--  SQL-s mitte-klastreeritud indeksi loomine Name veeru järgi DimEmployee tabelis
Create NonClustered Index IX_DimEmployee_Name
ON DimEmployee(FirstName)

--37. Unikaalne ja mitte-unikaalne indeks

--Loome tabeli Employee
Create table tblEmployee
(
id int Primary Key,
FirstName nvarchar(50),
LastName nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50)
);

Execute sp_helpindex DimEmployee
Execute sp_helpindex tblEmployee

--Kui kustutada Unique Clustered Index-st, siis kirjutab meile viga
Drop index DimEmployee.PK_DimEmployee_EmployeeKey
Drop index tblEmployee.PK_DimEmplo_3213E83F49F15F99

-- unikaalset mitte-klastreeritud indeksit loomine FirstName ja LastName veeru põhjal.
Create Unique NonClustered Index UIX_DimEmployee_FirstName_LastName
ON tblEmployee(FirstName, LastName)

--  lisame koodiga unikaalse piirangu City veerule
ALTER TABLE tblEmployee 
ADD CONSTRAINT UQ_tblEmployee_City 
UNIQUE NONCLUSTERED (City)

--siis tekib nimekiri UNIQUE NONCLUSTERED indeks
EXECUTE SP_HELPCONSTRAINT DimEmployee
EXECUTE SP_HELPCONSTRAINT tblEmployee

--Kuitahan vahele jätta ainult viis rida ja lisada viis unikaalset, kasutab see valikut IGNORE_DUP_KEY
CREATE UNIQUE INDEX IX_tblEmployee_City
ON tblEmployee(City)
WITH IGNORE_DUP_KEY

--38.
-- Loomine klastrita indeks veeru BaseRate jaoks
Create NonClustered Index IX_tblEmployee_Salary
On DimEmployee (BaseRate Asc) 

--Järgnev SELECT päring saab kasu BaseRate veeru indeksist 
Select * From DimEmployee where BaseRate > 40 and BaseRate < 80

--Kui soovid uuendada või kustutada rida, siis SQL server peab esmalt leidma rea. indeksi abil tehakse seda kiiremini
Delete from DimEmployee where BaseRate = 25
Update DimEmployee Set BaseRate = 9000 where BaseRate = 7500

--Indeksid aitab päringuid
Select * from DimEmployee order by BaseRate
Select * from DimEmployee order by BaseRate Desc

--GROUP BY päringud saavad kasu indeksitest. 
Select BaseRate, COUNT(BaseRate) as Total
from DimEmployee
Group By BaseRate
