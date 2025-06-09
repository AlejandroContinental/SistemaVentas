-- Procedimiento para mostrar todos los empleados
CREATE PROCEDURE sp_MostrarEmpleados
AS
BEGIN
    SELECT
        empleadoID,
        nombres,
        apellidos,
        email,
        cargo,
        telefono,
        fechaContratacion,
        estado
    FROM Empleados;
END;
GO

-- Procedimiento para registrar un nuevo empleado
CREATE PROCEDURE sp_RegistrarEmpleado
    @nombres NVARCHAR(100),
    @apellidos NVARCHAR(100),
    @email NVARCHAR(150) = NULL,
    @cargo NVARCHAR(50) = NULL,
    @telefono NVARCHAR(20) = NULL,
    @fechaContratacion DATE
AS
BEGIN
    INSERT INTO Empleados (nombres, apellidos, email, cargo, telefono, fechaContratacion, estado)
    VALUES (@nombres, @apellidos, @email, @cargo, @telefono, @fechaContratacion, 1); -- Estado por defecto 1 (activo)
END;
GO

-- Procedimiento para editar un empleado existente
CREATE PROCEDURE sp_EditarEmpleado
    @empleadoID INT,
    @nombres NVARCHAR(100),
    @apellidos NVARCHAR(100),
    @email NVARCHAR(150) = NULL,
    @cargo NVARCHAR(50) = NULL,
    @telefono NVARCHAR(20) = NULL,
    @fechaContratacion DATE,
    @estado BIT
AS
BEGIN
    UPDATE Empleados
    SET
        nombres = @nombres,
        apellidos = @apellidos,
        email = @email,
        cargo = @cargo,
        telefono = @telefono,
        fechaContratacion = @fechaContratacion,
        estado = @estado
    WHERE
        empleadoID = @empleadoID;
END;
GO

-- Procedimiento para "eliminar" un empleado (cambiar su estado a inactivo)
CREATE PROCEDURE sp_EliminarEmpleado
    @empleadoID INT
AS
BEGIN
    UPDATE Empleados
    SET
        estado = 0 -- Cambia el estado a inactivo (0)
    WHERE
        empleadoID = @empleadoID;
END;
GO

-- Procedimiento para obtener un empleado por su ID
CREATE PROCEDURE sp_ObtenerEmpleadoPorID
    @empleadoID INT
AS
BEGIN
    SELECT
        empleadoID,
        nombres,
        apellidos,
        email,
        cargo,
        telefono,
        fechaContratacion,
        estado
    FROM Empleados
    WHERE empleadoID = @empleadoID;
END;
GO