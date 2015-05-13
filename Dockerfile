FROM ubuntu

MAINTAINER Halid Altuner <halid@halid.org>

RUN apt-get update
RUN apt-get upgrade -y

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y curl
RUN curl --silent http://apt.mopidy.com/mopidy.gpg | sudo apt-key add -
RUN curl --silent http://apt.mopidy.com/mopidy.list > /etc/apt/sources.list.d/mopidy.list
RUN apt-get update

RUN apt-get -y install mopidy mopidy-spotify mopidy-soundcloud mopidy-scrobbler mopidy-mpris mopidy-beets mopidy-alsamixer
RUN apt-get clean

ADD mopidy.conf /.config/mopidy/mopidy.conf
ADD webclient   /var/www/webclient

EXPOSE 6680 6600 8000

CMD /usr/bin/mopidy
