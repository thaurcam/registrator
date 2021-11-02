FROM golang:1.17.2-alpine3.14 AS builder
WORKDIR /go/src/github.com/gliderlabs/registrator/
COPY . .
RUN \
	apk add --no-cache curl git \
	&& curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh \
	&& dep ensure -vendor-only \
	&& CGO_ENABLED=0 GOOS=linux go build \
		-a -installsuffix cgo \
		-ldflags "-X main.Version=$(cat VERSION)" \
		-o bin/registrator \
		.

FROM alpine:3.14
RUN apk add --no-cache ca-certificates
COPY --from=builder /go/src/github.com/gliderlabs/registrator/bin/registrator /bin/registrator

ENTRYPOINT ["/bin/registrator"]
