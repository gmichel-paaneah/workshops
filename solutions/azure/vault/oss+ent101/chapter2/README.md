### Chapter 2 - Solutions

* Connect to Vault
`sudo wget ${var.vault_url} -P /usr/local/bin/vault; sudo chmod 855 /usr/local/bin/vault`<br>
`export VAULT_ADDR=http://${azurerm_public_ip.main.ip_address}:8200`

* Init and unseal vault
`vault operator init`<br>
`vault operator unseal`<br>
`vault login <root token>`

* Install license file
`vault write sys/license text=LICENSEFILE`<br>
`vault read sys/license`<br>
