CREATE DATABASE VentasSenati
GO
USE VentasSenati
GO
CREATE TABLE Categorias (
    categoriaID INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
	estado BIT NOT NULL DEFAULT 1
);

CREATE TABLE Clientes (
    clienteID INT IDENTITY(1,1) PRIMARY KEY,
    nombres NVARCHAR(100) NOT NULL,
    apellidos NVARCHAR(100) NOT NULL,
    email NVARCHAR(150) NULL,
    telefono NVARCHAR(20) NULL,
    direccion NVARCHAR(250) NULL,
    fechaRegistro DATE NOT NULL DEFAULT GETDATE(),
    estado BIT NOT NULL DEFAULT 1
);

CREATE TABLE Empleados (
    empleadoID INT IDENTITY(1,1) PRIMARY KEY,
    nombres NVARCHAR(100) NOT NULL,
    apellidos NVARCHAR(100) NOT NULL,
    email NVARCHAR(150) NULL,
    cargo NVARCHAR(50) NULL,
    telefono NVARCHAR(20) NULL,
    fechaContratacion DATE NOT NULL,
    estado BIT NOT NULL DEFAULT 1
);

CREATE TABLE Sesion (
	sesionID INT IDENTITY(1,1) PRIMARY KEY,
    empleadoID INT,
    usuario NVARCHAR(100) NOT NULL,
    contrasena VARBINARY(256) NOT NULL,
    FOREIGN KEY (empleadoID) REFERENCES Empleados(empleadoID)
);

CREATE TABLE Productos (
    productoID INT IDENTITY(1,1) PRIMARY KEY,
    nombreProducto NVARCHAR(150) NOT NULL,
    descripcion NVARCHAR(500) NULL,
    precioUnitario DECIMAL(12,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    estado BIT NOT NULL DEFAULT 1,
    categoriaID INT NOT NULL,
	FOREIGN KEY (categoriaID) REFERENCES Categorias(categoriaID)
);

CREATE TABLE Ventas (
    ventaID INT IDENTITY(1,1) PRIMARY KEY,
    clienteID INT NOT NULL,
    empleadoID INT NOT NULL,
    fechaVenta DATETIME NOT NULL DEFAULT GETDATE(),
    metodoPago NVARCHAR(50) NULL,
    estado BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (clienteID) REFERENCES Clientes(clienteID),
    FOREIGN KEY (empleadoID) REFERENCES Empleados(empleadoID)
);


CREATE TABLE Detalle_Ventas (
    detalleID INT IDENTITY(1,1) PRIMARY KEY,
    ventaID INT NOT NULL,
    productoID INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precioUnitario DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (ventaID) REFERENCES Ventas(ventaID),
    FOREIGN KEY (productoID) REFERENCES Productos(productoID)
);
