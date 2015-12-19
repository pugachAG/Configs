FROM phusion/baseimage

ADD configure_container.sh /tmp/
RUN sh /tmp/configure_container.sh


