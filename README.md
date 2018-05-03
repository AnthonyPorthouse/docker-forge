# Docker Forge

## What This Is

Docker Forge is a simple docker container for running Minecraft servers with mods loaded via [Minecraft Forge][forge].

## Example Usage

To run a server we would do something like the following: (values assume FTB Revelation 1.8.0)

```sh
docker run \
    --rm -it \
    -p 25565:25565 \
    --env RAM_MAX=4096M \
    --env FORGE_VERSION=1.12.2-14.23.2.2627 \
    -v /home/anthony/server:/opt \
    anthonyporthouse/docker-forge install
```

This mounts the server, downloads the forge installer, runs the installer then begins server initialization. The server will stop once it reaches the EULA confirmation step.

Now we confirm the EULA by changing the EULA file to include `eula=true`

Now we can once again run 

```sh
docker run \
    --rm -it \
    -p 25565:25565 \
    --env RAM_MAX=4096M \
    --env FORGE_VERSION=1.12.2-14.23.2.2627 \
    -v /home/anthony/server:/opt \
    anthonyporthouse/docker-forge
```

and our server will start up fully.

## Configuration

Several environment variables are exposed and these are used to configure the instance:

+ `FORGE_VERSION` - The version of Forge to use. This should match whatever your modpack is set to.
+ `MIN_RAM` - The minimum amount of RAM the server should have. Passed into the `-Xms` parameter. Defaults to `512M`
+ `MAX_RAM` - The maximum amount of RAM the server should have. Passed into the `-Xmx` parameter. Defaults to `2048M`
+ `JAVA_PARAMS` - Custom parameters to run the server with. Defaults to `-XX:+UseG1GC -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M`

## Command Arguments

+ `install` - Required during setup, or any time the forge version changes. This will download the forge installer, and run it. This fetches the Minecraft and the Forge universal JAR, then procede to run the server.

[forge]: http://www.minecraftforge.net "Minecraft Forge"
