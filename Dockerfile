FROM ubuntu:latest

MAINTAINER Christian Wollinger "cwollinger@web.de"

ENV LOL_IP localhost
ENV LOL_PORT 9987
ENV LOL_USER 
ENV LOL_PASSWORD 
ENV LOL_NICK

RUN apt-get update && apt-get install -y curl php cron git php7.0-xml

ADD crontab /etc/cron.d/hello-cron
 
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/hello-cron
 
# Create the log file to be able to run tail
RUN touch /var/log/cron.log

RUN mkdir /api

RUN git clone https://github.com/planetteamspeak/ts3phpframework.git /api/ts3phpframework

# Run the command on container startup
CMD ["cron", "-f"]
