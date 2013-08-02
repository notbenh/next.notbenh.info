<?php
/*
  $media_dir = '/media'; # a 'web-safe' path for the media dir
  if(isset($_GET['img'])){
    $path = $media_dir . '/' . urlencode($_GET['img']); # the actual file path of the encoded value
    $file_path = '.'. $path;
    if(! file_exists($path)){
      #echo "!!!! NEED TO DOWNLOAD FILE ". $_GET['img'] . " to $path !!!!";
      #$handle = fopen($_GET['img'],'rb');
      #if( fwrite( $handle, $file_path) === false ){
      #  echo '!!! FAILURE !!!';
      #  die;
      #}
      #fclose($handle);
      $img = $_GET['img'];
    }
    else {
      $img = $path;
    }
  } 
  else{
    $img = "/media/funny-gifs-pug-fangs.gif";
  }
*/
  if(isset($_GET['img'])){
   $img = $_GET['img'];
  }
  else{
    $img = "/media/funny-gifs-pug-fangs.gif";
  }
?>
<!DOCTYPE html>
<html>
<head>
  <title>The Repeater!</title>
  <style>
    .background { 
       background-image: url(<?= $img ?>) ;
       position: fixed;
     }
    body, div { 
      margin: 0px;
      padding: 0px;
    }
    div { 
      height: 100%;
      width:  100%;
    }
    div#api {
      border: 1px solid #000;
      background-color: #FFF;
      position: absolute;
      width:50%;
      height:auto;
      left: 50%;
      margin-left:-25%;
      top: 50%;
      margin-top:-25%;
      
      /* Theoretically for IE 8 & 9 (more valid) */   
      /* ...but not required as filter works too */
      /* should come BEFORE filter */
      -ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=50)";
      
      /* This works in IE 8 & 9 too */
      /* ... but also 5, 6, 7 */
      filter: alpha(opacity=90);
      
      /* Older than Firefox 0.9 */
      -moz-opacity:0.9;
      
      /* Safari 1.x (pre WebKit!) */
      -khtml-opacity: 0.9;
       
      /* Modern!
      /* Firefox 0.9+, Safari 2?, Chrome any?
      /* Opera 9+, IE 9+ */
      opacity: 0.9;
    }
    div#api div{ margin:20px; height:auto; width:auto; /*border:1px solid #F00;*/ }
  </style>
  <script src='//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js'></script>
  <script type='text/javascript'>
    (new Image).src= '<?= $img ?>'; //preload
    $(document).ready( function(){ $('div#here').addClass( 'background' ) });
  </script>
</head>
<body><div id='here'></div>
<?php if(count($_GET) == 0){ ?>
<div id='api'>
  <div>
  <h1>Welcome to The Repeater!</h1>
  <p>This is just a toy to create the impression of a repeated background, like the silly puppy that is currently nomming on your screen. If you give it an image as the get var <strong>img</strong>, then the docs go away.</p>
  <form action='<?= $_SERVER['PHP_SELF'] ?>' method='GET'>
    <label for='img'>full path to an image</label>
    <input type='text' name='img'></input>
    <input type='submit' value='REPEATIFY'></input>
  </form>
  </div> 
</div>
<?php } ?>
</body>
</html>
