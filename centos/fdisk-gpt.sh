#!/bin/bash
#umount data* directories
umount /data*
#!/bin/bash
#clean all exiting partitions
wipefs -a /dev/sdb

#create gpt partition table
fdisk /dev/sdb << EOF
g
w
EOF

#define number of partitions
PARTS=$(seq 1 20)
#loop for make partition, format, create dir and mount
for PART in ${PARTS};
do fdisk /dev/sdb << EOF
n
${PART}

+1GB
w
EOF
done;