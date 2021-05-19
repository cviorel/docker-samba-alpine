# docker-samba-alpine

Lightweight Samba docker container, based on the latest Alpine Linux base image.

By default, the share will be accessible read-only for everyone.
See smb.conf for details, or feel free to use your own config (see below).

Due to the fact that `nmbd` wants to broadcast and become the `local master` on your subnet,
you need to supply the `--network host` flag to make the server visible to the hosts subnet (likely your LAN).

Mapping the ports alone is likely not sufficient for proper discovery as the processes inside the container are only aware of the internal Docker network, and not the host network.

In any case, directly accessing the shares works just fine this way.

## Usage

```bash
docker run --name samba \
--rm -d \
--network host
-v /mnt/iso:/shared \
cviorel/docker-samba-alpine
```

When specifying `USERNAME` and `PASSWORD` a non-root user with no password, no home dir, no shell, and gid/uid set to `1000`
will be created.
Then a samba user matching this user from above will be created.

```bash
docker run --name samba \
-d \
-p 135:135/tcp \
-p 137:137/udp \
-p 138:138/udp \
-p 139:139/tcp \
-p 445:445/tcp \
-e USERNAME=user \
-e PASSWORD='SecretPa$$word' \
-e READWRITE=true \
-v /mnt/iso:/shared \
cviorel/docker-samba-alpine
```

## License

[MIT License](LICENSE)

## Author Information

[Viorel Ciucu](https://vciconsulting.net/)
