#!/bin/sh

set -e

export CONF=/etc/umurmur/umurmur.conf

# if umurmur.conf was given with -v/-m option in docker
if mount | grep '/etc/umurmur' -q; then
	exit 0
fi

# strings
for i in welcometext certificate private_key ca_path password \
		admin_password banfile bindaddr bindaddr6 logfile \
		username groupname; do
	eval value=\$$i

	if [ $value ]; then
		sed -i \
			-e "s|^$i = .*|$i = \"$value\";|" \
			-e "s|# ?$i = .*|$i = \"$value\";|" \
			$CONF
	fi
done

unset i

# integers and booleans
for i in max_bandwidth ban_length enable_ban sync_banfile allow_textmessage \
		opus_threshold max_users bindport bindport6; do
	eval value=\$$i
	if [ $value ] ; then
		sed -i \
			-e "s|^$i = .*|$i = $value;|" \
			-e "s|# ?$i = .*|$i = $value;|" \
			$CONF
	fi
done

unset i

if ! grep -E '^channels =.*' $CONF -q; then
	cat /etc/umurmur/channels.conf >> $CONF
fi
