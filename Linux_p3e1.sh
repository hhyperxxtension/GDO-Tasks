#1.---------------------------------------------
oleg@blond-figure:~/GD-Linux-3$ dd if=/dev/zero of=disk1.img bs=1MiB count=1000
1000+0 records in
1000+0 records out
1048576000 bytes (1.0 GB, 1000 MiB) copied, 2.55195 s, 411 MB/s
oleg@blond-figure:~/GD-Linux-3$ dd if=/dev/zero of=disk2.img bs=1MiB count=1000
1000+0 records in
1000+0 records out
1048576000 bytes (1.0 GB, 1000 MiB) copied, 2.65217 s, 395 MB/s
oleg@blond-figure:~/GD-Linux-3$ dd if=/dev/zero of=disk3.img bs=1MiB count=1000
1000+0 records in
1000+0 records out
1048576000 bytes (1.0 GB, 1000 MiB) copied, 2.21984 s, 472 MB/s
oleg@blond-figure:~/GD-Linux-3$ sudo losetup -f disk1.img
oleg@blond-figure:~/GD-Linux-3$ sudo losetup -f disk2.img
oleg@blond-figure:~/GD-Linux-3$ sudo losetup -f disk3.img
oleg@blond-figure:~/GD-Linux-3$ losetup -l|grep img
/dev/loop11         0      0         0  0 /home/oleg/GD-Linux-3/disk2.img                    0     512
/dev/loop2          0      0         0  0 /home/oleg/GD-Linux-3/disk1.img                    0     512
/dev/loop12         0      0         0  0 /home/oleg/GD-Linux-3/disk3.img                    0     512
#2.---------------------------------------------
oleg@blond-figure:~/GD-Linux-3$ sudo parted /dev/loop2
GNU Parted 3.6
Using /dev/loop2
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) mktable msdos
(parted) mkpart primary ext4 0% 100%
(parted) print
Model: Loopback device (loopback)
Disk /dev/loop2: 1049MB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags:

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  1049MB  1048MB  primary  ext4

(parted) quit
Information: You may need to update /etc/fstab.

oleg@blond-figure:~/GD-Linux-3$ sudo mkfs.ext4 /dev/loop2p1
mke2fs 1.47.0 (5-Feb-2023)
Discarding device blocks: done
Creating filesystem with 255744 4k blocks and 64000 inodes
Filesystem UUID: 75291996-4ebf-45b6-9090-501d4dc7ea4c
Superblock backups stored on blocks:
       32768, 98304, 163840, 229376

Allocating group tables: done
Writing inode tables: done
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

oleg@blond-figure:~/GD-Linux-3$ sudo parted /dev/loop11
GNU Parted 3.6
Using /dev/loop11
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) mktable gpt
(parted) mkpart primary xfs 0% 50%
(parted) mkpart primary btrfs 50% 100%
(parted) print
Model: Loopback device (loopback)
Disk /dev/loop11: 1049MB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags:

Number  Start   End     Size   File system  Name     Flags
 1      1049kB  524MB   523MB  xfs          primary
 2      524MB   1048MB  523MB  btrfs        primary

(parted) quit
Information: You may need to update /etc/fstab.

oleg@blond-figure:~/GD-Linux-3$ sudo parted /dev/loop12
GNU Parted 3.6
Using /dev/loop12
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) mktable gpt
(parted) mkpart primary ext4 0% 33%
(parted) mkpart primary xfs 33% 67%
(parted) mkpart primary btrfs 67% 100%
(parted) print
Model: Loopback device (loopback)
Disk /dev/loop12: 1049MB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags:

Number  Start   End     Size   File system  Name     Flags
 1      1049kB  346MB   345MB  ext4         primary
 2      346MB   703MB   357MB  xfs          primary
 3      703MB   1048MB  345MB  btrfs        primary

(parted) quit
Information: You may need to update /etc/fstab.

oleg@blond-figure:~/GD-Linux-3$ sudo mkfs.xfs /dev/loop11p1
meta-data=/dev/loop11p1          isize=512    agcount=4, agsize=31936 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=1
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
data     =                       bsize=4096   blocks=127744, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=16384, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
Discarding blocks...Done.
oleg@blond-figure:~/GD-Linux-3$ sudo mkfs.btrfs /dev/loop11p2
btrfs-progs v6.6.3
See https://btrfs.readthedocs.io for more information.

