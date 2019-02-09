FROM base/archlinux

# Workaround for wrong permissions in base image # https://github.com/archimg/archlinux/issues/6
RUN /usr/bin/chmod -v 1777 /tmp

RUN pacman -Syy && pacman --noconfirm -S sudo
RUN /usr/sbin/sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers && \
    /usr/sbin/echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# Add user, group sudo; switch to user
RUN /usr/sbin/groupadd --system sudo && /usr/sbin/useradd -m --groups sudo user
USER user

COPY ./.stack-work/install/x86_64-linux-tinfo6/lts-13.0/8.6.3/bin/archsetup-exe /opt/archsetup-exe
COPY config /opt/config/
COPY setup /opt/setup/

WORKDIR /opt
CMD /opt/archsetup-exe
