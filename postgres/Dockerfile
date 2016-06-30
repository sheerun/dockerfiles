FROM postgres:9.5
MAINTAINER Adam Stankiewicz <sheerun@sher.pl>

ENV ZOMBODB_VER 3.0.0
ENV POSTGIS_VER 2.2

# Install dependencies
RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates wget python-pip curl

# Install pgxn
RUN pip install pgxnclient

# Install postgis
RUN apt-get install --no-install-recommends -y postgresql-9.5-postgis-${POSTGIS_VER}

# Install zombo
RUN cd / && mkdir zombodb && cd zombodb \
  && wget https://github.com/zombodb/zombodb/releases/download/v${ZOMBODB_VER}/zombodb_trusty_pg95-${ZOMBODB_VER}_amd64.deb \
  && cd /zombodb && dpkg -i zombodb_trusty_pg95-${ZOMBODB_VER}_amd64.deb

# Cleanup
RUN apt-get update -y -qq --fix-missing \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Configuration
COPY postgresql.conf "/usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample"
