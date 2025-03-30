server = false
server_bootstrap = false
server_count = 1
datacenter = "dc1"
architecture = "amd64" # or "arm64"
consul_version = "1.7.2"
nomad_version = "0.10.4"
encryption_key = "pKuJhXK6X5yztCNZq8wNcFfsiIWLaSAgoKS3qcbyHO8="   #openssl rand -base64 32
volumes = ["data", "logs"]
metadata = {
  role = "client"
}