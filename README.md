# Run Subtitle Edit in docker container

**If you just want a CLI version there is a CLI version in here:**
https://github.com/SubtitleEdit/subtitleedit-cli

## Run Subtitle Edit command line

```sh
docker run --rm \
 --volume "$PWD":/app \
 andrepricardo/subtitleedit list
```

## Developer instructions

### Build container

```sh
docker build -t andrepricardo/subtitleedit .
```

### Test it locally

```sh
docker run --rm \
    --volume "$PWD":/data \
    -it andrepricardo/subtitleedit \
    list
```

```sh
docker run --rm \
    --volume "$PWD":/data \
    --entrypoint /bin/bash \
    -it andrepricardo/subtitleedit
```

#### OSX workaround X11

First setup OSX to forward X11
https://gist.github.com/sorny/969fe55d85c9b0035b0109a31cbcb088

Then run with `-e DISPLAY=docker.for.mac.host.internal:0`

```sh
docker run --rm \
    --volume "$PWD":/data \
    -e DISPLAY=docker.for.mac.host.internal:0 \
    -it andrepricardo/subtitleedit
```

For the CLI

```sh
docker run --rm \
    --volume "$PWD":/data \
    -e DISPLAY=docker.for.mac.host.internal:0 \
    -it andrepricardo/subtitleedit \
    /convert
```

Example

```sh
docker run --rm \
    --volume "$PWD":/data \
    -e DISPLAY=docker.for.mac.host.internal:0 \
    -it andrepricardo/subtitleedit \
    /convert 'de Oliveira-1993-Val Abraao.srt' subrip /fps:25 /targetfps:24
```
