FROM ubuntu:latest

MAINTAINER Christian Wollinger "cwollinger@web.de"

RUN apt-get update && apt-get install -y curl php
