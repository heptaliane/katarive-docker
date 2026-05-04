TARGET := cpu

.PHONY: build run

build:
	docker compose -f docker-compose.$(TARGET).yaml build

run:
	docker compose -f docker-compose.$(TARGET).yaml up -d --build
