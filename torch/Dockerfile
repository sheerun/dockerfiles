FROM sheerun/cuda:latest

RUN git clone https://github.com/torch/distro.git /root/torch --recursive --depth 1

WORKDIR /root/torch

RUN bash install-deps

RUN ./install.sh

ENV LUA_PATH="/root/.luarocks/share/lua/5.1/?.lua;/root/.luarocks/share/lua/5.1/?/init.lua;/root/torch/install/share/lua/5.1/?.lua;/root/torch/install/share/lua/5.1/?/init.lua;./?.lua;/root/torch/install/share/luajit-2.1.0-beta1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua" LUA_CPATH="/root/.luarocks/lib/lua/5.1/?.so;/root/torch/install/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so" PATH="/root/torch/install/bin:$PATH"

ENV LD_LIBRARY_PATH="/root/torch/install/lib:$LD_LIBRARY_PATH" DYLD_LIBRARY_PATH="/root/torch/install/lib:$DYLD_LIBRARY_PATH" LUA_CPATH="/root/torch/install/lib/?.so;$LUA_CPATH"

RUN apt-get install -y libprotobuf-dev protobuf-compiler && luarocks install loadcaffe

RUN cd /tmp && git clone https://github.com/nimbix/image-common.git && cd image-common && ./install-nimbix-ubuntu-trusty.sh && rm -rf /tmp/image-common

RUN export -p | grep -v "^export HOSTNAME" | grep -v "^export PWD" | grep -v "^export DEBIAN_FRONTEND" | grep -v "^export HOME" | grep -v "^export SHLVL" > /etc/environment && rm /etc/profile.d/00-container-environment.sh
