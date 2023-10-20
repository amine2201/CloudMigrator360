USE gold_db;
GO

CREATE OR ALTER PROC CreateSQLServerlessView_gold 
    @ViewName nvarchar(100)
AS
BEGIN
    -- Declare the SQL statement as a variable
    DECLARE @statement nvarchar(MAX);

    -- Build the SQL statement with the view name and path
    SET @statement = N'CREATE OR ALTER VIEW ' + QUOTENAME(@ViewName) + ' AS 
                        SELECT * 
                        FROM OPENROWSET(
                            BULK ''https://datalakecloudmigration.dfs.core.windows.net/gold/SalesLT/' + @ViewName + '/'',
                            FORMAT = ''DELTA''
                            ) as [result];';

    -- Execute the SQL statement
    EXEC sp_executesql @statement;
END;
GO
