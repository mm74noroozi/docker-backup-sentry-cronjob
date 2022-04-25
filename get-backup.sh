#!/bin/bash
export SENTRY_DSN=$SENTRY_DSN_TOKEN
# export LEVEL=debug
eval "$(sentry-cli bash-hook --log-level debug)"

backup_path=/tmp/
name=$(date +backup_%Y-%m-%d_%H-%M-%S.tar.gz)

tar -czvf $backup_path/"$name" /source

scp -i /root/ssh/homeca -r -P $SERVER_PORT -o StrictHostKeyChecking=no $backup_path/* $SERVER_ADDRESS:$SERVER_BACKUP_PATH

rm  $backup_path/"$name"
