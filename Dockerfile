FROM frapsoft/openssl AS build

COPY ./server.cnf server.cnf
COPY ./user.cnf user.cnf

# setup self-signed CA for demo
RUN openssl req -config server.cnf -x509 -nodes -newkey rsa:2048 -keyout ca_key.pem -out ca_cert.pem

# sign a user certificate for testing
RUN openssl req -config user.cnf -nodes -newkey rsa:2048 -keyout user_key.pem -out user_req.pem && \
    openssl x509 -req -CA ca_cert.pem -CAkey ca_key.pem -CAcreateserial -in user_req.pem -out user_cert.pem && \
    openssl pkcs12 -export -password pass:password -clcerts -in user_cert.pem -inkey user_key.pem -out user.p12

FROM httpd

COPY --from=build ca_cert.pem /etc/pki/tls/certs/ca_cert.pem
COPY --from=build ca_key.pem /etc/pki/tls/private/ca_key.pem

COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./httpd-ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf

COPY --from=build user.p12 /usr/local/apache2/htdocs/public/user-certificate.p12

COPY ./index.html /usr/local/apache2/htdocs/index.html
COPY ./authenticated.html /usr/local/apache2/htdocs/private/index.html