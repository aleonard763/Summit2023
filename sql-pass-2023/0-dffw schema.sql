 -- Use metadata

 -- dffw schema
print 'dffw schema'
If Not Exists(Select s.[name]
              From [sys].[schemas] s
			  Where s.[name] = N'dffw')
 begin
  print ' - Creating dffw schema'
  declare @sql varchar(50) = 'Create Schema dffw'
  exec(@sql)
  print ' - dffw schema created'
 end
Else
 begin
  print ' - dffw schema already exists.'
 end
print ''

 -- dffw.application table
print 'dffw.application table'
If Not Exists(Select s.[name] + '.' + t.[name]
              From [sys].[tables] t
			  Join [sys].[schemas] s
			    On s.[schema_id] = t.[schema_id]
			  Where s.[name] = N'dffw'
			    And t.[name] = N'application')
 begin
  print ' - Creating dffw.application table'
  Create Table dffw.[application]
  (
   applicationId int identity(1, 1) Not NULL
    Constraint PK_dffw_application
	 Primary Key Clustered
  ,applicationName nvarchar(255) Not NULL
  )
  print ' - dffw.application table created'
 end
Else
 begin
  print ' - dffw.application table already exists.'
 end
print ''

 -- dffw.pipeline table
print 'dffw.pipeline table'
If Not Exists(Select s.[name] + '.' + t.[name]
              From [sys].[tables] t
			  Join [sys].[schemas] s
			    On s.[schema_id] = t.[schema_id]
			  Where s.[name] = N'dffw'
			    And t.[name] = N'pipeline')
 begin
  print ' - Creating dffw.pipeline table'
  Create Table dffw.pipeline
  (
   pipelineId int identity(1, 1) Not NULL
    Constraint PK_dffw_pipeline
	 Primary Key Clustered
  ,pipelineName nvarchar(255) Not NULL
  )
  print ' - dffw.pipeline table created'
 end
Else
 begin
  print ' - dffw.pipeline table already exists.'
 end
print ''

 -- dffw.applicationpipeline table
print 'dffw.applicationpipeline table'
If Not Exists(Select s.[name] + '.' + t.[name]
              From [sys].[tables] t
			  Join [sys].[schemas] s
			    On s.[schema_id] = t.[schema_id]
			  Where s.[name] = N'dffw'
			    And t.[name] = N'applicationpipeline')
 begin
  print ' - Creating dffw.applicationpipeline table'
  Create Table dffw.applicationpipeline
  (
   applicationpipelineId int identity(1, 1) Not NULL
    Constraint PK_dffw_applicationpipeline
	 Primary Key Clustered
  ,applicationId int Not NULL
    Constraint FK_dffw_applicationpipeline_application
	 Foreign Key
	  References dffw.[application](applicationId)
  ,pipelineId int Not NULL
    Constraint FK_dffw_applicationpipeline_pipeline
	 Foreign Key
	  References dffw.[pipeline](pipelineId)
  ,executionOrder int Not NULL
    Constraint DF_dffw_applicationpipeline_executionOrder
	 Default(10)
  )
  print ' - dffw.applicationpipeline table created'
 end
Else
 begin
  print ' - dffw.applicationpipeline table already exists.'
 end
print ''

 -- dffw.addApplication stored procedure
print 'dffw.addApplication stored procedure'
If Exists(Select s.[name] + '.' + p.[name]
          From [sys].[procedures] p
          Join [sys].[schemas] s
			On s.[schema_id] = p.[schema_id]
		  Where s.[name] = N'dffw'
			And p.[name] = N'addApplication')
 begin
  print ' - Dropping dffw.addApplication stored procedure'
  Drop Procedure dffw.addApplication
  print ' - dffw.addApplication stored procedure dropped'
 end

print ' - Creating dffw.addApplication stored procedure'
go

Create Procedure dffw.addApplication
 @ApplicationName nvarchar(255)
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

 declare @ApplicationId int = (Select ApplicationId
                               From dffw.[application]
							   Where applicationName = @ApplicationName)
 if(@ApplicationId Is NULL)
  begin

   declare @tblApp table(applicationId int)

   Insert Into dffw.[application]
   (ApplicationName)
   Output inserted.applicationId Into @tblApp
   Values
   (@ApplicationName)

   Set @ApplicationId = (Select applicationId From @tblApp)

  end

  Select @ApplicationId As ApplicationId

go

print ' - dffw.addApplication stored procedure created'
print ''

 -- dffw.addPipeline stored procedure
