#!/bin/bash

docker run --name samba -d \
-p 135:135/tcp \
-p 137:137/udp \
-p 138:138/udp \
-p 139:139/tcp \
-p 445:445/tcp \
-e USERNAME='user' \
-e PASSWORD='SecretPa$$word' \
-e READWRITE=true \
-v /mnt/iso:/shared cviorel/docker-samba-alpine
