render-cloud-init-server:
	@terraform apply -var-file=config/server.tfvars -auto-approve -input=false > /dev/null
	@terraform output -raw cloud-init > cloud-init-server.yaml

render-cloud-init-client:
	@echo "Join IP: $(join)"
	@terraform apply -var="join=$(join)" -var-file=config/client.tfvars -auto-approve -input=false > /dev/null
	@terraform output -raw cloud-init > cloud-init-client.yaml

launch-server: render-cloud-init-server
	multipass launch --name=server --cloud-init=cloud-init-server.yaml

launch-client:
	@if ! multipass info server | grep -q 'IPv4'; then \
		echo "Server not running. Please run 'make launch-server' first."; exit 1; \
	fi; \
	join_ip=$$(multipass info server | grep 'IPv4' | cut -d':' -f2 | xargs); \
	$(MAKE) render-cloud-init-client join=$$join_ip; \
	multipass launch --name=client --cloud-init=cloud-init-client.yaml

reset:
	multipass stop --all
	multipass delete --all
	multipass purge
	$(MAKE) launch-server
	$(MAKE) launch-client
	@echo "Server and client launched. Please run 'make shell-server' or 'make shell-client' to access them."
	@echo "Server IP: $$(multipass info server | grep 'IPv4' | cut -d':' -f2 | xargs)"
	@echo "Client IP: $$(multipass info client | grep 'IPv4' | cut -d':' -f2 | xargs)"


