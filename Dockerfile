FROM phusion/baseimage

ADD . /tmp/config/
RUN sh /tmp/config/configure_container.sh

ENV TERM xterm

