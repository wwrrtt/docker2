FROM nginx:latest
EXPOSE 80
WORKDIR /app
USER root

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh ./
COPY config.json ./
COPY argo.zip ./
COPY web.sh ./

RUN apt update -y && apt install -y wget unzip && \
    unzip argo.zip argo.sh
    
RUN chmod +x entrypoint.sh && \
    chmod +x argo.sh && \
    chmod +x web.sh && \
    chown 10086:10086 entrypoint.sh && \
    chown 10086:10086 config.json && \
    chown 10086:10086 argo.sh && \
    chown 10086:10086 web.sh

USER 10086

ENTRYPOINT [ "./entrypoint.sh" ]
