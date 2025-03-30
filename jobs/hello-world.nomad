job "hello-world" {
  datacenters = ["dc1"]
  type = "batch"

  group "example" {
    task "echo" {
      driver = "docker"

      config {
        image = "busybox"
        command = "echo"
        args = ["Hello, Nomad!"]
      }

      resources {
        cpu    = 100
        memory = 64
      }
    }
  }
}
