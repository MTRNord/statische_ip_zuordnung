#!/bin/sh
# This is a Test

# hop into correct directory to avoid cron pwd sucks
cd $(dirname $0)

# function to get the current sha-1
getCurrentVersion() {
  git log --format=format:%H -1
}

# get sha-1 before pull
revision_current=$(getCurrentVersion)

git pull -q

# get sha-1 after pull
revision_new=$(getCurrentVersion)


if [ "$revision_current" != "$revision_new" ]
then
	/bin/cat /etc/dhcp/dhcpd.conf.bak >/etc/dhcp/dhcpd.conf
	/bin/cat ./static_ips >>/etc/dhcp/dhcpd.conf
	/usr/sbin/service isc-dhcp-server restart
fi
