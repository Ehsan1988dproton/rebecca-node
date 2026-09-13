# مرحله اول: کامپایل ربکا نود با زبان Go
FROM golang:alpine AS builder
RUN apk add --no-cache git
RUN git clone https://github.com/rebeccapanel/Rebecca-node.git /app
WORKDIR /app
RUN go build -o rebecca-node .

# مرحله دوم: آماده‌سازی محیط نهایی
FROM debian:stable-slim
RUN apt-get update && apt-get install -y curl bash ca-certificates && rm -rf /var/lib/apt/lists/*

# نصب هسته Xray
RUN bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install

# کپی کردن باینری اصلی ربکا نود از مرحله قبل
COPY --from=builder /app/rebecca-node /usr/local/bin/rebecca-node

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 62050
ENTRYPOINT ["/entrypoint.sh"]
