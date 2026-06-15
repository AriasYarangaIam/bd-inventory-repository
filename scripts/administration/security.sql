USE inventory_db;

CREATE LOGIN Fabarias WITH PASSWORD = 'Fabarias150!';

USE inventory_db;
CREATE USER user_George FOR LOGIN Fabarias;

CREATE ROLE Rol_Cajero;

ALTER ROLE Rol_Cajero ADD MEMBER user_George;

GRANT SELECT, INSERT ON SCHEMA::Comercial TO Rol_Cajero;
GRANT EXECUTE ON OBJECT::Comercial.usp_RegistrarVentaDetalle TO Rol_Cajero;


USE inventory_db;
CREATE USER user_Ivvy FOR LOGIN Fabarias;

CREATE ROLE Rol_Auditor;

ALTER ROLE Rol_Auditor ADD MEMBER user_Ivvy;

GRANT SELECT ON SCHEMA::Comercial TO Rol_Auditor;
GRANT SELECT ON SCHEMA::Logistica TO Rol_Auditor;
