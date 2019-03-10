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
    libidn-dev

WORKDIR /

RUN git clone https://github.com/atig/atig.git
WORKDIR atig 
RUN bundle install --path=vendor/bundle --jobs=4 --retry=3
