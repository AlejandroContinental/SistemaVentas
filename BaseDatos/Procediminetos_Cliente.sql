CREATE PROCEDURE sp_MostrarClientes
AS
BEGIN
    SELECT
        clienteID,
        nombres,
        apellidos,
        email,
        telefono,
        direccion,
        fechaRegistro,
        estado
    FROM Clientes;
END;
GO

CREATE PROCEDURE sp_RegistrarCliente
    @nombres NVARCHAR(100),
    @apellidos NVARCHAR(100),
    @email NVARCHAR(150) = NULL, -- Permitir NULL
    @telefono NVARCHAR(20) = NULL, -- Permitir NULL
    @direccion NVARCHAR(250) = NULL -- Permitir NULL
AS
BEGIN
    INSERT INTO Clientes (nombres, apellidos, email, telefono, direccion, estado)
    VALUES (@nombres, @apellidos, @email, @telefono, @direccion, 1); -- Estado por defecto 1 (activo)
END;
GO

CREATE PROCEDURE sp_EditarCliente
    @clienteID INT,
    @nombres NVARCHAR(100),
    @apellidos NVARCHAR(100),
    @email NVARCHAR(150) = NULL,
    @telefono NVARCHAR(20) = NULL,
    @direccion NVARCHAR(250) = NULL,
    @estado BIT
AS
BEGIN
    UPDATE Clientes
    SET
        nombres = @nombres,
        apellidos = @apellidos,
        email = @email,
        telefono = @telefono,
        direccion = @direccion,
        estado = @estado
    WHERE
        clienteID = @clienteID;
END;
GO


CREATE PROCEDURE sp_EliminarCliente
    @clienteID INT
AS
BEGIN
    UPDATE Clientes
    SET
        estado = 0 
    WHERE
        clienteID = @clienteID;
END;
GO

CREATE PROCEDURE sp_ObtenerClientePorID
    @clienteID INT
AS
BEGIN
    SELECT
        clienteID,
        nombres,
        apellidos,
        email,
        telefono,
        direccion,
        fechaRegistro,
        estado
    FROM Clientes
    WHERE clienteID = @clienteID;
END;
GO