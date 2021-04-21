.PHONY: build validate debug

build: validate
	packer build .

validate:
	@echo "[INFO] Starting validation."
	@packer validate source.pkr.hcl
	@echo "[INFO] Source valid."

debug:
	ansible-playbook --connection=local --inventory 127.0.0.1 playbook.yml
