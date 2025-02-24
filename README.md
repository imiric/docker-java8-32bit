# Java8 w/ IcedTea plugin

Dockerfile for creating a 32bit Docker image with Java8 JRE and the IcedTea plugin.
This is useful for old servers that use Java-based IPMI (e.g. Supermicro).

## Build

```shell
sudo docker build --platform linux/386 -t imiric/docker-java8-32bit .
```


## Usage

1. Download a JNLP file from the server.

2. Run:
   ```shell
   sudo docker run --rm --platform linux/386 --network=host \
     -e DISPLAY=$DISPLAY -e HOSTNAME=$HOSTNAME \
     -v /tmp/.X11-unix:/tmp/.X11-unix \
     -v "$HOME/Downloads/launch.jnlp:/data/launch.jnlp" \
     -it imiric/docker-java8-32bit javaws launch.jnlp
   ```
   
   This will launch the IcedTea Web window and load the application.
   You might be prompted to accept the HTTPS certificate, to accept the application
   signature and to run the application. 

   If you run into any permission issues connecting to the X server, such as
   `Can't open display` or `Authorization required`, allow local connections with:

   ```shell
   xhost +local:
   ```

   Then when you're done enable access control again with `xhost -`.

## License

[MIT](./LICENSE)
