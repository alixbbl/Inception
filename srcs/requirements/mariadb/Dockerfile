FROM debian:bullseye

RUN apt-get update -y && apt-get install -y  mariadb-server

# create directories and set the correct permissions
RUN mkdir -p var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 755 /var/run/mysqld

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod 0644 /etc/mysql/mariadb.conf.d/ /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/dbscript.sh /usr/local/bin/
RUN chmod +755 /usr/local/bin/dbscript.sh

EXPOSE 3306

ENTRYPOINT [ "sh", "/usr/local/bin/dbscript.sh" ]
# ENTRYPOINT [ "/bin/bash" ]
