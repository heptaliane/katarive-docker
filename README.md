# katarive-docker

This repository provides a basic Docker setup for **Katarive**, a system for generating and managing narrated audio content.

## Prerequisites

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Make](https://www.gnu.org/software/make/) (optional, but recommended)

## Getting Started

The easiest way to start Katarive is using the provided `Makefile`.

### 1. Start the Containers

By default, this will start the **CPU version** of VOICEVOX.

```bash
make start
```

If you have an **NVIDIA GPU** and the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) installed, run:

```bash
make start TARGET=nvidia
```

Once the containers are running, you can access the Web UI at:
[http://localhost:9421](http://localhost:9421)

### 2. Stop the Containers

```bash
make stop
```

## Advanced Usage

### Available Make Commands

| Command | Description |
| :--- | :--- |
| `make build` | Build the Docker images. |
| `make start` | Build and start the containers in detached mode. |
| `make stop` | Stop and remove the containers. |

You can specify the hardware target for any command using `TARGET=cpu` (default) or `TARGET=nvidia`.

### Customizing Plugins

Katarive plugins are automatically built during the Docker image creation based on the configuration in `plugins.csv`.

To add or remove plugins:
1. Edit `plugins.csv`.
2. Rebuild the images: `make build` (or `make start`).

The format of `plugins.csv` is: `repository_url,binary_name` (binary name is optional).

> [!TIP]
> Plugins with the **`default-`** prefix in their binary name have the lowest priority. If you want to override a default plugin's functionality, simply add a custom plugin without the `default-` prefix.

### Manual Execution

If you don't have `make`, you can run the commands manually. Ensure that `UID` and `GID` are set to avoid permission issues with mounted volumes:

```bash
export UID=$(id -u)
export GID=$(id -g)
docker compose -f docker-compose.cpu.yaml up -d --build
```

## Customization

- Modifying the `docker-compose.*.yaml` files to change ports or environment variables.
- Updating the `Dockerfile` for more complex build changes.
- Mounting your own data volumes for persistent storage.
