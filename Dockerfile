FROM node:lts-alpine AS fe-builder

WORKDIR /app

RUN apk add git

# Build katarive-web-ui
RUN git clone https://github.com/heptaliane/katarive-web-ui.git
RUN cd katarive-web-ui/ && npm install && npm run build

FROM golang:tip-alpine AS go-builder

WORKDIR /app

RUN apk add git openssh-client

# Build katarive-server
RUN git clone https://github.com/heptaliane/katarive-server.git
RUN cd katarive-server/ && go build .

# Build plugins
COPY build-plugins.sh plugins.csv /app/
RUN mkdir -p -m 0700 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts
RUN --mount=type=ssh sh build-plugins.sh /app/plugins.csv

FROM alpine:latest

WORKDIR /app

RUN apk add ffmpeg
RUN mkdir -p /app/plugins /app/web

COPY --from=fe-builder /app/katarive-web-ui/dist/ /app/web
COPY --from=go-builder /app/katarive-server/katarive-server /app/
COPY --from=go-builder /app/plugins/ /app/plugins

CMD ["/app/katarive-server"]
