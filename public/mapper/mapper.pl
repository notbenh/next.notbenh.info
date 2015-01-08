#!/usr/bin/env perl
use strict;
use warnings;
use feature qw{say};

my $office = '926+NW+13th+Ave,Portland,OR';

for my $house ( '702+NE+Ainsworth+St,Portland,OR'
              , '5516+NE+24th+Ave,Portland,OR'
              , '4903+NE+27th+Ave,Portland,OR'
              , '4629+NE+11th+Ave,Portland,OR'
              , '3016+NE+9th+Ave,Portland,OR'
              ) {
  my $url = "https://maps.googleapis.com/maps/api/directions/json?origin=$office&destination=$house&key=AIzaSyAxD7h7ghyNvRnS8ib71DhRIQpfBmU-0Hg&mode=transit&departure_time=1343641500";
  my $cmd = "curl '$url' -o '$house.json'";
  say $cmd;
}

__END__
curl https://maps.googleapis.com/maps/api/directions/json\?origin\=926+NW+13th+Ave,Portland,OR\&destination\=3016+NE+9th+Ave,Portland,OR\&mode\=transit\&departure_time\=1343641500\&key\=AIzaSyBxRWBg7UPMSCLCr8SQfcHYgSSYqJy6RJs


https://www.google.com/maps/dir/702+NE+Ainsworth+St,+Portland,+OR+97211/926+NW+13th+Ave,+Portland,+OR+97209/@45.5447195,-122.7016563,13z/data=!3m1!4b1!4m14!4m13!1m5!1m1!1s0x5495a7033bffb0e3:0x631c718b7327a123!2m2!1d-122.658521!2d45.566092!1m5!1m1!1s0x549509fe9a9e8711:0x4e48579a74f2f93d!2m2!1d-122.6842224!2d45.529878!3e3

