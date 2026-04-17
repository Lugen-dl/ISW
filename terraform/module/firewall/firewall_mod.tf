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
    source_addresses = [ "0.0.0.0/0" ] #Only our server in DO can enter with ssh
  }

  inbound_rule {
    protocol = "tcp"
    port_range = "80"
    source_load_balancer_uids = [ var.ld_id ] #filtrating requests ONLY with lb
  }

  outbound_rule {
    protocol = "tcp"
    port_range = "all" #"all" cause, it will be easier to update our server conf packages
    destination_addresses = [ "0.0.0.0/0", "::/0" ]
  }


  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535" #keeping it so, our server won't have any problems with dns requests
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}