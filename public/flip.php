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
  left:50%;
}
div#result span{
  position:relative;
  left:-50%;
  font-size:550px;
}
footer{
  position:absolute;
  right:10px;
}
</style>
</head>
<body>
<div id='result'>
   <span>
   <?php 
   $min = isset($_GET['min']) ? $_GET['min'] : 0;
   $max = isset($_GET['max']) ? $_GET['max'] : 1;
   echo rand($min,$max);
   ?>

   </span>
</div>
<footer>API: min & max specified via GET vars. IE d6 is <? $d6= $_SERVER['PHP_SELF'].'?min=1&max=6'; echo "<a href='$d6'>$d6</a>"; ?>
</body>
</html>
