FROM debian:stable-slim

# نصب پکیج‌های ضروری شامل ابزار باز کردن فایل زیپ
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    bash \
    jq \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# دانلود و نصب مستقیم هسته Xray بدون نیاز به systemd
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then XRAY_ARCH="64"; \
    elif [ "$ARCH" = "aarch64" ]; then XRAY_ARCH="arm64-v8a"; \
    else XRAY_ARCH="64"; fi && \
    curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-$XRAY_ARCH.zip && \
    unzip xray.zip -d /tmp/xray && \
    install -m 755 /tmp/xray/xray /usr/local/bin/xray && \
    mkdir -p /usr/local/share/xray && \
    cp /tmp/xray/geosite.dat /usr/local/share/xray/ && \
    cp /tmp/xray/geoip.dat /usr/local/share/xray/ && \
    rm -rf xray.zip /tmp/xray

# کپی کردن اسکریپت راه‌اندازی نود
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# پورت پیش‌فرض کنترل نود
EXPOSE 62050

ENTRYPOINT ["/entrypoint.sh"]
