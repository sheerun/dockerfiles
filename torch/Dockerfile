FROM sheerun/cuda:latest

RUN git clone https://github.com/torch/distro.git /root/torch --recursive --depth 1 && \
  cd /root/torch && \
  bash install-deps

RUN cd /root/torch && \
# Run without nvcc to prevent timeouts
    sed -i 's/path_to_nvcc=$(which nvcc)/path_to_nvcc=$(which no_nvcc)/g' install.sh && \
    sed -i 's,path_to_nvcc=/usr/local/cuda/bin/nvcc,path_to_nvcc=,g' install.sh && \
  yes no | ./install.sh && \
# Restore Torch7 installation script
    sed -i 's/path_to_nvcc=$(which no_nvcc)/path_to_nvcc=$(which nvcc)/g' install.sh

ENV LUA_PATH="/root/.luarocks/share/lua/5.1/?.lua;/root/.luarocks/share/lua/5.1/?/init.lua;/root/torch/install/share/lua/5.1/?.lua;/root/torch/install/share/lua/5.1/?/init.lua;./?.lua;/root/torch/install/share/luajit-2.1.0-beta1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua" LUA_CPATH="/root/.luarocks/lib/lua/5.1/?.so;/root/torch/install/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so" PATH="/root/torch/install/bin:$PATH"

ENV LD_LIBRARY_PATH="/root/torch/install/lib:$LD_LIBRARY_PATH" DYLD_LIBRARY_PATH="/root/torch/install/lib:$DYLD_LIBRARY_PATH" LUA_CPATH="/root/torch/install/lib/?.so;$LUA_CPATH"

RUN luarocks install nn && luarocks install rnn && luarocks install penlight

RUN luarocks install cutorch

RUN luarocks install cunn && luarocks install cudnn

RUN apt-get install -y libprotobuf-dev protobuf-compiler && luarocks install loadcaffe
