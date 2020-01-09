## Chapter 7 Solutions

* Enable and configure vault transit
`vault secrets enable transit`<br>
`vault write -f transit/keys/my-key`<br>
`vault write transit/encrypt/my-key plaintext=$(base64 <<< "my secret data")`<br>
`vault write transit/decrypt/my-key ciphertext=vault:v1:8SDd3WHDOjf7mq610.yCqYjBXAiQQAVZRkFM13ok481zoCmHnSeDX10.yf7w==`base64 --decode <<< "bXkgc2VjcmV0IGRhdGEK"`<br>
