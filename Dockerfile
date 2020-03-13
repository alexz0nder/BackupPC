FROM alpine:3.8

LABEL maintainer="Alexander Baklanov <alexzonder@e1.ru>"

ENV BACKUPPC_VERSION 4.2.1
ENV BACKUPPC_XS_VERSION 0.57
ENV RSYNC_BPC_VERSION 3.0.9.12
ENV PAR2_VERSION v0.8.0

# Install backuppc runtime dependencies
RUN apk --no-cache --update add python3 rsync bash perl perl-archive-zip perl-xml-rss perl-cgi perl-file-listing expat samba-client iputils openssh openssl rrdtool msmtp lighttpd lighttpd-mod_auth gzip apache2-utils tzdata libstdc++ libg
# Install Nagios NRPE plugins for monitoring
  nrpe nagios nagios-plugins nagios-plugins-load nagios-plugins-disk sudo \
# uncomment sudoers.d include catalogue.
 && sed -i 's/#includedir/includedir/g' /etc/sudoers \
# Install backuppc build dependencies
 && apk --no-cache --update --virtual build-dependencies add gcc g++ libgcc linux-headers autoconf automake make git patch perl-dev python3-dev expat-dev curl wget \
# Install supervisor
 && python3 -m ensurepip \
 && pip3 install --upgrade pip circus \
# Compile and install BackupPC:XS
 && git clone https://github.com/backuppc/backuppc-xs.git /root/backuppc-xs --branch $BACKUPPC_XS_VERSION \
 && cd /root/backuppc-xs \
 && perl Makefile.PL && make && make test && make install \
# Compile and install Rsync (BPC version)
 && git clone https://github.com/backuppc/rsync-bpc.git /root/rsync-bpc --branch $RSYNC_BPC_VERSION \
 && cd /root/rsync-bpc && ./configure && make reconfigure && make && make install \
# Compile and install PAR2
 && git clone https://github.com/Parchive/par2cmdline.git /root/par2cmdline --branch $PAR2_VERSION \
 && cd /root/par2cmdline && ./automake.sh && ./configure && make && make check && make install \
# Configure MSMTP for mail delivery (initially sendmail is a sym link to busybox)
 && rm -f /usr/sbin/sendmail \
 && ln -s /usr/bin/msmtp /usr/sbin/sendmail \
# Disable strict host key checking
 && sed -i -e 's/^# Host \*/Host */g' /etc/ssh/ssh_config \
 && sed -i -e 's/^#   StrictHostKeyChecking ask/    StrictHostKeyChecking no/g' /etc/ssh/ssh_config \
# Get BackupPC, it will be installed at runtime to allow dynamic upgrade of existing config/pool
 && curl -o /root/BackupPC-$BACKUPPC_VERSION.tar.gz -L https://github.com/backuppc/backuppc/releases/download/$BACKUPPC_VERSION/BackupPC-$BACKUPPC_VERSION.tar.gz \
# Prepare backuppc home
 && mkdir -p /home/backuppc && cd /home/backuppc \
# Mark the docker as not run yet, to allow entrypoint to do its stuff
 && touch /firstrun \
# Clean
 && rm -rf /root/backuppc-xs /root/rsync-bpc /root/par2cmdline  && mkdir -p /etc/nrpe.d && mkdir -p /usr/lib64/nagios/plugins \
 && apk del build-dependencies

COPY gitlab_swarm/get_swarm_git_status.sh /usr/bin/get_swarm_git_status.sh
COPY gitlab_swarm/make_swarm_git_backup.sh /usr/bin/make_swarm_git_backup.sh
RUN chmod +x /usr/bin/get_swarm_git_status.sh && chmod +x /usr/bin/make_swarm_git_backup.sh

COPY nagios/check_backuppc/check_backuppc /usr/lib64/nagios/plugins/check_backuppc
COPY nagios/check_backuppc/check_backuppc_du /usr/lib64/nagios/plugins/check_backuppc_du

COPY conf/nrpe.cfg /etc/nrpe.cfg
COPY conf/nrpe.d /etc/nrpe.d
COPY conf/lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY conf/sudoers /etc/sudoers
COPY conf/entrypoint.sh /entrypoint.sh
COPY conf/run.sh /run.sh
COPY conf/circus.ini /etc/circus.ini
RUN chmod +x /entrypoint.sh && chmod +x /run.sh

EXPOSE 8080
EXPOSE 5666

WORKDIR /home/backuppc

VOLUME ["/etc/backuppc", "/home/backuppc", "/data/backuppc"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/run.sh"]
