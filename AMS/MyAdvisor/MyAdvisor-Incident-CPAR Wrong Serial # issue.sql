select f.AssetNumber, t.SerialNum, f.SerialNum , 
'UPDATE FixedAssets SET SerialNum = '''+ t.serialnum + ''' where FixedAssetId='''+ CONVERT(VARCHAR(100), f.FixedAssetId) +''''
from Incidents i
join ToolStringComponentInfo t on i.IncidentID = t.IncidentID
join FixedAssets f on f.FixedAssetId = t.FixedAssetID and f.SerialNum != t.SerialNum
where i.CPARId ='4210434' and f.AssetNumber is null
