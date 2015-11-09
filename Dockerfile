# vim:set ft=dockerfile:
FROM debian:jessie

# install oracle jdk 7
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list \
  && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 \
  && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get update \
  && apt-get install -y \
    oracle-java7-installer \
    subversion \
    ant \
    ant-contrib \
    wget \
    python3-docopt \
    python3-psutil

# python3-docopt and python3-psutil above is to speed up jst install

# maven
# buildomatic requires maven to be installed in /usr/local/maven
RUN wget -qO- http://mirrors.ibiblio.org/apache/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz | tar xz -C /usr/local \
  && ln -s /usr/local/apache-maven-3.2.5 /usr/local/maven \
  && ln -s /usr/local/maven/bin/mvn /usr/local/bin/mvn

COPY e /

RUN groupadd jst --gid=1000 && useradd -g jst --uid=1000 jst
RUN mkdir /home/jst && chown jst:jst /home/jst
RUN mkdir -p /opt/jrs && chown jst:jst /opt/jrs

RUN mkdir -p /home/jst/bin && chown jst:jst /home/jst/bin

# create a symlink to jst (downloaded later, see the entrypoint)
RUN ln -s /home/jst/bin/jst /usr/local/bin/jst

COPY install-jst.sh /home/jst/
RUN chown jst:jst /home/jst/install-jst.sh

WORKDIR /opt/jrs

USER jst

ENTRYPOINT ["/e"]

CMD ["--help"]
