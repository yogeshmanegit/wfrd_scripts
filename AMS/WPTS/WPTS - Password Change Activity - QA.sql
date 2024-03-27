USE Master; 
IF EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'WPTSWebUser')
BEGIN
	DROP Login WPTSWebUser;
END
GO

IF EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'WPTSJobsOfflineUser')
BEGIN
	DROP Login WPTSJobsOfflineUser;
END
GO

IF EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'WPTSFishingOfflineUser')
BEGIN
	DROP Login WPTSFishingOfflineUser;
END
GO

IF EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'WPTSSSISUser')
BEGIN
	DROP Login WPTSSSISUser;
END
GO

IF EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'AccuViewUser')
BEGIN
	DROP Login AccuViewUser;
END
GO

IF EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'ValkyrieUser')
BEGIN
	DROP Login ValkyrieUser;
END
GO

IF EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'WPTS_ASLUser')
BEGIN
	DROP Login WPTS_ASLUser;
END
GO

IF EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'WFT\srv_apbis1')
BEGIN
	DROP Login [WFT\srv_apbis1];
END
GO


--- Drop users 
USE DisJobHistoryINT1;

IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'WPTSWebUser')
BEGIN
    DROP USER WPTSWebUser;
END

IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'WPTSJobsOfflineUser')
BEGIN
    DROP USER WPTSJobsOfflineUser;
END
GO

IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'WPTSFishingOfflineUser')
BEGIN
    DROP USER WPTSFishingOfflineUser;
END
GO

IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'WPTSSSISUser')
BEGIN
    DROP USER WPTSSSISUser;
END
GO

IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'AccuViewUser')
BEGIN
    DROP USER AccuViewUser;
END
GO

IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'ValkyrieUser')
BEGIN
    DROP USER ValkyrieUser;
END
GO

IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'WPTS_ASLUser')
BEGIN
	DROP USER WPTS_ASLUser;
END
GO

use OFIIntegrate_Multilang;

IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'WPTSWebUser')
BEGIN
    DROP USER WPTSWebUser;
END

IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'WPTSJobsOfflineUser')
BEGIN
    DROP USER WPTSJobsOfflineUser;
END
GO

IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'WPTSFishingOfflineUser')
BEGIN
    DROP USER WPTSFishingOfflineUser;
END
GO

IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'WPTSSSISUser')
BEGIN
    DROP USER WPTSSSISUser;
END
GO

IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'AccuViewUser')
BEGIN
    DROP USER AccuViewUser;
END
GO

IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'ValkyrieUser')
BEGIN
    DROP USER ValkyrieUser;
END
GO

use WPTS_DataMart;
IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'wft\srv_apbis1')
BEGIN
    DROP USER [wft\srv_apbis1];
END
GO

-------------------------------------------------------------------------------------


use master;
CREATE LOGIN [WptsWebUser] WITH PASSWORD=N'JLTQW@I?L?9PAaN', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
CREATE LOGIN [WptsJobsOfflineUser] WITH PASSWORD=N'bL5NCO<EQHP5\Q5', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
CREATE LOGIN [WptsFishingOfflineUser] WITH PASSWORD=N'd@X9CYXYWYQDB@X', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
CREATE LOGIN [WptsSsisUser] WITH PASSWORD=N'ZA=S8J4O_QW=]RO', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
--CREATE LOGIN [AccuViewUser] WITH PASSWORD=N'OYZRSVQIK5^[cVU', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
CREATE LOGIN [ValkyrieUser] WITH PASSWORD=N'M]2MUZQMZWVZ\HG', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
CREATE LOGIN [WPTS_ASLUser] WITH PASSWORD=N'd35O=HWTCcFM[N3', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
CREATE LOGIN [WFT\SRV_APBIS1] FROM WINDOWS WITH DEFAULT_DATABASE=[WPTS_DataMart], DEFAULT_LANGUAGE=[us_english]

USE DisJobHistoryINT1;
CREATE USER [WptsWebUser] FOR LOGIN [WPTSWebUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [WptsJobsOfflineUser] FOR LOGIN [WptsJobsOfflineUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [WptsFishingOfflineUser] FOR LOGIN [WptsFishingOfflineUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [WptsSsisUser] FOR LOGIN [WptsSsisUser] WITH DEFAULT_SCHEMA=[dbo]
--CREATE USER [AccuViewUser] FOR LOGIN [AccuViewUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [ValkyrieUser] FOR LOGIN [ValkyrieUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [WPTS_ASLUser] FOR LOGIN [WPTS_ASLUser] WITH DEFAULT_SCHEMA=[dbo]


GRANT SELECT, INSERT, UPDATE, DELETE, EXEC TO [WPTSWebUser];
GRANT SELECT, INSERT, UPDATE, DELETE, EXEC TO [WptsJobsOfflineUser];
GRANT SELECT, INSERT, UPDATE, DELETE, EXEC TO [WptsFishingOfflineUser];
GRANT SELECT TO [WptsSsisUser];
--GRANT SELECT TO [AccuViewUser];
GRANT SELECT TO [ValkyrieUser];
GRANT SELECT ON IncidentTracking TO [WPTS_ASLUser];  
GRANT SELECT ON GPI1 TO [WPTS_ASLUser];  
GRANT SELECT ON [Status] TO [WPTS_ASLUser];  
GRANT SELECT ON [uvw_ExternalAuditFindings] TO [WPTS_ASLUser];  

----------
use OFIIntegrate_Multilang;

CREATE USER [WptsWebUser] FOR LOGIN [WPTSWebUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [WptsJobsOfflineUser] FOR LOGIN [WptsJobsOfflineUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [WptsFishingOfflineUser] FOR LOGIN [WptsFishingOfflineUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [WptsSsisUser] FOR LOGIN [WptsSsisUser] WITH DEFAULT_SCHEMA=[dbo]
--CREATE USER [AccuViewUser] FOR LOGIN [AccuViewUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [ValkyrieUser] FOR LOGIN [ValkyrieUser] WITH DEFAULT_SCHEMA=[dbo]

GRANT SELECT, INSERT, UPDATE, DELETE, EXEC TO [WPTSWebUser];
GRANT SELECT, INSERT, UPDATE, DELETE, EXEC TO [WptsJobsOfflineUser];
GRANT SELECT, INSERT, UPDATE, DELETE, EXEC TO [WptsFishingOfflineUser];
GRANT SELECT TO [WptsSsisUser];
--GRANT SELECT TO [AccuViewUser];
GRANT SELECT TO [ValkyrieUser];

use WPTS_DataMart;
CREATE USER [WFT\SRV_APBIS1] FOR LOGIN [WFT\SRV_APBIS1] WITH DEFAULT_SCHEMA=[dbo]
GRANT SELECT ON [uvw_vps] TO [WFT\SRV_APBIS1];
