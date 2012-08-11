#!/usr/bin/env perl

use strict;
use warnings;

use IO::File;

usage() unless @ARGV == 1;

my $path = $ARGV[0];

if ( not -d $path) {
    usage();
}

#initialize chromosome/file list
my @chr_list = (1..22,"X","Y","M");
my @file_list = map { $_ = $path."/chr$_.fa";} @chr_list;

#open each source and print its contents to stdout
for my $file (@file_list) {
    my $fh = IO::File->new($file);
    while ( my $line = $fh->getline) {
        print $line;
    }
    $fh->close;
}

sub usage {
    print "\nusage:   ./fasta_combiner.pl <path/to/input/fastas>\n";
    print "try>     ./fasta_combiner.pl /home/<yournamehere>/Downloads/ > myNewReference.fa\n";
    exit(1);
}
