oleg@blond-figure:~/GigaDevOps/Linux/4/2Task$ ./backup.sh
./backup/backup_2025-09-09_00-52-14.tar.gz: OK
Проверка целостности пройдена
oleg@blond-figure:~/GigaDevOps/Linux/4/2Task$ ls
backup  backup.log  backup.sh  source
oleg@blond-figure:~/GigaDevOps/Linux/4/2Task$ ls backup
backup_2025-09-09_00-49-42.tar.gz      backup_2025-09-09_00-52-14.tar.gz      latest
backup_2025-09-09_00-49-42.tar.gz.md5  backup_2025-09-09_00-52-14.tar.gz.md5
oleg@blond-figure:~/GigaDevOps/Linux/4/2Task$ ls source/
one  two
oleg@blond-figure:~/GigaDevOps/Linux/4/2Task$ ls backup/latest/
one  two
oleg@blond-figure:~/GigaDevOps/Linux/4/2Task$ cat backup.log
2025-09-09_00-49-42: Резервное копирование успешно
2025-09-09_00-52-14: Резервное копирование успешно
oleg@blond-figure:~/GigaDevOps/Linux/4/2Task$

