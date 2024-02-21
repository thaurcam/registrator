FROM golang:1.22.0-alpine3.19 AS builder
WORKDIR /go/src/github.com/gliderlabs/registrator/
COPY . .
RUN \
	apk add --no-cache curl git \
	&& CGO_ENABLED=0 GOOS=linux go build \
		-a -installsuffix cgo \
		-ldflags "-X main.Version=$(cat VERSION)" \
		-o bin/registrator \
		.

FROM alpine:3.19.1
RUN apk add --no-cache ca-certificates
COPY --from=builder /go/src/github.com/gliderlabs/registrator/bin/registrator /bin/registrator
RUN apk -U upgrade
ENTRYPOINT ["/bin/registrator"]
