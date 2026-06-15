CREATE FUNCTION Logistica.udf_CalcularDescuento(
    @cantidad INT,
    @precio_unitario DECIMAL(10, 2)
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @descuento DECIMAL(10, 2);

    IF @cantidad >= 5
        SET @descuento = @precio_unitario * 0.10;
    ELSE
        SET @descuento = 0;
    
    RETURN @descuento;
END;
GO

CREATE FUNCTION Comercial.udf_ObtenerHistorialCliente(
    @dni_cliente CHAR(8)
)
RETURNS TABLE
AS
    RETURN (
        SELECT p.nombre_producto, v.fecha_evento, dv.cantidad_vendida, dv.precio_unitario_venta
        FROM Comercial.VENTAS v
        INNER JOIN Comercial.DETALLE_VENTA dv
        ON v.codigo_venta = dv.codigo_venta
        INNER JOIN Logistica.PRODUCTOS p
        ON dv.id_producto = p.id_producto
        WHERE v.dni = @dni_cliente
    );
GO
