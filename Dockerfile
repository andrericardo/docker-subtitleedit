# syntax=docker/dockerfile:1.6

FROM ubuntu:22.04 AS unzipper
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    unzip

ARG version=4.0.1
ARG file=SE401.zip
ARG checksum=3729606b10a6cc47bc72c6ff1570931eaf1072974f979137ea6239ed6edada48

ADD --checksum=sha256:${checksum} https://github.com/SubtitleEdit/subtitleedit/releases/download/${version}/${file} /tmp/
RUN unzip /tmp/${file} -d /app/ \
 && rm -rf /tmp/${file}

FROM ubuntu:22.04
COPY  --from=unzipper /app/ /app/

ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update && apt-get install -y \
    mono-complete \
    libhunspell-dev \
    # (libmpv.so)
    libmpv-dev \
    tesseract-ocr \
    # (already installed on some distros, SE uses (libvlc.so))
    vlc \
    # (already installed on some distros)
    ffmpeg \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /data

# SubtitleEdit /convert
# See the examples in https://www.nikse.dk/subtitleedit/help#commandline
# use `SubtitleEdit /convert /list` for the full list
ENTRYPOINT ["mono", "/app/SubtitleEdit.exe"]
