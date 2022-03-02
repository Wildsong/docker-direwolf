# I do this build in two stages.
# That way the final image does not need to have all the build and development files in it.

# STAGE 1 -- Clone the current direwolf source and build it.

FROM debian:bullseye AS direwolf_build

RUN apt-get update && \
    apt-get install -y git build-essential libasound2-dev libudev-dev libgps-dev cmake

RUN git clone http://github.com/wb2osz/direwolf

RUN cd direwolf && \
    mkdir build && cd build && \
    cmake .. && \
    make && \
    make install && \
    make install-conf

# STAGE 2 - Set up the user and config file.

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y git alsa-utils gpsd

COPY --from=direwolf_build /direwolf/build/direwolf.conf /srv/direwolf.conf.ORIGINAL
COPY --from=direwolf_build /usr/local/ /usr/local/

EXPOSE 8000

RUN groupadd -g 1000 direwolf && \
    useradd -u 1000 -g direwolf direwolf && \
    chfn -f "Direwolf" direwolf && \
    adduser direwolf audio

COPY $PWD/direwolf.conf /srv/

USER direwolf
WORKDIR /home/direwolf

CMD [ "direwolf", "-p", "-c", "/srv/direwolf.conf"]