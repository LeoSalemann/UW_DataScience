/*
# UW PCE Data Science Autumn 2017 Assignment 5
# Leo Salemann 11/10/17
# Based on MatrixAlgebra.sql Copyright 2013-2017 by Ernst Henle. All rights reserved

This code was developed in SQLServer Management Studio
There are some differences in MySQL and SQL Fiddle:  http://sqlfiddle.com/
*/

USE
MatrixAlgebra
GO

/*

Sparse 2D matrices 
In these exercises numerical matrices are encoded using the sparse matrix format.

The sparse matrix format is very similar to the EAV format.
The sparse matrix format is used to represent a matrix.
The EAV format is used to represent a table (relation).

*/


BEGIN TRY 
DROP TABLE Matrix1;
END TRY BEGIN CATCH END CATCH
BEGIN TRY 
DROP TABLE Matrix2;
END TRY BEGIN CATCH END CATCH
BEGIN TRY 
DROP TABLE Matrix3;
END TRY BEGIN CATCH END CATCH

/*Create sparse 2D matrices*/ 
CREATE TABLE Matrix1 (RowID nchar(10)
, ColumnID nchar(10)
, Value real); 
CREATE TABLE Matrix2 (RowID nchar(10)
, ColumnID nchar(10)
, Value real); 
CREATE TABLE Matrix3 (RowID nchar(10)
, ColumnID nchar(10)
, Value real); 

/*Load values into Matrix1*/ 
INSERT INTO Matrix1 VALUES ('one', 'one', -2)
INSERT INTO Matrix1 VALUES ('one', '2', 2)
INSERT INTO Matrix1 VALUES ('one', '3', -1)
INSERT INTO Matrix1 VALUES ('one', '4', 1)

-- Matrix1 is in the sparse matrix format and represents this 1X4 matrix:
----------------------------------
--      |'one'| '2' | '3' | '4' |
----------------------------------
-- 'one'| -2  |  2  |  -1 |  1  |
----------------------------------
SELECT * FROM Matrix1

INSERT INTO Matrix2 VALUES ('one', 'one', 0)
INSERT INTO Matrix2 VALUES ('2', 'one', 2)
INSERT INTO Matrix2 VALUES ('3', 'one', 3)
INSERT INTO Matrix2 VALUES ('4', 'one', 5)

-- Matrix2 is in the sparse matrix format and represents
-- this 4X1 matrix:
---------------
--      |'one'|
---------------
-- 'one'|  0  |
--  '2' |  2  |
--  '3' |  3  |
--  '4' |  5  |
---------------
SELECT * FROM Matrix2



--Exercise 3a
-- Write SQL to multiply a matrix in the sparse matrix
-- format by 7.  Use Matrix1 as your example matrix.
-- The result of the multiplication is in the sparse
-- matrix format.
-- Do not use insert statements or create any new tables
-- or views.
-- Answer for Exercise 3a:
SELECT Matrix1.RowID AS RowID
, Matrix1.ColumnID AS ColumnID, Matrix1.Value*7 AS Value
	FROM Matrix1

--Exercise 3b
-- Write SQL to transpose a matrix in the sparse matrix
-- format.  Use Matrix2 as your example matrix.
-- The result of the transposition will be in the sparse
-- matrix format.
-- Do not use insert statements or create any new tables
-- or views.
-- Answer for Exercise 3b:
SELECT Matrix1.ColumnID AS RowID
, Matrix1.RowID AS ColumnID, Matrix1.Value AS Value
	FROM Matrix1

-- Exercise  3c 
SELECT * FROM Matrix1
SELECT * FROM Matrix3

-- Anser based on stackoverflow post
-- https://stackoverflow.com/questions/19436895/sql-how-to-to-sum-two-values-from-different-tables
-- Answer for Exercise 3c:
select a.RowID, a.ColumnID, a.Value+b.Value as Value from Matrix1 a join Matrix3 b 
on a.RowID=b.RowID AND a.ColumnID = b.ColumnID


-- Exercise after 3c
--   Create Sparse_Format_Table_A
BEGIN TRY 
DROP TABLE Sparse_Format_Table_A;
END TRY BEGIN CATCH END CATCH


/*Create sparse 2D matrix*/ 
CREATE TABLE Sparse_Format_Table_A (R real, C real, V real);


/*Load values into Matrix1*/ 
INSERT INTO Sparse_Format_Table_A VALUES (1, 1, 2)
INSERT INTO Sparse_Format_Table_A VALUES (2, 2, 3)
INSERT INTO Sparse_Format_Table_A VALUES (3, 2, -7)
Select * FROM  Sparse_Format_Table_A;

/* transpose */
-- Answer for Exercise after 3c:
SELECT Sparse_Format_Table_A.C AS R 
, Sparse_Format_Table_A.R AS C, Sparse_Format_Table_A.V AS V 
    FROM Sparse_Format_Table_A 
