SELECT*
FROM [About movies(1915-2023)]

----- Dropping Unwanted columns
ALTER TABLE [About movies(1915-2023)] DROP COLUMN Stars,"Description"

------ To Check for null
SELECT*
FROM "About movies(1915-2023)"
WHERE column1 IS NULL
OR Movie_Name IS NULL
OR Year_of_Release IS NULL
OR Run_Time_in_minutes IS NULL
OR Movie_Rating IS NULL
OR Votes IS NULL
OR MetaScore IS NULL 
OR Gross IS NULL
OR Genre IS NULL
OR Certification IS NULL
OR Director IS NULL;

------- Checking for duplicates
SELECT *
FROM "About movies(1915-2023)" A
WHERE EXISTS (
    SELECT 1
    FROM "About movies(1915-2023)" B
    WHERE A.column1 = B.column1
    AND A.Movie_Name = B.Movie_Name
    AND A.Year_of_Release = B.Year_of_Release
    AND A.Run_Time_in_minutes = B.Run_Time_in_minutes
    AND A.Movie_Rating = B.Movie_Rating
    AND A.Votes = B.Votes
    AND A.MetaScore = B.MetaScore
    AND A.Gross = B.Gross
    AND A.Genre = B.Genre
    AND A.Certification = B.Certification
    AND A.Director = B.Director
    AND A.column1 <> B.column1 
);

------- Converting the datatype for Gross column
SELECT Gross
FROM [About movies(1915-2023)]
-------- Converting datatypes
SELECT Gross, CONVERT(INT,Gross) 
FROM [About movies(1915-2023)]  

------ updatig the table
UPDATE [About movies(1915-2023)]
SET Gross = CONVERT(INT,Gross) 

------ Changing the datatype and  Calculating the median value in the Gross column to replace the NULL values
SELECT
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Gross) OVER () AS Median
FROM
    [About movies(1915-2023)];

	UPDATE [About movies(1915-2023)]
SET Gross = '16930000'
WHERE Gross IS NULL; ----(2915 rows affected)

------- Changing the datatype and Calculating the median value in the MetaScore column  to replace the NULL values
SELECT
UPDATE [About movies(1915-2023)]
SET MetaScore = CONVERT(INT,MetaScore) 
SELECT
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY MetaScore) OVER () AS Median
FROM
    [About movies(1915-2023)];

	UPDATE [About movies(1915-2023)]
SET MetaScore = '60'
WHERE MetaScore IS NULL---(2026 rows affected)

------- Replacing NULL values for certification column with "Unspecified"
UPDATE [About movies(1915-2023)]
SET Certification = 'Unspecified'
WHERE Certification IS NULL ----(369 rows affected)

----- Cleaning the column Director 
SELECT Director, REPLACE(REPLACE(REPLACE(Director,'[',''),']',''),'''','') 
as Director FROM [About movies(1915-2023)];

UPDATE [About movies(1915-2023)]
SET Director =  REPLACE(REPLACE(REPLACE(Director,'[',''),']',''),'''','') 
FROM [About movies(1915-2023)];

----- Cleaning the column Genre
SELECT Genre, REPLACE(REPLACE(REPLACE(Genre,'[',''),']',''),'''','') 
as Genre FROM [About movies(1915-2023)];

UPDATE [About movies(1915-2023)]
SET Genre = REPLACE(REPLACE(REPLACE(Genre,'[',''),']',''),'''','') 
FROM [About movies(1915-2023)]; 


 ------ Renaming column1 as Movie_id
EXEC sp_rename '[About movies(1915-2023)].column1', 'Movie_id', 'COLUMN';



