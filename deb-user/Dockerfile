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

# Force build 2
# LMS 
# Debug?
ENV HA_USER "squeezeboxserver"
ENV UDEV false

ENV TEST_A=fish
ENV TEST_AB=${TEST_A}+chips

COPY rootfs/ /

RUN apt-get update \
    && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN apt-get update \
    && apt-get upgrade -y -o Dpkg::Options::="--force-confold" \
    && apt-get -y install --no-install-recommends \
                linuxlogo \
                openssh-server \
                curl \
                wget \
                shellcheck \
                vim \
                git \
                awscli \
                iputils-ping \
                bind9-host \
                yq \
                file \
                android-file-transfer \
                mosquitto-clients \
                mariadb-client \
                pulseaudio-utils \
                pulsemixer \
                unzip \
                rsync 

RUN echo deb https://download.docker.com/linux/debian bookworm stable >/etc/apt/sources.list.d/docker.list && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - && \
    apt-get update && (apt-get -y install --no-install-recommends \                                            
                docker-ce-cli || true) 

RUN apt-get install -y --no-install-recommends python3-pip python3-setuptools python3-dev python3-wheel gcc python3-jsonpath-rw python3-regex python3-requests python3-aiohttp python3-tabulate python3-netdisco python3-jinja2 python3-dateparser python3-ruamel.yaml python3-click python3-click-log pipx && \
    pipx install homeassistant-cli==0.9.6
                                                                                                                                                                                                                                                                            
RUN apt-get install -y --no-install-recommends libjson-rpc-perl && cd /sources && git clone --depth 1 -b "master" https://github.com/pssc/squeezy && cd squeezy && cp squeezy /usr/local/bin/ && cd /tmp && rm -r /sources/squeezy                                          
                                                                                                                                                                                                                                                                            
# oh-my-bash                                                                                                                                                                                                                                                                
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --prefix=/usr/local --unattended                  


COPY patch /sources/

RUN for i in /sources/*.patch;do patch -d / -p1 -i $i;done || true

#Cleanup
RUN if [ -z "${debug}" -o "${debug}" = "false" ];then apt-get -y remove \
        curl \
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
    io.hass.name="deb-user" \
    io.hass.description="Debian User Terminal" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Phillip Camp <phillip.camp+ha<removeme>@gmail.com>" \
    org.label-schema.description="Debian User Terminal" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="deb" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.usage="https://github.com/pssc/ha-addon-deb/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/pssc/ha-addon-deb" \
    org.label-schema.vendor="pssc"

#    org.label-schema.url="https://community.home-assistant.io/t/home-assistant-community-add-on-portainer/68836?u=frenck" \
