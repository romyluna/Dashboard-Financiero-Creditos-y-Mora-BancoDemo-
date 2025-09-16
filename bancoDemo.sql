-------------------------------------------------
-- 1. Crear la base de datos
-------------------------------------------------
CREATE DATABASE BancoDemo;
GO

-- Usar la base recién creada
USE BancoDemo;
GO

-------------------------------------------------
-- 2. Crear tabla Clientes
-------------------------------------------------
CREATE TABLE Clientes (
    cliente_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    ciudad NVARCHAR(100),
    fecha_alta DATE,
    segmento NVARCHAR(50)
);
GO

-------------------------------------------------
-- 3. Crear tabla Creditos
-------------------------------------------------
CREATE TABLE Creditos (
    credito_id INT IDENTITY(1,1) PRIMARY KEY,
    cliente_id INT NOT NULL,
    monto DECIMAL(12,2),
    saldo DECIMAL(12,2),
    fecha_otorgado DATE,
    estado NVARCHAR(50),
    CONSTRAINT FK_Creditos_Clientes FOREIGN KEY (cliente_id)
        REFERENCES Clientes(cliente_id)
);
GO

-------------------------------------------------
-- 4. Insertar datos en Clientes
-- (no se carga cliente_id porque es autoincremental)
-------------------------------------------------
INSERT INTO Clientes (nombre, ciudad, fecha_alta, segmento)
VALUES
    ('Ana', 'Buenos Aires', '2022-01-15', 'Retail'),
    ('Juan', 'Córdoba', '2023-03-10', 'Retail'),
    ('Pedro', 'Mendoza', '2021-08-22', 'PyME');
GO

-------------------------------------------------
-- 5. Insertar datos en Creditos
-- (no se carga credito_id porque es autoincremental)
-------------------------------------------------
INSERT INTO Creditos (cliente_id, monto, saldo, fecha_otorgado, estado)
VALUES
    (1, 5000, 2000, '2023-01-10', 'Vigente'),
    (2, 10000, 0, '2022-12-05', 'Cancelado'),
    (1, 3000, 3000, '2023-07-01', 'Vigente');
GO

-------------------------------------------------
-- 6. Agregar columna de vencimiento
-------------------------------------------------
ALTER TABLE Creditos
ADD fecha_vencimiento DATE;
GO

-------------------------------------------------
-- 7. Actualizar fecha de vencimiento
-- Cada crédito vence un año después de la fecha de otorgamiento
-------------------------------------------------
UPDATE Creditos
SET fecha_vencimiento = DATEADD(MONTH, 12, fecha_otorgado);
GO
