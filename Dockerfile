ARG VARIANT=slim

FROM openjdk:${VARIANT}

LABEL maintainer="Anthony Porthouse <anthony@porthou.se>"

RUN apt-get update \
    && apt-get install curl -y \
    && apt-get clean

# Minecraft and Forge Settings
ENV FORGE_VERSION="1.17.1-37.0.70"

# Server Settings
ENV MIN_RAM="512M"
ENV MAX_RAM="2048M"
ENV JAVA_PARAMS="-XX:+UseG1GC -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M"

COPY launch.sh /launch.sh

VOLUME /opt
WORKDIR /opt

EXPOSE 25565

ENTRYPOINT ["/launch.sh"]
