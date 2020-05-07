USE Exam
GO

IF OBJECT_ID('Students', 'U') is not null
	DROP TABLE Students
IF OBJECT_ID('Marks', 'U') is not null
	DROP TABLE Marks
IF OBJECT_ID('Details', 'U') is not null
	DROP TABLE Details

CREATE TABLE Students (
SID INT PRIMARY KEY IDENTITY,
SName VARCHAR(100),
SAge INT,
NoOfSubjects INT UNIQUE NOT NULL
)

CREATE TABLE Marks (
MID INT PRIMARY KEY IDENTITY,
Score INT,
Subject VARCHAR(100)
)

CREATE TABLE Details (
DID INT PRIMARY KEY IDENTITY,
SID INT REFERENCES Students(SID),
MID INT REFERENCES Marks(MID),
Status VARCHAR(100)
)

insert into Students(SName, SAge, NoOfSubjects) values 
('name1', 21, 1),
('name2', 20, 2),
('name3', 21, 3),
('name4', 22, 4),
('name5', 15, 5),
('name6', 15, 6),
('name7', 16, 7),
('name8', 17, 8),
('name9', 18, 9),
('name10', 19, 10),
('name11', 20, 11),
('name12', 21, 12),
('name13', 22, 13);
insert into Marks(Score, Subject) values 
(10, 'subject1'), 
(9, 'subject2'), 
(10, 'subject3'), 
(8, 'subject4'), 
(7, 'subject1'), 
(6, 'subject2'), 
(10, 'subject3'), 
(9, 'subject4'), 
(5, 'subject5'), 
(4, 'subject3'), 
(3, 'subject2'), 
(2, 'subject3'), 
(1, 'subject1'), 
(9, 'subject2');

insert into Details (SID, MID, Status) values 
(1, 1, 'passed'),
(2, 10, 'failed'),
(3, 11, 'failed'),
(4, 12, 'failed'),
(5, 13, 'failed'),
(6, 2, 'passed'),
(7, 3, 'passed'),
(8, 4, 'passed'),
(9, 5, 'passed'),
(8, 6, 'passed'),
(7, 7, 'passed'),
(6, 7, 'passed'),
(5, 7, 'passed'),
(4, 8, 'passed');

SELECT * FROM Students
SELECT * FROM Marks
SELECT * FROM Details

-- a
-- Find an existing index named N_idx_Subject and delete it if found.    
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'N_idx_Subject')       
DROP INDEX N_idx_Subject ON Marks;    
GO   
-- Create a nonclustered index called N_idx_Subject on the Marks table using the Subject column.    
CREATE NONCLUSTERED INDEX N_idx_Subject ON Marks(Subject);    
GO 
-- Create a nonclustered index called N_idx_Subject on the Marks table using the Subject column.    
CREATE NONCLUSTERED INDEX N_idx_SAge ON Students(SAge);    
GO 

-- seek
SELECT * 
FROM Students
WHERE NoOfSubjects > 3

-- scan
SELECT * 
FROM Students

-- seek non
SELECT SAge
FROM Students
WHERE SAge > 10

-- scan non
SELECT SAge
FROM Students

-- key lookup
SELECT *
FROM Students
ORDER BY NoOfSubjects

-- check the indexes (nonclustered) for the database
SELECT TableName = t.name, IndexName = ind.name, IndexId = ind.index_id, ColumnId = ic.index_column_id,      
ColumnName = col.name, ind.*, ic.*, col.*  FROM sys.indexes ind  
INNER JOIN sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id  
INNER JOIN sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id  
INNER JOIN sys.tables t ON ind.object_id = t.object_id  
WHERE ind.is_primary_key = 0 AND ind.is_unique = 0 AND ind.is_unique_constraint = 0       
	AND t.is_ms_shipped = 0  ORDER BY t.name, ind.name, ind.index_id, ic.index_column_id;

-- all the indexes from table Students 
SELECT i2.name, i1.user_scans, i1.user_seeks, i1.user_updates,i1.last_user_scan,i1.last_user_seek, i1.last_user_update 
FROM sys.dm_db_index_usage_stats i1 inner join sys.indexes i2 on i1.index_id = i2.index_id  
WHERE i1.object_id = OBJECT_ID('Students') and i1.object_id = i2.object_id

-- all the indexes from the current database  
SELECT OBJECT_NAME(A.[OBJECT_ID]) AS [OBJECT NAME], I.[NAME] AS [INDEX NAME], A.LEAF_INSERT_COUNT,         
	A.LEAF_UPDATE_COUNT, A.LEAF_DELETE_COUNT 
FROM SYS.DM_DB_INDEX_OPERATIONAL_STATS (NULL,NULL,NULL,NULL ) A         
INNER JOIN SYS.INDEXES AS I ON I.[OBJECT_ID] = A.[OBJECT_ID] AND I.INDEX_ID = A.INDEX_ID  
WHERE  OBJECTPROPERTY(A.[OBJECT_ID],'IsUserTable') = 1 

-- b

-- Find an existing index named N_idx_Score and delete it if found.    
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'N_idx_Score')        
DROP INDEX N_idx_Score ON Marks;    
GO   
-- Create a nonclustered index called N_idx_Score on the Marks table using the Score column.    
CREATE NONCLUSTERED INDEX N_idx_Score ON Marks(Score);    
GO 

SELECT Score
FROM Marks
WHERE Score = 9

-- list the index plan 
SET NOCOUNT ON; 
GO

SET SHOWPLAN_ALL ON; 
GO 

SELECT * FROM Marks WHERE Score BETWEEN 5 AND 10; 
GO 

SET SHOWPLAN_ALL OFF
GO 

-- c
CREATE OR ALTER VIEW test 
AS 
SELECT s.SName, s.SAge, m.Subject, m.Score FROM Students s 
INNER JOIN Details d ON s.SID = d.SID
INNER JOIN Marks m ON m.MID = d.MID 
WHERE SAge BETWEEN 19 and 21 OR Score > 6
GO 
 
SELECT * FROM test

-- Find an existing index named N_idx_SName and delete it if found.    
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'N_idx_SName')        
DROP INDEX N_idx_SName ON Students;    
GO   
-- Create a nonclustered index called N_idx_Subject on the Marks table using the Subject column.    
CREATE NONCLUSTERED INDEX N_idx_SName ON Students(SName);    
GO

SELECT s.SName from Students s 
INNER JOIN Details d ON s.SID = d.SID 
INNER JOIN Marks m ON m.MID = d.MID 
Where SAge BETWEEN 19 and 21 OR Score > 6 

-- CHECK THE INDEXES for the given table 
EXEC sp_helpindex 'Students' 