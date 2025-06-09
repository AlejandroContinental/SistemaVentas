CREATE PROCEDURE sp_MostrarVentas
AS
BEGIN
    SELECT
        P.nombreProducto AS 'Nombre del Producto',
        DV.cantidad AS Cantidad,
        (DV.cantidad * DV.precioUnitario) AS Total, -- Calcula el total por línea de detalle
        C.nombres + ' ' + C.apellidos AS 'Nombre del Cliente',
        V.metodoPago AS 'Método de Pago',
        E.nombres + ' ' + E.apellidos AS 'Nombre del Empleado',
        V.fechaVenta AS 'Fecha de Venta'
    FROM
        Ventas V
    INNER JOIN
        Detalle_Ventas DV ON V.ventaID = DV.ventaID
    INNER JOIN
        Productos P ON DV.productoID = P.productoID
    INNER JOIN
        Clientes C ON V.clienteID = C.clienteID
    INNER JOIN
        Empleados E ON V.empleadoID = E.empleadoID
    WHERE
        V.estado = 1
    ORDER BY
        V.fechaVenta DESC; -- Ordena por la fecha de venta más reciente
END;
GO