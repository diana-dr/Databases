use s1
go 

if object_id ('FireworksTypes', 'u') is not null
	drop table FireworksTypes

if object_id ('FireworkProducts', 'u') is not null
	drop table FireworkProducts

if object_id ('Suppliers', 'u') is not null
	drop table Suppliers

if object_id ('Events_', 'u') is not null
	drop table Events_

if object_id ('FireworkProductsSuppliers', 'u') is not null
	drop table FireworkProductsSuppliers

if object_id ('FireworkProductsEvents', 'u') is not null
	drop table FireworkProductsEvents

create table FireworksTypes(
TFID INT PRIMARY KEY IDENTITY(1, 1),
TFName VARCHAR(100),
TFDescription VARCHAR(500)
)
create table FireworkProducts(
FPID INT PRIMARY KEY IDENTITY(1,1),
FPName VARCHAR(100),
duration int,
color varchar(100),
TFID INT REFERENCES FireworksTypes(TFID)
)
create table Suppliers(
SupID INT PRIMARY KEY IDENTITY(1,1),
SName varchar(100),
turnover int
)
create table Events_(
EID INT PRIMARY KEY IDENTITY(1,1),
EName varchar(100),
EDate date
)
create table FireworkProductsSuppliers(
	FPID INT REFERENCES FireworkProducts(FPID),
	SupID INT REFERENCES Suppliers(SupID),
	price int
	PRIMARY KEY(FPID, SupID)
)
create table FireworkProductsEvents(
	FPID INT REFERENCES FireworkProducts(FPID),
	EID INT REFERENCES Events_(EID),
	scheduledTime time,
	primary key (FPID, EID)
)

insert into FireworksTypes values ('t1', 'd1'), ('t2', 'd2'), ('t3', 'd3')
insert into FireworkProducts values ('fp1', 10, 'red', 1), ('fp2', 19, 'blue', 2), ('fp3', 26, 'yellow', 3)
insert into Suppliers values ('s1', 1999), ('s2', 1717), ('s3', 9999)

select * from FireworksTypes
select * from FireworkProducts
select * from Suppliers
go

CREATE OR ALTER PROCEDURE addFPSupplier @SName varchar(100), @FPName varchar(100), @Price int
as
	declare @SID int = (select SupID from Suppliers where SName = @SName),
			@FPID int = (select FPID from FireworkProducts where FPName = @FPName)
	if @SID is null or @FPID is null
	begin
		raiserror('no such suplier/firework product', 16, 1)
		return -1
	end
	if exists (select * from FireworkProductsSuppliers where SupID = @SID and FPID = @FPID)
		update FireworkProductsSuppliers
		set price = @Price
		where SupID = @SID and FPID = @FPID
	else
		insert into FireworkProductsSuppliers values (@FPID, @SID, @Price)
go

execute addFPSupplier 's2', 'fp2', 199
execute addFPSupplier 's2', 'fp3', 200
execute addFPSupplier 's1', 'fp2', 199
execute addFPSupplier 's3', 'fp2', 199

select * from FireworkProductsSuppliers

go

insert into Events_ values ('e1', '10-10-2019'), ('e2', '11-11-2020'), ('e3', '12-12-2019')
insert into FireworkProductsEvents values (1, 1, '11:11'), (2, 1, '19:19'), (3, 1, '18:19'), (1, 2, '20:20')

select * from Events_
select * from FireworkProductsEvents
go

CREATE OR ALTER VIEW viewEventsForAllFP
AS SELECT E.EName
FROM Events_ E
WHERE NOT EXISTS 
	(SELECT FP.FPID
	FROM FireworkProducts FP
	EXCEPT
	SELECT FPE.FPID
	FROM FireworkProductsEvents FPE
	WHERE FPE.EID = E.EID)
GO 


select * from viewEventsForAllFP
go

CREATE OR ALTER FUNCTION mostFPSuppliers()
RETURNS TABLE
RETURN
	SELECT S.SName
	FROM Suppliers S
	WHERE S.SupID IN 
		(SELECT FPE.SupID
		FROM FireworkProductsSuppliers FPE
		GROUP BY FPE.SupID
		)
GO

select * from FireworkProductsSuppliers
select * from mostFPSuppliers()