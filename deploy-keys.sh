# Create the CA Key and Certificate for signing Client Certs
openssl genrsa -des3 -out ca.key 4096
openssl rsa -in ca.key -out ca.key # remove password!
openssl req -new -x509 -days 1095 -key ca.key -out ca.crt
 
# Create the Server Key, CSR, and Certificate
openssl genrsa -des3 -out server.key 2048
openssl rsa -in server.key -out server.key # remove password!
openssl req -new -key server.key -out server.csr
 
# We're self signing our own server cert here.  This is a no-no in production.
openssl x509 -req -days 1095 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt
 
# Create the Client Key and CSR
openssl genrsa -des3 -out client.key 2048
openssl rsa -in client.key -out client.key # no password! 
openssl req -new -key client.key -out client.csr
 
# Sign the client certificate with our CA cert.  Unlike signing our own server cert, this is what we want to do.
openssl x509 -req -days 1095 -in client.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out client.crt
