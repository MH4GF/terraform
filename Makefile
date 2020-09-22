.PHONY: help

help:
	@awk -F ':|##' '/^[^\t].+?:.*?##/ { printf "\033[36m%-22s\033[0m %s\n", $$1, $$NF }' $(MAKEFILE_LIST)

plan:    terraform/plan        ## terraform plan
apply:   terraform/apply       ## terraform apply
fmt:     terraform/fmt         ## terraform fmt
output:  terraform/output      ## terraform output
show:    terraform/show        ## terraform show
refresh: terraform/refresh     ## terraform refresh

### init
terraform/init:
	@docker-compose run --rm terraform $(@F)

### fmt
terraform/fmt:
	@docker-compose run --rm terraform $(@F) -write=true

### plan
terraform/plan: terraform/init terraform/fmt
	@docker-compose run --rm terraform $(@F)

### apply
terraform/apply: terraform/init terraform/fmt
	@docker-compose run --rm terraform $(@F)

### output
terraform/output: terraform/init terraform/fmt
	@docker-compose run --rm terraform $(@F)

### show
terraform/show: terraform/init terraform/fmt
	@docker-compose run --rm terraform $(@F)

### refresh
terraform/refresh: terraform/init terraform/fmt
	@docker-compose run --rm terraform $(@F)
