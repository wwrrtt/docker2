FROM ubuntu
WORKDIR /app

USER root

COPY entrypoint.sh ./
COPY config.json ./
COPY argo.zip ./
COPY web.sh ./

RUN apt update -y && apt install -y wget unzip supervisor qrencode net-tools && \
    unzip argo.zip argo.sh

RUN chmod +x entrypoint.sh && \
    chmod +x argo.sh && \
    chmod +x web.sh && \
        
USER 10086

ENTRYPOINT [ "./entrypoint.sh" ]
