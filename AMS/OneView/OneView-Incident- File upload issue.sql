
SELECT 
'INSERT INTO FileManagementMetadata (ID, Bucket, VirtualPath, IsFile, IsDirectory, Version, Created, CreatedBy, Owner, Hash, Length, BytesWritten, IsPending, ResumeKey) VALUES (' +
'''' + 'OneView/Jobs/' + CONVERT(varchar(4),year(j.dateSubmitted)) + '/' + CONVERT(varchar(4),month(j.dateSubmitted)) + '/' + LOWER(CONVERT(varchar(100), j.jobID)) + ''',' +
'''OneView'','+ '''' + 'Jobs/' + CONVERT(varchar(4),year(j.dateSubmitted)) + '/' + CONVERT(varchar(4),month(j.dateSubmitted)) + '/' + LOWER(CONVERT(varchar(100), j.jobID)) + ''''
+',0,1,0, GETDATE(), ''WFT\e220932'',''e220932'',null, 0, 0, 0, null)',

'INSERT INTO FileManagementMetadata (ID, Bucket, VirtualPath, IsFile, IsDirectory, Version, Created, CreatedBy, Owner, Hash, Length, BytesWritten, IsPending, ResumeKey) VALUES (' +
'''' + 'OneView/Jobs/' + CONVERT(varchar(4),year(j.dateSubmitted)) + '/' + CONVERT(varchar(4),month(j.dateSubmitted)) + '/' + LOWER(CONVERT(varchar(100), j.jobID)) + '/internal'',' +
'''OneView'','+ '''' + 'Jobs/' + CONVERT(varchar(4),year(j.dateSubmitted)) + '/' + CONVERT(varchar(4),month(j.dateSubmitted)) + '/' + LOWER(CONVERT(varchar(100), j.jobID)) + '/internal'''
+',0,1,0, GETDATE(), ''WFT\e220932'',''e220932'',null, 0, 0, 0, null)'


FROM ONEVIEW.DBO.JOB J (NOLOCK)
LEFT JOIN FileManagementMetadata F (NOLOCK) on f.Id like '%' + CONVERT(VARCHAR(100),j.jobID) + '%'
WHERE --j.jobID = 'b8c5b1aa-2e42-4bbd-a44f-22e9ea3d66d5' and 
f.Id is null and j.dateSubmitted > '2022-01-01'

