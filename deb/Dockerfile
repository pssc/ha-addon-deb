ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base/amd64:5.2.3
FROM ${BUILD_FROM}
ARG target_uid=1000
ARG debug=true

ARG BUILD_ARCH

# ARGS...

#FIX From Arg.
# env
# Allow longer shutdown
ENV S6_SERVICES_GRACETIME 119000
# Set for package install
ENV DEBIAN_FRONTEND "noninteractive" 
# FIXME? locales
#ENV LANG C.UTF-8
# TZ config at runtime
ENV DISABLE_HA_AUTHENTICATION true

# LMS 
# Debug?
ENV HA_USER "squeezeboxserver"
ENV UDEV false

RUN mv init s6init
COPY rootfs/ /


RUN apt-get update \
    && apt-get upgrade -y -o Dpkg::Options::="--force-confold" \
    && apt-get -y install --no-install-recommends \
		curl \
		wget \
		rsync \
		git \
		nfs-common \
		udev \
		awscli \
		lvm2 \
		patch \
		exfat-fuse \
		exfat-utils \
		openssh-server \
                gnupg2 \
		tmux \
		sudo \
                shellcheck \
		sshfs \
		tzdata 

RUN echo deb https://download.docker.com/linux/debian bullseye stable >/etc/apt/sources.list.d/docker.list && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - && \
    apt-get update && apt-get -y install --no-install-recommends \
                docker-ce-cli 

RUN echo deb http://ftp.uni-kl.de/debian-multimedia/ stable main >/etc/apt/sources.list.d/debian-multimedia.list && \
    apt-get update -oAcquire::AllowInsecureRepositories=true \
    && apt-get --allow-unauthenticated -y install --no-install-recommends deb-multimedia-keyring \
    && apt-get update \
    && apt-get -y install --no-install-recommends \
    	abcde \
        eject \
        lame \
        eyed3 \
        aacgain \
        glyrc

#RUN curl -sSL https://get.haskellstack.org/ | sh && \
#RUN apt-get install --no-install-recommends haskell-stack && \
#    stack upgrade && \
#    git clone https://github.com/hadolint/hadolint /sources/hadolint && \
#    cd /sources/hadolint && \
#    stack install
#RUN  usermod --password $(openssl passwd -1 wibble) root
#chpasswd
#FIXME DEV?
RUN if [[ ! -z "${debug}" ]];then apt-get -y install --no-install-recommends vim less procps strace;fi 

RUN mkdir -p /sources && cd /sources \
    && apt-get -y install --no-install-recommends build-essential cmake git libjson-c-dev libwebsockets-dev \
    && git clone --depth 1 --branch 1.6.3 https://github.com/tsl0922/ttyd.git \
    && cd ttyd && mkdir build && cd build \
    && cmake .. \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_VERBOSE_MAKEFILE=TRUE \
    && make && make install

RUN curl -L -s -o /usr/bin/ha \
        "https://github.com/home-assistant/cli/releases/download/4.17.0/ha_${BUILD_ARCH}" \
    && chmod a+x /usr/bin/ha \
    && ha completion > /usr/share/bash-completion/completions/ha

RUN cd /sources && git clone --depth 1 -b "stable" https://github.com/deajan/osync && cd osync && bash install.sh --no-stats && cd /tmp && rm -r /sources/osync

RUN apt-get install -y --no-install-recommends python3-pip python3-setuptools python3-dev python3-wheel gcc python3-jsonpath-rw python3-regex python3-requests python3-aiohttp python3-tabulate python3-netdisco python3-jinja2 python3-dateparser python3-ruamel.yaml python3-click python3-click-log && pip3 install homeassistant-cli

RUN apt-get install -y --no-install-recommends libjson-rpc-perl && cd /sources && git clone --depth 1 -b "master" https://github.com/pssc/squeezy && cd squeezy && cp squeezy /usr/local/bin/ && cd /tmp && rm -r /sources/squeezy

COPY patch /sources/

RUN for i in /sources/*.patch;do patch -d / -p1 -i $i;done || true

#Cleanup
RUN if [ -z "${debug}" -o "${debug}" = "false" ];then apt-get -y remove \
        git \
        wget \
        && apt-get clean -y \
	&& apt-get -y autoremove \
        && rm -f -r /sources \
        /root/.cache \
        /root/.cmake \
        && find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
	\
	&& rm -f /var/lib/apt/lists/* \
     ; fi

#RUN rm -r /tmp && ln -s /tmpfs /tmp
#ENV TEMP /tmpfs/
#ENV TMP /tmpfs/
#ENV TMPDIR /tmpfs/
#ENV TEMPDIR /tmpfs/
# root in tmp?

# HOME still said /root
#RUN sed -i -e "s#:/root:#:/data/root:#" /etc/passwd

VOLUME /data
VOLUME /share
VOLUME /backup
VOLUME /config
VOLUME /ssl
#VOLUME /tmpfs
VOLUME /media

# Build arguments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION


# Labels
LABEL \
    io.hass.name="deb" \
    io.hass.description="Debian based shell" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Phillip Camp <phillip.camp+ha<removeme>@gmail.com>" \
    org.label-schema.description="Debian based shell" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="deb" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.usage="https://github.com/pssc/ha-addon-deb/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/pssc/ha-addon-deb" \
    org.label-schema.vendor="pssc"

#    org.label-schema.url="https://community.home-assistant.io/t/home-assistant-community-add-on-portainer/68836?u=frenck" \
