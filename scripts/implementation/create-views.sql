-- Creación de vistas
CREATE VIEW Comercial.vw_ReporteDespacho AS
SELECT 
    CONCAT(c.primer_nombre,
    ' ', c.primer_apellido,
    ' ', c.segundo_apellido) AS nombre_completo,
    c.dni,
    v.codigo_venta,
    v.fecha_evento
    FROM Comercial.CLIENTES c
    INNER JOIN Comercial.VENTAS v
    ON c.dni = v.dni;
    GO

CREATE VIEW Logistica.vw_AlmacenesCriticos AS
SELECT
    a.codigo_almacen,
    a.capacidad,
    SUM(i.cantidad_disponible) AS cantidad_total_disponible
    FROM Logistica.ALMACENES a
    INNER JOIN Logistica.INVENTARIO i
    ON a.codigo_almacen = i.codigo_almacen
    GROUP BY a.codigo_almacen, a.capacidad
    HAVING SUM(i.cantidad_disponible) > 150;
    GO