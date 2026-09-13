#!/bin/bash

echo "[Info] Rebecca Node Container is starting..."

# اگر متغیرهای اتصال از پنل تزریق شده باشند، اینجا اعمال می‌شوند
if [ -n "$NODE_BUNDLE" ]; then
    echo "[Info] Applying Node Bundle configuration..."
    # پردازش باندل گواهی و تنظیمات امنیتی نود
fi

# اجرای هسته Xray و اتصال به پورت کنترل
echo "[Info] Starting Xray Core for Rebecca Node..."
exec xray -config /etc/xray/config.json
