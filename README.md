# Introduction
This project provides Docker images to periodically back up a PostgreSQL database to S3 and automatically rotate the backup files.
The project is based on [saltonmassally/python-rotate-backups-s3](https://github.com/saltonmassally/python-rotate-backups-s3) for rotating files
and  [heyman/postgresql-backup](https://github.com/heyman/postgresql-backup) for backup and restore data from PostgreSQL.
# Usage
## Backup
```yaml
services:
  postgres:
    image: postgres:12
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password

  backup:
    image: navidmir/postgres-backup-to-s3-with-rotation:latest
    environment:
      CRON_SCHEDULE=* */12 * * *
      DB_HOST=postgres
      DB_PASS=password
      DB_USER=user
      DB_NAME=mydb
      S3_PATH=s3://backup/
      S3_ENDPOINT=https://s3.amazonaws.com
      AWS_ACCESS_KEY_ID=
      AWS_SECRET_ACCESS_KEY=
      ROTATION_DAILY=7
      ROTATION_WEEKLY=4
      ROTATION_MONTHLY=12
      ROTATION_YEARLY=always
```
