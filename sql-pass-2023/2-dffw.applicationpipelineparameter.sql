
 -- dffw.applicationpipelineparameter table
print 'dffw.applicationpipelineparameter table'
If Not Exists(Select s.[name] + '.' + t.[name]
              From [sys].[tables] t
			  Join [sys].[schemas] s
			    On s.[schema_id] = t.[schema_id]
			  Where s.[name] = N'dffw'
			    And t.[name] = N'applicationpipelineparameter')
 begin
  print ' - Creating dffw.applicationpipelineparameter table'
  Create Table dffw.applicationpipelineparameter
  (
   applicationpipelineparameterId int identity(1, 1) Not NULL
    Constraint PK_dffw_applicationpipelineparameter
	 Primary Key Clustered
  ,applicationpipelineId int Not NULL
    Constraint FK_dffw_applicationpipelineparameter_applicationpipeline
	 Foreign Key
	  References dffw.[applicationpipeline](applicationpipelineId)
  ,parametername nvarchar(255) Not NULL
  ,parametervalue sql_variant Not NULL
  )
  print ' - dffw.applicationpipelineparameter table created'
 end
Else
 begin
  print ' - dffw.applicationpipelineparameter table already exists.'
 end
print ''

 -- dffw.addOrUpdateApplicationPipelineParameter stored procedure
print 'dffw.addOrUpdateApplicationPipelineParameter stored procedure'
If Exists(Select s.[name] + '.' + p.[name]
          From [sys].[procedures] p
          Join [sys].[schemas] s
			On s.[schema_id] = p.[schema_id]
		  Where s.[name] = N'dffw'
			And p.[name] = N'addOrUpdateApplicationPipelineParameter')
 begin
  print ' - Dropping dffw.addOrUpdateApplicationPipelineParameter stored procedure'
  Drop Procedure dffw.addOrUpdateApplicationPipelineParameter
  print ' - dffw.addOrUpdateApplicationPipelineParameter stored procedure dropped'
 end

print ' - Creating dffw.addOrUpdateApplicationPipelineParameter stored procedure'
go

Create Procedure dffw.addOrUpdateApplicationPipelineParameter
 @ApplicationName nvarchar(255)
,@PipelineName nvarchar(255)
,@ParameterName nvarchar(255)
,@ParameterValue sql_variant
As

 if(
    (@ApplicationName Is NULL)
	Or
	(@ApplicationName = '')
   )
 begin
  RaisError('@ApplicationName is NULL or empty.', 16, 1);
  return;
 end
 
 if(
    (@PipelineName Is NULL)
	Or
	(@PipelineName = '')
   )
 begin
  RaisError('@PipelineName is NULL or empty.', 16, 1);
  return;
 end

 if(
    (@ParameterName Is NULL)
	Or
	(@ParameterName = '')
   )
 begin
  RaisError('@ParameterName is NULL or empty.', 16, 1);
  return;
 end

 declare @ErrMsg nvarchar(255)

 declare @ApplicationId int = (Select ApplicationId
                               From dffw.[application]
							   Where applicationName = @ApplicationName)
 if(@ApplicationId Is NULL)
  begin
   set @ErrMsg = N'Cannot locate ' + @ApplicationName + ' in dffw.application table.'
   RaisError(@ErrMsg, 16, 1);
  end

 declare @PipelineId int = (Select PipelineId
                            From dffw.pipeline
							Where pipelineName = @PipelineName)

 if(@PipelineId Is NULL)
  begin
   set @ErrMsg = N'Cannot locate ' + @PipelineName + ' in dffw.pipeline table.'
   RaisError(@ErrMsg, 16, 1);
  end

 declare @ApplicationPipelineId int = (Select ApplicationPipelineId
                                       From dffw.applicationpipeline
							           Where applicationId = @ApplicationId
									     And pipelineId = @PipelineId)

 if(@ApplicationPipelineId Is NULL)
  begin
   set @ErrMsg = N'Cannot locate applicationPipelineId for applicationId ' + Convert(nvarchar(12), @ApplicationId) + ', pipelineId ' + Convert(nvarchar(12), @PipelineId) + ' in dffw.applicationpipeline table.'
   RaisError(@ErrMsg, 16, 1);
  end

 declare @ApplicationPipelineParameterId int = (Select app.ApplicationPipelineParameterId
                                                From dffw.applicationpipelineparameter app
												Join dffw.applicationpipeline ap
												  On ap.applicationpipelineId = app.applicationpipelineId
							                    Where app.applicationPipelineId = @ApplicationPipelineId
												  And app.parametername = @ParameterName)

 if(@ApplicationPipelineParameterId Is NULL)
  begin

   declare @tblApp table(applicationPipelineParameterId int)

   Insert Into dffw.applicationpipelineparameter
   (applicationpipelineId, parametername, parametervalue)
   Output inserted.applicationPipelineParameterId Into @tblApp
   Values
   (@ApplicationPipelineId, @ParameterName, @ParameterValue)

   Set @ApplicationPipelineParameterId = (Select applicationPipelineParameterId From @tblApp)

  end
 else
  begin

   Update dffw.applicationpipelineparameter
   Set parametervalue = @ParameterValue
   Where applicationPipelineParameterId = @ApplicationPipelineParameterId

  end

  Select @ApplicationPipelineParameterId As ApplicationPipelineParameterId