Performing full device TRIM /dev/loop11p2 (499.00MiB) ...
NOTE: several default settings have changed in version 5.15, please make sure
      this does not affect your deployments:
      - DUP for metadata (-m dup)
      - enabled no-holes (-O no-holes)
      - enabled free-space-tree (-R free-space-tree)

Label:              (null)
UUID:               957f12f7-36e1-465e-b973-9e4e169bd143
Node size:          16384
Sector size:        4096
Filesystem size:    499.00MiB
Block group profiles:
  Data:             single            8.00MiB
  Metadata:         DUP              32.00MiB
  System:           DUP               8.00MiB
SSD detected:       no
Zoned device:       no
Incompat features:  extref, skinny-metadata, no-holes, free-space-tree
Runtime features:   free-space-tree
Checksum:           crc32c
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1   499.00MiB  /dev/loop11p2

oleg@blond-figure:~/GD-Linux-3$ sudo mkfs.ext4 /dev/loop12p1
mke2fs 1.47.0 (5-Feb-2023)
Discarding device blocks: done
Creating filesystem with 84224 4k blocks and 84240 inodes
Filesystem UUID: a007c2af-83cd-4684-af95-a4de2994a646
Superblock backups stored on blocks:
       32768

Allocating group tables: done
Writing inode tables: done
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

oleg@blond-figure:~/GD-Linux-3$ sudo mkfs.xfs /dev/loop12p2
meta-data=/dev/loop12p2          isize=512    agcount=4, agsize=21760 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=1
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
data     =                       bsize=4096   blocks=87040, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=16384, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
Discarding blocks...Done.
oleg@blond-figure:~/GD-Linux-3$ sudo mkfs.btrfs /dev/loop12p3
btrfs-progs v6.6.3
See https://btrfs.readthedocs.io for more information.

Performing full device TRIM /dev/loop12p3 (329.00MiB) ...
NOTE: several default settings have changed in version 5.15, please make sure
      this does not affect your deployments:
      - DUP for metadata (-m dup)
      - enabled no-holes (-O no-holes)
      - enabled free-space-tree (-R free-space-tree)

Label:              (null)
UUID:               cc9b2557-ca3a-4c6a-9083-84bdf6b8e1af
Node size:          16384
Sector size:        4096
Filesystem size:    329.00MiB
Block group profiles:
  Data:             single            8.00MiB
  Metadata:         DUP              32.00MiB
  System:           DUP               8.00MiB
SSD detected:       no
Zoned device:       no
Incompat features:  extref, skinny-metadata, no-holes, free-space-tree
Runtime features:   free-space-tree
Checksum:           crc32c
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1   329.00MiB  /dev/loop12p3
#3.---------------------------------------------
oleg@blond-figure:~/GD-Linux-3$ sudo fsck.ext4 /dev/loop2p1
[sudo] password for oleg:
Sorry, try again.
[sudo] password for oleg:
e2fsck 1.47.0 (5-Feb-2023)
/dev/loop2p1: clean, 11/64000 files, 8748/255744 blocks
oleg@blond-figure:~/GD-Linux-3$ sudo xfs_repair /dev/loop11p1
Phase 1 - find and verify superblock...
Phase 2 - using internal log
        - zero log...
        - scan filesystem freespace and inode maps...
        - found root inode chunk
Phase 3 - for each AG...
        - scan and clear agi unlinked lists...
        - process known inodes and perform inode discovery...
        - agno = 0
        - agno = 1
        - agno = 2
        - agno = 3
        - process newly discovered inodes...
Phase 4 - check for duplicate blocks...
        - setting up duplicate extent list...
        - check for inodes claiming duplicate blocks...
        - agno = 0
        - agno = 1
        - agno = 3
        - agno = 2
Phase 5 - rebuild AG headers and trees...
        - reset superblock...
Phase 6 - check inode connectivity...
        - resetting contents of realtime bitmap and summary inodes
        - traversing filesystem ...
        - traversal finished ...
        - moving disconnected inodes to lost+found ...
Phase 7 - verify and correct link counts...
done
oleg@blond-figure:~/GD-Linux-3$ sudo btrfs check /dev/loop11p2
Opening filesystem to check...
Checking filesystem on /dev/loop11p2
UUID: 957f12f7-36e1-465e-b973-9e4e169bd143
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 147456 bytes used, no error found
total csum bytes: 0
total tree bytes: 147456
total fs tree bytes: 32768
total extent tree bytes: 16384
btree space waste bytes: 140480
file data blocks allocated: 0
 referenced 0
