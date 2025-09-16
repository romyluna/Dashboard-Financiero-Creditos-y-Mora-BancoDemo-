# Dashboard Financiero – Créditos y Mora - BancoDemo 

# Proyecto SQL + Power BI 📊

Este proyecto es una base de datos de ejemplo para practicar consultas SQL relacionadas con clientes y créditos. Incluye la creación de tablas, inserción de datos y consultas útiles para análisis y KPIs.
</br>
</br>Power BI con algunas consultas vinculadas a vistas de SQL.

---

## 📂 Contenido del proyecto

🔹 BancoDemo.sql → Script para crear la base de datos, tablas y cargar datos iniciales.

🔹 ConsultasBancoDemo.sql → Colección de consultas SQL de análisis y métricas.

🔹 bancoDemo.pbix-> graficos en power Bi conectado a vistas de SQL

## 🏗️ Cómo usarlo

🔹 Abrí SQL Server Management Studio (SSMS) u otro gestor compatible.

🔹 Ejecutá el script BancoDemo.sql para crear la base y poblarla con datos.

🔹 Ejecutá el script ConsultasBancoDemo.sql para correr las consultas.

---

## 📊 Consultas SQL

🔹 Tablas base: listado de Clientes y Créditos, y unión básica entre ambas.

🔹 Distribución de créditos: total de créditos por cliente y por ciudad.

🔹 Saldos pendientes: por cliente, por ciudad y combinación cliente/ciudad (solo vigentes).

🔹 Créditos cancelados: total por ciudad.

🔹 Métricas de clientes: cantidad de clientes con crédito vigente y días transcurridos desde otorgamiento.

🔹 Mora: lista de clientes en mora y créditos en mora por cliente (cantidad y saldo).

🔹 KPIs: tasa de mora, promedio de créditos general y promedio por ciudad.

---

## 🚀 Potenciales usos

🔹 Practicar SQL (joins, group by, agregaciones, funciones de fecha).

🔹 Usar la base como fuente de datos para reportes en Power BI.

🔹 Conexion de Power BI con SQL mediante 5 vistas que se crearon en base algunas consultas hechas en SQL 

---

## 📊 POWER BI - Créditos & Mora 

![POWER_BI](https://github.com/romyluna/Dashboard-Financiero-Creditos-y-Mora-BancoDemo-/raw/main/screenshots/uno.png)

## 📄 Vistas SQL utilizadas en Power BI

## 1- v_TotalCreditosCliente

🔹 Muestra el total de créditos por cliente (nombre y cliente_id).

## 2- v_ClientesMora

🔹 Lista clientes con créditos en mora.

## 3- v_TasaMora

🔹 Calcula la tasa de mora sobre créditos vigentes (% de créditos vencidos con saldo pendiente).

Nota: da 100% porque puse de ejemplo 3 clientes de los cuales 2 estan en mora y uno cancelo su credito 

## 4-  v_PromedioCreditos

🔹 Calcula el promedio de monto de créditos.

---

### 👩‍💻 Contacto
<a name="contacto"></a>

👩‍💻 Romina Olivera Luna
</br>
💌 rominalunaolivera@gmail.com
</br>
🔗 [LinkedIn
](https://www.linkedin.com/in/romina-bluna/)

[⬆️ Volver arriba](#readme)

