#!/home/notbenh/local/bin/perl
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
my $gr = $q->param('g')  || 0;

my @colors = map{color_mix($h1,$h2,$_)} series(0,1,$gr);

my $template = q{
[% MACRO color_div(c) BLOCK %]
<div>
   <strong>[%c | upper%]</strong>
   <div class='swatch' style='background-color:#[% c | upper %]'></div>
</div>
[% END %]
[% MACRO form_div(c, name) BLOCK %]
<div>
   <input type='text' name='[%name%]' value='[%c | upper%]' />
   <div class='swatch' style='background-color:#[% c | upper%]'></div>
   <span style='clear:both'/>
</div>
[% END %]
[% MACRO color(c) BLOCK %]
<tr>
   <th>[%c | upper%]</th>
   <td class='swatch' style='background-color:#[% c | upper %]'></td>
</tr>
[% END %]
[% MACRO form(c, name) BLOCK %]
<tr>
   <th><input type='text' name='[%name%]' value='[%c | upper%]' /></th>
   <td class='swatch' style='background-color:#[% c | upper%]'></td>
</tr>
[% END %]
<html>
<head>
<style>
div {position: relative}
div.swatch {
   height: 1em;
   width: 20em;
   float:right;
}
</style>
</head>
<body>
<form action='color.cgi'>
[% first = colors.shift %]
[% last  = colors.pop %]
<table>
[% form(first,'h1') %]
[% FOREACH c IN colors %]
[% color(c) %]
[% END %]
[% form(last,'h2') %]
<tr>
   <th>steps</th>
   <td><input type='text' name='g' value='[%grad%]'/></td>
</tr>
<tr>
   <th></th>
   <td><input type='submit'></td>
</tr>
</table>
</form>
</body>
</html>
};
print $q->header;
$t->process(\$template, {colors => \@colors, grad => $gr});


