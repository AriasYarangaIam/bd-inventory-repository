USE inventory_db;
GO

CREATE PROCEDURE Comercial.usp_RegistrarVentaDetalle
    @dni_cliente CHAR(8),
    @codigo_producto INT,
    @cantidad INT,
    @codigo_almacen CHAR(5)

AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Declarando variable para obtener el precio unitario del producto
        DECLARE @precio_unitario DECIMAL(10, 2);

        -- Obteniendo el precio unitario del producto
        SELECT @precio_unitario = precio
    FROM Logistica.PRODUCTOS
    WHERE id_producto = @codigo_producto;

        -- Declarando variable para obtener el código de venta
        DECLARE @codigo_venta INT;

        INSERT INTO Comercial.VENTAS
        (dni, fecha_evento)
    VALUES
        (@dni_cliente, GETDATE());

        -- Obteniendo el código de venta generado
        SELECT @codigo_venta = SCOPE_IDENTITY();

        -- Insertando el detalle de la venta generada anteriormente
        INSERT INTO Comercial.DETALLE_VENTA
        (codigo_venta, id_producto, cantidad_vendida, precio_unitario_venta)
    VALUES
        (@codigo_venta, @codigo_producto, @cantidad, @precio_unitario);

        -- Actualizando el stock del producto vendido
        UPDATE Logistica.INVENTARIO
        SET cantidad_disponible = cantidad_disponible - @cantidad
        WHERE id_producto = @codigo_producto AND codigo_almacen = @codigo_almacen;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
        ROLLBACK TRANSACTION;
        END
        -- Manejo de errores
        DECLARE @ErrorMessage NVARCHAR(2000),
                @ErrorSeverity INT,
                @ErrorState INT;
        
        SELECT @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-- Ejecución de prueba del Procedimiento Almacenado
EXEC Comercial.usp_RegistrarVentaDetalle 
    @dni_cliente = '71000001', 
    @codigo_producto = 1, 
    @cantidad = 2, 
    @codigo_almacen = 'ALM01';
GO

