#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: deb
# ==============================================================================

set -xe
exit 0
DIRS="/root /home"
DDEST=/data
CFGS="/etc/ssh /etc/vim"
CDEST=/config/deb

mkdir -p ${CDEST}

for i in $DIRS;do
	bn=$(basename $i)
	[ ! -L ${i} -a ! -r ${DDEST}/${bn} ] && mv $i ${DDEST}/ && ln -s ${DDEST}/${bn} $i 
done

for i in $CFGS;do
	bn=$(basename $i)
	[ ! -L ${i} -a ! -r ${CDEST}/${bn} ] && mv $i ${CDEST}/ && ln -s ${CDEST}/${bn} $i 
done