go

print ' - dffw.addOrUpdateApplicationPipelineParameter stored procedure created'
print ''

 -- dffw.getApplicationPipelineParameterCount stored procedure
print 'dffw.getApplicationPipelineParameterCount stored procedure'
If Exists(Select s.[name] + '.' + p.[name]
          From [sys].[procedures] p
          Join [sys].[schemas] s
			On s.[schema_id] = p.[schema_id]
		  Where s.[name] = N'dffw'
			And p.[name] = N'getApplicationPipelineParameterCount')
 begin
  print ' - Dropping dffw.getApplicationPipelineParameterCount stored procedure'
  Drop Procedure dffw.getApplicationPipelineParameterCount
  print ' - dffw.getApplicationPipelineParameterCount stored procedure dropped'
 end

print ' - Creating dffw.getApplicationPipelineParameterCount stored procedure'
go

Create Procedure dffw.getApplicationPipelineParameterCount
 @ApplicationName nvarchar(255)
,@PipelineName nvarchar(255)
As

 if(
    (@ApplicationName Is NULL)
	Or
	(@ApplicationName = '')
   )
 begin
  RaisError('@ApplicationName is NULL or empty.', 16, 1);
  return;
 end
 
 if(
    (@PipelineName Is NULL)
	Or
	(@PipelineName = '')
   )
 begin
  RaisError('@PipelineName is NULL or empty.', 16, 1);
  return;
 end

 declare @ErrMsg nvarchar(255)

 declare @ApplicationId int = (Select ApplicationId
                               From dffw.[application]
							   Where applicationName = @ApplicationName)
 if(@ApplicationId Is NULL)
  begin
   set @ErrMsg = N'Cannot locate ' + @ApplicationName + ' in dffw.application table.'
   RaisError(@ErrMsg, 16, 1);
  end

 declare @PipelineId int = (Select PipelineId
                            From dffw.pipeline
							Where pipelineName = @PipelineName)

 if(@PipelineId Is NULL)
  begin
   set @ErrMsg = N'Cannot locate ' + @PipelineName + ' in dffw.pipeline table.'
   RaisError(@ErrMsg, 16, 1);
  end

 declare @ApplicationPipelineId int = (Select ApplicationPipelineId
                                       From dffw.applicationpipeline
							           Where applicationId = @ApplicationId
									     And pipelineId = @PipelineId)

 if(@ApplicationPipelineId Is Not NULL)
  begin

   Select Count(*) As ApplicationPipelineParameterCount
   From dffw.applicationpipelineparameter app
   Where app.applicationpipelineId = @ApplicationPipelineId

  end

go

print ' - dffw.getApplicationPipelineParameterCount stored procedure created'
print ''
go

 -- dffw.getApplicationPipelineParameters stored procedure
print 'dffw.getApplicationPipelineParameters stored procedure'
If Exists(Select s.[name] + '.' + p.[name]
          From [sys].[procedures] p
          Join [sys].[schemas] s
			On s.[schema_id] = p.[schema_id]
		  Where s.[name] = N'dffw'
			And p.[name] = N'getApplicationPipelineParameters')
 begin
  print ' - Dropping dffw.getApplicationPipelineParameters stored procedure'
  Drop Procedure dffw.getApplicationPipelineParameters
  print ' - dffw.getApplicationPipelineParameters stored procedure dropped'
 end

print ' - Creating dffw.getApplicationPipelineParameters stored procedure'
go

Create Procedure dffw.getApplicationPipelineParameters
 @ApplicationName nvarchar(255)
