#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper; sub D(@){print Dumper @_}

sub a2z_file {
  open my $fh, '<', shift;
  my %words;
  while(<$fh>){
    next if /#/; # skip comments
    chomp;
    for my $word (split){
      my ($letter) = /^./g;
      push @{$words{$letter}}, $word;
    }
  }
  return \%words;
}

my $names = a2z_file('./male-names');
D $names;

