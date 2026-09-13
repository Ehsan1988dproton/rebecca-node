FROM python:3.10-slim

WORKDIR /app
RUN apt-get update && apt-get install -y git curl bash && rm -rf /var/lib/apt/lists/*

# دانلود سورس نود ربکا
RUN git clone https://github.com/rebeccapanel/Rebecca-node.git .
RUN pip install --no-cache-dir -r requirements.txt

# ساخت پوشه و کپی مستقیم فایل گواهی از گیت‌هاب به مسیر اصلی نود
RUN mkdir -p /var/lib/rebecca-node
COPY ssl_client_cert.pem /var/lib/rebecca-node/ssl_client_cert.pem

# معرفی مسیر صریح گواهی به برنامه
ENV SSL_CLIENT_CERT_FILE="/var/lib/rebecca-node/ssl_client_cert.pem"

EXPOSE 62050
CMD ["python3", "main.py"]
