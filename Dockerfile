FROM ubuntu:latest

MAINTAINER Christian Wollinger "cwollinger@web.de"

RUN apt-get update && apt-get install -y curl php cron git php7.0-xml

ADD crontab /etc/cron.d/hello-cron
 
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/hello-cron
 
# Create the log file to be able to run tail
RUN touch /var/log/cron.log

RUN mkdir /api

RUN git clone https://github.com/planetteamspeak/ts3phpframework.git /api
 
# Run the command on container startup
CMD ["cron", "-f"]
