FROM alpine:latest
RUN apk add --no-cache ca-certificates \
    dpkg \
    git \
    musl-dev \
    openssh \
    bash \
    tzdata \
    ruby \
    ruby-bundler \
    perl \
    sqlite \
    sqlite-dev \
    sqlite-libs \
    build-base \
    ruby-dev \
    libidn \
    libidn-dev \
    wget

WORKDIR /

RUN git clone https://github.com/atig/atig.git
WORKDIR atig 
RUN bundle install --path=vendor/bundle --jobs=4 --retry=3

WORKDIR /
RUN wget http://www.clovery.jp/tiarra/archive/2010/02/tiarra-20100212.tar.gz \
    && tar -zxvf tiarra-20100212.tar.gz \
    && ln -s tiarra-20100212 tiarra
COPY tiarra.conf tiarra/


ENTRYPOINT ["/tiarra/tiarra", "-d"]
