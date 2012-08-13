#!/usr/bin/env perl

use strict;
use warnings;

use IO::File;

usage() unless @ARGV == 2;

my $path = $ARGV[0];
my $output_path = $ARGV[1];

if ( not -d $path) {
    usage();
}
if (-e $output_path) {
    blocked();
}

#initialize chromosome/file list
my @chr_list = (1..22,"X","Y","M");
my @file_list = map { $_ = $path."/chr$_.fa";} @chr_list;

#check for the presence of all the required files
map { missing($_) if (not -e $_); } @file_list;

my $output_fh = IO::File->new(">$output_path");

#open each source and print its contents to stdout
for my $file (@file_list) {
    my $fh = IO::File->new($file);
    while ( my $line = $fh->getline) {
        print $output_fh $line;
    }
    $fh->close;
}

$output_fh->close;

sub usage {
    print "\nusage:   ./fasta_combiner.pl <path/to/input/fastas>  <path/to/output/fasta\n";
    print "try>     ./fasta_combiner.pl /home/<yournamehere>/Downloads/ ./myNewReference.fa\n";
    exit(1);
}

sub missing {
    my $file = shift;
    print "\nCould not locate input at: $file\n";
    exit(1);
}

sub blocked {
    print "Path to the output is blocked by an existing file: $output_path\n";
    exit(1);
}
