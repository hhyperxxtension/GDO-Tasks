oleg@blond-figure:~/GD-Linux-3/Linux/4$ nano script1.sh
oleg@blond-figure:~/GD-Linux-3/Linux/4$ chmod +x script1.sh
oleg@blond-figure:~/GD-Linux-3/Linux/4$ ./script1.sh
^Coleg@blond-figure:~/GD-Linux-3/Linux/4$ ls
logs  script1.sh
oleg@blond-figure:~/GD-Linux-3/Linux/4$ cd logs/
oleg@blond-figure:~/GD-Linux-3/Linux/4/logs$ ls
monitor_2025-09-06.err  monitor_2025-09-06.log
oleg@blond-figure:~/GD-Linux-3/Linux/4/logs$ cat monitor_2025-09-06.err
oleg@blond-figure:~/GD-Linux-3/Linux/4/logs$ cat monitor_2025-09-06.log
=== Мониторинг на Sat Sep  6 20:24:27 MSK 2025 ===
Загрузка CPU:
top - 20:24:28 up  6:43,  4 users,  load average: 0.40, 0.36, 0.42
Память:
               total        used        free      shared  buff/cache   available
Mem:           3.8Gi       3.1Gi       180Mi        46Mi       774Mi       654Mi
Swap:          4.0Gi       2.0Gi       2.0Gi
Диск:
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           387M   17M  371M   5% /run
/dev/vda1        96G   24G   73G  25% /
tmpfs           1.9G  3.1M  1.9G   1% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/vda16      881M  142M  678M  18% /boot
/dev/vda15      105M  6.2M   99M   6% /boot/efi
tmpfs           387M   20K  387M   1% /run/user/1000
/dev/loop10p1   264M   40K  243M   1% /mnt/quota
Получен сигнал завершения. Ротация логов и выход.
oleg@blond-figure:~/GD-Linux-3/Linux/4/logs$ cd ..
oleg@blond-figure:~/GD-Linux-3/Linux/4$ ls
logs  script1.sh
oleg@blond-figure:~/GD-Linux-3/Linux/4$ ./script1.sh -d
+ trap cleanup SIGINT SIGTERM
+ true
+ monitor
++ date
+ echo '=== Мониторинг на Sat Sep  6 20:25:54 MSK 2025 ==='
+ echo 'Загрузка CPU:'
+ top -bn1
+ grep 'load average'
+ echo Память:
+ free -h
+ echo Диск:
+ df -h
+ rotate_logs
+ find ./logs -type f -name '*.log' -mtime +3 -delete
+ find ./logs -type f -name '*.err' -mtime +3 -delete
+ sleep 60
^C++ cleanup
++ echo 'Получен сигнал завершения. Ротация логов и выход.'
++ rotate_logs
++ find ./logs -type f -name '*.log' -mtime +3 -delete
++ find ./logs -type f -name '*.err' -mtime +3 -delete
++ exit 0
oleg@blond-figure:~/GD-Linux-3/Linux/4$ nano
logs/       script1.sh
oleg@blond-figure:~/GD-Linux-3/Linux/4$ nano script1.sh
oleg@blond-figure:~/GD-Linux-3/Linux/4$
