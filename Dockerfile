FROM python:3.10-slim

WORKDIR /app
RUN apt-get update && apt-get install -y git curl bash build-essential && rm -rf /var/lib/apt/lists/*

# کلون کردن پروژه در پوشه موقت
RUN git clone https://github.com/rebeccapanel/Rebecca-node.git /temp

# انتقال فایل‌ها به /app بدون پاک کردن فایل‌های موجود (مثل گواهی)
RUN cp -rn /temp/. /app/ && rm -rf /temp

# نمایش لیست فایل‌ها در لاگ بیلد برای بررسی
RUN ls -la /app

# آپدیت پیپ و نصب پکیج‌ها
RUN pip install --no-cache-dir --upgrade pip
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

# تنظیم مسیر فایل گواهی
RUN mkdir -p /var/lib/rebecca-node
RUN if [ -f ssl_client_cert.pem ]; then cp ssl_client_cert.pem /var/lib/rebecca-node/ssl_client_cert.pem; fi

ENV SSL_CLIENT_CERT_FILE="/var/lib/rebecca-node/ssl_client_cert.pem"

EXPOSE 62050
CMD ["python3", "main.py"]