,@PipelineName nvarchar(255)
As

 if(
    (@ApplicationName Is NULL)
	Or
	(@ApplicationName = '')
   )
 begin
  RaisError('@ApplicationName is NULL or empty.', 16, 1);
  return;
 end
 
 if(
    (@PipelineName Is NULL)
	Or
	(@PipelineName = '')
   )
 begin
  RaisError('@PipelineName is NULL or empty.', 16, 1);
  return;
 end

 declare @ErrMsg nvarchar(255)

 declare @ApplicationId int = (Select ApplicationId
                               From dffw.[application]
							   Where applicationName = @ApplicationName)
 if(@ApplicationId Is NULL)
  begin
   set @ErrMsg = N'Cannot locate ' + @ApplicationName + ' in dffw.application table.'
   RaisError(@ErrMsg, 16, 1);
  end

 declare @PipelineId int = (Select PipelineId
                            From dffw.pipeline
							Where pipelineName = @PipelineName)

 if(@PipelineId Is NULL)
  begin
   set @ErrMsg = N'Cannot locate ' + @PipelineName + ' in dffw.pipeline table.'
   RaisError(@ErrMsg, 16, 1);
  end

 declare @ApplicationPipelineId int = (Select ApplicationPipelineId
                                       From dffw.applicationpipeline
							           Where applicationId = @ApplicationId
									     And pipelineId = @PipelineId)

 declare @parameterJSON nvarchar(max) = ''

 if(@ApplicationPipelineId Is Not NULL)
  begin

   declare @val nvarchar(max)

   declare curpar cursor for
   Select app.parameterName + ':' + Convert(nvarchar(max),app.ParameterValue) + ','
   From dffw.applicationpipelineparameter app
   Where app.applicationpipelineId = @applicationpipelineId

   open curpar
   fetch next from curpar into @val

   While(@@fetch_status = 0)
    begin

     Set @parameterJSON = @parameterJSON + @val

     Select @val = app.parameterName + ':' + Convert(nvarchar(max),app.ParameterValue) + ','
     From dffw.applicationpipelineparameter app
     Where app.applicationpipelineId = @applicationpipelineId

     fetch next from curpar into @val

    end

   close curpar
   deallocate curpar

   Set @parameterJSON = Substring(@parameterJSON, 1, (Len(@parameterJSON) - 1))

  end

  Select @parameterJSON As parameterJSON

go

print ' - dffw.getApplicationPipelineParameters stored procedure created'
print ''

print 'Add Application Five\v5-pipeline1 waitSeconds application pipeline parameter'
declare @ApplicationName nvarchar(255) = N'Application Five'
declare @PipelineName nvarchar(255) = N'v5-pipeline1'
declare @ParameterName nvarchar(255) = N'waitSeconds'
declare @ParameterValue sql_variant = 9

exec dffw.addOrUpdateApplicationPipelineParameter @ApplicationName = @ApplicationName
                                                , @PipelineName = @PipelineName
												, @ParameterName = @ParameterName
												, @ParameterValue = @ParameterValue

print 'Application Five\v5-pipeline1 waitSeconds application pipeline parameter added'
go

declare @ApplicationName nvarchar(255) = N'Application Five'
declare @PipelineName nvarchar(255) = N'v5-pipeline1'

exec dffw.getApplicationPipelineParameters @ApplicationName = @ApplicationName
                                         , @PipelineName = @PipelineName

Select *
From dffw.applicationpipelineparameter

go

print 'Add Application FiveDotOne\v5-pipeline2 waitSeconds application pipeline parameter'
declare @ApplicationName nvarchar(255) = N'Application FiveDotOne'
declare @PipelineName nvarchar(255) = N'v5-pipeline2'
declare @ParameterName nvarchar(255) = N'waitSeconds'
declare @ParameterValue sql_variant = 4

exec dffw.addOrUpdateApplicationPipelineParameter @ApplicationName = @ApplicationName
                                                , @PipelineName = @PipelineName
												, @ParameterName = @ParameterName
												, @ParameterValue = @ParameterValue

print 'Application FiveDotOne\v5-pipeline2 waitSeconds application pipeline parameter added'
go

declare @ApplicationName nvarchar(255) = N'Application FiveDotOne'
declare @PipelineName nvarchar(255) = N'v5-pipeline2'

exec dffw.getApplicationPipelineParameters @ApplicationName = @ApplicationName
                                         , @PipelineName = @PipelineName

go

print 'Add Application FiveDotOne\v5-pipeline2 waitSeconds application pipeline parameter'
declare @ApplicationName nvarchar(255) = N'Application FiveDotOne'
declare @PipelineName nvarchar(255) = N'v5-pipeline2'
declare @ParameterName nvarchar(255) = N'waitSeconds2'
declare @ParameterValue sql_variant = 7

exec dffw.addOrUpdateApplicationPipelineParameter @ApplicationName = @ApplicationName
                                                , @PipelineName = @PipelineName
												, @ParameterName = @ParameterName
												, @ParameterValue = @ParameterValue

print 'Application FiveDotOne\v5-pipeline2 waitSeconds2 application pipeline parameter added'
go

declare @ApplicationName nvarchar(255) = N'Application FiveDotOne'
declare @PipelineName nvarchar(255) = N'v5-pipeline2'

exec dffw.getApplicationPipelineParameters @ApplicationName = @ApplicationName
                                         , @PipelineName = @PipelineName

Select *
From dffw.applicationpipelineparameter
go

