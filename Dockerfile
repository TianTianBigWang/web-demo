FROM golang:1.22-alpine as builder
ENV GOPROXY=https://goproxy.io,direct
ENV GO111MODULE=on
ENV GOCACHE=/go/pkg/.cache/go-build
WORKDIR /work
ADD . .
RUN GOOS=linux CGO_ENABLED=0 go build -ldflags="-s -w" -installsuffix cgo -o app main.go

FROM alpine
ENV NAME=dynasty
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone
COPY --from=builder /work/app /work/app
#COPY --from=builder /work/config /work/config
WORKDIR /work
CMD ["./app"]
