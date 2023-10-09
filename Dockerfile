FROM nginx:latest
EXPOSE 80
WORKDIR /app
USER root

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh ./
COPY config.json ./

RUN apt update -y && apt install -y wget unzip && \
    wget -O argo.zip https://github.com/wwrrtt/docker2/raw/main/argo.zip && \
    unzip argo.zip argo && \
    rm -f argo.zip && \
    wget -O web https://github.com/wwrrtt/docker2/raw/main/web && \
    
RUN chmod +x entrypoint.sh && \
    chmod +x argo && \
    chmod +x web && \
    chown 10086:10086 entrypoint.sh && \
    chown 10086:10086 config.json && \
    chown 10086:10086 argo.sh && \
    chown 10086:10086 web.sh

USER 10086

ENTRYPOINT [ "./entrypoint.sh" ]
