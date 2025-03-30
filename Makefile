render-cloud-init-server:
	@terraform apply -var-file=config/server.tfvars -auto-approve -input=false > /dev/null
	@terraform output -raw cloud-init > cloud-init-server.yaml

render-cloud-init-client:
	@echo "Join IP: $(join)"
	@terraform apply -var="join=$(join)" -var-file=config/client.tfvars -auto-approve -input=false > /dev/null
	@terraform output -raw cloud-init > cloud-init-client.yaml



