

CREATE VIEW v_TotalCreditosCliente AS

-- Total de créditos por cliente
SELECT
    cl.nombre,
    cl.cliente_id,
    SUM(cr.monto) AS total_creditos
FROM Clientes cl
JOIN Creditos cr ON cl.cliente_id = cr.cliente_id
GROUP BY cl.nombre,cl.cliente_id;




CREATE VIEW v_ClientesMora AS

-- Créditos en mora por cliente (cantidad y saldo)
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


CREATE VIEW v_TasaMora AS
-- Tasa de mora (solo sobre créditos vigentes)
SELECT
    CAST(SUM(CASE 
        WHEN saldo > 0 AND fecha_vencimiento < GETDATE() THEN 1 ELSE 0 END) AS FLOAT)
    / COUNT(CASE WHEN estado = 'Vigente' THEN 1 END) * 100 AS tasa_mora
FROM Creditos;


CREATE VIEW v_PromedioCreditos AS
-- Promedio de créditos (forma 2 con float)
SELECT AVG(CAST(monto AS FLOAT)) AS promedio_credito
FROM Creditos;