
 -- Application Five
declare @ApplicationName nvarchar(255) = N'Application FiveDotOne'
declare @tblApp table(applicationId int)
insert into @tblApp
exec dffw.addApplication @ApplicationName = @ApplicationName
declare @applicationId int = (select applicationId From @tblApp)
select @applicationId As ApplicationId

declare @PipelineName nvarchar(255) = N'v5-pipeline2'
declare @tblPip table(pipelineId int)
insert into @tblPip
exec dffw.addPipeline @PipelineName = @PipelineName
declare @pipelineId int = (select pipelineId From @tblPip)
select @pipelineId As PipelineId

declare @executionOrder int = 10
declare @tblAp table(ApplicationPipelineId int)
insert into @tblAp
exec dffw.addApplicationPipeline @ApplicationId = @applicationId
                                , @PipelineId = @pipelineId
								, @ExecutionOrder = @executionOrder
declare @ApplicationPipelineId int = (select ApplicationPipelineId From @tblAp)
select @ApplicationPipelineId As ApplicationPipelineId

exec dffw.getApplicationPipelines @ApplicationName = @ApplicationName
go

print 'Add Application FiveDotOne\v5-pipeline2 waitSeconds and waitSeconds2 application pipeline parameters'
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
declare @ParameterName nvarchar(255) = N'waitSeconds2'
declare @ParameterValue sql_variant = 7

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

/*Select *
From dffw.applicationpipelineparameter
*/
 -- (c) Copyright 2021, Enterprise Data & Analytics
