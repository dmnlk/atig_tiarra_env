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
	perl-archive-zip \
	perl-boolean \
	perl-capture-tiny \
	perl-cgi \
	perl-compress-raw-zlib \
	perl-data-dumper \
	perl-date-manip \
	perl-datetime \
	perl-datetime-format-strptime \
	perl-datetime-timezone \
	perl-dbd-sqlite \
	perl-dbi \
	perl-dev \
	perl-digest-sha1 \
	perl-doc \
	perl-file-slurp \
	perl-file-temp \
	perl-file-which \
	perl-getopt-long \
	perl-html-parser \
	perl-html-tree \
	perl-http-cookies \
	perl-io \
	perl-io-compress \
	perl-io-html \
	perl-io-socket-ssl \
	perl-io-stringy \
	perl-json \
	perl-libwww \
	perl-lingua-en-numbers-ordinate \
	perl-lingua-preferred \
	perl-list-moreutils \
	perl-lwp-useragent-determined \
	perl-module-build \
	perl-module-pluggable \
	perl-net-ssleay \
	perl-parse-recdescent \
	perl-path-class \
	perl-scalar-list-utils \
	perl-term-progressbar \
	perl-term-readkey \
	perl-test-exception \
	perl-test-requires \
	perl-timedate \
	perl-try-tiny \
	perl-unicode-string \
	perl-xml-libxml \
	perl-xml-libxslt \
	perl-xml-parser \
	perl-xml-sax \
	perl-xml-treepp \
	perl-xml-twig \
	perl-xml-writer
WORKDIR /

RUN git clone https://github.com/atig/atig.git
WORKDIR atig 
RUN bundle install --path=vendor/bundle --jobs=4 --retry=3

WORKDIR /
RUN wget http://www.clovery.jp/tiarra/archive/2010/02/tiarra-20100212.tar.gz \
    && tar -zxvf tiarra-20100212.tar.gz \
    && ln -s tiarra-20100212 tiarra
COPY tiarra.conf tiarra/

ENTRYPOINT ["/bin/bash"]
#ENTRYPOINT ["/tiarra/tiarra", "-d"]
