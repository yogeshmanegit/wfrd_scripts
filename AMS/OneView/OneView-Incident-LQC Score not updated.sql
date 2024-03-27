select Id, Created, 'UPDATE  FileManagementMetadata SET Created = ''' + CONVERT(varchar(MAX), created, 127) +''' WHERE Id = ''' + Id +'''' from FileManagementMetadata (NOLOCK) where id like '%3bdcc9f5-f95a-463d-aaf5-1fd84fb7422b%'

--UPDATE FileManagementMetadata SET Created = GETDATE() where id like '%3bdcc9f5-f95a-463d-aaf5-1fd84fb7422b%'
