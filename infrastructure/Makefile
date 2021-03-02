.PHONY: init plan apply validate estimate-cost destroy

init:
	terraform init

plan: init validate
	terraform plan

apply: init validate
	terraform apply -auto-approve

validate:
	pre-commit run --all-files

estimate-cost: init
	terraform plan -out plan.save && \
	terraform show -json plan.save > plan.json && \
	infracost --tfjson ./plan.json

destroy:
	terraform destroy
