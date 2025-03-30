## Getting Started

### Before You Start

> **If you're an absolute beginner**, watch [HashiCorp's official "Getting Started" video](https://www.youtube.com/watch?v=xl58mjMJjrg) to understand the basic concepts of Nomad.

---

### Requirements

This tutorial uses virtual machines via [Multipass](https://multipass.run/) running Ubuntu 22.04.

Make sure to install Multipass on your local machine before proceeding.

**Note:** The setup has been tested on MacBook Pro (M2 and M3).
> If you're running on an ARM-based system (like Apple Silicon), change it to:

```hcl
architecture = "arm64"
```
---

### Setup

#### 1. Create Configuration Files

Copy the example configuration templates:

```shell
cp config/server-template.tfvars config/server.tfvars 
cp config/client-template.tfvars config/client.tfvars 
```

##### Launch VMs machines

Start the server and client VMs:

```shell
make launch-server
make launch-client
```

##### SSH VMs machines

Access the server or client shell via:

```shell
multipass shell server
multipass shell client
```

##### Deploy nomad job (test)

Submit a test job to verify everything is working:

```shell
make hello-world-job
```

##### Stop & Clean

To stop and delete the VMs:

```shell
make clean
```
