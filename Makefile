TARGET := cpu

.PHONY: build run

build:
	docker compose -f docker-compose.$(TARGET).yaml build

run:
	docker compose -f docker-copmose.$(TARGET).yaml up -d --build
