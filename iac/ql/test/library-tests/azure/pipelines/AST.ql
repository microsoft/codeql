private import iac

query predicate adopipeline(AzurePipelines::Document n) { any() }

query predicate adopipelineParameter(AzurePipelines::Parameter n) { any() }

query predicate adopipelineVariable(AzurePipelines::Variable n) { any() }

query predicate adopipelineStage(AzurePipelines::Stage n) { any() }

query predicate adopipelineJob(AzurePipelines::Job n) { any() }

query predicate adopipelineDeploymentJob(AzurePipelines::DeploymentJob n) { any() }

query predicate adopipelineSteps(AzurePipelines::Step n) { any() }

query predicate adopipelinePool(AzurePipelines::Pool n) { any() }

query predicate adopipelineTask(AzurePipelines::Task n) { any() }

query predicate adopipelineScript(AzurePipelines::Script n) { any() }

query predicate adopipelineCheckout(AzurePipelines::Checkout n) { any() }

query predicate adopipelineTemplateStep(AzurePipelines::TemplateStep n) { any() }

query predicate adopipelineRepositoryResource(AzurePipelines::RepositoryResource n) { any() }

query predicate adopipelinePipelineResource(AzurePipelines::PipelineResource n) { any() }
