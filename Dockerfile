FROM golang:alpine

RUN  apk add --update git \
 &&  go get -u v2ray.com/core/... \
 &&  go install v2ray.com/core/tools/build \
 &&  $GOPATH/bin/build -dir /$GOPATH/bin/v2ray \
 &&  apk del git 
 
ENV CONFIG_JSON=... V2ray_crt=none v2ray_key=none

ADD entrypoint.sh /entrypoint.sh

RUN chgrp -R 0 /go/bin/v2ray \
    && chmod -R g+rwX /go/bin/v2ray \
    && chmod +x /entrypoint.sh

ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080
