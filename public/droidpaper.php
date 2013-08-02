<pre>
<?
  if($_GET['img']){
    $img_data = getimagesize( $_GET['img'] );
     /*
      Array
      (
          [0] => 740
          [1] => 1295
          [2] => 2
          [3] => width="740" height="1295"
          [bits] => 8
          [channels] => 3
          [mime] => image/jpeg
      )
      */
    $dst_image = imagecreate($img_data[0]*3,$img_data[1]);
    $src_image = imagecreatefromjpeg($_GET['img']);
    $dst_x     = $img_data[0];
    $dst_y     = 0;
    $src_x     = 0;
    $src_y     = 0;
    $dst_w     = $_GET['img'][0] * 3;
    $dst_h     = $_GET['img'][1];
    $src_w     = $_GET['img'][0];
    $src_h     = $_GET['img'][1];
    
    #$out_data = imagecopyresized ( $dst_image, $src_image, $dst_x, $dst_y, $src_x, $src_y, $dst_w, $dst_h, $src_w, $src_h );
    $out_data = imagecopy( $dst_image, $src_image, $dst_x, $dst_y, $src_x, $src_y, 0, 0 );
  }
  else {
    echo 'img is required';
  }
    
     
?>
</pre>
