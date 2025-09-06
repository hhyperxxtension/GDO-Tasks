#1----------------------------------
oleg@blond-figure:~/GD-Linux-3$ sudo mount -o ro /dev/loop11p1 /mnt/disk3/p1
oleg@blond-figure:~/GD-Linux-3$ sudo mount -o sync /dev/loop11p2 /mnt/disk3/p2
oleg@blond-figure:~/GD-Linux-3$ sudo mount -o noexec /dev/loop11p3 /mnt/disk3/p3
oleg@blond-figure:~/GD-Linux-3$ mount|grep mnt
/dev/loop11p1 on /mnt/disk3/p1 type ext4 (ro,relatime)
/dev/loop11p2 on /mnt/disk3/p2 type xfs (rw,relatime,sync,wsync,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop11p3 on /mnt/disk3/p3 type btrfs (rw,noexec,relatime,discard=async,space_cache=v2,subvolid=5,subvol=/)
#2----------------------------------
oleg@blond-figure:~/GD-Linux-3$ sudo tune2fs -Q usrquota,grpquota /dev/loop10p1
tune2fs 1.47.0 (5-Feb-2023)
oleg@blond-figure:~/GD-Linux-3$ sudo tune2fs -l /dev/loop10p1 | grep quota
Filesystem features:      has_journal ext_attr resize_inode dir_index filetype extent 64bit flex_bg sparse_super large_file huge_file dir_nlink extra_isize quota metadata_csum
User quota inode:         3
Group quota inode:        4
oleg@blond-figure:~/GD-Linux-3$ sudo mount -o usrquota,grpquota /dev/loop10p1 /mnt/quota/
oleg@blond-figure:~/GD-Linux-3$ sudo quotaon -v /mnt/quota
quotaon: using . on /dev/loop10p1 [/mnt/quota]: File exists
quotaon: using . on /dev/loop10p1 [/mnt/quota]: File exists
oleg@blond-figure:~/GD-Linux-3$ sudo passwd user1
New password:
Retype new password:
passwd: password updated successfully
oleg@blond-figure:~/GD-Linux-3$ sudo edquota user1
#открылся nano
Disk quotas for user user1 (uid 1002):
  Filesystem                   blocks       soft       hard     inodes     soft     hard
  /dev/loop10p1                     0          0          10000          0        0        0


