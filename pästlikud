-- 92. DDL-i päästik SQL Serveris

-- DDL-i pästikud saab luua konkreetse andmebaasi või serveri tasemel
Create trigger trMyFirstTrigger
ON database
FOR CREATE_TABLE
AS
BEGIN
  Print 'New table created'
END
Create Table Test (Id int)

-- -- Päästik käivitub tabeli loomisel, muutmisel või kustutamisel
Alter trigger trMyFirstTrigger
ON database
FOR CREATE_TABLE,ALTER_TABLE,DROP_TABLE
AS
BEGIN
  Print 'A table has just been created, modified or deleted'
END

ALTER TABLE Test
ADD test varchar(10)

-- Kuidas keelata kasutajatel tabelite loomine, muutmine või kustutamine 
Alter trigger trMyFirstTrigger
ON Database
FOR CREATE_TABLE,ALTER_TABLE,DROP_TABLE
AS
BEGIN
Rollback
  Print 'You cannot create, alter or drop a table'
END

DROP TABLE Test
  
-- Kui tahate lubada pästlikud
DISABLE Trigger trMyFirstTrigger ON Database

-- Kuidas kustutada pästlikud
Drop Trigger trMyFirstTrigger ON Database

-- TestTable muutmine NewTestTable nimi vastu 
Create trigger trRenameTable
ON Database
FOR RENAME
AS
BEGIN
 Print 'You just renamed something'
END

sp_rename 'Test','NewTesttable'

-- 93. Pästlikud DDL serveri tasemel

--Keelatab selles andmebaasis tabelite loomist, muutmist ja kustutamist
Create trigger tr_DatabaseScopeTrigger
ON Database
FOR CREATE_TABLE,ALTER_TABLE,DROP_TABLE
AS
BEGIN
Rollback
   Print 'You cannot create, alter or drop a table in the current database'
END

DROP TABLE NewTesttable

-- -- See on serveritaseme päästik, mis lisab koodile sõna ALL
Create trigger tr_ServerScopeTrigger
ON ALL SERVER
FOR CREATE_TABLE,ALTER_TABLE,DROP_TABLE
AS
BEGIN
Rollback
  Print 'You cannot create, alter or drop a table in any database on the server'
END

-- Kuidas keelata DDL-i päästik serveri tasemel
DISABLE Trigger tr_ServerScopeTrigger ON ALL SERVER

-- Kuidas lubada DDL-i päästik serveri tasemel
ENABLE Trigger tr_ServerScopeTrigger ON ALL SERVER

-- Kuidas kustuta DDL-i päästik serveri tasemel
DROP Trigger tr_ServerScopeTrigger ON ALL SERVER
