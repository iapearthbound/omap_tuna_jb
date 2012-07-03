#!/usr/bin/perl -W

use strict;
use Cwd;


my $dir = getcwd;

my $usage = "odinkrnl.pl <ramdisk-directory>\n";

die $usage unless $ARGV[0];

chdir $ARGV[0] or die "$ARGV[0] $!";

system ("find . | cpio -o -H newc | gzip > $dir/ramdisk-repack.gz");

chdir $dir or die "$ARGV[0] $!";;

system ("rm $dir/recovery.img");
print "\nremoved old recovery.img \n";

# Parameters for Samsung Prevail
system ("$dir/mkbootimg --cmdline 'console=ttyMSM1,115200' --kernel rzImage --ramdisk ramdisk-repack.gz -o recovery.img --base 0x00200000 --pagesize 4096");
print "\nrepacked boot image written at recovery.img\n";
unlink("ramdisk-repack.gz") or die $!;




