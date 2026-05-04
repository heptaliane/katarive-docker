# katarive-docker

This repository provides a basic Docker setup for **Katarive**, a system for generating and managing narrated audio content.

## Prerequisites

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## Getting Started

To start the Katarive server along with the VOICEVOX engine, choose the configuration that matches your hardware:

### CPU (Default)
```bash
docker compose -f docker-compose.cpu.yaml up -d --build
```

### NVIDIA GPU
```bash
docker compose -f docker-compose.nvidia.yaml up -d --build
```
> [!NOTE]
> NVIDIA GPU support requires the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) installed on the host.

Once the containers are running, you can access the Web UI at:
[http://localhost:9421](http://localhost:9421)

## Customization

This is a basic setup designed to get you started quickly. You can customize the environment by:

- Modifying the `docker-compose.*.yaml` files to change ports or environment variables.
- Updating the `Dockerfile` to include additional plugins or change the build process.
- Mounting your own data volumes for persistent storage.

Additional configurations (e.g., for other hardware or plugins) may be added in the future. Feel free to adapt this setup to your specific needs.
