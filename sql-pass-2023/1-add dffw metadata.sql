 -- Application One
declare @ApplicationName nvarchar(255) = N'Application One'
declare @tblApp table(applicationId int)
insert into @tblApp
exec dffw.addApplication @ApplicationName = @ApplicationName
declare @applicationId int = (select applicationId From @tblApp)
select @applicationId As ApplicationId

declare @PipelineName nvarchar(255) = N'v3-pipeline1'
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

 -- Application Two
set @ApplicationName = N'Application Two'
delete @tblApp
insert into @tblApp
exec dffw.addApplication @ApplicationName = @ApplicationName
set @applicationId = (select applicationId From @tblApp)
select @applicationId As ApplicationId

set @PipelineName = N'v3-pipeline2'
delete @tblPip
insert into @tblPip
exec dffw.addPipeline @PipelineName = @PipelineName
set @pipelineId = (select pipelineId From @tblPip)
select @pipelineId As PipelineId

set @executionOrder = 10
delete @tblAp
insert into @tblAp
exec dffw.addApplicationPipeline @ApplicationId = @applicationId
                                , @PipelineId = @pipelineId
								, @ExecutionOrder = @executionOrder
set @ApplicationPipelineId = (select ApplicationPipelineId From @tblAp)
select @ApplicationPipelineId As ApplicationPipelineId

exec dffw.getApplicationPipelines @ApplicationName = @ApplicationName

 -- Application Three
 set @ApplicationName = N'Application Three'
delete @tblApp
insert into @tblApp
exec dffw.addApplication @ApplicationName = @ApplicationName
set @applicationId = (select applicationId From @tblApp)
select @applicationId As ApplicationId

set @PipelineName = N'v3-pipeline1'
delete @tblPip
insert into @tblPip
exec dffw.addPipeline @PipelineName = @PipelineName
set @pipelineId = (select pipelineId From @tblPip)
select @pipelineId As PipelineId

set @executionOrder = 10
delete @tblAp
insert into @tblAp
exec dffw.addApplicationPipeline @ApplicationId = @applicationId
                                , @PipelineId = @pipelineId
								, @ExecutionOrder = @executionOrder
set @ApplicationPipelineId = (select ApplicationPipelineId From @tblAp)
select @ApplicationPipelineId As ApplicationPipelineId

set @PipelineName = N'v3-pipeline2'
delete @tblPip
insert into @tblPip
exec dffw.addPipeline @PipelineName = @PipelineName
set @pipelineId = (select pipelineId From @tblPip)
select @pipelineId As PipelineId

set @executionOrder = 20
delete @tblAp
insert into @tblAp
exec dffw.addApplicationPipeline @ApplicationId = @applicationId
                                , @PipelineId = @pipelineId
								, @ExecutionOrder = @executionOrder
set @ApplicationPipelineId = (select ApplicationPipelineId From @tblAp)
select @ApplicationPipelineId As ApplicationPipelineId

exec dffw.getApplicationPipelines @ApplicationName = @ApplicationName

 -- Application Four
 set @ApplicationName = N'Application Four'
delete @tblApp
insert into @tblApp
exec dffw.addApplication @ApplicationName = @ApplicationName
set @applicationId = (select applicationId From @tblApp)
select @applicationId As ApplicationId

set @PipelineName = N'v0-pipeline1'
delete @tblPip
insert into @tblPip
exec dffw.addPipeline @PipelineName = @PipelineName
set @pipelineId = (select pipelineId From @tblPip)
select @pipelineId As PipelineId

set @executionOrder = 10
delete @tblAp
insert into @tblAp
exec dffw.addApplicationPipeline @ApplicationId = @applicationId
                                , @PipelineId = @pipelineId
								, @ExecutionOrder = @executionOrder
set @ApplicationPipelineId = (select ApplicationPipelineId From @tblAp)
select @ApplicationPipelineId As ApplicationPipelineId

set @PipelineName = N'v0-pipeline2'
delete @tblPip
insert into @tblPip
exec dffw.addPipeline @PipelineName = @PipelineName
set @pipelineId = (select pipelineId From @tblPip)
select @pipelineId As PipelineId

