#!/bin/bash
#
# Boot Image Creator for Samsung Galaxy SL
# by codeworkx
# http://www.twitter.com/codeworkx
#

rm recovery_ramdisk.cpio.gz
rm recovery.img

if test -e zImage ; then
    pushd recovery
    find . | cpio -o -H newc | gzip > ../recovery_ramdisk.cpio.gz
    popd
    ./mkbootimg --cmdline 'root=/dev/mmcblk0p2 rw mem=592M init=/init videoout=omap_vout omap_vout.video1_numbuffers=6 omap_vout.vid1_static_vrfb_alloc=y omapfb.vram=\"0:4M\"  omap_version=\"3630\" console=ttyS2,115200n8' --kernel zImage --ramdisk recovery_ramdisk.cpio.gz -o recovery.img
    rm recovery_ramdisk.cpio.gz
else
    echo "No zImage found"
fi
