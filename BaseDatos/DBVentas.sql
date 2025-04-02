-- Creación de la base de datos
CREATE DATABASE SistemaDeVenta;
GO

-- Usar la base de datos creada
USE SistemaDeVenta;
GO

-- Creación de la tabla Clientes
CREATE TABLE Clientes (
    DNI INT PRIMARY KEY,
    Nombres VARCHAR(255),
    Apellido VARCHAR(255),
    Telefono INT,
    Direccion VARCHAR(255)
);
GO

-- Creación de la tabla Pedidos
CREATE TABLE Pedidos (
    IDPedido INT PRIMARY KEY,
    FechaPedido DATE,
    Dirección VARCHAR(255),
    DecripciónPedido VARCHAR(255)
);
GO

-- Creación de la tabla Productos
CREATE TABLE Productos (
    IDProducto INT PRIMARY KEY,
    NombreProducto VARCHAR(255),
    Stock INT,
    Precio DECIMAL(10, 2),
    IDProveedor INT
);
GO

-- Creación de la tabla Proveedores
CREATE TABLE Proveedores (
    IDProveedor INT PRIMARY KEY,
    NombreProveedor VARCHAR(255),
    Dirección VARCHAR(255),
    Teléfono INT
);
GO

-- Creación de la tabla Factura
CREATE TABLE Factura (
    IDFactura VARCHAR(20) PRIMARY KEY,
    IDCompra VARCHAR(20),
    FechaEmisión DATE,
    MontoTotal DECIMAL(10, 2),
    IDProducto INT
);
GO

-- Creación de la tabla Compra
CREATE TABLE Compra (
    IDCompra VARCHAR(20) PRIMARY KEY,
    FechaCompra DATE,
    DNI INT,
    IDPedido INT,
    IDFactura VARCHAR(20),
    IDProducto INT
);
GO

-- Definición de claves foráneas

-- Clave foránea en la tabla Productos que referencia a la tabla Proveedores
ALTER TABLE Productos
ADD CONSTRAINT FK_Productos_Proveedores
FOREIGN KEY (IDProveedor)
REFERENCES Proveedores (IDProveedor);
GO

-- Clave foránea en la tabla Factura que referencia a la tabla Compra
ALTER TABLE Factura
ADD CONSTRAINT FK_Factura_Compra
FOREIGN KEY (IDCompra)
REFERENCES Compra (IDCompra);
GO

-- Clave foránea en la tabla Factura que referencia a la tabla Productos
ALTER TABLE Factura
ADD CONSTRAINT FK_Factura_Productos
FOREIGN KEY (IDProducto)
REFERENCES Productos (IDProducto);
GO

-- Clave foránea en la tabla Compra que referencia a la tabla Clientes
ALTER TABLE Compra
ADD CONSTRAINT FK_Compra_Clientes
FOREIGN KEY (DNI)
REFERENCES Clientes (DNI);
GO

-- Clave foránea en la tabla Compra que referencia a la tabla Pedidos
ALTER TABLE Compra
ADD CONSTRAINT FK_Compra_Pedidos
FOREIGN KEY (IDPedido)
REFERENCES Pedidos (IDPedido);
GO

-- Clave foránea en la tabla Compra que referencia a la tabla Factura
ALTER TABLE Compra
ADD CONSTRAINT FK_Compra_Factura
FOREIGN KEY (IDFactura)
REFERENCES Factura (IDFactura);
GO

-- Clave foránea en la tabla Compra que referencia a la tabla Productos
ALTER TABLE Compra
ADD CONSTRAINT FK_Compra_Productos
FOREIGN KEY (IDProducto)
REFERENCES Productos (IDProducto);
GO