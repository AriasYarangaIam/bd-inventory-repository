USE inventory_db;
GO

-- ============================================================
-- Script de verificación post-despliegue
-- Comprueba que el esquema, datos y objetos programables
-- estén correctamente creados después de ejecutar el proyecto.
-- ============================================================

DECLARE @errores INT = 0;

PRINT '--- 1. Verificando esquemas ---';
IF NOT EXISTS (
    SELECT 1 FROM sys.schemas WHERE name IN ('General', 'Logistica', 'Comercial')
    GROUP BY name HAVING COUNT(*) = 1
)
BEGIN
    PRINT 'ERROR: Faltan esquemas requeridos.';
    SET @errores += 1;
END
ELSE
BEGIN
    PRINT 'OK: Esquemas General, Logistica y Comercial existen.';
END

PRINT '--- 2. Verificando tablas principales ---';
DECLARE @tablas_esperadas TABLE (nombre SYSNAME);
INSERT INTO @tablas_esperadas VALUES
    ('General.DISTRITOS'), ('General.DIRECCIONES'), ('Logistica.CATEGORIAS'),
    ('Logistica.ALMACENES'), ('Comercial.CLIENTES'), ('Logistica.PRODUCTOS'),
    ('Comercial.VENTAS'), ('Comercial.DETALLE_VENTA'), ('Logistica.INVENTARIO'),
    ('Logistica.HISTORIAL_PRECIOS');

IF EXISTS (
    SELECT 1 FROM @tablas_esperadas t
    WHERE NOT EXISTS (
        SELECT 1 FROM sys.tables tb
        JOIN sys.schemas s ON tb.schema_id = s.schema_id
        WHERE CONCAT(s.name, '.', tb.name) = t.nombre
    )
)
BEGIN
    PRINT 'ERROR: Faltan tablas requeridas.';
    SET @errores += 1;
END
ELSE
BEGIN
    PRINT 'OK: Todas las tablas principales existen.';
END

PRINT '--- 3. Verificando datos mínimos de catálogos ---';
DECLARE @conteos TABLE (tabla SYSNAME, minimo INT);
INSERT INTO @conteos VALUES
    ('General.DISTRITOS', 20),
    ('General.DIRECCIONES', 20),
    ('Logistica.CATEGORIAS', 20),
    ('Logistica.ALMACENES', 20),
    ('Comercial.CLIENTES', 20),
    ('Logistica.PRODUCTOS', 20),
    ('Comercial.VENTAS', 10),
    ('Comercial.DETALLE_VENTA', 20),
    ('Logistica.INVENTARIO', 20);

DECLARE @tabla SYSNAME, @minimo INT, @cantidad INT;
DECLARE c CURSOR FOR SELECT tabla, minimo FROM @conteos;
OPEN c;
FETCH NEXT FROM c INTO @tabla, @minimo;
WHILE @@FETCH_STATUS = 0
BEGIN
    EXECUTE('SELECT @cantidad = COUNT(*) FROM ' + @tabla);

    IF @cantidad < @minimo
    BEGIN
        PRINT 'ERROR: ' + @tabla + ' tiene ' + CAST(@cantidad AS VARCHAR) + ' registros (minimo ' + CAST(@minimo AS VARCHAR) + ').';
        SET @errores += 1;
    END
    ELSE
    BEGIN
        PRINT 'OK: ' + @tabla + ' tiene ' + CAST(@cantidad AS VARCHAR) + ' registros.';
    END

    FETCH NEXT FROM c INTO @tabla, @minimo;
END
CLOSE c;
DEALLOCATE c;

PRINT '--- 4. Verificando integridad referencial básica ---';
DECLARE @huerfanos INT;

SELECT @huerfanos = COUNT(*) FROM Comercial.CLIENTES c
LEFT JOIN General.DISTRITOS d ON c.id_distrito = d.id_distrito
WHERE d.id_distrito IS NULL;
IF @huerfanos > 0
BEGIN
    PRINT 'ERROR: CLIENTES con distrito huérfano: ' + CAST(@huerfanos AS VARCHAR);
    SET @errores += 1;
END

SELECT @huerfanos = COUNT(*) FROM Logistica.ALMACENES a
LEFT JOIN General.DIRECCIONES d ON a.id_direccion = d.id_direccion
WHERE d.id_direccion IS NULL;
IF @huerfanos > 0
BEGIN
    PRINT 'ERROR: ALMACENES con dirección huérfana: ' + CAST(@huerfanos AS VARCHAR);
    SET @errores += 1;
END

