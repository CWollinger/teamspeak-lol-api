FROM ubuntu:latest

MAINTAINER Christian Wollinger "cwollinger@web.de"

ENV LOL_IP localhost
ENV LOL_PORT 9987
ENV LOL_USER User
ENV LOL_PASSWORD Password
ENV LOL_NICK Nickname

RUN apt-get update && apt-get install -y curl php cron git php7.0-xml
RUN mkdir /api

COPY crontab /etc/cron.d/hello-cron
COPY lolstatus.php /api
COPY lolstatus.sh /api
 
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/hello-cron
 
# Create the log file to be able to run tail
RUN touch /var/log/cron.log

RUN git clone https://github.com/planetteamspeak/ts3phpframework.git /api/ts3phpframework

# Run the command on container startup
CMD ["cron", "-f"]
