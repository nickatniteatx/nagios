#!/usr/bin/perl

use strict;
use warnings;
use File::stat;
use Data::Printer colored=>1;
my @directories;

my $base=$ARGV[0];
my $newest="";
my $biggest="";

opendir(my $dh,$base) || die "Please enter a valid directory\n";

while(readdir $dh) {
    
    if($_ =~ /^\./) { next; }
    my $dir_stat = stat "$base/$_";
    my $dir_ctime = $dir_stat->mtime();
    push(@directories, { directory => "$base/$_", age => $dir_ctime } );
#print "$base/$_", ": $dir_ctime\n";

       
}
closedir $dh;

print p(@directories);

$biggest=$directories[0];
shift(@directories);

foreach (@directories) {

    if ($biggest->{age} < $_->{age}) { $biggest=$_ ; }

}

print $biggest->{directory};

