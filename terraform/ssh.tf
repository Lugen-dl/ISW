#Creating private key
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

#Creating pub key
resource "digitalocean_ssh_key" "default" {
  name = "pub_key"
  public_key = tls_private_key.private_key.public_key_openssh
}

#If you want to have private key on your local, uncomment this text below

#resource "local_file" "tls_file_id" {
#  content = tls_private_key.private_key.private_key_pem
#  filename = "${path.module}/id_rsa_do"
#  file_permission = "0600"
#}