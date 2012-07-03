#!/bin/bash
#
# Boot Image Creator for Samsung Galaxy SL
# by codeworkx
# http://www.twitter.com/codeworkx
#

rm ramdisk.cpio.gz
rm normalboot.img

if test -e zImage ; then
    pushd root
    find . | cpio -o -H newc | gzip > ../ramdisk.cpio.gz
    popd
    ./mkbootimg --kernel zImage --ramdisk ramdisk.cpio.gz -o normalboot.img --base 0x13000000 --pagesize 4096
   rm ramdisk.cpio.gz
else
    echo "No zImage found"
fi

