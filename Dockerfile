FROM nginx:latest 

# 添加一个非 root 用户
RUN adduser --system --group appuser

# 设置工作目录
WORKDIR /app 

# 复制应用程序文件
COPY nginx.conf /etc/nginx/nginx.conf 
COPY config.json ./ 
COPY entrypoint.sh ./ 

# 安装依赖项和 Xray Core
RUN apt-get update && apt-get install -y wget unzip iproute2 systemctl && \ 
    wget -O temp.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \ 
    unzip temp.zip xray && \ 
    rm -f temp.zip && \ 
    chmod -v 755 xray entrypoint.sh 

# 更改文件夹权限
RUN chown -R appuser:appuser /app

# 切换到该用户
USER appuser

# 启动 Nginx 和 Xray Core
CMD [ "/bin/sh", "-c", "./entrypoint.sh" ]
