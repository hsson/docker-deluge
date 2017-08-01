FROM ubuntu:16.04
MAINTAINER hsson

# Install and setup deluge
RUN apt-get update && apt-get install -y deluged deluge-web

# Install and setup openvpn
RUN apt-get install -y openvpn unzip wget curl
RUN cd /tmp && wget https://files.ovpn.com/ubuntu_cli/ovpn-se.zip \
    && unzip ovpn-se.zip \
    && mv config/* /etc/openvpn \
    && rm -rf config \
    && rm ovpn-se.zip

ARG VPN_USER
ARG VPN_PASS
RUN echo ${VPN_USER} >> /etc/openvpn/credentials
RUN echo ${VPN_PASS} >> /etc/openvpn/credentials

# Expose ports
EXPOSE 8112
EXPOSE 1194
EXPOSE 1195

# Mount volume where data will be saved
VOLUME /data

# Copy over deluge configs
COPY deluge-conf/*.conf /root/.config/deluge/

COPY startup.sh /etc/torrent/startup.sh
RUN chmod +x /etc/torrent/startup.sh

# Start services
ENTRYPOINT /etc/torrent/startup.sh
