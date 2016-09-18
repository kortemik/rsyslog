#!/bin/bash

git clone https://github.com/rsyslog/librelp.git ${HOME}/build/kortemik/librelp
cd ${HOME}/build/kortemik/librelp
autoreconf -fvi
./configure --prefix=${HOME}/build/kortemik/target/librelp
make
make install
git clone https://github.com/rsyslog/liblogging.git ${HOME}/build/kortemik/liblogging
cd ${HOME}/build/kortemik/liblogging
autoreconf -fvi
./configure --prefix=${HOME}/build/kortemik/target/liblogging --disable-journal --enable-rfc3195 --disable-man-pages 
make
make install
git clone https://github.com/rsyslog/libestr.git ${HOME}/build/kortemik/libestr
cd ${HOME}/build/kortemik/libestr
autoreconf -fvi
./configure --prefix=${HOME}/build/kortemik/target/libestr
make
make install
git clone https://github.com/rsyslog/libfastjson.git ${HOME}/build/kortemik/libfastjson
cd ${HOME}/build/kortemik/libfastjson
./autogen.sh --prefix=${HOME}/build/kortemik/target/libfastjson
make
make install
cd ${HOME}/build/kortemik/rsyslog
PKG_CONFIG_PATH="${HOME}/build/kortemik/target/librelp/lib/pkgconfig" CFLAGS="-I${HOME}/build/kortemik/target/liblogging/include" LIBESTR_CFLAGS="-I${HOME}/build/kortemik/target/libestr/include" LIBESTR_LIBS="-L${HOME}/build/kortemik/target/libestr/lib -lestr" LIBLOGGING_STDLOG_CFLAGS="-I${HOME}/build/kortemik/target/liblogging/include" LIBLOGGING_STDLOG_LIBS="-L${HOME}/build/kortemik/target/liblogging/lib -llogging-stdlog" JSON_C_CFLAGS="-I${HOME}/build/kortemik/target/libfastjson/include/libfastjson" JSON_C_LIBS="-L${HOME}/build/kortemik/target/libfastjson/lib -lfastjson" RELP_CFLAGS="-I${HOME}/build/kortemik/target/librelp/include" RELP_LIBS="${HOME}/build/kortemik/target/librelp/lib" ./autogen.sh --prefix=${HOME}/build/kortemik/target/rsyslog --disable-generate-man-pages --enable-relp --enable-imfile --enable-debug --enable-memcheck 
make
make install
