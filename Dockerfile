FROM nginx:alpine
RUN apk update \
 && apk add jq \
 && rm -rf /var/cache/apk/*
COPY build /usr/share/nginx/html
COPY nginx-default.conf /etc/nginx/conf.d/default.conf
COPY 99-env-settings.sh /docker-entrypoint.d/99-env-settings.sh
RUN chmod 775 /docker-entrypoint.d/99-env-settings.sh