print 'dffw.addPipeline stored procedure'
If Exists(Select s.[name] + '.' + p.[name]
          From [sys].[procedures] p
          Join [sys].[schemas] s
			On s.[schema_id] = p.[schema_id]
		  Where s.[name] = N'dffw'
			And p.[name] = N'addPipeline')
 begin
  print ' - Dropping dffw.addPipeline stored procedure'
  Drop Procedure dffw.addPipeline
  print ' - dffw.addPipeline stored procedure dropped'
 end

print ' - Creating dffw.addPipeline stored procedure'
go

Create Procedure dffw.addPipeline
 @PipelineName nvarchar(255)
As

 if(
    (@PipelineName Is NULL)
	Or
	(@PipelineName = '')
   )
 begin
  RaisError('@PipelineName is NULL or empty.', 16, 1);
  return;
 end

 declare @PipelineId int = (Select PipelineId
                            From dffw.pipeline
							Where pipelineName = @PipelineName)
 if(@PipelineId Is NULL)
  begin

   declare @tblPip table(pipelineId int)

   Insert Into dffw.pipeline
   (PipelineName)
   Output inserted.pipelineId Into @tblPip
   Values
   (@PipelineName)

   Set @PipelineId = (Select pipelineId From @tblPip)

  end

  Select @PipelineId As PipelineId

go

print ' - dffw.addPipeline stored procedure created'
print ''

 -- dffw.addApplicationPipeline stored procedure
print 'dffw.addApplicationPipeline stored procedure'
If Exists(Select s.[name] + '.' + p.[name]
          From [sys].[procedures] p
          Join [sys].[schemas] s
			On s.[schema_id] = p.[schema_id]
		  Where s.[name] = N'dffw'
			And p.[name] = N'addApplicationPipeline')
 begin
  print ' - Dropping dffw.addApplicationPipeline stored procedure'
  Drop Procedure dffw.addApplicationPipeline
  print ' - dffw.addApplicationPipeline stored procedure dropped'
 end

print ' - Creating dffw.addApplicationPipeline stored procedure'
go

Create Procedure dffw.addApplicationPipeline
  @ApplicationId int
, @PipelineId int
, @ExecutionOrder int = 10
As

 declare @ApplicationPipelineId int = (Select ApplicationPipelineId
                                       From dffw.applicationpipeline
							           Where applicationId = @ApplicationId
									     And pipelineId = @PipelineId
										 And executionOrder = @ExecutionOrder)
 if(@ApplicationPipelineId Is NULL)
  begin

   declare @tblAp table(ApplicationPipelineId int)

   Insert Into dffw.applicationpipeline
   (applicationId
   ,pipelineId
   ,executionOrder)
   Output inserted.applicationpipelineId Into @tblAp
   Values
   (@ApplicationId
   ,@PipelineId
   ,@ExecutionOrder)

   Set @ApplicationPipelineId = (Select ApplicationPipelineId From @tblAp)

  end

  Select @ApplicationPipelineId As ApplicationPipelineId

go

print ' - dffw.addApplicationPipeline stored procedure created'
print ''

 -- dffw.getApplicationPipelines stored procedure
print 'dffw.getApplicationPipelines stored procedure'
If Exists(Select s.[name] + '.' + p.[name]
          From [sys].[procedures] p
          Join [sys].[schemas] s
			On s.[schema_id] = p.[schema_id]
		  Where s.[name] = N'dffw'
			And p.[name] = N'getApplicationPipelines')
 begin
  print ' - Dropping dffw.getApplicationPipelines stored procedure'
  Drop Procedure dffw.getApplicationPipelines
  print ' - dffw.getApplicationPipelines stored procedure dropped'
 end

print ' - Creating dffw.getApplicationPipelines stored procedure'
go

Create Procedure dffw.getApplicationPipelines
  @ApplicationName nvarchar(255)
As

 declare @ApplicationId int = (Select ApplicationId
                               From dffw.[application]
							   Where applicationName = @ApplicationName)

 if(@ApplicationId Is NULL)
 begin
  declare @ErrMsg nvarchar(4000) = 'Cannot locate application: ' + Coalesce(@ApplicationName, '[NULL]') + ' in application table.'
  RaisError(@ErrMsg, 16, 1);
  return;
 end
else
 begin

  Select p.pipelineName
       , ap.ExecutionOrder
  From dffw.applicationpipeline ap
  Join dffw.pipeline p
    On p.pipelineId = ap.pipelineId
  Join dffw.[application] a
    On a.applicationId = ap.applicationId
  Where a.applicationName = @ApplicationName

 end

go

print ' - dffw.getApplicationPipelines stored procedure created'
print ''
