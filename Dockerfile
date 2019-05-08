FROM frapsoft/openssl AS build

COPY ./certificate.config certificate.config

# setup auto-signed CA for demo
RUN openssl req -config certificate.config -new -newkey rsa:2048 -nodes -keyout domain.key -out domain.csr && \
    openssl x509 -req -days 365 -in domain.csr -signkey domain.key -out domain.crt

FROM httpd

COPY --from=build domain.crt /etc/pki/tls/certs/ca.crt
COPY --from=build domain.key /etc/pki/tls/private/ca.key
COPY --from=build domain.csr /etc/pki/tls/private/ca.csr

COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./httpd-ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf
