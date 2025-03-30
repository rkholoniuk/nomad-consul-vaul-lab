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
	@echo "Server IP: $$(multipass info server | grep 'IPv4' | cut -d':' -f2 | xargs)"
	$(MAKE) launch-client
	@echo "Client IP: $$(multipass info client | grep 'IPv4' | cut -d':' -f2 | xargs)"
	@echo "Server and client launched. Please run 'make shell-server' or 'make shell-client' to access them."
	


launch-client1:
	@if ! multipass info server | grep -q 'IPv4'; then \
		echo "Server not running. Please run 'make launch-server' first."; exit 1; \
	fi; \
	join_ip=$$(multipass info server | grep 'IPv4' | cut -d':' -f2 | xargs); \
	$(MAKE) render-cloud-init-client join=$$join_ip; \
	multipass launch --name=client1 --cloud-init=cloud-init-client.yaml

info:
	multipass info --all

shell-server:
	multipass shell server
	# nomad server members

shell-client:
	multipass shell client

test-job:
	@if ! multipass info server | grep -q 'IPv4'; then \
		echo "Server not running. Please run 'make launch-server' first."; exit 1; \
	fi; \
	join_ip=$$(multipass info server | grep 'IPv4' | cut -d':' -f2 | xargs); \
	export NOMAD_ADDR="http://$$(join_ip):4646"
	@echo "export NOMAD_ADDR=$$(echo $$NOMAD_ADDR)"
	nomad job run jobs/hello-world.nomad
	@echo "Job submitted. Check the status with 'nomad job status hello-world'."
	@echo "To see the logs, run 'nomad alloc logs <allocation_id>'"
	@echo "To see the job status, run 'nomad job status hello-world'."
stop:
	multipass stop --all

clean: stop
	multipass delete --all
	multipass purge