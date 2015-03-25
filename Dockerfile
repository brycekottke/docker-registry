FROM nginx

RUN mkdir /etc/nginx/certs

COPY default.conf /etc/nginx/conf.d/default.conf
COPY docker-registry.conf /etc/nginx/docker-registry.conf

VOLUME ["/etc/nginx/certs"]

EXPOSE 443
