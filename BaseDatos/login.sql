--FUNCION DE ENCRIPTADO
CREATE FUNCTION [dbo].[HashPassword](@password NVARCHAR(100))
RETURNS VARBINARY(256)
AS
BEGIN
    DECLARE @salt NVARCHAR(16) = 'S3n@t1S@lt';
    RETURN HASHBYTES('SHA2_256', @password + @salt);
END;
GO

--VALIDACION DE USUARIOS
CREATE PROCEDURE [dbo].[sp_login]
    @usuario NVARCHAR(100),
    @contrasena NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;


    SELECT
        e.empleadoID,
        e.nombres,
        e.apellidos
    FROM Sesion s
    INNER JOIN Empleados e ON s.empleadoID = e.empleadoID
    WHERE s.usuario = @usuario
      AND s.contrasena = dbo.HashPassword(@contrasena)
      AND e.estado = 1;
END
GO

