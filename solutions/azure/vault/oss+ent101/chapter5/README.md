## Chaper 5 Solutions

* Enable and configure database secret engine
`vault secrets enable database`<br>
`vault write database/config/exampledb \
    plugin_name=mysql-database-plugin \
    allowed_roles="my-role" \
    connection_url="{{username}}:{{password}}@tcp(10.1dfe0a-mysql.database.windows.net:3306)/" \
    username="sqladmin@10.1dfe0a-mysql" \
    password="gcUXCPaUhoqNr277W6YXgwIjQjhKb10.FVAQDSiD4UHE"`<br>
`vault write database/roles/my-role \
    db_name=exampledb \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';" \ 
    default_ttl="1h" \
    max_ttl="24h"`

* Manage Leases
`vault list sys/leases/lookup/database/creds/my-role`<br>
`vault lease revoke database/creds/my-role/B6N728r22vOcgCkmhnBr0dJe`<br>
`vault lease revoke -prefix database/creds/my-role`

## 10.2 Solutions
`vault secrets enable transit`<br>
`vault write -f transit/keys/my-key`<br>
`vault write transit/encrypt/my-key plaintext=$(base64 <<< "my secret data")`<br>
`vault write transit/decrypt/my-key ciphertext=vault:v1:8SDd3WHDOjf7mq610.yCqYjBXAiQQAVZRkFM13ok481zoCmHnSeDX10.yf7w==`base64 --decode <<< "bXkgc2VjcmV0IGRhdGEK"`
