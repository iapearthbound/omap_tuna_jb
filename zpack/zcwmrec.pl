#!/usr/bin/perl -W

use strict;
use Cwd;


my $dir = getcwd;

my $usage = "zcwmrec.pl <ramdisk-directory>\n";

die $usage unless $ARGV[0];

chdir $ARGV[0] or die "$ARGV[0] $!";

system ("find . | cpio -o -H newc | gzip > $dir/ramdisk-repack.gz");

chdir $dir or die "$ARGV[0] $!";;

# Parameters for Samsung Prevail
system ("$dir/mkbootimg --cmdline 'console=ttyMSM1,115200' --kernel rzImage --ramdisk ramdisk-repack.gz -o recovery.img --base 0x00200000 --pagesize 4096");
print "\nrepacked recovery image written at recovery.img\n";
unlink("ramdisk-repack.gz") or die $!;
system ("rm $dir/zcwmrec.zip");
print "\nremoved old zcwmrec.zip\n";
system ("rm $dir/zcwmfiles2/recovery.img");
print "\nremoved old recovery.img from $dir/zcwmfiles2/\n";
system ("cp recovery.img $dir/zcwmfiles2/");
print "\ncopied new recovery.img to $dir/zcwmfiles2\n";
system ("rm recovery.img");
print "\nremoved temporary recovery.img\n";
chdir ("$dir/zcwmfiles2");
system ("zip -9 -r $dir/zcwmrec.zip *");
print "\nceated zcwmrec.zip\n";
print "\ndone\n";



