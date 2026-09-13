#!/bin/bash
set -e

echo "[Info] Setting up Node SSL Certificate..."
mkdir -p /var/lib/marzban-node

CERT_PATH="/var/lib/marzban-node/ssl_client_cert.pem"

# نوشتن کل محتوای متغیر NODE_CERT (که شامل گواهی و کلید است) در فایل نهایی
echo "$NODE_CERT" > "$CERT_PATH"

# صادر کردن متغیر محیطی برای سرویس
export SSL_CLIENT_CERT_FILE="$CERT_PATH"

echo "[Info] Starting Node Daemon..."
exec python3 main.py
