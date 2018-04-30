FROM mhart/alpine-node:8

WORKDIR /

RUN apk update && apk add nginx

# If you have native dependencies, you'll need extra tools
# RUN apk add --no-cache make gcc g++ python
RUN npm install node-raumserver

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.4.0/s6-overlay-amd64.tar.gz /tmp/
RUN gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C /

COPY ./manifest/ .

EXPOSE 3000 3535

ENTRYPOINT ["/init"]

