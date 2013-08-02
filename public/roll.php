<!DOCTYPE html>
<html>
<head>
<link href='http://fonts.googleapis.com/css?family=Days+One' rel='stylesheet' type='text/css'>
<style>
body{
  font-family: 'Days One', sans-serif;
}
div#result{
  position:absolute;
  top:auto;
  bottom:auto;
  font-size:250px;
}
span.die:before ,
span.die:after {
  color:#CCC;
}
span.die:before { content: "[" }
span.die:after  { content: "]" }

footer{
  position:absolute;
  right:10px;
}
</style>
</head>
<body>
<div id='result'>
<?php 
   if(count($_GET) == 0) { 
     $_GET['d1'] = 1;
   } # have a default
   foreach( $_GET as $die => $value ) {
     preg_match('/^(?:(\d+)x)?d(\d+)/',$die,$matches);
     list($string,$count,$max) = $matches;
     $min = $max == 1 ? 0 : 1;
     foreach(range(1, $count ? $count : 1) as $i){
       printf("  <span class='die'>%d</span>\n",rand($min,$max));
     }
   }
?>
</div>
<footer>
die is d(sides of die) and can be rolled (multiple)x times </br>
for example: <? $example= $_SERVER['PHP_SELF'].'?4xd6&2x10'; echo "<a href='$example'>$example</a>"; ?> will roll a d6 4 times and a d10 twice.</br>
the default is a d1 (coin) and will return <span class='die'>0</span> or <span class='die'>1</span> rather than <span class='die'>1</span> or <span class='die'>2</die>
</body>
</html>
