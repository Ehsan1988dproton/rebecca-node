FROM gozargah/marzban-node:latest

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 62050

ENTRYPOINT ["/entrypoint.sh"]
