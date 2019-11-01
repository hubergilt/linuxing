wipefs -a /dev/sdb
parted /dev/sdb mktable gpt
PARTS=$(seq 1 20)
for PART in ${PARTS};
do parted /dev/sdb mkpart primary ext4 $((${PART}-1))G ${PART}G;
   mkfs.ext4 /dev/sdb${PART};
   mkdir /data${PART};
   mount /dev/sdb${PART} /data${PART};
done;

