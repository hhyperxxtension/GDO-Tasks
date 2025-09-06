#1---------------------------------
oleg@blond-figure:~/GD-Linux-3$ mount|grep loop
/dev/loop11p2 on /mnt/disk3/p2 type xfs (rw,relatime,sync,wsync,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop11p3 on /mnt/disk3/p3 type btrfs (rw,noexec,relatime,discard=async,space_cache=v2,subvolid=5,subvol=/)
/dev/loop10p1 on /mnt/quota type ext4 (rw,relatime,quota,usrquota,grpquota)
/dev/loop11p1 on /mnt/disk3/p1 type ext4 (rw,relatime)
oleg@blond-figure:~/GD-Linux-3$ sudo dd if=/dev/zero of=/mnt/disk3/p1/test_write.bin bs=4k count=25000 conv=fdatasync
25000+0 records in
25000+0 records out
102400000 bytes (102 MB, 98 MiB) copied, 0.64975 s, 158 MB/s
oleg@blond-figure:~/GD-Linux-3$ sudo dd if=/dev/zero of=/mnt/disk3/p2/test_write.bin bs=4k count=25000 conv=fdatasync
25000+0 records in
25000+0 records out
102400000 bytes (102 MB, 98 MiB) copied, 84.3147 s, 1.2 MB/s
oleg@blond-figure:~/GD-Linux-3$ sudo dd if=/dev/zero of=/mnt/disk3/p3/test_write.bin bs=4k count=25000 conv=fdatasync
25000+0 records in
25000+0 records out
102400000 bytes (102 MB, 98 MiB) copied, 0.570626 s, 179 MB/s
#2---------------------------------
oleg@blond-figure:~/GD-Linux-3$ sudo dd if=/mnt/disk3/p1/test_write.bin of=/dev/null bs=4k
25000+0 records in
25000+0 records out
102400000 bytes (102 MB, 98 MiB) copied, 0.0613659 s, 1.7 GB/s
oleg@blond-figure:~/GD-Linux-3$ sudo dd if=/mnt/disk3/p2/test_write.bin of=/dev/null bs=4k
25000+0 records in
25000+0 records out
102400000 bytes (102 MB, 98 MiB) copied, 0.187447 s, 546 MB/s
oleg@blond-figure:~/GD-Linux-3$ sudo dd if=/mnt/disk3/p3/test_write.bin of=/dev/null bs=4k
25000+0 records in
25000+0 records out
102400000 bytes (102 MB, 98 MiB) copied, 0.202329 s, 506 MB/s
oleg@blond-figure:~/GD-Linux-3$
#3-----------------------
oleg@blond-figure:~/GD-Linux-3$ sudo umount /dev/loop11p1
oleg@blond-figure:~/GD-Linux-3$ sudo umount /dev/loop11p2
oleg@blond-figure:~/GD-Linux-3$ sudo umount /dev/loop11p3
oleg@blond-figure:~/GD-Linux-3$ sudo fsck.ext4 -f /dev/loop11p1
e2fsck 1.47.0 (5-Feb-2023)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/loop11p1: 12/84240 files (0.0% non-contiguous), 34459/84224 blocks
oleg@blond-figure:~/GD-Linux-3$ sudo xfs_repair /dev/loop11p2
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
oleg@blond-figure:~/GD-Linux-3$ sudo btrfs check /dev/loop11p3
Opening filesystem to check...
Checking filesystem on /dev/loop11p3
UUID: cc9b2557-ca3a-4c6a-9083-84bdf6b8e1af
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 102678528 bytes used, no error found
total csum bytes: 100000
total tree bytes: 278528
total fs tree bytes: 32768
total extent tree bytes: 16384
btree space waste bytes: 168242
file data blocks allocated: 102400000
 referenced 102400000
oleg@blond-figure:~/GD-Linux-3$
