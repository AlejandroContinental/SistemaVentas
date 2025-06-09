CREATE PROCEDURE [dbo].[sp_registrar_producto]
    @nombreProducto NVARCHAR(150),
    @descripcion NVARCHAR(500),
    @precioUnitario DECIMAL(12,2),
    @stock INT,
    @estado BIT,
    @categoriaID INT
AS
BEGIN
    INSERT INTO Productos (nombreProducto, descripcion, precioUnitario, stock, estado, categoriaID)
    VALUES (@nombreProducto, @descripcion, @precioUnitario, @stock, @estado, @categoriaID);
END
GO
CREATE PROCEDURE [dbo].[sp_editar_producto]
    @productoID INT,
    @nombreProducto NVARCHAR(150),
    @descripcion NVARCHAR(500),
    @precioUnitario DECIMAL(12,2),
    @stock INT,
    @estado BIT,
    @categoriaID INT
AS
BEGIN
    UPDATE Productos
    SET nombreProducto = @nombreProducto,
        descripcion = @descripcion,
        precioUnitario = @precioUnitario,
        stock = @stock,
        estado = @estado,
        categoriaID = @categoriaID
    WHERE productoID = @productoID;
END
GO
CREATE PROCEDURE [dbo].[sp_EliminarProducto]
    @productoID INT
AS
BEGIN
    UPDATE Productos
    SET estado = 0
    WHERE productoID = @productoID;
END
GO
CREATE PROCEDURE [dbo].[sp_listar_productos]
AS
BEGIN
    SELECT 
        p.productoID,
        p.nombreProducto,
        p.descripcion,
        p.precioUnitario,
        p.stock,
        p.estado,
        c.nombre AS categoria
    FROM Productos p
    INNER JOIN Categorias c ON p.categoriaID = c.categoriaID
END
GO
CREATE PROCEDURE [dbo].[sp_ObtenerProductoPorID]
    @productoID INT
AS
BEGIN
    SELECT 
        p.productoID,
        p.nombreProducto,
        p.descripcion,
        p.precioUnitario,
        p.stock,
        p.estado,
        p.categoriaID,
        c.nombre AS nombreCategoria
    FROM Productos p
    INNER JOIN Categorias c ON p.categoriaID = c.categoriaID
    WHERE p.productoID = @productoID;
END
GO