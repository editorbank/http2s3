# The HTTP bridge to S3/AWS compatible storage

## Test commands for Linux

* Run server in Docker via docker-compose

```bash
./init.sh
```

* Test

```bash
./test.sh
```

* Clean work space

```bash
./clean.sh
```

## Errors

* 1
```text
WARN[0000] Error validating CNI config file /home/ed/.config/cni/net.d/http2s3_default.conflist: [plugin bridge does not support config version "1.0.0" plugin portmap does not support config version "1.0.0" plugin firewall does not support config version "1.0.0" plugin tuning does not support config version "1.0.0"] 
ERRO[0000] Error tearing down partially created network namespace for container 37d46135160583f13052790eceeefdbb38c72c1db8c1e092e5514126d4adbb0f: CNI network "http2s3_default" not found 
```

Replace in file `~/.config/cni/net.d/http2s3_default.conflist` text `"cniVersion": "1.0.0",` to `"cniVersion": "0.4.0",` as in `*-podman.conflist`.
Add fix to `init-podman.sh`.

* 2
```text
Error: unable to start container 357c140ba9b15c726410a799e162e129c12b69820346fc00b191045ecfa7882b: rootlessport cannot expose privileged port 82, you can add 'net.ipv4.ip_unprivileged_port_start=82' to /etc/sysctl.conf (currently 1024), or choose a larger port number (>= 1024): listen tcp 0.0.0.0:82: bind: permission denied
exit code: 125
ERRO[0006] error starting some container dependencies
ERRO[0006] "rootlessport cannot expose privileged port 82, you can add 'net.ipv4.ip_unprivileged_port_start=82' to /etc/sysctl.conf (currently 1024), or choose a larger port number (>= 1024): listen tcp 0.0.0.0:82: bind: permission denied"
Error: unable to start container 1959ed6a1d8a7f07d5eed09ca2f3c27b456837075eddc424e63aa10fde4d61fa: error starting some containers: internal libpod error
exit code: 125
```
Change in ports 81,82 to 8001,8002.

## Links

* [Я сделал свой PyPI-репозитарий с авторизацией и S3. На Nginx](https://habr.com/ru/articles/518126/)
* [Use Compose Files with Podman](https://docs.oracle.com/en/learn/podman-compose/index.html#confirm-podman-compose-is-working)
