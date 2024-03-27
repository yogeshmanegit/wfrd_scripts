
---------------------------------------------------------WPTS SSIS User --------------------------------------------------------------------------

use master;
IF EXISTS (SELECT name FROM sys.server_principals WHERE name = 'WptsSsisUser')
BEGIN
	DROP Login [WptsSsisUser];
END

USE [DISJobHistory]
IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'WptsSsisUser')
BEGIN
	DROP USER [WptsSsisUser];
END

USE [WPTS_DataMart]
IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'WptsSsisUser')
BEGIN
	DROP USER [WptsSsisUser];
END

USE [JDEJobs]
IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'WptsSsisUser')
BEGIN
	DROP USER [WptsSsisUser];
END


USE [master]
GO
CREATE LOGIN [WptsSsisUser] WITH PASSWORD=N'HD4CN=YOS@dVJBM', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
USE [DISJobHistory]
GO
CREATE USER [WptsSsisUser] FOR LOGIN [WptsSsisUser]
GO
USE [DISJobHistory]
GO
ALTER ROLE [db_datareader] ADD MEMBER [WptsSsisUser]
ALTER ROLE [db_owner] ADD MEMBER [WptsSsisUser]

--GRANT ALTER TO [WptsSsisUser]
--GRANT UPDATE ON HrmsStagingUsers TO [WptsSsisUser]
--GRANT Delete, INSERT, UPDATE ON DownHole2 TO [WptsSsisUser]
--GRANT Delete, INSERT, UPDATE ON Downhole2ToolsStaging TO [WptsSsisUser]
--GRANT Delete, UPDATE ON downhole2Tools TO [WptsSsisUser]

GO
USE [WPTS_DataMart]
GO
CREATE USER [WptsSsisUser] FOR LOGIN [WptsSsisUser]
GO
USE [WPTS_DataMart]
GO
ALTER ROLE [db_datareader] ADD MEMBER [WptsSsisUser]
GO
USE [WPTS_DataMart]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [WptsSsisUser]
GO
USE [JDEJobs]
GO
CREATE USER [WptsSsisUser] FOR LOGIN [WptsSsisUser]
GO
ALTER ROLE [db_datareader] ADD MEMBER [WptsSsisUser]
GO
GRANT ALTER TO [WptsSsisUser]
GRANT EXEC TO [WptsSsisUser]



-----------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------WPTS SSRS User --------------------------------------------------------------------------

use master;
IF EXISTS (SELECT name FROM sys.server_principals WHERE name = 'WptsSsrsUser')
BEGIN
	DROP Login [WptsSsrsUser];
END

USE [DISJobHistory]
IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'WptsSsrsUser')
BEGIN
	DROP USER [WptsSsrsUser];
END

USE [WPTS_DataMart]
IF EXISTS (SELECT name FROM sys.database_principals WHERE name = 'WptsSsrsUser')
BEGIN
	DROP USER [WptsSsrsUser];
END


USE [master]
GO
CREATE LOGIN [WptsSsrsUser] WITH PASSWORD=N'ABD4CN=ssrsdVJBM', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
USE [DISJobHistory]
GO
CREATE USER [WptsSsrsUser] FOR LOGIN [WptsSsrsUser]
GO
USE [DISJobHistory]
GO
ALTER ROLE [db_datareader] ADD MEMBER [WptsSsrsUser]
GO
USE [WPTS_DataMart]
GO
CREATE USER [WptsSsrsUser] FOR LOGIN [WptsSsrsUser]
GO
USE [WPTS_DataMart]
GO
ALTER ROLE [db_datareader] ADD MEMBER [WptsSsrsUser]
GO
-----------------------------------------------------------------------------------------------------------------------------------




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
USE DISJobHistory;

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

