FROM ubuntu:14.04

RUN dpkg --add-architecture i386

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-client \
    openssh-server \
    libopenal1 \
    libopenal1:i386 \
    lib32z1 \
    lib32ncurses5 \
    libbz2-1.0:i386 \
    libstdc++6:i386 \
    libxxf86vm1 \
    libssl1.0.0:i386 \
    libglu1:i386 \
    libxrandr-dev \
    libxrandr2:i386 \
    zip unzip

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y clang \
    libc6-dev-i386 \
    libcurl3:i386 \
    libssl-dev:i386

RUN DEBIAN_FRONTEND=noninteractive apt-get install fakeroot -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y rsync

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential

RUN mkdir /var/run/sshd

RUN useradd -ms /bin/bash -p maker -G sudo -g root game
RUN echo "game:maker" | chpasswd

USER game
RUN mkdir -p /home/game/Desktop

USER root

WORKDIR /home/game

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
