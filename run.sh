#!/bin/sh

chmod 600 /root/.ssh/deploy_key

eval $(ssh-agent -s)
ssh-add /root/.ssh/deploy_key

export SHELL="/bin/bash"

exec /entrypoint.sh #--ssh "/usr/bin/ssh -o StrictHostKeyChecking=no -i /root/.ssh/deploy_key ${SHELL_SSH_SERVER}"
