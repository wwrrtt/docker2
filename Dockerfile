FROM nginx:latest 
EXPOSE 80 
WORKDIR /app 

USER root

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh ./
COPY web.sh ./

RUN apt-get update && \
    apt-get install -y curl wet unzip iproute2 systemctl

RUN chmod +x entrypoint.sh && \
    chown 10014:10014 entrypoint.sh && \
    chmod +x web.sh && \
    chown 10014:10014 web.sh && \
    chmod -R a+r /etc/nginx && \
    chown -R 10014:10014 /etc/nginx
    
USER 10014
CMD ["nginx","-g","daemon off;"]
ENTRYPOINT [ "./entrypoint.sh" ]
