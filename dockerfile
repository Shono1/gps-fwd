FROM --platform=linux/arm64 ubuntu:24.04
# RUN pip install numpy pymavlink
RUN apt-get update && apt-get install -y --no-install-recommends git meson ninja-build pkg-config gcc g++
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && update-ca-certificates
WORKDIR /usr/local/app
COPY mavlink-router/ /usr/local/app/mavlink-router
WORKDIR /usr/local/app/mavlink-router
RUN git submodule update --init --recursive
RUN meson setup build . -Dsystemdsystemunitdir=/usr/lib/systemd/system
RUN ninja -C build install
COPY main.conf /etc/mavlink-router/main.conf
CMD [ "mavlink-routerd"]


# Pull with 
# POST http://192.168.1.111:9134/v2.0/extension/
# {
#   "identifier": "automata1.lan:5000/gps-fwd",
#   "tag": "router",
#   "name": "gps",
#   "docker": "automata1.lan:5000/gps-fwd",
#   "enabled": true,
#   "permissions": "{\"HostConfig\":{\"NetworkMode\": \"host\", \"Privileged\": true}}"
# }