#!/bin/bash
printenv | grep LOL > /api/env.txt

/usr/sbin/cron -f
