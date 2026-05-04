FROM node:lts-alpine AS fe-builder

WORKDIR /app

RUN apk add git

# Build katarive-web-ui
RUN git clone https://github.com/heptaliane/katarive-web-ui.git
RUN cd katarive-web-ui/ && npm install && npm run build

FROM golang:tip-alpine AS go-builder

WORKDIR /app

RUN apk add git

# Build katarive-server
RUN git clone https://github.com/heptaliane/katarive-server.git
RUN cd katarive-server/ && go build .

# Build body-content-source-plugin
RUN git clone https://github.com/heptaliane/katarive-body-content-source-plugin.git
RUN cd katarive-body-content-source-plugin/ && go build .

# Build voicevox-narrator-plugin
RUN git clone https://github.com/heptaliane/katarive-voicevox-narrator-plugin.git
RUN cd katarive-voicevox-narrator-plugin/ && go build .

FROM alpine:latest

WORKDIR /app

RUN apk add ffmpeg
RUN mkdir -p /app/plugins /app/web

COPY --from=fe-builder /app/katarive-web-ui/dist/ /app/web
COPY --from=go-builder /app/katarive-server/katarive-server /app/
COPY --from=go-builder /app/katarive-body-content-source-plugin/katarive-body-content-source-plugin /app/plugins/
COPY --from=go-builder /app/katarive-voicevox-narrator-plugin/katarive-voicevox-narrator-plugin /app/plugins/

CMD ["/app/katarive-server"]
