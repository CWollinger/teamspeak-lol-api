FROM ubuntu:latest

MAINTAINER Christian Wollinger "cwollinger@web.de"



RUN apt-get update && apt-get install -y curl php cron git php7.0-xml jq
RUN mkdir /api

#COPY crontab /etc/cron.d/hello-cron
COPY lolstatus.php /api
COPY lolstatus.sh /api
 
# Give execution rights on the cron job
#RUN chmod 0644 /etc/cron.d/hello-cron
 
# Create the log file to be able to run tail
RUN touch /var/log/cron.log

ADD crontab /root/
RUN crontab /root/crontab

RUN git clone https://github.com/planetteamspeak/ts3phpframework.git /api/ts3phpframework
RUN chmod u+x /api/lolstatus.sh
# Run the command on container startup
WORKDIR /api

COPY entrypoint.sh /api
RUN chmod u+x /api/entrypoint.sh
ENTRYPOINT ["/api/entrypoint.sh"]
