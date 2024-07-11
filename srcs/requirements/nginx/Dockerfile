FROM debian:bullseye

RUN apt-get update -y && apt-get install -y nginx\
                                            openssl

# directory for SSL sertificates and the nginx process
RUN mkdir -p /etc/nginx/ssl

# create a self-signed SSL certificate for the nginx server
RUN  openssl req    -x509\
                    -nodes\
                    -out /etc/nginx/ssl/inception.crt\
                    -keyout /etc/nginx/ssl/inception.key\
                    -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=alibourb/CN=alibourb/"

RUN mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html
RUN chmod 755 /var/www/html

# ensure that the web server has the necessary permissions to read and write to those files
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

# run nginx in the foreground
ENTRYPOINT ["nginx", "-g", "daemon off;"]
