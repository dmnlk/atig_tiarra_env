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
    perl-utils \
    sqlite \
    sqlite-dev \
    sqlite-libs \
    build-base \
    ruby-dev \
    libidn \
    libidn-dev \
    wget \
    supervisor

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

WORKDIR /

RUN git clone https://github.com/atig/atig.git
WORKDIR atig 
RUN bundle install --jobs=4 --retry=3
RUN sed  -i -e s/::Twitter::Validation/::Twitter::TwitterText::Validation/ lib/atig/command/status.rb

ENV TARBALL https://bitbucket.org/topia/tiarra/get/full-history.tar.gz
ENV APPDIR  /tiarra
RUN  wget -qO- https://cpanmin.us \
    | perl - App::cpanminus \
  && cpanm HTTP::Request::Common \
  && rm -r ~/.cpanm 

RUN mkdir -p $APPDIR && \
    wget -qO- $TARBALL \
    | tar xzf - \
      --directory=$APPDIR \
      --strip-components=1 
COPY tiarra.conf /tiarra/

COPY supervisord.conf /etc/supervisord.conf
EXPOSE 6664

ENTRYPOINT ["/usr/bin/supervisord"]
