--39. View SQL serveris
--peaksime ühendama kaks tabelit omavahel
SELECT EmployeeKey, FirstName, BaseRate, Gender, DepartmentName
from DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName

--loome view
Create View vWEmployeesByDepartment
AS
SELECT EmployeeKey, FirstName, BaseRate, Gender, DepartmentName
from DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName
Select * FROM vWEmployeesByDepartment

--View, mis tagastab ainult IT osakonna töötajad
Create View vWITDepartment_Employees
AS
SELECT EmployeeKey, FirstName, BaseRate, Gender, DepartmentName
from DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName
WHERE DimDepartmentGroup.DepartmentGroupName = 'IT'

--View, kus ei ole BaseRate veergu
Create View vWEmployeesNonConfidentialData
AS
SELECT EmployeeKey, FirstName, BaseRate, Gender, DepartmentName
from DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName

--View, mis tagastab summeeritud andmed töötajate koondarvest.
Create View vWEmployeesCountByDepartment
AS
SELECT DepartmentName, COUNT(EmployeeKey) AS TotalEmployees
from DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName
Group By DepartmentName

sp_helptext vWEmployeesByDepartment
sp_helptext vWITDepartment_Employees
sp_helptext vWEmployeesNonConfidentialData
sp_helptext vWEmployeesCountByDepartment

-- 40. View uuendused
-- Loome View, mis tagastab peaaegu kõik veerud
Create view vWEmployeesDataExceptSalary
AS
SELECT EmployeeKey, FirstName, Gender, DepartmentName
From DimEmployee
Select * from vWEmployeesDataExceptSalary

-- Järgnev päring uuendab Name veerus olevat nime Mike Mikey peale
Update vWEmployeesDataExceptSalary
Set FirstName = 'Mikey' Where EmployeeKey = 2

-- Sisestada ja kustutada ridu baastabelis ning kasutada view-d
Delete from vWEmployeesDataExceptSalary where EmployeeKey = 2
Insert into vWEmployeesDataExceptSalary values(2, 'Mikey', 'Male', 'Marketing')

-- Loome kahte tabelit ühendava view
Create view vWEmployeesDatailsByDepartment
AS
SELECT EmployeeKey, FirstName, Gender, DepartmentName
From DimEmployee
join DimDepartmentGroup
on DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName
SELECT * FROM vWEmployeesDatailsByDepartment

-- Uuendame John osakonda HR pealt IT peale
Update vWEmployeesDatailsByDepartment
set DepartmentName = 'IT' where FirstName = 'Mark'
