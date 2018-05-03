#!/bin/sh
set -e

if [ "$1" = "install" ]; then
	apk add --no-cache --update curl
	curl -L https://files.minecraftforge.net/maven/net/minecraftforge/forge/$FORGE_VERSION/forge-$FORGE_VERSION-installer.jar -o forge-$FORGE_VERSION-installer.jar
	java -jar forge-$FORGE_VERSION-installer.jar --install
	rm forge-$FORGE_VERSION-installer.jar forge-$FORGE_VERSION-installer.jar.log
	apk del curl
fi

java -server -Xms${MIN_RAM} -Xmx${MAX_RAM} ${JAVA_PARAMS} -jar forge-$FORGE_VERSION-universal.jar nogui