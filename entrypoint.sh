#!/bin/bash

echo "[Info] Setting up Node Certificate..."
mkdir -p /var/lib/marzban-node

# قرار دادن گواهی و کلید در مسیر استاندارد نود
if [ -n "$NODE_CERT" ]; then
    echo "$NODE_CERT" > /var/lib/marzban-node/ssl_client_cert.pem
fi

if [ -n "$NODE_KEY" ]; then
    echo "$NODE_KEY" >> /var/lib/marzban-node/ssl_client_cert.pem
fi

echo "[Info] Starting Node Daemon..."
exec python3 main.py
