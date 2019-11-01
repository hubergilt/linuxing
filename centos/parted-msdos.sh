#!/bin/bash
#umount data* directories
umount /data*
#clean all exiting partitions
wipefs -a /dev/sdb
#create partition table
parted /dev/sdb mktable msdos
#define numer of partitions
PARTS=$(seq 1 3)
#loop for make partition, format, create dir and mount
for PART in ${PARTS};
do parted /dev/sdb mkpart primary ext4 $((${PART}-1))G ${PART}G;
   mkfs.ext4 /dev/sdb${PART};
   [ ! -d /data${PART} ] && mkdir /data${PART};
   mount /dev/sdb${PART} /data${PART};
done;

#make extented partition
parted /dev/sdb mkpart extended 4G 20G

#define numer of partitions
PARTS=$(seq 4 19)
#loop for make partition, format, create dir and mount
for PART in ${PARTS};
do parted /dev/sdb mkpart logical ext4 ${PART}G $((${PART}+1))G;
   mkfs.ext4 /dev/sdb$((${PART}+1));
   [ ! -d /data${PART} ] && mkdir /data${PART};
   mount /dev/sdb$((${PART}+1)) /data${PART};
done;