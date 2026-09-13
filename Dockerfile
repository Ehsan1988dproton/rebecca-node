FROM python:3.10-slim

WORKDIR /app
RUN apt-get update && apt-get install -y git curl bash build-essential && rm -rf /var/lib/apt/lists/*

# کلون کردن مستقیم پروژه در پوشه /app
RUN git clone https://github.com/rebeccapanel/Rebecca-node.git /app

# نصب پکیج‌ها (پیدا کردن خودکار requirements.txt در صورت وجود)
RUN pip install --no-cache-dir --upgrade pip
RUN if [ -f requirements.txt ]; then \
        pip install --no-cache-dir -r requirements.txt; \
    elif [ -f "$(find . -name requirements.txt | head -n 1)" ]; then \
        pip install --no-cache-dir -r "$(find . -name requirements.txt | head -n 1)"; \
    fi

# تنظیم و انتقال فایل گواهی
RUN mkdir -p /var/lib/rebecca-node
COPY ssl_client_cert.pem /var/lib/rebecca-node/ssl_client_cert.pem
ENV SSL_CLIENT_CERT_FILE="/var/lib/rebecca-node/ssl_client_cert.pem"

EXPOSE 62050

# اجرای پویا فایل main صرف نظر از پوشه آن
CMD ["sh", "-c", "python3 $(find . -name main.py | head -n 1)"]
