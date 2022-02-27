#!/bin/bash

set -euo pipefail

sudo rm server.* -f
rm privkey.pem -f

openssl req -new -text -passout pass:abcd -subj /CN=localhost -out server.req -keyout privkey.pem
openssl rsa -in privkey.pem -passin pass:abcd -out server.key
openssl req -x509 -in server.req -text -key server.key -out server.crt
#chmod 600 server.key
#test $(uname -s) = Linux && sudo chown 70 server.key
