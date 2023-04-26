FROM ubuntu
WORKDIR /app

COPY entrypoint.sh ./
COPY config.json ./
COPY argo.zip ./
COPY web.sh ./

USER root

RUN apt update -y && apt install -y wget unzip supervisor qrencode net-tools && \
    unzip argo.zip argo.sh && \
    chmod +x entrypoint.sh && \
    chmod +x argo.sh && \
    chmod +x web.sh && \
    chown 10086:10086 /entrypoint.sh && \
    chown 10086:10086 /config.json && \
    chown 10086:10086 /argo.zip && \
    chown 10086:10086 /argo.sh && \
    chown 10086:10086 /web.sh

USER 10086

ENTRYPOINT [ "./entrypoint.sh" ]
