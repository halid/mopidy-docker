FROM ubuntu

MAINTAINER Devon Blandin <dblandin@gmail.com>

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y curl
RUN curl --silent http://apt.mopidy.com/mopidy.gpg | sudo apt-key add -
RUN curl --silent http://apt.mopidy.com/mopidy.list > /etc/apt/sources.list.d/mopidy.list
RUN apt-get update

RUN apt-get install mopidy mopidy-spotify -y

ADD mopidy.conf /.config/mopidy/mopidy.conf
ADD webclient   /var/www/webclient

EXPOSE 6680 6600

CMD ["/usr/bin/mopidy"]
