#!/usr/bin/perl -W

use strict;
use Cwd;


my $dir = getcwd;

my $usage = "zcwmkrnl.pl <ramdisk-directory>\n";

die $usage unless $ARGV[0];

chdir $ARGV[0] or die "$ARGV[0] $!";

system ("find . | cpio -o -H newc | gzip > $dir/ramdisk-repack.gz");

chdir $dir or die "$ARGV[0] $!";;




