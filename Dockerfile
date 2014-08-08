FROM ubuntu

MAINTAINER Devon Blandin <dblandin@gmail.com>

RUN apt-get update
RUN apt-get upgrade -y

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y curl
RUN curl --silent http://apt.mopidy.com/mopidy.gpg | sudo apt-key add -
RUN curl --silent http://apt.mopidy.com/mopidy.list > /etc/apt/sources.list.d/mopidy.list
RUN apt-get update

RUN apt-get -y install mopidy mopidy-spotify mopidy-scrobblericecast2
RUN apt-get clean

ADD mopidy.conf /.config/mopidy/mopidy.conf
ADD icecast.xml /etc/icecast2/icecast.xml
Add silence.mp3 /usr/share/icecast2/web/silence.mp3
ADD webclient   /var/www/webclient

EXPOSE 6680 6600 8000

CMD icecast2 -c /etc/icecast2/icecast.xml & /usr/bin/mopidy
