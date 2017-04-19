FROM sheerun/torch:latest

WORKDIR /root

RUN git clone https://github.com/jcjohnson/neural-style.git

WORKDIR /root/neural-style

RUN bash models/download_models.sh

RUN export -p | grep -v "^export HOSTNAME" | grep -v "^export PWD" | grep -v "^export DEBIAN_FRONTEND" | grep -v "^export HOME" | grep -v "^export SHLVL" > /etc/profile.d/00-environment.sh
