USE inventory_db;

BACKUP DATABASE inventory_db
TO DISK = 'C:\Users\user\OneDrive\Desktop\inventory_full.bak'
WITH FORMAT, INIT,
NAME = N'Copia de seguridad finalizada',
STATS = 10;
GO

BACKUP DATABASE inventory_db
TO DISK = 'C:\Users\user\OneDrive\Desktop\inventory_diff.bak'
WITH DIFFERENTIAL,
NAME = N'Copia de seguridad diferencial',
STATS = 10;
GO