SELECT @huerfanos = COUNT(*) FROM Logistica.PRODUCTOS p
LEFT JOIN Logistica.CATEGORIAS c ON p.id_categoria = c.id_categoria
WHERE c.id_categoria IS NULL;
IF @huerfanos > 0
BEGIN
    PRINT 'ERROR: PRODUCTOS con categoría huérfana: ' + CAST(@huerfanos AS VARCHAR);
    SET @errores += 1;
END

SELECT @huerfanos = COUNT(*) FROM Comercial.VENTAS v
LEFT JOIN Comercial.CLIENTES c ON v.dni = c.dni
WHERE c.dni IS NULL;
IF @huerfanos > 0
BEGIN
    PRINT 'ERROR: VENTAS con cliente huérfano: ' + CAST(@huerfanos AS VARCHAR);
    SET @errores += 1;
END

SELECT @huerfanos = COUNT(*) FROM Comercial.DETALLE_VENTA dv
LEFT JOIN Comercial.VENTAS v ON dv.codigo_venta = v.codigo_venta
LEFT JOIN Logistica.PRODUCTOS p ON dv.id_producto = p.id_producto
WHERE v.codigo_venta IS NULL OR p.id_producto IS NULL;
IF @huerfanos > 0
BEGIN
    PRINT 'ERROR: DETALLE_VENTA con venta o producto huérfano: ' + CAST(@huerfanos AS VARCHAR);
    SET @errores += 1;
END

SELECT @huerfanos = COUNT(*) FROM Logistica.INVENTARIO i
LEFT JOIN Logistica.PRODUCTOS p ON i.id_producto = p.id_producto
LEFT JOIN Logistica.ALMACENES a ON i.codigo_almacen = a.codigo_almacen
WHERE p.id_producto IS NULL OR a.codigo_almacen IS NULL;
IF @huerfanos > 0
BEGIN
    PRINT 'ERROR: INVENTARIO con producto o almacén huérfano: ' + CAST(@huerfanos AS VARCHAR);
    SET @errores += 1;
END

PRINT 'OK: Integridad referencial básica verificada.';

PRINT '--- 5. Verificando objetos programables ---';
IF NOT EXISTS (SELECT 1 FROM sys.procedures WHERE name = 'usp_RegistrarVentaDetalle' AND schema_id = SCHEMA_ID('Comercial'))
BEGIN
    PRINT 'ERROR: No existe el stored procedure Comercial.usp_RegistrarVentaDetalle.';
    SET @errores += 1;
END
ELSE
BEGIN
    PRINT 'OK: Stored procedure Comercial.usp_RegistrarVentaDetalle existe.';
END

IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'trg_Auditor_Precios')
BEGIN
    PRINT 'ERROR: No existe el trigger Logistica.trg_Auditor_Precios.';
    SET @errores += 1;
END
ELSE
BEGIN
    PRINT 'OK: Trigger Logistica.trg_Auditor_Precios existe.';
END

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'udf_CalcularDescuento' AND schema_id = SCHEMA_ID('Logistica'))
BEGIN
    PRINT 'ERROR: No existe la función Logistica.udf_CalcularDescuento.';
    SET @errores += 1;
END
ELSE
BEGIN
    PRINT 'OK: Función Logistica.udf_CalcularDescuento existe.';
END

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'udf_ObtenerHistorialCliente' AND schema_id = SCHEMA_ID('Comercial'))
BEGIN
    PRINT 'ERROR: No existe la función Comercial.udf_ObtenerHistorialCliente.';
    SET @errores += 1;
END
ELSE
BEGIN
    PRINT 'OK: Función Comercial.udf_ObtenerHistorialCliente existe.';
END

PRINT '--- 6. Verificando reglas de negocio básicas ---';
IF EXISTS (SELECT 1 FROM Logistica.INVENTARIO WHERE cantidad_disponible < 0)
BEGIN
    PRINT 'ERROR: Existen registros de inventario con stock negativo.';
    SET @errores += 1;
END
ELSE
BEGIN
    PRINT 'OK: No hay stock negativo en inventario.';
END

IF EXISTS (SELECT 1 FROM Logistica.PRODUCTOS WHERE precio < 0)
BEGIN
    PRINT 'ERROR: Existen productos con precio negativo.';
    SET @errores += 1;
END
ELSE
BEGIN
    PRINT 'OK: No hay productos con precio negativo.';
END

PRINT '--- Resultado final ---';
IF @errores = 0
BEGIN
    PRINT 'VERIFICACION COMPLETADA: No se encontraron errores.';
END
ELSE
BEGIN
    PRINT 'VERIFICACION COMPLETADA CON ' + CAST(@errores AS VARCHAR) + ' ERROR(ES).';
END
GO
