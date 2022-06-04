#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: deb
# ==============================================================================

set -xe
DIRS="/root /home"
DDEST=/data
CFGS="/etc/ssh /etc/vim"
CDEST=/config/deb

mkdir -p ${CDEST}

for i in $DIRS;do
	bn=$(basename $i)
	if [ ! -L ${i} ];then
	   if [ ! -r ${DDEST}/${bn} ];then
              mv $i ${DDEST}/ 
           else 
	      mv $i $i.orig
	   fi
	   ln -s ${DDEST}/${bn} $i 
	fi
done

for i in $CFGS;do
	bn=$(basename $i)
	if [ ! -L ${i} ];then
	   if [ ! -r ${CDEST}/${bn} ];then
              mv $i ${CDEST}/ 
           else
	      mv $i $i.orig
	   fi
	   ln -s ${CDEST}/${bn} $i 
	fi
done