set @executionOrder = 20
delete @tblAp
insert into @tblAp
exec dffw.addApplicationPipeline @ApplicationId = @applicationId
                                , @PipelineId = @pipelineId
								, @ExecutionOrder = @executionOrder
set @ApplicationPipelineId = (select ApplicationPipelineId From @tblAp)
select @ApplicationPipelineId As ApplicationPipelineId

set @PipelineName = N'v1-pipeline2'
delete @tblPip
insert into @tblPip
exec dffw.addPipeline @PipelineName = @PipelineName
set @pipelineId = (select pipelineId From @tblPip)
select @pipelineId As PipelineId

set @executionOrder = 30
delete @tblAp
insert into @tblAp
exec dffw.addApplicationPipeline @ApplicationId = @applicationId
                                , @PipelineId = @pipelineId
								, @ExecutionOrder = @executionOrder
set @ApplicationPipelineId = (select ApplicationPipelineId From @tblAp)
select @ApplicationPipelineId As ApplicationPipelineId

set @PipelineName = N'v1-pipeline1'
delete @tblPip
insert into @tblPip
exec dffw.addPipeline @PipelineName = @PipelineName
set @pipelineId = (select pipelineId From @tblPip)
select @pipelineId As PipelineId

set @executionOrder = 40
delete @tblAp
insert into @tblAp
exec dffw.addApplicationPipeline @ApplicationId = @applicationId
                                , @PipelineId = @pipelineId
								, @ExecutionOrder = @executionOrder
set @ApplicationPipelineId = (select ApplicationPipelineId From @tblAp)
select @ApplicationPipelineId As ApplicationPipelineId

set @PipelineName = N'v3-pipeline1'
delete @tblPip
insert into @tblPip
exec dffw.addPipeline @PipelineName = @PipelineName
set @pipelineId = (select pipelineId From @tblPip)
select @pipelineId As PipelineId

set @executionOrder = 50
delete @tblAp
insert into @tblAp
exec dffw.addApplicationPipeline @ApplicationId = @applicationId
                                , @PipelineId = @pipelineId
								, @ExecutionOrder = @executionOrder
set @ApplicationPipelineId = (select ApplicationPipelineId From @tblAp)
select @ApplicationPipelineId As ApplicationPipelineId

set @PipelineName = N'v3-pipeline2'
delete @tblPip
insert into @tblPip
exec dffw.addPipeline @PipelineName = @PipelineName
set @pipelineId = (select pipelineId From @tblPip)
select @pipelineId As PipelineId

set @executionOrder = 60
delete @tblAp
insert into @tblAp
exec dffw.addApplicationPipeline @ApplicationId = @applicationId
                                , @PipelineId = @pipelineId
								, @ExecutionOrder = @executionOrder
set @ApplicationPipelineId = (select ApplicationPipelineId From @tblAp)
select @ApplicationPipelineId As ApplicationPipelineId

exec dffw.getApplicationPipelines @ApplicationName = @ApplicationName

 -- Application Five
 set @ApplicationName = N'Application Five'
delete @tblApp
insert into @tblApp
exec dffw.addApplication @ApplicationName = @ApplicationName
set @applicationId = (select applicationId From @tblApp)
select @applicationId As ApplicationId

set @PipelineName = N'v5-pipeline1'
delete @tblPip
insert into @tblPip
exec dffw.addPipeline @PipelineName = @PipelineName
set @pipelineId = (select pipelineId From @tblPip)
select @pipelineId As PipelineId

set @executionOrder = 10
delete @tblAp
insert into @tblAp
exec dffw.addApplicationPipeline @ApplicationId = @applicationId
                                , @PipelineId = @pipelineId
								, @ExecutionOrder = @executionOrder
set @ApplicationPipelineId = (select ApplicationPipelineId From @tblAp)
select @ApplicationPipelineId As ApplicationPipelineId

exec dffw.getApplicationPipelines @ApplicationName = @ApplicationName
