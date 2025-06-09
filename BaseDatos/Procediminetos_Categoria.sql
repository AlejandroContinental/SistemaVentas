CREATE PROCEDURE sp_EliminarCategoria
    @categoriaID INT
AS
BEGIN
    UPDATE Categorias
    SET estado = 0
    WHERE categoriaID = @categoriaID;
END

CREATE PROCEDURE sp_ObtenerCategoriaPorID
    @categoriaID INT
AS
BEGIN
    SELECT 
        c.categoriaID,
        c.nombre,
        c.estado
    FROM Categorias c
    WHERE c.categoriaID = @categoriaID;
END

CREATE PROCEDURE sp_registrar_categoria
    @nombre NVARCHAR(100),
    @estado BIT
AS
BEGIN
    INSERT INTO Categorias (nombre, estado)
    VALUES (@nombre, @estado);
END;
CREATE PROCEDURE sp_editar_categoria
    @categoriaID INT,
    @nombre NVARCHAR(100),
    @estado BIT
AS
BEGIN
    UPDATE Categorias
    SET
        nombre = @nombre,
        estado = @estado
    WHERE
        categoriaID = @categoriaID;
END;