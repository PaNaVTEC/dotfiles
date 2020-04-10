#!/usr/bin/env bash

generateCertificates () {
  openssl req \
          -x509 \
          -newkey rsa:2048 \
          -keyout key.pem \
          -out cert.pem \
          -days 999 \
          -subj "/C=US/ST=Oregon/L=Portland/O=Company Name/OU=Org/CN=localhost"
}
