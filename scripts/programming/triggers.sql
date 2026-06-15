CREATE TRIGGER Logistica.trg_Auditor_Precios
ON Logistica.PRODUCTOS
AFTER UPDATE
AS
BEGIN

    IF UPDATE(precio)
    BEGIN
        INSERT INTO Logistica.HISTORIAL_PRECIOS (id_producto, precio_anterior, precio_nuevo)
        SELECT i.id_producto, d.precio, i.precio
        FROM inserted i
        INNER JOIN deleted d
        ON i.id_producto = d.id_producto;
    END
END;
GO 