use WPTS_Multilang;

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
CREATE LOGIN [WptsWebUser] WITH PASSWORD=N'B^GRaC5Yc]Z6=2I', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
CREATE LOGIN [WptsJobsOfflineUser] WITH PASSWORD=N'2T1H1[@$?9@PAU*', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
CREATE LOGIN [WptsFishingOfflineUser] WITH PASSWORD=N'UcVIMS@@T?cV]bG', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
CREATE LOGIN [AccuViewUser] WITH PASSWORD=N'O@DGJJD1I8YP<BJ', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
CREATE LOGIN [ValkyrieUser] WITH PASSWORD=N'BH[]PP::[P5QAMa', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
CREATE LOGIN [WPTS_ASLUser] WITH PASSWORD=N'd35O=HWTCcFM[N3', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
CREATE LOGIN [WFT\SRV_APBIS1] FROM WINDOWS WITH DEFAULT_DATABASE=[WPTS_DataMart], DEFAULT_LANGUAGE=[us_english]
CREATE LOGIN [WptsSsrsUser] WITH PASSWORD=N'ABD4CN=ssrsdVJBM', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON

USE DISJobHistory;
CREATE USER [WptsWebUser] FOR LOGIN [WPTSWebUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [WptsJobsOfflineUser] FOR LOGIN [WptsJobsOfflineUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [WptsFishingOfflineUser] FOR LOGIN [WptsFishingOfflineUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [AccuViewUser] FOR LOGIN [AccuViewUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [ValkyrieUser] FOR LOGIN [ValkyrieUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [WPTS_ASLUser] FOR LOGIN [WPTS_ASLUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [WptsSsrsUser] FOR LOGIN [WptsSsrsUser] WITH DEFAULT_SCHEMA=[dbo]

GRANT SELECT, INSERT, UPDATE, DELETE, EXEC TO [WPTSWebUser];
GRANT SELECT, INSERT, UPDATE, DELETE, EXEC TO [WptsJobsOfflineUser];
GRANT SELECT, INSERT, UPDATE, DELETE, EXEC TO [WptsFishingOfflineUser];
GRANT SELECT TO [AccuViewUser];
GRANT SELECT TO [ValkyrieUser];
GRANT SELECT ON IncidentTracking TO [WPTS_ASLUser];  
GRANT SELECT TO [WptsSsrsUser];

----------
use WPTS_Multilang;

CREATE USER [WptsWebUser] FOR LOGIN [WPTSWebUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [WptsJobsOfflineUser] FOR LOGIN [WptsJobsOfflineUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [WptsFishingOfflineUser] FOR LOGIN [WptsFishingOfflineUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [AccuViewUser] FOR LOGIN [AccuViewUser] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [ValkyrieUser] FOR LOGIN [ValkyrieUser] WITH DEFAULT_SCHEMA=[dbo]

GRANT SELECT, INSERT, UPDATE, DELETE, EXEC TO [WPTSWebUser];
GRANT SELECT, INSERT, UPDATE, DELETE, EXEC TO [WptsJobsOfflineUser];
GRANT SELECT, INSERT, UPDATE, DELETE, EXEC TO [WptsFishingOfflineUser];
GRANT SELECT TO [AccuViewUser];
GRANT SELECT TO [ValkyrieUser];

use WPTS_DataMart;
CREATE USER [WFT\SRV_APBIS1] FOR LOGIN [WFT\SRV_APBIS1] WITH DEFAULT_SCHEMA=[dbo]
CREATE USER [WptsSsrsUser] FOR LOGIN [WptsSsrsUser] WITH DEFAULT_SCHEMA=[dbo]

GRANT SELECT ON [uvw_vps] TO [WFT\SRV_APBIS1];
GRANT SELECT TO [WptsSsrsUser];

use JDEJobs;
CREATE USER [WPTSWebUser] FOR LOGIN [WPTSWebUser] WITH DEFAULT_SCHEMA=[dbo]
ALTER ROLE [db_datareader] ADD MEMBER [WPTSWebUser]
