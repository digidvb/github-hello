FROM golang:alpine AS build-env
RUN env && mkdir /go/src/app && apk update && apk add make cmake
ADD . /go/src/app/
WORKDIR /go/src/app
ENV [ "CGO_ENABLED=0", "GOOS=linux" ]
RUN mkdir build && cd build && cmake .. && make && make install

FROM scratch
WORKDIR /app
COPY --from=build-env /usr/local/bin/hello .
ENTRYPOINT [ "./hello" ]
