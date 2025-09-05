oleg@blond-figure:~$
oleg@blond-figure:~$ sudo df -h
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           387M   18M  369M   5% /run
/dev/vda1        96G   24G   72G  25% /
tmpfs           1.9G  3.1M  1.9G   1% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/vda16      881M  113M  707M  14% /boot
/dev/vda15      105M  6.2M   99M   6% /boot/efi
overlay          96G   24G   72G  25% /var/lib/docker/overlay2/3f12c920b53a5cf9db3b44a6f75e34e466b35107dfb147b78f74488eb7bb9028/merged
overlay          96G   24G   72G  25% /var/lib/docker/overlay2/5c40aa9a7c86e8093886818d498646efcc11d2dd4ac5d7fa7e699e4e42c9663b/merged
overlay          96G   24G   72G  25% /var/lib/docker/overlay2/f02a43d80d9e5a36b004317f881f0b225ad53953a32845a58ad7c912cd227a9b/merged
overlay          96G   24G   72G  25% /var/lib/docker/overlay2/61ffacc1c544ec77c41e697b6915bd99a2c77e7b82fed9db53249242c6df5e70/merged
overlay          96G   24G   72G  25% /var/lib/docker/overlay2/08b15e51f312c613339206e192e41727540ff2c920209ff55a5d148b4596808d/merged
tmpfs           387M   16K  387M   1% /run/user/1000
/dev/loop11p1   435M   34M  402M   8% /mnt/disk2/p1
/dev/loop11p2   499M  5.8M  418M   2% /mnt/disk2/p2
/dev/loop12p1   293M   24K  270M   1% /mnt/disk3/p1
/dev/loop12p2   276M   23M  254M   9% /mnt/disk3/p2
/dev/loop12p3   329M  5.8M  248M   3% /mnt/disk3/p3
/dev/loop2p1    965M   24K  899M   1% /mnt/disk1/p1
oleg@blond-figure:~$ fallocate -l 500M file1
oleg@blond-figure:~$ fallocate -l 700M file2
oleg@blond-figure:~$ sudo du -ah | sort -hr | head -3
1.9G   .
701M   ./file2
501M   ./file1
oleg@blond-figure:~$ smartctl -H /dev/sda
smartctl 7.4 2023-08-01 r5530 [x86_64-linux-6.8.0-71-generic] (local build)
Copyright (C) 2002-23, Bruce Allen, Christian Franke, www.smartmontools.org

Smartctl open device: /dev/sda failed: Permission denied
oleg@blond-figure:~$ sudo smartctl -H /dev/sda
smartctl 7.4 2023-08-01 r5530 [x86_64-linux-6.8.0-71-generic] (local build)
Copyright (C) 2002-23, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF READ SMART DATA SECTION ===
SMART Health Status: OK

oleg@blond-figure:~$
