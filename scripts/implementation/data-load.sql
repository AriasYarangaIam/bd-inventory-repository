-- Inserción de datos en las tablas catálogo.

INSERT INTO General.DISTRITOS
    (nombre_distrito)
VALUES
    ('Lima Centro'),
    ('Miraflores'),
    ('San Isidro'),
    ('Santiago de Surco'),
    ('San Borja'),
    ('Lince'),
    ('Jesús María'),
    ('Pueblo Libre'),
    ('San Miguel'),
    ('Magdalena del Mar'),
    ('Surquillo'),
    ('Barranco'),
    ('Chorrillos'),
    ('La Molina'),
    ('Ate Vitarte'),
    ('Santa Anita'),
    ('San Juan de Lurigancho'),
    ('Independencia'),
    ('Comas'),
    ('Los Olivos');
GO

INSERT INTO General.DIRECCIONES
    (nombre_direccion)
VALUES
    ('Av. Garcilaso de la Vega 1250, CyberPlaza Int. 204'),
    ('Av. Petit Thouars 5356, Compupalace'),
    ('Calle Las Begonias 450, Torre Tecnológica'),
    ('Av. Javier Prado Este 4560, Almacén Central'),
    ('Jirón Paruro 1430, Galería Comercial'),
    ('Av. Argentina 3090, Parque Industrial'),
    ('Av. Los Frutales 220, Zona Logística'),
    ('Calle Los Halcones 150, Surquillo'),
    ('Av. La Marina 2500, Local Comercial'),
    ('Av. Carlos Izaguirre 850, MegaCentro'),
    ('Av. Elmer Faucett 1920, Zona Aduanera'),
    ('Av. República de Panamá 3420'),
    ('Calle Los Negocios 420, Edificio B'),
    ('Av. Nicolás Ayllón 2890, Almacén 4'),
    ('Av. Próceres de la Independencia 1540'),
    ('Jirón Camaná 1150, Centro de Lima'),
    ('Av. Benavides 3450, Piso 3'),
    ('Calle Las Camelias 890, San Isidro'),
    ('Av. Tomás Valle 1200, Complejo Norte'),
    ('Av. Defensores del Morro 1850, Chorrillos');
GO

INSERT INTO Logistica.CATEGORIAS
    (nombre_categoria)
VALUES
    ('Laptops y Notebooks'),
    ('Smartphones'),
    ('Monitores'),
    ('Teclados y Mouses'),
    ('Almacenamiento SSD'),
    ('Discos Duros HDD'),
    ('Memorias RAM'),
    ('Tarjetas de Video (GPU)'),
    ('Placas Madre'),
    ('Procesadores (CPU)'),
    ('Fuentes de Poder'),
    ('Gabinetes y Cases'),
    ('Audífonos y Headsets'),
    ('Micrófonos Profesionales'),
    ('Cámaras Web'),
    ('Impresoras y Suministros'),
    ('Equipos de Red (Routers)'),
    ('Cables y Adaptadores'),
    ('Sillas y Escritorios Gamer'),
    ('Software y Licencias');
GO

-- Inserción en las tablas para operaciones

INSERT INTO Logistica.ALMACENES
    (codigo_almacen, id_direccion, capacidad)
VALUES
    ('ALM01', 1, 150),
    ('ALM02', 2, 200),
    ('ALM03', 3, 120),
    ('ALM04', 4, 500),
    ('ALM05', 5, 80),
    ('ALM06', 6, 350),
    ('ALM07', 7, 400),
    ('ALM08', 8, 100),
    ('ALM09', 9, 150),
    ('ALM10', 10, 250),
    ('ALM11', 11, 300),
    ('ALM12', 12, 180),
    ('ALM13', 13, 220),
    ('ALM14', 14, 450),
    ('ALM15', 15, 130),
    ('ALM16', 16, 90),
    ('ALM17', 17, 160),
    ('ALM18', 18, 140),
    ('ALM19', 19, 210),
    ('ALM20', 20, 170);
GO

INSERT INTO Comercial.CLIENTES
    (dni, id_distrito, primer_nombre, primer_apellido, segundo_apellido)
VALUES
    ('71000001', 1, 'Juan', 'Perez', 'Gomez'),
    ('71000002', 2, 'Maria', 'Chuquimia', 'Rojas'),
    ('71000003', 3, 'Carlos', 'Mendoza', 'Torres'),
    ('71000004', 4, 'Ana', 'Vargas', 'Lopez'),
    ('71000005', 5, 'Luis', 'Fernandez', 'Silva'),
    ('71000006', 6, 'Jorge', 'Mamani', 'Condori'),
    ('71000007', 7, 'Claudia', 'Benitez', 'Flores'),
    ('71000008', 8, 'Pedro', 'Salinas', 'Vega'),
    ('71000009', 9, 'Carla', 'Fuentes', 'Rojas'),
    ('71000010', 10, 'Diego', 'Caceres', 'Lazo'),
    ('71000011', 11, 'Sofia', 'Morales', 'Cruz'),
    ('71000012', 12, 'Andres', 'Herrera', 'Poma'),
    ('71000013', 13, 'Valeria', 'Chavez', 'Noriega'),
    ('71000014', 14, 'Raul', 'Paredes', 'Limas'),
    ('71000015', 15, 'Natalia', 'Ramos', 'Delgado'),
    ('71000016', 16, 'Fernando', 'Alvarado', 'Soto'),
    ('71000017', 17, 'Isabella', 'Gutierrez', 'Paz'),
    ('71000018', 18, 'Kevin', 'Quispe', 'Tapia'),
    ('71000019', 19, 'Daniela', 'Lozano', 'Rios'),
    ('71000020', 20, 'Sebastian', 'Villanueva', 'Tello');
GO

