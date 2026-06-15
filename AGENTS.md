# AGENTS.md — inventory_scripts

SQL Server database project for an inventory/warehouse management system.

## Database

- **Target DB**: `inventory_db` (create it before running any script).
- **T-SQL** with `GO` batch separators. Run scripts in SSMS, sqlcmd, or Azure Data Studio.

## Required execution order

Scripts depend on previous ones. Run in this order:

1. `scripts/implementation/create-tables.sql` — creates schemas (`General`, `Logistica`, `Comercial`) and all tables.
2. `scripts/implementation/data-load.sql` — seed data for all tables.
3. `scripts/implementation/create-views.sql` — views that depend on tables + data.
4. `scripts/programming/store-procedures.sql` — stored procedures (references tables).
5. `scripts/programming/triggers.sql` — triggers (references tables).
6. `scripts/programming/user-defined-functions.sql` — scalar + table-valued functions.
7. `scripts/implementation/querys-joins-agroup.sql` — analytic queries (read-only, safe to re-run).
8. `scripts/administration/security.sql` — logins/users/roles.
9. `scripts/administration/backup.sql` — backup commands (standalone).
10. `scripts/administration/verification.sql` — post-deployment checks (read-only, safe to re-run).

## Schema layout

| Schema | Purpose |
|---|---|
| `General` | Shared reference tables (districts, addresses) |
| `Logistica` | Warehousing, products, categories, inventory |
| `Comercial` | Sales, clients, sale details |

## Quirks

- `models/` directory is empty — reserved for future ER diagrams / model files.
- Backup scripts write to `C:\Users\user\OneDrive\Desktop\` — paths are hardcoded; adjust before running in other environments.
- No test framework, no CI — manual execution against a local SQL Server instance.

## Recent improvements

- Added `.gitignore` to avoid committing SQL backup and temporary files.
- Fixed `USE BD_Inventory;` typo in `security.sql`; all scripts now consistently use `inventory_db`.
- Added `scripts/administration/verification.sql` for lightweight post-deployment validation of schemas, tables, data, referential integrity, and programmable objects.
