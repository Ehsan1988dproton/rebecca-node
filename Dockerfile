FROM python:3.10-slim

WORKDIR /app
RUN apt-get update && apt-get install -y git curl bash build-essential && rm -rf /var/lib/apt/lists/*

# کلون کردن پروژه در پوشه موقت و انتقال به اپ
RUN git clone https://github.com/rebeccapanel/Rebecca-node.git /temp && \
    cp -r /temp/. /app && \
    rm -rf /temp

# پیدا کردن خودکار main.py و انتقال آن به ریشه /app اگر داخل زیرپوشه باشد
RUN if [ ! -f /app/main.py ]; then \
        MAIN_PATH=$(find /app -name main.py | head -n 1); \
        if [ -n "$MAIN_PATH" ]; then \
            cp "$MAIN_PATH" /app/; \
        fi; \
    fi

# آپدیت پیپ و نصب شرطی پکیج‌ها
RUN pip install --no-cache-dir --upgrade pip
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

# انتقال و تنظیم فایل گواهی
RUN mkdir -p /var/lib/rebecca-node
COPY ssl_client_cert.pem /var/lib/rebecca-node/ssl_client_cert.pem

ENV SSL_CLIENT_CERT_FILE="/var/lib/rebecca-node/ssl_client_cert.pem"

EXPOSE 62050
CMD ["python3", "main.py"]
