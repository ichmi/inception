FROM debian:buster

WORKDIR /var/www/html

RUN apt-get update && apt-get upgrade -y && apt-get install -y openssl

RUN mkdir -p /etc/nginx/certificates
RUN \
openssl req -x509 \
-newkey rsa:2048 \
-nodes \
-keyout /etc/nginx/certificates/frosa-ma.key \
-out /etc/nginx/certificates/frosa-ma.csr \
-subj "/CN=frosa-ma.42.fr"

RUN apt-get install -y nginx

COPY conf/nginx.conf /etc/nginx
COPY conf/www.conf /etc/nginx/conf.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
