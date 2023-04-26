FROM ubuntu
MAINTAINER kid 

USER root

COPY entrypoint.sh ./
COPY config.json ./
COPY argo.zip ./
COPY web.sh ./

RUN apt update -y && apt install -y wget unzip supervisor qrencode net-tools && \
    unzip argo.zip argo.sh

RUN chmod +x entrypoint.sh && \
    chown 10086:10086 entrypoint.sh && \
    chmod +x argo.sh && \
    chown 10086:10086 argo.sh && \
    chmod +x web.sh && \
    chown 10086:10086 web.sh && \
    
USER 10086

ENTRYPOINT [ "./entrypoint.sh" ]
