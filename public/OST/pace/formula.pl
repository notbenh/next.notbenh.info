#!/usr/bin/env perl
use strict;
use warnings;
use Scalar::Util qw{looks_like_number};

sub formula {
  my ($weeks,$lessons_complete) = @_;
  my $total_weeks = 24;
  my $total_lessons = 12;
  return int(($lessons_complete/$total_lessons)*10)- int(($weeks/$total_weeks)*10);
}

sub risk {
  return '' unless looks_like_number $_[0];
  return 'rushing' if $_[0] > 4;
  return 'ahead'   if $_[0] > 1;
  return 'urgent'  if $_[0] < -4;
  return 'warning' if $_[0] < -1;
}

sub ROW($@) {
  my $type = shift;
  return sprintf qq{<tr>\n%s\n</tr>\n}
               , join '', map{ sprintf qq{  <$type class='%s'>$_</$type>\n}, risk($_)} @_;
}

print ROW 'th', 'weeks:', 1..24;
foreach my $lesson (0..12){
  print ROW 'td', "L$lesson:", map{formula($_,$lesson)} 1..24;
}

