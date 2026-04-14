#Creating domain name
resource "digitalocean_domain" "domain_rn" {
  name = "IsW-kottster.com"
  ip_address = digitalocean_droplet.name.ipv4_address
}
# Adding domain into cloudflare (cloudflare account id and domain name)
resource "cloudflare_zone" "my_domain" {
  account_id = var.cloudflare_api
  zone = "my-cool-test-site.com"
}

#Создаем новую запись что бы компьютер знал куда перевести
#пользователя если он введет ://my-cool-test-site.com
resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.my_domain.id #what name of domain using
  name = "www" #name of sub-domain
  type = "A" #ipv-4 type
  proxied = true #creating free ssl for protection
}
