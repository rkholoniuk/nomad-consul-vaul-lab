## Getting started

### Before you start

*If you're absolute beginner, please watch the [official getting started](https://www.youtube.com/watch?v=xl58mjMJjrg) video from Hashicorp* to get some basic concepts

###  Requisition
I'm using VMs ([multipass](https://multipass.run/)) on Ubuntu 22.04 for this tutorial. Ensure that you install Multipass on your machine before you go


##### Create config for server and client
```shell
cp config/server-template.tfvars config/server.tfvars 
cp config/client-template.tfvars config/client.tfvars 

```

##### Launch VMs machines
```shell
make launch-server
make launch-client
```

##### SSH VMs machines
```shell
multipass shell server
multipass shell client
```

##### Deploy nomad job (test)
```shell
make hello-world-job
```

##### Stop & Clean
```shell
make clean
```
