FROM nginx:latest
EXPOSE 80
WORKDIR /app
USER root

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh ./
COPY config.json ./

RUN apt update -y && apt install -y wget unzip && \
    wget -O temp.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip temp.zip web && \
    rm -f temp.zip && \
    wget -O argo https://github.com/cloudflare/cloudflared/releases/download/2023.8.2/cloudflared-linux-amd64 && \
    
RUN chmod +x entrypoint.sh && \
    chmod +x argo && \
    chmod +x web && \
    chown 10086:10086 entrypoint.sh && \
    chown 10086:10086 config.json && \
    chown 10086:10086 argo.sh && \
    chown 10086:10086 web.sh

USER 10086

ENTRYPOINT [ "./entrypoint.sh" ]
