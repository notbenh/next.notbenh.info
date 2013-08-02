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
  font-size:350px;
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
   $words = array('sense','cents','sents');
   echo $words[ array_rand($words) ];
   ?>
   </span>
</div>
</body>
</html>
