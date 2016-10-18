# postfix-satellite-rsyslog
Postfix Satellite + rsyslog

This container will relay mail through another SMTP server specified via environment variables. It's been created to be used along other docker containers.

Example usage:

docker run -i -t --name postfix -e MYHOSTNAME=myhostname.local -e MYNETWORKS=172.17.0.0/16 -e RELAYHOST=smtp.someserver.com -v /opt/log:/var/log atr0s/postfix-syslog-satellite
