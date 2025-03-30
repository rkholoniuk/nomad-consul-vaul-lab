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

**Note:** This Makefile has been tested on MacBook Pro (M2 and M3).  
> Some commands, may not work the same way on Linux.
> multipass info server | grep 'IPv4' | cut -d':' -f2 | xargs

---

### Setup

#### 1. Create Configuration Files

Copy the example configuration templates:

```shell
cp config/server-template.tfvars config/server.tfvars 
cp config/client-template.tfvars config/client.tfvars 
```

#### 2.Launch VMs machines

Start the server and client VMs:

```shell
make launch-server
make launch-client
```
#### 3.SSH into VMS

Access the server or client shell via:

```shell
multipass shell server
multipass shell client
```

#### 4.Deploy nomad job (test)

Submit a test job to verify everything is working:

```shell
make hello-world-job
```

#### 4.Stop & Clean

To stop and delete the VMs:

```shell
make clean
```
