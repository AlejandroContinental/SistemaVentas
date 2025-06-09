USE [VentasSenati];
GO
--Crear backup en ruta por defecto
IF OBJECT_ID('dbo.usp_BackupVentasSenati') IS NOT NULL
    DROP PROCEDURE dbo.usp_BackupVentasSenati;
GO

CREATE PROCEDURE dbo.usp_BackupVentasSenati
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @backupPath NVARCHAR(500);
    DECLARE @backupFileName NVARCHAR(600);
    DECLARE @sqlCommand NVARCHAR(MAX);
    DECLARE @databaseName SYSNAME = N'VentasSenati'; -- Nombre de la base de datos

    -- Obtener la ruta de directorio de backup por defecto de la instancia
    CREATE TABLE #BackupPath (
        value_name NVARCHAR(255),
        value NVARCHAR(500)
    );

    INSERT INTO #BackupPath (value_name, value)
    EXEC master..xp_instance_regread
        N'HKEY_LOCAL_MACHINE',
        N'Software\Microsoft\MSSQLServer\MSSQLServer',
        N'BackupDirectory';

    SELECT @backupPath = value FROM #BackupPath;

    -- Limpiar la tabla temporal
    DROP TABLE #BackupPath;

    -- Verificar si se obtuvo la ruta
    IF @backupPath IS NULL
    BEGIN
        RAISERROR('No se pudo obtener la ruta de backup por defecto de SQL Server.', 16, 1);
        RETURN;
    END;

    -- Construir el nombre del archivo de backup con la fecha y hora actuales
    SET @backupFileName = @backupPath + '\' + @databaseName + '_FullBackup_' + 
                          FORMAT(GETDATE(), 'yyyyMMdd_HHmmss') + '.bak';

    -- Construir el comando de backup dinámicamente
    SET @sqlCommand = N'BACKUP DATABASE [' + @databaseName + N']' +
                      N' TO DISK = N''' + @backupFileName + N'''' +
                      N' WITH NOFORMAT, NOINIT, ' +
                      N' NAME = N''' + @databaseName + N'-Full Database Backup'', ' +
                      N' SKIP, NOREWIND, NOUNLOAD, STATS = 10;';

    -- Imprimir el comando que se va a ejecutar (opcional, para depuración)
    PRINT 'Ejecutando comando de backup:';
    PRINT @sqlCommand;

    -- Ejecutar el comando de backup
    EXEC sp_executesql @sqlCommand;

    PRINT 'Backup de la base de datos ' + @databaseName + ' creado exitosamente en: ' + @backupFileName;

END;
GO
--Lista de BACKUPS

IF OBJECT_ID('dbo.usp_ListarBackupsVentasSenati') IS NOT NULL
    DROP PROCEDURE dbo.usp_ListarBackupsVentasSenati;
GO

CREATE PROCEDURE [dbo].[usp_ListarBackupsVentasSenati]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        bs.backup_set_id AS IDBackup, -- ID único del backup
        bs.database_name AS NombreBaseDeDatos,
        bs.backup_start_date AS FechaInicioBackup,
        bs.backup_finish_date AS FechaFinBackup,
        bs.type AS TipoBackup, -- 'D' = Full, 'I' = Differential, 'L' = Log
        bmf.physical_device_name AS UbicacionArchivoBackup,
        CAST(bs.backup_size / 1024.0 / 1024.0 AS DECIMAL(10, 2)) AS TamanoMB
    FROM
        msdb.dbo.backupset AS bs
    INNER JOIN
        msdb.dbo.backupmediafamily AS bmf ON bs.media_set_id = bmf.media_set_id
    WHERE
        bs.database_name = N'VentasSenati'
    ORDER BY
        bs.backup_finish_date DESC;
END;
GO

USE [master];
GO

CREATE PROCEDURE [dbo].[usp_RestaurarBackupVentasSenati]
    @IDBackup INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @BackupFile NVARCHAR(500);

    -- Obtener el archivo físico del backup a partir del ID
    SELECT TOP 1
        @BackupFile = bmf.physical_device_name
    FROM
        msdb.dbo.backupset bs
    INNER JOIN
        msdb.dbo.backupmediafamily bmf ON bs.media_set_id = bmf.media_set_id
    WHERE
        bs.backup_set_id = @IDBackup
        AND bs.database_name = 'VentasSenati';

    IF @BackupFile IS NULL
    BEGIN
        RAISERROR('No se encontró un backup con el ID proporcionado.', 16, 1);
        RETURN;
    END

    -- Poner la base de datos en modo SINGLE_USER para restaurar
    ALTER DATABASE VentasSenati SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    -- Restaurar la base de datos
    RESTORE DATABASE VentasSenati
    FROM DISK = @BackupFile
    WITH REPLACE, RECOVERY;

    -- Volver a MULTI_USER
    ALTER DATABASE VentasSenati SET MULTI_USER;

    PRINT 'La base de datos VentasSenati ha sido restaurada correctamente desde el backup con ID ' + CAST(@IDBackup AS NVARCHAR);
END;
GO
