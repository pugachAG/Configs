FROM phusion/baseimage

#RUN apt-get update && apt-get upgrade && apt-get install -y git

# Create user
RUN useradd -g sudo -m pugachag && echo "pugachag:Zaa123" | chpasswd

ADD install_vim.sh /tmp/
RUN sh /tmp/install_vim.sh


