#!/bin/bash
#umount data* directories
umount /data*
#!/bin/bash
#clean all exiting partitions
wipefs -a /dev/sdb

#create gpt partition table
fdisk /dev/sdb <<EOF
g
w
EOF

#define number of partitions
PARTS=$(seq 1 2)
#loop for make partition
for PART in ${PARTS};
do fdisk /dev/sdb << EOF
n


+1GB
w
EOF

#and format, create dir and mount
mkfs.ext4 /dev/sdb${PART};
[ ! -d /data${PART} ] && mkdir /data${PART};
mount /dev/sdb${PART} /data${PART};

done;