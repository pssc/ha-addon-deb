ARG BUILD_FROM=ghcr.io/pssc/ha-addon-deb-amd64:latest
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

COPY rootfs/ /

RUN apt-get update \
    && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN echo deb http://ftp.uni-kl.de/debian-multimedia/ bookworm main >/etc/apt/sources.list.d/debian-multimedia.list && \
    apt-get update -oAcquire::AllowInsecureRepositories=true \
    && apt-get --allow-unauthenticated -y install --no-install-recommends deb-multimedia-keyring \
    && apt-get update \
    && apt-get -y install --no-install-recommends \
    	abcde \
        eject \
        lame \
        eyed3 \
        aacgain \
        rsync \
        glyrc

RUN if [ "${debug}" = "true" ];then \
    cp /usr/bin/abcde /usr/bin/abcde.orig \
    && cp /usr/bin/abcde-musicbrainz-tool /usr/bin/abcde-musicbrainz-tool.orig \
    && cp /usr/share/perl5/WebService/MusicBrainz.pm /usr/share/perl5/WebService/MusicBrainz.pm.orig \
    ; fi
COPY sources /sources/
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

# Build arguments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION


# Labels
LABEL \
    io.hass.name="deb-abcde" \
    io.hass.description="Debian based terminal for abcde" \
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
