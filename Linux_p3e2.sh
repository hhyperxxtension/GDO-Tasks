oleg@blond-figure:~/GD-Linux-3$ cd /mnt
oleg@blond-figure:/mnt$ sudo mkdir disk1 disk1/p1 disk2 disk2/p1 disk2/p2 disk3 disk3/p1 disk3/p2 disk3/p3
oleg@blond-figure:/mnt$ tree
.
├── disk1
│   └── p1
├── disk2
│   ├── p1
│   └── p2
└── disk3
    ├── p1
    ├── p2
    └── p3

10 directories, 0 files
oleg@blond-figure:/mnt$ losetup -l|grep img
/dev/loop11         0      0         0  0 /home/oleg/GD-Linux-3/disk2.img                    0     512
/dev/loop2          0      0         0  0 /home/oleg/GD-Linux-3/disk1.img                    0     512
/dev/loop12         0      0         0  0 /home/oleg/GD-Linux-3/disk3.img                    0     512
oleg@blond-figure:/mnt$ sudo mount /dev/loop2p1 disk1/p1/
oleg@blond-figure:/mnt$ sudo mount /dev/loop11p1 disk2/p1/
oleg@blond-figure:/mnt$ sudo mount /dev/loop11p2 disk2/p2/
oleg@blond-figure:/mnt$ sudo mount /dev/loop12p1 disk3/p1/
oleg@blond-figure:/mnt$ sudo mount /dev/loop12p2 disk3/p2/
oleg@blond-figure:/mnt$ sudo mount /dev/loop12p3 disk3/p3/
oleg@blond-figure:/mnt$ lsblk|grep -B1 mnt
loop2        7:2    0 1000M  0 loop
└─loop2p1  259:1    0  999M  0 part /mnt/disk1/p1
--
loop11       7:11   0 1000M  0 loop
├─loop11p1 259:2    0  499M  0 part /mnt/disk2/p1
└─loop11p2 259:3    0  499M  0 part /mnt/disk2/p2
loop12       7:12   0 1000M  0 loop
├─loop12p1 259:4    0  329M  0 part /mnt/disk3/p1
├─loop12p2 259:5    0  340M  0 part /mnt/disk3/p2
└─loop12p3 259:6    0  329M  0 part /mnt/disk3/p3
oleg@blond-figure:/mnt$ sudo blkid|grep loop2|awk '{print $1, $2}'
/dev/loop2p1: UUID="75291996-4ebf-45b6-9090-501d4dc7ea4c"
oleg@blond-figure:/mnt$ echo 'UUID="75291996-4ebf-45b6-9090-501d4dc7ea4c" /mnt/disk1/p1 ext4 defaults 0 2'|sudo tee -a /etc/fstab
UUID="75291996-4ebf-45b6-9090-501d4dc7ea4c" /mnt/disk1/p1 ext4 defaults 0 2
oleg@blond-figure:/mnt$ sudo tail /etc/fstab
LABEL=cloudimg-rootfs   /        ext4   discard,commit=30,errors=remount-ro  0 1
LABEL=BOOT      /boot   ext4    defaults        0 2
LABEL=UEFI      /boot/efi       vfat    umask=0077      0 1
/swapfile    none    swap    sw    0 0
UUID="75291996-4ebf-45b6-9090-501d4dc7ea4c" /mnt/disk1/p1 ext4 defaults 0 2
oleg@blond-figure:/mnt$ sudo umount /dev/loop2p1
oleg@blond-figure:/mnt$ sudo lsblk|grep p2p1
└─loop2p1  259:1    0  999M  0 part
oleg@blond-figure:/mnt$ sudo mount -a
mount: (hint) your fstab has been modified, but systemd still uses
       the old version; use 'systemctl daemon-reload' to reload.
oleg@blond-figure:/mnt$ sudo lsblk|grep p2p1
└─loop2p1  259:1    0  999M  0 part /mnt/disk1/p1
oleg@blond-figure:/mnt$
