FROM sameersbn/ubuntu:14.04.20150604
MAINTAINER sameer@damagehead.com

ENV ftp_proxy http://proxy.pfr.co.nz:8080
ENV http_proxy http://proxy.pfr.co.nz:8080
ENV https_proxy http://proxy.pfr.co.nz:8080
ENV no_proxy localhost,127.0.0.1,10.1.4.52,10.1.4.56,10.1.8.154,.pfr.co.nz


ENV PG_VERSION 9.4
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
 && echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
 && apt-get update \
 && apt-get install -y postgresql-${PG_VERSION} postgresql-client-${PG_VERSION} postgresql-contrib-${PG_VERSION} \
 && rm -rf /var/lib/postgresql \
 && rm -rf /var/lib/apt/lists/* # 20150604

ADD start /start
RUN chmod 755 /start

EXPOSE 5432

VOLUME ["/var/lib/postgresql"]
VOLUME ["/run/postgresql"]

CMD ["/start"]
