TARGET := cpu

.PHONY: build start stop

build:
	env UID=$(shell id -u) GID=$(shell id -g) \
		docker compose -f docker-compose.$(TARGET).yaml build

start:
	env UID=$(shell id -u) GID=$(shell id -g) \
		docker compose -f docker-compose.$(TARGET).yaml \
		up -d --build

stop:
	env UID=$(shell id -u) GID=$(shell id -g) \
		docker compose -f docker-compose.$(TARGET).yaml \
		down --remove-orphans
