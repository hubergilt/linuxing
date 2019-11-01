#!/bin/bash
#clean all exiting partitions
wipefs -a /dev/sdb
#create partition table
parted /dev/sdb mktable gpt
#define numer of partitions
PARTS=$(seq 1 20)
#loop for make partition, format, create dir and mount
for PART in ${PARTS};
do parted /dev/sdb mkpart primary ext4 $((${PART}-1))G ${PART}G;
   mkfs.ext4 /dev/sdb${PART};
   [ ! -d /data${PART} ] && mkdir /data${PART};
   mount /dev/sdb${PART} /data${PART};
done;