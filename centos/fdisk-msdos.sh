#!/bin/bash
#umount data* directories
umount /data*
#!/bin/bash
#clean all exiting partitions
wipefs -a /dev/sdb

#create gpt partition table
fdisk /dev/sdb <<EOF
o
w
EOF

# mkfs.ext4 /dev/sdb1;
# [ ! -d /data1 ] && mkdir /data1};
# mount /dev/sdb1 /data1;

#define number of partitions
PARTS=$(seq 1 3)
#loop for make partition
for PART in ${PARTS};
do fdisk /dev/sdb << EOF
n
p
${PART}

+1GB
w
EOF
done;

#define extended partition number 4
fdisk /dev/sdb << EOF
n
e
4


w
EOF

#define number of partitions
PARTS=$(seq 5 21)
#loop for make partition
for PART in ${PARTS};
do fdisk /dev/sdb << EOF
n
l
${PART}

+1GB
w
EOF
done;

#partprobe
    
for PART in ${PARTS};
do  mkfs.ext4 /dev/sdb${PART};
    [ ! -d /data${PART} ] && mkdir /data${PART};
    mount /dev/sdb${PART} /data${PART};
done;