INSERT INTO Logistica.PRODUCTOS
    (id_categoria, nombre_producto, precio, descripcion)
VALUES
    (1, 'Laptop HP 14-dq', 1250.00, 'Laptop gama de entrada, Intel Celeron, 4GB RAM, 128GB SSD. Ideal ofimática.'),
    (2, 'Xiaomi Redmi 12C', 450.00, 'Smartphone económico, MediaTek Helio G85, 4GB RAM, 128GB almacenamiento.'),
    (3, 'Monitor Terraz 22"', 280.00, 'Monitor Full HD 60Hz, panel VA, conexión HDMI y VGA.'),
    (4, 'Combo Teclado/Mouse Logitech MK120', 55.00, 'Kit alámbrico USB, diseño resistente a salpicaduras.'),
    (5, 'SSD Kingston A400 480GB', 125.00, 'Unidad de estado sólido SATA 2.5 pulgadas, lectura hasta 500MB/s.'),
    (6, 'Disco Duro Seagate Barracuda 1TB', 180.00, 'Disco duro mecánico HDD 3.5 pulgadas, 7200 RPM, SATA 6Gb/s.'),
    (7, 'Memoria RAM Crucial 8GB DDR4', 90.00, 'Módulo de memoria RAM 2666MHz CL19 para PC de escritorio.'),
    (8, 'Tarjeta de Video GTX 1650 4GB', 650.00, 'GPU gama media-baja, GDDR6, ideal para eSports y diseño básico.'),
    (9, 'Placa Madre Gigabyte H410M', 260.00, 'Motherboard Micro-ATX LGA 1200, soporte para Intel 10ma Gen.'),
    (10, 'Procesador Intel Core i3-10100F', 320.00, 'CPU de 4 núcleos y 8 hilos, requiere tarjeta gráfica dedicada.'),
    (11, 'Fuente de Poder Antryx 450W', 110.00, 'Fuente estándar no modular para ensambles de oficina.'),
    (12, 'Case Halion con Fuente 600W', 140.00, 'Gabinete ATX estándar incluye fuente genérica y kit teclado/mouse.'),
    (13, 'Audífonos Redragon Ares', 85.00, 'Headset estéreo con micrófono incorporado, conector 3.5mm.'),
    (14, 'Micrófono de Solapa Boya M1', 60.00, 'Micrófono lavalier omnidireccional, cable de 6 metros.'),
    (15, 'Cámara Web Halion 720p', 45.00, 'Webcam básica con micrófono integrado, conexión USB Plug & Play.'),
    (16, 'Impresora Multifuncional HP DeskJet', 190.00, 'Impresora a inyección de tinta, conectividad WiFi y USB.'),
    (17, 'Router TP-Link TL-WR840N', 65.00, 'Router inalámbrico N 300Mbps, 2 antenas externas.'),
    (18, 'Cable HDMI Vention 2 Metros', 15.00, 'Cable trenzado HDMI 2.0, soporta 4K a 60Hz.'),
    (19, 'Silla de Oficina Ergonómica Básica', 160.00, 'Silla con respaldo de malla transpirable, altura ajustable.'),
    (20, 'Antivirus ESET NOD32 (1 Año)', 80.00, 'Licencia digital para 1 PC, protección básica contra malware.');
GO

INSERT INTO Comercial.VENTAS (dni, fecha_evento)
VALUES 
    ('71000001', '2026-05-01 10:15:00'), 
    ('71000002', '2026-05-02 11:30:00'), 
    ('71000003', '2026-05-03 09:45:00'), 
    ('71000004', '2026-05-04 14:20:00'), 
    ('71000005', '2026-05-05 16:10:00'), 
    ('71000006', '2026-05-06 12:05:00'), 
    ('71000007', '2026-05-07 15:50:00'), 
    ('71000008', '2026-05-08 10:25:00'), 
    ('71000009', '2026-05-09 11:40:00'), 
    ('71000010', '2026-05-10 13:15:00');
GO

INSERT INTO Comercial.DETALLE_VENTA
    (codigo_venta, id_producto, cantidad_vendida, precio_unitario_venta)
VALUES

    (1, 2, 5, 450.00),
    (1, 18, 5, 15.00),
    (2, 3, 1, 280.00),
    (2, 4, 2, 55.00),
    (3, 8, 1, 650.00),
    (3, 9, 1, 260.00),
    (3, 10, 1, 320.00),
    (3, 11, 1, 110.00),
    (3, 12, 1, 140.00),
    (4, 13, 3, 85.00),
    (4, 14, 2, 60.00),
    (5, 15, 4, 45.00),
    (6, 16, 1, 190.00),
    (7, 1, 1, 1250.00),
    (7, 19, 1, 160.00),
    (8, 2, 1, 450.00),
    (8, 5, 2, 125.00),
    (9, 20, 10, 80.00),
    (10, 17, 2, 65.00),
    (10, 18, 4, 15.00);
GO

INSERT INTO Logistica.INVENTARIO (id_producto, codigo_almacen, cantidad_disponible)
VALUES 
    (1, 'ALM01', 45),   (2, 'ALM02', 120),  (3, 'ALM03', 60),   (4, 'ALM04', 300),
    (5, 'ALM05', 150),  (6, 'ALM06', 80),   (7, 'ALM07', 250),  (8, 'ALM08', 35),
    (9, 'ALM09', 75),   (10, 'ALM10', 90),  (11, 'ALM11', 110), (12, 'ALM12', 65),
    (13, 'ALM13', 180), (14, 'ALM14', 95),  (15, 'ALM15', 210), (16, 'ALM16', 40),
    (17, 'ALM17', 130), (18, 'ALM18', 500), (19, 'ALM19', 25),  (20, 'ALM20', 999);
GO