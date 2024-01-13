FROM ubuntu:22.04

ARG BAIK_VERSION=9.5.2

WORKDIR /workspace

RUN apt-get update

RUN apt-get install -y wget unzip gcc

RUN wget https://sourceforge.net/projects/baik/files/baik-source/baik%20versi%20$BAIK_VERSION%20source/baik9_source_$BAIK_VERSION-2021.zip/download -O /tmp/baik.zip 

RUN unzip /tmp/baik.zip

RUN mv baik* baik

WORKDIR /workspace/baik

RUN gcc -o baik -DLINUX \
        -I/usr/include -I/usr/local/include \
        -L/usr/lib -L/usr/lib64 -L/usr/local/lib  \
        tbaik.c baik_ident.c baik_stack.c baik_expression.c \
        baik_compare.c baik_factor.c interpreter.c interpreterSub.c interpreterClass.c \
        -lpthread -lm -lg

RUN cp -p baik /usr/local/bin 

WORKDIR /code

COPY bin .

CMD "./run.sh"