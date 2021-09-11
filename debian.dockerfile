FROM debian:stretch-slim as user
RUN apt-get -y upgrade
RUN apt-get -y update
#RUN export DEBIAN_FRONTEND=noninteractive && apt-get install build-essential libssl-dev
RUN apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y \
	adduser automake \
    bash bash-completion binutils bsdmainutils \
    ca-certificates cmake curl doxygen \
    g++-multilib git \
    libtool libffi6 libffi-dev lbzip2 \
    make nsis \
	openssh-client openssh-server \
    patch pkg-config \
    python python-pip \
    python3 python3-pip \
    python3-setuptools \
    vim virtualenv \
    xz-utils
ARG PASSWORD=${PASSWORD}
ENV GIT_DISABLE_UNTRACKED_CACHE=true
ARG HOST_UID=${HOST_UID:-4000}
ARG HOST_USER=${HOST_USER:-nodummy}
#RUN mkdir -p  /home/${HOST_USER} 
RUN [ "${HOST_USER}" == "root" ] || \
    (adduser -h /home/${HOST_USER} -D -u ${HOST_UID} ${HOST_USER} \
    && chown -R "${HOST_UID}:${HOST_UID}" /home/${HOST_USER})
#RUN for u in $(ls /home); do for g in disk lp floppy audio cdrom dialout video netdev games users; do addgroup $u $g; done;done
#RUN useradd -m -p $(openssl passwd -1 ${PASSWORD}) -s /bin/bash -G sudo ${HOST_USER}
#RUN echo "${HOST_USER}:${PASSWORD}" | chpasswd
#RUN echo root:${PASSWORD} | chpasswd
RUN echo "${HOST_USER} ALL=(ALL) ALL" >> /etc/sudoers
#RUN bash echo "root ALL=(ALL) ALL" >> /etc/sudoers
RUN echo "Set disable_coredump false" >> /etc/sudo.conf

RUN mkdir -p /home/${HOST_USER}/.ssh &&  chmod 700 /home/${HOST_USER}/.ssh
RUN touch  /home/${HOST_USER}/.ssh/id_rsa
RUN echo -n ${SSH_PRIVATE_KEY} | base64 --decode >  /home/${HOST_USER}/.ssh/id_rsa
RUN  chown -R "${HOST_UID}:${HOST_UID}" /home/${HOST_USER}/.ssh
RUN chmod 600 /home/${HOST_USER}/.ssh/id_rsa

WORKDIR /home/${HOST_USER}
CMD ["bash"]
