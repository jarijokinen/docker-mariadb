# docker-mariadb
#
# Dockerfile for MariaDB on Debian 9.0 (stretch)
#
# USAGE:
#
#   docker build -t mysql .
#   docker volume create --name mysql-data
#   docker run -d -p 127.0.0.1:3306:3306 -v mysql-data:/var/lib/mysql mysql

FROM debian:stretch-slim
MAINTAINER Jari Jokinen <info@jarijokinen.com>

RUN echo 'APT::Install-Recommends "0";' > /etc/apt/apt.conf.d/01recommends \
  && apt-get update \
  && apt-get install -y \
    mariadb-server \
    mariadb-client \
  && rm -rf /var/lib/apt/lists/*

RUN sed -i 's|127.0.0.1|0.0.0.0|' /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306
CMD ["/usr/bin/mysqld_safe"]
