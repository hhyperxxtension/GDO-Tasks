#!/bin/bash
SOURCE_DIR="./source"
BACKUP_DIR="./backup"
LOG_FILE="./backup.log"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVE_NAME="backup_$DATE.tar.gz"

if rsync -a --backup --backup-dir=incremental_$DATE $SOURCE_DIR/ $BACKUP_DIR/latest/; then
    tar -czf $BACKUP_DIR/$ARCHIVE_NAME -C $BACKUP_DIR latest/
else
    echo "Ошибка rsync" >&2
    exit 1
fi

md5sum $BACKUP_DIR/$ARCHIVE_NAME > $BACKUP_DIR/$ARCHIVE_NAME.md5
if md5sum -c $BACKUP_DIR/$ARCHIVE_NAME.md5; then
    echo "Проверка целостности пройдена"
else
    echo "Ошибка проверки целостности" >&2
    exit 1
fi

echo "$DATE: Резервное копирование успешно" >> $LOG_FILE
