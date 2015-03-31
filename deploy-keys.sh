# Creates the CA Key / Certificate for signing Client Certs
openssl genrsa -des3 -out ca.key 4096
openssl rsa -in ca.key -out ca.key # removes the password
openssl req -new -x509 -days 1095 -key ca.key -out ca.crt
 
# Creates the Server Key, CSR, and Certificate
openssl genrsa -des3 -out server.key 2048
openssl rsa -in server.key -out server.key # removes the password
openssl req -new -key server.key -out server.csr
 
# Self signs our Server Certificate. 
openssl x509 -req -days 1095 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt
 
# Creates the Client Key and CSR
openssl genrsa -des3 -out client.key 2048
openssl rsa -in client.key -out client.key # no password! 
openssl req -new -key client.key -out client.csr
 
# Signs the Client Certificate With Our CA Certificate.
openssl x509 -req -days 1095 -in client.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out client.crt
