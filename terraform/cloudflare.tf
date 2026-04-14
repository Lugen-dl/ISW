#Creating domain name without registator. So it cut any useful features as using cloudlfare
#resource "digitalocean_domain" "domain_rn" {
#  name = "IsW-kottster.com"
#  ip_address = digitalocean_droplet.web.ipv4_address
#}
# Giving created domain it id (this mostly need to configure your domain settings)

resource "cloudflare_zone" "my_domain" {
  account_id = var.cloudflare_id
  zone = "isw-pet-project.site"
}

#Создаем новую запись что бы компьютер знал куда перевести
#пользователя если он введет ://my-cool-test-site.com
resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.my_domain.id #what name of domain using
  name = "@" #name of sub-domain
  type = "A" #ipv-4 type
  proxied = true #creating free ssl for protection
  content =  digitalocean_droplet.web.ipv4_address
}
