FROM nginx:latest 
EXPOSE 80 
WORKDIR /app 

USER root

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh ./
COPY web.sh ./
COPY argo.zip ./

RUN apt-get update && apt-get install -y wget unzip iproute2 systemctl && \
    unzip argo.zip argo

RUN chmod +x entrypoint.sh && \
    chown 10086:10086 entrypoint.sh && \
    chmod +x web.sh && \
    chown 10086:10086 web.sh && \
    chmod +x argo && \
    chown 10086:10086 argo && \
    chmod -R a+r /etc/nginx && \
    chown -R 10086:10086 /etc/nginx
    
USER 10086
CMD ["nginx","-g","daemon off;"]
ENTRYPOINT [ "./entrypoint.sh" ]
