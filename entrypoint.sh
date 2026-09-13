#!/bin/bash

echo "[Info] Setting up Rebecca Node Certificate..."
mkdir -p /var/lib/rebecca-node

# قرار دادن گواهی و کلید در مسیر مورد نیاز ربکا نود
if [ -n "$NODE_CERT" ]; then
    echo "$NODE_CERT" > /var/lib/rebecca-node/ssl_client_cert.pem
fi

if [ -n "$NODE_KEY" ]; then
    echo "$NODE_KEY" >> /var/lib/rebecca-node/ssl_client_cert.pem
fi

# معرفی مسیر گواهی به دیمون ربکا نود
export SSL_CLIENT_CERT_FILE="/var/lib/rebecca-node/ssl_client_cert.pem"

echo "[Info] Starting Rebecca Node Daemon..."
exec /usr/local/bin/rebecca-node
