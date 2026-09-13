FROM python:3.10-slim

WORKDIR /app
RUN apt-get update && apt-get install -y git curl bash build-essential && rm -rf /var/lib/apt/lists/*

# کلون کردن پروژه در پوشه موقت
RUN git clone https://github.com/rebeccapanel/Rebecca-node.git /temp && \
    cp -r /temp/. /app && \
    rm -rf /temp

# آپدیت پیپ و نصب پکیج‌ها
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# انتقال و تنظیم فایل گواهی
RUN mkdir -p /var/lib/rebecca-node
COPY ssl_client_cert.pem /var/lib/rebecca-node/ssl_client_cert.pem

ENV SSL_CLIENT_CERT_FILE="/var/lib/rebecca-node/ssl_client_cert.pem"

EXPOSE 62050
CMD ["python3", "main.py"]
