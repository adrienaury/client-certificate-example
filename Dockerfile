FROM frapsoft/openssl AS build

COPY ./openssl.cnf openssl.cnf

# setup self-signed CA for demo
RUN openssl req -config openssl.cnf -x509 -nodes -newkey rsa:2048 -keyout ca.key -out ca.crt

FROM httpd

COPY --from=build ca.crt /etc/pki/tls/certs/ca.crt
COPY --from=build ca.key /etc/pki/tls/private/ca.key

COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./httpd-ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf
