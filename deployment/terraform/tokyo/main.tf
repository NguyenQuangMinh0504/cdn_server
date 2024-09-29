provider "google" {
    credentials = file("~/.config/gcloud/application_default_credentials.json")
    project = "cdn-demo-1"
    region = "asia-northeast1"
}

resource "google_compute_instance" "default" {
    name = "test"
    machine_type = "e2-small"
    zone = "asia-northeast1-c"
    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-12"
      }
    }
    network_interface {
      network = "default"
      access_config {
        
      }
    }
    tags = ["http-server","https-server"]
}