#!/bin/bash

# first generate CSR with 2048 and sha-2
openssl req -nodes -new -sha256 -newkey rsa:2048 -keyout bestflare.key -out bestflare.csr

# /etc/nginx/conf.d

# change the port to 443
echo "server {listen       443 ssl;   server_name bestflare.com;   ssl                 on;   ssl_certificate     /opt/cert/bestflare.pem;   ssl_certificate_key /opt/cert/bestflare.key;   }" >> /etc/nginx/conf.d

# Disable weak ssl\Tsl protocols
echo "ssl_protocols           TSLv1.2;" >> /etc/ssl/ssl.conf

# Disable weak chipher suites
echo "ssl_ciphers "EECDH+ECDSA+AESGCM EECDH+aRSA+AESGCM EECDH+ECDSA+SHA384 EECDH+ECDSA+SHA256 EECDH+aRSA+SHA384 EECDH+aRSA+SHA256 EECDH+aRSA+RC4 EECDH EDH+aRSA HIGH !RC4 !aNULL !eNULL !LOW !3DES !MD5 !EXP !PSK !SRP !DSS";" >> /etc/tsl/ssl.conf

# Install chain certificate
echo "Add the chain cert contents in the website certificate like below. In my example, it would be /opt/cert/bestflare.pem"

# Secure Diffie-Hellman for TLS
openssl dhparam -out dhparams.pem 4096

echo "ssl_dhparam    /opt/cert/dhparams.pem;" >> /etc/ssl/ssl.conf

###########################################
# Template for HTTPS server configuration #
###########################################

## HTTPS server configuration
#server {
#   listen       443 ssl;
#   server_name bestflare.com;
#   ssl                 on;
#   ssl_certificate     /opt/cert/bestflare.pem;
#   ssl_certificate_key /opt/cert/bestflare.key;
#   ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
#   ssl_prefer_server_ciphers   on;
#   ssl_ciphers "EECDH+ECDSA+AESGCM EECDH+aRSA+AESGCM EECDH+ECDSA+SHA384 EECDH+ECDSA+SHA256 EECDH+aRSA+SHA384 EECDH+aRSA+SHA256 EECDH+aRSA+RC4 EECDH EDH+aRSA HIGH !RC4 !aNULL !eNULL !LOW !3DES !MD5 !EXP !PSK !SRP !DSS";
#   ssl_dhparam     /opt/cert/dhparams.pem;
#}
