FROM debian:stable-slim

# نصب پکیج‌های ضروری
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    jq \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# دانلود و نصب آخرین نسخه هسته Xray (دقیقاً مشابه ساختار استاندارد)
RUN bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install

# کپی کردن اسکریپت راه‌اندازی نود
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# پورت پیش‌فرض کنترل نود
EXPOSE 62050

ENTRYPOINT ["/entrypoint.sh"]
