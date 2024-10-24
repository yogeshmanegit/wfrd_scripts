USE [oneview]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[sp_ImportMyAdvisorFixedAssetData]

SELECT	'Return Value' = @return_value

GO