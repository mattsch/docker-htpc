# Fedora HTPC Docker Container

Docker container for [HTPC](https://github.com/Hellowlol/HTPC-Manager) using Fedora.

## Usage

Create with defaults:

```bash
docker create -v /path/to/config/dir:/config \
    -v /path/to/storage/dir:/storage \
    -v /etc/localtime:/etc/localtime:ro \
    -p 6789:6789 --name=htpc mattsch/fedora-htpc
```

Create with a custom uid/gid for the htpc daemon:

```bash
docker create -v /path/to/config/dir:/config \
    -v /path/to/storage/dir:/storage \
    -v /etc/localtime:/etc/localtime:ro \
    -e LUID=1234 -e LGID=1234 \
    -p 6789:6789 --name=htpc mattsch/fedora-htpc
```

Using host networking rather than the port forwards above will give the best
performance.  However, this allows the container to have full access to the
host's networking stack.  Be sure you understand the implications before using
it.

