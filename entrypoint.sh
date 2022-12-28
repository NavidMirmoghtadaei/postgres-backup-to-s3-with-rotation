#!/bin/bash
set -e

if [[ $@ == crond* ]] && [ -z "$CRON_SCHEDULE" ]; then
    echo "ERROR: \$CRON_SCHEDULE not set!"
    exit 1
fi

# Write cron schedule
echo "$CRON_SCHEDULE python -u /backup/backup.py > /dev/stdout && rotate-backups-s3 -U $AWS_ACCESS_KEY_ID -P $AWS_SECRET_ACCESS_KEY --aws-host $(echo $S3_ENDPOINT |sed 's/^http\(\|s\):\/\///g') --daily=$ROTATION_DAILY --weekly=$ROTATION_WEEKLY --monthly=$ROTATION_MONTHLY --yearly=$ROTATION_YEARLY $S3_PATH > /dev/stdout" > /var/spool/cron/crontabs/root

exec "$@"
