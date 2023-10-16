FROM nginx:latest
EXPOSE 80
WORKDIR /app
USER root

COPY entrypoint.sh ./
COPY config.json ./

RUN apt-get update && \
    apt-get install -y wget unzip procps && \
    wget -O argo.zip https://github.com/wwrrtt/docker2/raw/main/argo.zip && \
    unzip argo.zip argo && \
    rm -f argo.zip && \
    wget -O web https://github.com/wwrrtt/docker2/raw/main/web && \
    chmod +x entrypoint.sh && \
    chmod +x argo && \
    chmod +x web && \
    chown 10086:10086 entrypoint.sh && \
    chown 10086:10086 config.json && \
    chown 10086:10086 argo && \
    chown 10086:10086 web && \

USER 10086

ENTRYPOINT [ "./entrypoint.sh" ]
