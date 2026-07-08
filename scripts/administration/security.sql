CREATE LOGIN Faber WITH PASSWORD = 'Sys_ProveeTech2026!';

CREATE USER user_George FOR LOGIN Faber;

DROP USER user_George;

CREATE ROLE Rol_Cajero;

ALTER ROLE Rol_Cajero ADD MEMBER user_George;

GRANT SELECT, INSERT ON SCHEMA::Comercial TO Rol_Cajero;
GRANT EXECUTE ON OBJECT::Comercial.usp_RegistrarVentaDetalle TO Rol_Cajero;


CREATE USER user_Ivvy FOR LOGIN Faber;

DROP USER user_Ivvy;

CREATE ROLE Rol_Auditor;

ALTER ROLE Rol_Auditor ADD MEMBER user_Ivvy;

GRANT SELECT ON SCHEMA::Comercial TO Rol_Auditor;
GRANT SELECT ON SCHEMA::Logistica TO Rol_Auditor;


SELECT
    usuario.name AS NombreUsuario,
    usuario.type_desc AS Tipo,
    rol.name AS NombreRol
FROM sys.database_role_members rm
    JOIN sys.database_principals usuario ON rm.member_principal_id = usuario.principal_id
    JOIN sys.database_principals rol ON rm.role_principal_id = rol.principal_id
WHERE usuario.name IN ('user_George', 'user_Ivvy');

SELECT
    rol.name AS NombreRol,
    permiso.permission_name AS PermisoOtorgado,
    permiso.state_desc AS Estado,
    ISNULL(esquema.name, objeto.name) AS AplicadoA,
    permiso.class_desc AS TipoObjeto
FROM sys.database_permissions permiso
    JOIN sys.database_principals rol ON permiso.grantee_principal_id = rol.principal_id
    LEFT JOIN sys.schemas esquema ON permiso.class = 3 AND permiso.major_id = esquema.schema_id
    LEFT JOIN sys.objects objeto ON permiso.class = 1 AND permiso.major_id = objeto.object_id
WHERE rol.name IN ('Rol_Cajero', 'Rol_Auditor');