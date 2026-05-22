USE inventory_db;

-- Consulta que retorna nombre completo, dni, codigo de venta y fecha de la transacción

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

-- Consulta que retorna el dinero totla que ha gastado cada cliente en la tienda

SELECT
    c.dni,
    CONCAT(c.primer_nombre,
    ' ', c.primer_apellido,
    ' ', c.segundo_apellido) AS nombre_completo,
    SUM(d.cantidad_vendida * d.precio_unitario_venta) AS dinero_gastado
    FROM Comercial.CLIENTES c
    INNER JOIN Comercial.VENTAS v
    ON c.dni = v.dni
    INNER JOIN Comercial.DETALLE_VENTA d
    ON v.codigo_venta = d.codigo_venta
    GROUP BY c.dni, c.primer_nombre, c.primer_apellido, c.segundo_apellido;

SELECT * FROM Comercial.DETALLE_VENTA;

-- Consulta que muestra el codigo del almacen, la capacidad total del almacén y la suma total de cantidad disponible.
-- Filtro: Mostrar almacenes donde esa suma sea > 150.
SELECT
    a.codigo_almacen,
    a.capacidad,
    SUM(i.cantidad_disponible) AS cantidad_total_disponible
    FROM Logistica.ALMACENES a
    INNER JOIN Logistica.INVENTARIO i
    ON a.codigo_almacen = i.codigo_almacen
    GROUP BY a.codigo_almacen, a.capacidad
    HAVING SUM(i.cantidad_disponible) > 150;

-- Consulta que muestra el identificador del producto, el nombre del producto y precio
-- Filtro: Muestra únicamente productos entre 50 y 300 soles inclusive.
-- Condición: Si el precio es menor a 100, la etiqueta será 'Gama Entrada', caso contrario, sera 'Gama Media'.
SELECT
    id_producto,
    nombre_producto,
    precio,
    clasificacion = CASE
        WHEN precio < 100 THEN 'Gama Entrada'
        ELSE 'Gama Media'
        END
    FROM Logistica.PRODUCTOS
    WHERE precio BETWEEN 50 AND 300;

-- Consulta que muestra el dni, primer nombre de todos los clientes junto al codigo_venta de las ventas que han realizado.
-- Condición: El reporte debe filtrar y mostrar únicamente a los clientes que no tengan ninguna venta registrada.
SELECT
    c.dni,
    c.primer_nombre,
    v.codigo_venta
    FROM Comercial.CLIENTES c
    LEFT JOIN Comercial.VENTAS v
    ON c.dni = v.dni
    WHERE v.codigo_venta IS NULL;

-- Consulta que muestra el nombre del producto y el nombre de la categoría
-- Filtro: Mostrar únicamente categorías que no tengan ningún producto asociado.
SELECT
    p.nombre_producto,
    c.nombre_categoria
    FROM Logistica.PRODUCTOS p
    RIGHT JOIN Logistica.CATEGORIAS c
    ON p.id_categoria = c.id_categoria
    WHERE p.nombre_producto IS NULL;

-- Consulta que muestra el identificador del producto, nombre del producto junto al codigo de venta y la cantidad vendida.
SELECT 
    p.id_producto,
    p.nombre_producto,
    d.codigo_venta,
    d.cantidad_vendida
    FROM Logistica.PRODUCTOS p
    FULL OUTER JOIN Comercial.DETALLE_VENTA d
    ON p.id_producto = d.id_producto;