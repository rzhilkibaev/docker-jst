# vim:set ft=dockerfile:
FROM debian:jessie

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
ENTRYPOINT ["/e"]

CMD ["--help"]
