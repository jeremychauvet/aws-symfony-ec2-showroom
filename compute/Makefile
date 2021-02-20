.PHONY: build validate

build:
	packer build .

validate:
	@echo "[INFO] Starting validation."
	@packer validate source.pkr.hcl
	@echo "[INFO] Source valid."
