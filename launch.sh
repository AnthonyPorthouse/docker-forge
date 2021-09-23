#!/bin/sh
set -e

if [ "$1" = "install" ]; then
	curl -L "https://files.minecraftforge.net/maven/net/minecraftforge/forge/$FORGE_VERSION/forge-$FORGE_VERSION-installer.jar" -o "forge-$FORGE_VERSION-installer.jar"
	java -jar "forge-$FORGE_VERSION-installer.jar" --install
	rm "forge-$FORGE_VERSION-installer.jar" "forge-$FORGE_VERSION-installer.jar.log"
fi

echo "Accepting Minecraft EULA"
echo "eula=true" > eula.txt

if [ -f "run.sh" ] && [ -f "user_jvm_args.txt" ]; then
	echo "Detected forge launch script, executing."

	echo "-Xms${MIN_RAM}" >> user_jvm_args.txt
	echo "-Xmx${MAX_RAM}" >> user_jvm_args.txt
	echo "${JAVA_PARAMS}"

	./run.sh nogui
else
	echo "Detected legacy forge jar, executing."
	java -server -Xms"${MIN_RAM}" -Xmx"${MAX_RAM}" ${JAVA_PARAMS} -jar "forge-$FORGE_VERSION.jar" nogui
fi
