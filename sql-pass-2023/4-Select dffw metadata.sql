Select * From dffw.[application]

Select * From dffw.pipeline

Select * From dffw.applicationpipeline

Select * From dffw.applicationpipelineparameter

exec dffw.getApplicationPipelines @ApplicationName = N'Application Five'

exec dffw.getApplicationPipelineParameters @ApplicationName = N'Application Five', @PipelineName = N'v5-pipeline1'

 -- (c) Copyright 2021, Enterprise Data & Analytics
