-- Creación de esquemas para organizar las tablas
USE inventory_db;
GO

IF NOT EXISTS (SELECT *
FROM sys.schemas
WHERE name = 'General') EXEC('CREATE SCHEMA General');
GO
IF NOT EXISTS (SELECT *
FROM sys.schemas
WHERE name = 'Logistica') EXEC('CREATE SCHEMA Logistica');
GO
IF NOT EXISTS (SELECT *
FROM sys.schemas
WHERE name = 'Comercial') EXEC('CREATE SCHEMA Comercial');
GO

-- Limpieza de tablas existentes para ejecutar varias veces el script

DROP TABLE IF EXISTS Logistica.INVENTARIO;
DROP TABLE IF EXISTS Comercial.DETALLE_VENTA;
DROP TABLE IF EXISTS Comercial.VENTAS;
DROP TABLE IF EXISTS Logistica.PRODUCTOS;
DROP TABLE IF EXISTS Comercial.CLIENTES;
DROP TABLE IF EXISTS Logistica.ALMACENES;
DROP TABLE IF EXISTS General.DIRECCIONES;
DROP TABLE IF EXISTS Logistica.CATEGORIAS;
DROP TABLE IF EXISTS General.DISTRITOS;
GO

-- 1. Crear entidades fuertes (Catálogos)

CREATE TABLE GENERAL.DISTRITOS
(
    id_distrito INT IDENTITY(1, 1) PRIMARY KEY,
    nombre_distrito VARCHAR(50) NOT NULL
);
GO
CREATE TABLE GENERAL.DIRECCIONES
(
    id_direccion INT IDENTITY(1, 1) PRIMARY KEY,
    nombre_direccion VARCHAR(150) NOT NULL
);
GO
CREATE TABLE Logistica.CATEGORIAS
(
    id_categoria INT IDENTITY(1, 1) PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL
);
GO
-- 2. Creación de entidades con relaciones 1:N

CREATE TABLE Logistica.ALMACENES
(
    codigo_almacen CHAR(5) PRIMARY KEY,
    id_direccion INT NOT NULL,
    capacidad INT NOT NULL,
    FOREIGN KEY (id_direccion) REFERENCES GENERAL.DIRECCIONES(id_direccion)
);
GO

CREATE TABLE Logistica.HISTORIAL_PRECIOS(
    id_historial INT IDENTITY(1, 1) PRIMARY KEY,
    id_producto INT NOT NULL,
    precio_anterior DECIMAL(10, 2) NOT NULL,
    precio_nuevo DECIMAL(10, 2) NOT NULL,
    fecha_cambio DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_producto) REFERENCES Logistica.PRODUCTOS(id_producto)
);
GO

CREATE TABLE Comercial.CLIENTES
(
    dni CHAR(8) PRIMARY KEY,
    id_distrito INT NOT NULL,
    primer_nombre VARCHAR(25) NOT NULL,
    primer_apellido VARCHAR(25) NOT NULL,
    segundo_apellido VARCHAR(25) NOT NULL,
    FOREIGN KEY (id_distrito) REFERENCES General.DISTRITOS(id_distrito)
);
GO

CREATE TABLE Logistica.PRODUCTOS
(
    id_producto INT IDENTITY(1, 1) PRIMARY KEY,
    id_categoria INT NOT NULL,
    nombre_producto VARCHAR(150) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Logistica.CATEGORIAS(id_categoria)
);
GO

CREATE TABLE Comercial.VENTAS
(
    codigo_venta INT IDENTITY(1, 1) PRIMARY KEY,
    dni CHAR(8) NOT NULL,
    fecha_evento DATETIME NOT NULL,
    FOREIGN KEY (dni) REFERENCES Comercial.CLIENTES(dni)
);
GO
-- 3. Creación de las tablas intermediarias (Llaves Compuestas)

CREATE TABLE Comercial.DETALLE_VENTA
(
    codigo_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_vendida INT NOT NULL,
    precio_unitario_venta DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (codigo_venta, id_producto),
    FOREIGN KEY (codigo_venta) REFERENCES Comercial.VENTAS(codigo_venta),
    FOREIGN KEY (id_producto) REFERENCES Logistica.PRODUCTOS(id_producto)
);
GO

CREATE TABLE Logistica.INVENTARIO
(
    id_producto INT NOT NULL,
    codigo_almacen CHAR(5) NOT NULL,
    cantidad_disponible INT NOT NULL,
    PRIMARY KEY (id_producto, codigo_almacen),
    FOREIGN KEY (id_producto) REFERENCES Logistica.PRODUCTOS(id_producto),
    FOREIGN KEY (codigo_almacen) REFERENCES Logistica.ALMACENES(codigo_almacen)
);
GO