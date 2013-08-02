#!/home/notbenh/local/bin/perl
##!/usr/bin/perl
use strict;
use warnings;
use Color::Calc ('OutputFormat' => 'hex');
use CGI::Simple qw{-debug1};
use Template;

my $q = CGI::Simple->new;
my $t = Template->new({PRE_CHOMP => 1, POST_CHOMP =>1});

sub series {
   my ($a,$b,$c) = @_;
   $a = 0 unless defined $a;
   $b = 1 unless defined $b;
   $c = 1 unless defined $c;
   my $step = abs($a-$b)/($c+1);
   my @out = ($a);;
   for (0..$c) {
      push @out, $a += $step;
   }
   return @out;
}
my $h1 = $q->param('h1') || 'FFF';
my $h2 = $q->param('h2') || '000';
my $h3 = $q->param('h3') || 'F00';
my $gr = $q->param('g')  || 0;

my @series = series(0,1,$gr);

my @colors ;
foreach my $color ( map{color_mix($h1,$h2,$_)} @series ) {
   push @colors, [map{color_mix($color,$h3,$_)} @series];
}

my $template = q{
<html>
<head>
<style>
td.swatch {
   height: 1.5em;
   width: 15em;
   text-align:right;
}
td.swatch span {
   font-size:70%;
}
</style>
</head>
<body>
<form action='color.cgi'>
<table>
   <tr>
      <th>Color 1</th>
      <td><input type='text' name='h1' value='[%h1%]' /></td>
   </tr>
   <tr>
      <th>Color 2</th>
      <td><input type='text' name='h2' value='[%h2%]' /></td>
   </tr>
   <tr>
      <th>Color 3</th>
      <td><input type='text' name='h3' value='[%h3%]' /></td>
   </tr>
   <tr>
      <th>Steps</th>
      <td><input type='text' name='g' value='[%gr%]' /></td>
   </tr>
   <tr>
      <th></th>
      <td><input type='submit' /></td>
   </tr>
</table>
</form>

<table>
[% FOREACH row IN colors %]
<tr>

   [% FOREACH color IN row %]
   <td class='swatch' style='background-color:#[%color | upper %]'><span>[% color | upper %]</span></td>

   [% END %]
</tr>

[% END %]
</table>
</body>
</html>
};
print $q->header;
$t->process(\$template, {colors => \@colors, h1 => $h1, h2 => $h2, h3 => $h3, gr => $gr});


