FROM ubuntu:16.04
MAINTAINER hsson

# Install and setup deluge
RUN apt-get update && apt-get install -y deluged deluge-web

RUN adduser --system  --gecos "Deluge Service" --disabled-password --group --home /var/lib/deluge deluge

# Expose port
EXPOSE 8112

# Mount volume where data will be saved
VOLUME /data

# Switch to deluge user
USER deluge

# Start web UI
ENTRYPOINT /usr/bin/deluge-web
