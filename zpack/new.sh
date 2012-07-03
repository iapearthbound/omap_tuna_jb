#!/bin/sh
RAMV=$1
KVER=`cat ../.version`
RELV="`cat ../.version`-${RAMV}"
RELV="_FuguMod_$(date +%Y%m%d_r)${RELV}"
if [ "ZZ${RAMV}" == "ZZ" ]
then
echo "No version specified"
exit 1
else
cd initramfs-${RAMV} || exit 1
find . | cpio -o -H newc | gzip > ../new_initramfs.cpio.gz
cd ..
abootimg --create /devel/kernel${RELV}.img -k ../arch/arm/boot/zImage -r new_initramfs.cpio.gz

git tag -a r${KVER} -m r${KVER}

cd cwm
mv /devel/kernel${RELV}.img boot.img
        zip -q -r /devel/kernel${RELV}.zip boot.img META-INF || exit 1
        sha256sum /devel/kernel${RELV}.zip > /devel/kernel${RELV}.zip.sha256sum

scp /devel/kernel* elendil.arnor.org:public_html/galaxy_nexus/testing-${RAMV}/

cd ..
rm new_initramfs.cpio.gz cwm/boot.img /devel/kernel*

fi
