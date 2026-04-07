terraform {
  required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
    }
  }
}

resource "digitalocean_firewall" "firewall_id" {
  name = "Firewall"
  tags = var.tag

#Uncomment if you want to connect only with your ip
#  inbound_rule {
#    protocol = "tcp"
#    port_range = "22"
#    source_addresses = [ "${var.my_public_ip}/32"]
#  }
#
    inbound_rule {
    protocol = "tcp"
    port_range = "22"
    source_addresses = [ "0.0.0.0/0", "::/0" ]
  }

  inbound_rule {
    protocol = "tcp"
    port_range = "80"
    source_load_balancer_uids = [ var.ld_id ]
  }

  outbound_rule {
    protocol = "tcp"
    port_range = "1-65535"
    destination_addresses = [ "0.0.0.0/0", "::/0" ]
  }


  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}