# 使用 tootsuite/mastodon:v4.2.8 作为基础镜像
FROM tootsuite/mastodon:v4.2.8

# 设置工作目录
# WORKDIR /app

# 安装 wget（如果基础镜像中不存在）
# RUN apt-get update && apt-get install -y wget
# 安装curl和nvm来管理Node.js版本
RUN apt-get update && apt-get install -y curl gcc g++ make python
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
# 安装并使用特定版本的Node.js
SHELL ["bash", "-c"]
RUN source $HOME/.nvm/nvm.sh && \
    nvm install 20.10.0 && \
    nvm alias default 20.10.0 && \
    nvm use default

# 定义环境变量
ENV ALTERNATE_DOMAINS=${ALTERNATE_DOMAINS} \
    AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
    AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
    DATABASE_URL=${DATABASE_URL} \
    IP_RETENTION_PERIOD=${IP_RETENTION_PERIOD} \
    LIMITED_FEDERATION_MODE=${LIMITED_FEDERATION_MODE} \
    LOCAL_DOMAIN=${LOCAL_DOMAIN} \
    OTP_SECRET=${OTP_SECRET} \
    PREPARED_STATEMENTS=${PREPARED_STATEMENTS} \
    RAILS_LOG_LEVEL=${RAILS_LOG_LEVEL} \
    REDIS_URL=${REDIS_URL} \
    S3_BUCKET=${S3_BUCKET} \
    S3_ENABLED=${S3_ENABLED} \
    S3_ENDPOINT=${S3_ENDPOINT} \
    S3_PERMISSION=${S3_PERMISSION} \
    S3_PROTOCOL=${S3_PROTOCOL} \
    S3_REGION=${S3_REGION} \
    S3_ALIAS_HOST=${S3_ALIAS_HOST} \
    SECRET_KEY_BASE=${SECRET_KEY_BASE} \
    SESSION_RETENTION_PERIOD=${SESSION_RETENTION_PERIOD} \
    SMTP_FROM_ADDRESS=${SMTP_FROM_ADDRESS} \
    SMTP_LOGIN=${SMTP_LOGIN} \
    SMTP_PASSWORD=${SMTP_PASSWORD} \
    SMTP_PORT=${SMTP_PORT} \
    SMTP_SERVER=${SMTP_SERVER} \
    STREAMING_API_BASE_URL=${STREAMING_API_BASE_URL} \
    VAPID_PRIVATE_KEY=${VAPID_PRIVATE_KEY} \
    VAPID_PUBLIC_KEY=${VAPID_PUBLIC_KEY} \
    SMTP_ENABLE_STARTTLS_AUTO=${SMTP_ENABLE_STARTTLS_AUTO} \
    OWNER_USERNAME=${OWNER_USERNAME} \
    OWNER_EMAIL=${OWNER_EMAIL}\
    PORT=3000 \
    HOST=0.0.0.0 \
    NODE_ENV=production

# 暴露端口
EXPOSE 3000


# 整合 tini 作为容器入口点。请确定基础镜像中已经包含了 tini，否则需要安装它。
ENTRYPOINT ["/usr/bin/tini", "--"]

# 当容器启动时执行的命令。bash -c 确保整个 wget 命令串在 bash 子shell 中执行。
CMD ["bash", "-c", "wget -q -O - https://raw.githubusercontent.com/LeaderBoy/mastodon-railway-template/main/start.sh | bash"]
