FROM postgres:9.5
MAINTAINER Adam Stankiewicz <sheerun@sher.pl>

ENV ZOMBODB_VER 3.0.0
ENV POSTGIS_VER 2.2

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates wget python-pip curl build-essential

RUN echo "deb [arch=amd64] http://packages.2ndquadrant.com/pglogical/apt/ trusty-2ndquadrant main" > /etc/apt/sources.list.d/2ndquadrant.list

RUN wget --quiet -O - http://packages.2ndquadrant.com/pglogical/apt/AA7A6805.asc | apt-key add - && apt-get update

RUN apt-get install -y --no-install-recommends postgresql-server-dev-9.5

# Install zombo
RUN cd / && mkdir zombodb && cd zombodb \
  && wget https://github.com/zombodb/zombodb/releases/download/v${ZOMBODB_VER}/zombodb_trusty_pg95-${ZOMBODB_VER}_amd64.deb \
  && cd /zombodb && dpkg -i zombodb_trusty_pg95-${ZOMBODB_VER}_amd64.deb

# Install temporal tables extension
RUN pip install pgxnclient && pgxn install temporal_tables

RUN apt-get install -y --no-install-recommends postgresql-9.5-postgis-${POSTGIS_VER}
RUN apt-get install -y --no-install-recommends postgresql-9.5-pglogical postgresql-9.5-pglogical-output

# Cleanup
RUN apt-get update -y -qq --fix-missing \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Configuration
COPY config/postgresql.conf "/usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample"
COPY config/pg_hba.conf "/usr/share/postgresql/$PG_MAJOR/pg_hba.conf"
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY init.sh /docker-entrypoint-initdb.d/init.sh
