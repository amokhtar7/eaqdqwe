FROM alpine:latest

# install dependencies
# compile cpuminer

RUN apk --update --no-cache add libtool jansson openssl ca-certificates libcurl curl \
	&& apk --update --no-cache add --virtual build gcc git make automake openssl-dev \
			libtool ncurses-dev autoconf libc-dev curl-dev g++ \
	&& mkdir /build \
	&& cd /build \
	&& git clone --recursive https://github.com/tpruvot/cpuminer-multi.git \
	&& cd cpuminer-multi \
	&& ./autogen.sh \
	&& ./configure CFLAGS="-march=native" --with-crypto --with-curl \
	&& make \
	&& mv ./cpuminer / \
	&& cd / && rm -rf /build \
	&& apk del build

# install p2clu (j2cli in go)
ENV P2CLI_VERSION=r5
RUN curl -L https://github.com/wrouesnel/p2cli/releases/download/${P2CLI_VERSION}/p2 -o /usr/local/bin/p2 \
  && chmod +x /usr/local/bin/p2

ADD files/ /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

