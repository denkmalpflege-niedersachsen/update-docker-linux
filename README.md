# update-docker-linux

Shell script to update Docker Engine and Docker Desktop on Ubuntu/Debian Linux. Refreshes the official Docker APT repository, installs the latest `docker-ce`, `containerd.io`, and related plugins, then downloads and installs the latest Docker Desktop `.deb` package — all in one step.

## Usage

```bash
bash update-docker-linux.sh
```

Requires `sudo` privileges. Architecture is detected automatically (`amd64`/`arm64`).
