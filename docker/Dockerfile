FROM frolvlad/alpine-glibc:alpine-3.7

MAINTAINER yyu <yyu [at] mental.poker>

ENV TEXLIVE_DEPS \
    xz \
    tar \
    fontconfig-dev
    
ENV TEXLIVE_PATH /usr/local/texlive

ENV FONT_DEPS \
    unzip \
    fontconfig-dev

ENV FONT_PATH /usr/share/fonts/

ENV PERSISTENT_DEPS \
    wget \
    make \
    perl \
    ghostscript \
    bash \
    git

ENV PATH $TEXLIVE_PATH/bin/x86_64-linuxmusl:$PATH

RUN apk upgrade --update

# Install basic dependencies
RUN apk add --no-cache --virtual .persistent-deps $PERSISTENT_DEPS

# Setup fonts
RUN mkdir -p $FONT_PATH && \
    apk add --no-cache --virtual .font-deps $FONT_DEPS && \
    wget https://github.com/adobe-fonts/source-han-sans/raw/release/SubsetOTF/SourceHanSansJP.zip && \
      unzip SourceHanSansJP.zip && \
      cp SourceHanSansJP/*.otf $FONT_PATH && \
      rm -rf SourceHanSansJP.zip SourceHanSansJP && \
    wget https://github.com/adobe-fonts/source-han-serif/raw/release/SubsetOTF/SourceHanSerifJP.zip && \
      unzip SourceHanSerifJP.zip && \
      cp SourceHanSerifJP/*.otf $FONT_PATH && \
      rm -rf SourceHanSerifJP.zip SourceHanSerifJP && \
    fc-cache -f -v && \
    apk del .font-deps

# Set timezone to Tokyo
RUN apk --no-cache add tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo 'Asia/Tokyo' > /etc/timezone

# Install TeXLive
RUN apk add --no-cache --virtual .texlive-deps $TEXLIVE_DEPS && \
    mkdir /tmp/install-tl-unx && \
    wget -qO- http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | \
      tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    printf "%s\n" \
      "TEXDIR $TEXLIVE_PATH" \
      "selected_scheme scheme-small" \
      "option_doc 0" \
      "option_src 0" \
      > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
      -profile /tmp/install-tl-unx/texlive.profile && \
    tlmgr install latexmk collection-luatex collection-langjapanese \
      collection-fontsrecommended type1cm mdframed needspace fontaxes \
      boondox everyhook svn-prov framed placeins adjustbox \
      collectbox comment fncychap && \
    luaotfload-tool -u -vvv && \
    apk del .texlive-deps

VOLUME ["/workdir"]

WORKDIR /workdir

ENTRYPOINT ["/bin/bash", "-c", "make japanese"]
