/*global jQuery */
/*!
* FitText.js 1.1
*
* Copyright 2011, Dave Rupert http://daverupert.com
* Released under the WTFPL license
* http://sam.zoy.org/wtfpl/
*
* Date: Thu May 05 14:23:00 2011 -0600
*/

(function( $ ){

  $.fn.fitText = function( kompressor, options ) {

    // Setup options
    var compressor = kompressor || 1,
        settings = $.extend({
          'minFontSize' : Number.NEGATIVE_INFINITY,
          'maxFontSize' : Number.POSITIVE_INFINITY
        }, options);

    return this.each(function(){

      // Store the object
      var $this = $(this);

      // Resizer() resizes items based on the object width divided by the compressor * 10
      var resizer = function () {
        //$this.css('font-size', Math.max(Math.min($this.width() / (compressor*10), parseFloat(settings.maxFontSize)), parseFloat(settings.minFontSize)));
        //console.info("FITING:", $this.width()/(compressor*10) , parseFloat(settings.maxFontSize), parseFloat(settings.minFontSize))
        //console.info("DIMS:", $this.innerHeight(), $this.innerWidth())
        calc = Math.min($this.width() / (compressor*10))
        if( calc > 0) {
          calc = Math.min(calc,parseFloat(settings.maxFontSize))
        }
        else{
          calc = parseFloat(settings.maxFontSize)
        }
        pick = Math.max(calc, parseFloat(settings.minFontSize)) + 'px'
        console.info('PICK:', pick)
        $this.css('font-size', pick).css('line-height', pick )
      };

      // Call once to set.
      resizer();

      // Call on resize. Opera debounces their resize by default.
      $(window).on('resize.fittext orientationchange.fittext', resizer);

    });

  };

})( jQuery );
