/* ============================================================
   CONSULTAS BANCO DEMO - CR�DITOS
   Autor: Romina
   Descripci�n: Consultas de an�lisis y KPIs para Clientes y Cr�ditos
   ============================================================ */


/* =====================
   1. Tablas base
   ===================== */
SELECT * FROM Clientes;
SELECT * FROM Creditos;

-- Uni�n b�sica
SELECT *
FROM Clientes cl
JOIN Creditos cr ON cl.cliente_id = cr.cliente_id;


/* =====================
   2. Distribuci�n de Cr�ditos
   ===================== */

-- Total de cr�ditos por cliente
SELECT 
    cl.cliente_id,
    SUM(cr.monto) AS total_creditos
FROM Clientes cl
JOIN Creditos cr ON cl.cliente_id = cr.cliente_id
GROUP BY cl.cliente_id;

-- Total de cr�ditos por ciudad
SELECT 
    cl.ciudad,
    SUM(cr.monto) AS total_creditos
FROM Clientes cl
JOIN Creditos cr ON cl.cliente_id = cr.cliente_id
GROUP BY cl.ciudad;


/* =====================
   3. Saldos pendientes
   ===================== */

-- Saldo pendiente total por ciudad (solo cr�ditos vigentes)
SELECT 
    cl.ciudad,
    SUM(cr.saldo) AS saldo_pendiente
FROM Clientes cl
JOIN Creditos cr ON cl.cliente_id = cr.cliente_id
WHERE cr.estado = 'Vigente'
GROUP BY cl.ciudad;

-- Saldo pendiente por cliente (solo cr�ditos vigentes)
SELECT 
    cl.cliente_id,
    cl.nombre,
    SUM(cr.saldo) AS saldo_pendiente_total
FROM Clientes cl
JOIN Creditos cr ON cl.cliente_id = cr.cliente_id
WHERE cr.estado = 'Vigente'
GROUP BY cl.cliente_id, cl.nombre
ORDER BY saldo_pendiente_total DESC;

-- Cr�ditos vigentes por cliente + saldo pendiente por ciudad
SELECT 
    cl.cliente_id,
    cl.nombre,
    SUM(cr.monto) AS total_creditos,
    cl.ciudad,
    SUM(cr.saldo) AS saldo_pendiente
FROM Clientes cl
JOIN Creditos cr ON cl.cliente_id = cr.cliente_id
WHERE cr.estado = 'Vigente'
GROUP BY cl.cliente_id, cl.ciudad, cl.nombre
ORDER BY saldo_pendiente DESC;


/* =====================
   4. Cr�ditos Cancelados
   ===================== */
SELECT 
    cl.ciudad,
    SUM(cr.monto) AS total_creditos
FROM Clientes cl
JOIN Creditos cr ON cl.cliente_id = cr.cliente_id
WHERE cr.estado = 'Cancelado'
GROUP BY cl.ciudad;


/* =====================
   5. M�tricas de clientes
   ===================== */

-- Cantidad de clientes con cr�ditos vigentes
SELECT COUNT(DISTINCT cliente_id) AS clientes_con_credito_vigente
FROM Creditos
WHERE estado = 'Vigente';

-- D�as transcurridos desde otorgamiento
SELECT 
    credito_id,
    cliente_id,
    fecha_otorgado,
    DATEDIFF(DAY, fecha_otorgado, GETDATE()) AS dias_transcurridos
FROM Creditos;


/* =====================
   6. Mora
   ===================== */

-- Lista de clientes en mora
SELECT 
    cl.cliente_id,
    cl.nombre,
    cr.fecha_vencimiento,
    cr.saldo
FROM Clientes cl
JOIN Creditos cr ON cl.cliente_id = cr.cliente_id
WHERE cr.estado = 'Vigente'
  AND GETDATE() > cr.fecha_vencimiento;

-- Cr�ditos en mora por cliente (cantidad y saldo)
SELECT 
    cl.cliente_id,
    cl.nombre,
    cl.ciudad,
    COUNT(*) AS cantidad_creditos_mora,
    SUM(cr.saldo) AS saldo_en_mora
FROM Clientes cl
JOIN Creditos cr ON cl.cliente_id = cr.cliente_id
WHERE cr.saldo > 0
  AND cr.fecha_vencimiento < GETDATE()
GROUP BY cl.cliente_id, cl.nombre, cl.ciudad
ORDER BY saldo_en_mora DESC;


/* =====================
   7. KPIs
   ===================== */

-- Tasa de mora (% cr�ditos vencidos con saldo pendiente)
SELECT
    CAST(SUM(CASE 
        WHEN saldo > 0 AND fecha_vencimiento < GETDATE() THEN 1 ELSE 0 END) AS FLOAT)
    / COUNT(*) * 100 AS tasa_mora
FROM Creditos;

-- Tasa de mora (solo sobre cr�ditos vigentes)
SELECT
    CAST(SUM(CASE 
        WHEN saldo > 0 AND fecha_vencimiento < GETDATE() THEN 1 ELSE 0 END) AS FLOAT)
    / COUNT(CASE WHEN estado = 'Vigente' THEN 1 END) * 100 AS tasa_mora
FROM Creditos;

-- Promedio de cr�ditos (forma 1)
SELECT CAST(SUM(monto) / COUNT(credito_id) AS INT) AS promedio_monto
FROM Creditos;

-- Promedio de cr�ditos (forma 2 con float)
SELECT AVG(CAST(monto AS FLOAT)) AS promedio_credito
FROM Creditos;

-- Promedio de cr�ditos por ciudad
SELECT 
    cl.ciudad,
    AVG(CAST(cr.monto AS FLOAT)) AS promedio_credito
FROM Clientes cl
JOIN Creditos cr ON cl.cliente_id = cr.cliente_id
GROUP BY cl.ciudad;
