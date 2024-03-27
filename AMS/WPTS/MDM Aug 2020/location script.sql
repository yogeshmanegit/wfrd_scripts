--select * from LocationMDMStructure2020

--select Hemisphere, Geozone, MDMRegion, MDMSubregion, * from HdrWFTLocations
go

ALTER VIEW dbo.vw_LocationMDM
AS

select h.ID [H_ID], h.HemisphereMDMID, h.HemisphereCode, h.HemisphereMDMName, 
g.ID [G_Id], g.GeozoneMDMID, g.GeozoneMDMCode, g.GeozoneMDMName
from hdrWFTLocations_Hemisphere h (NOLOCK)
join hdrWFTLocations_Geozone g (NOLOCK) on h.HemisphereMDMID = g.HemisphereMDMID
join hdrWFTLocations_Region r (NOLOCK) ON 
GO

select top 10 * from vw_LocationMDM