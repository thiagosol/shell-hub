#!/bin/sh

chmod 600 /root/.ssh/deploy_key

eval $(ssh-agent -s)
ssh-add /root/.ssh/deploy_key

exec /entrypoint.sh
