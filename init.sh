#!/bin/sh

# Set timezone
if [ ! -z "${SYSTEM_TIMEZONE}" ]; then
    echo "configuring system timezone"
    echo "${SYSTEM_TIMEZONE}" > /etc/timezone
    dpkg-reconfigure -f noninteractive tzdata
fi

# Set mynetworks for postfix relay
if [ ! -z "${MYNETWORKS}" ]; then
    echo "setting mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 ${MYNETWORKS}"
    postconf -e mynetworks=" 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 ${MYNETWORKS}"
fi

if [ ! -z "${MYHOSTNAME}" ]; then
    echo "setting mynet = ${MYHOSTNAME}"
    postconf -e myhostname="${MYHOSTNAME}"
fi

if [ ! -z "${RELAYHOST}" ]; then
    echo "setting relayhost = ${RELAYHOST}"
    postconf -e relayhost="${RELAYHOST}"
fi

postconf -e inet_interfaces=all
postconf -e inet_protocols=ipv4

cat /etc/postfix/main.cf

/etc/init.d/postfix restart
