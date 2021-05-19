#!/bin/sh
set -x

# Only allow read access by default
READWRITE=${READWRITE:=false}

if [[ -n "$USERNAME" ]] && [[ -n "$PASSWORD" ]]
then
	# add a non-root user and group with no password, no home dir, no shell, and gid/uid set to 1000
	addgroup -g 1000 $USERNAME && adduser -D -H -G $USERNAME -s /bin/false -u 1000 $USERNAME

	# create a samba user matching our user from above
	echo -e "$PASSWORD\n$PASSWORD" | smbpasswd -a -s -c /config/smb.conf $USERNAME
fi

if [[ "$READWRITE" == "true" ]] && [[ -n "$PASSWORD" ]]
then
    sed -i "s/write list = /write list = $USERNAME/" /config/smb.conf
fi

supervisord -c /config/supervisord.conf
