#!/bin/bash
set -e

echo "[Info] Setting up Node Certificate..."
mkdir -p /var/lib/rebecca-node

CERT_PATH="/var/lib/rebecca-node/ssl_client_cert.pem"

# نوشتن گواهی و کلید در یک فایل
echo "$NODE_CERT" > "$CERT_PATH"
echo "$NODE_KEY" >> "$CERT_PATH"

# صادر کردن متغیر محیطی برای پایتون
export SSL_CLIENT_CERT_FILE="$CERT_PATH"

echo "[Info] Starting Node Daemon..."
exec python3 main.py
