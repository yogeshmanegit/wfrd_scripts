use master;

IF EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'WPTS_ASLUser')
BEGIN
	DROP Login WPTS_ASLUser;
END
GO

use DisJobHistoryINT1

IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'WPTS_ASLUser')
BEGIN
	DROP USER WPTS_ASLUser;
END
GO

use master
go

CREATE LOGIN [WPTS_ASLUser] WITH PASSWORD=N'd35O=HWTCcFM[N3', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
go

use DisJobHistoryINT1;

CREATE USER [WPTS_ASLUser] FOR LOGIN [WPTS_ASLUser] WITH DEFAULT_SCHEMA=[dbo]

GRANT SELECT ON IncidentTracking TO [WPTS_ASLUser];  
GRANT SELECT ON GPI1 TO [WPTS_ASLUser];  
GRANT SELECT ON [Status] TO [WPTS_ASLUser];  
GRANT SELECT ON [uvw_ExternalAuditFindings] TO [WPTS_ASLUser];  
