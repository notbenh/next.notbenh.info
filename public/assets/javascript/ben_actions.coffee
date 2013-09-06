auto_url_open = (result) ->
  output = ''
  matches = result.match(/https?:\/\/(?:(?!&[^;]+;)[^\s:"'<>)])+/g)
  if matches == null
    return result
  else
    for url in matches
      if autoURL_should_use_location
        window.location = url
        return 'initiate redirection to ' + url
      else
        window.open(url)
        output += url + " [opened in a new window or tab]\n"
    return output

getRandomInt = (min, max) -> return Math.floor(Math.random() * (max - min + 1)) + min
getRandomArrayValue = (array) -> return array[getRandomInt(0,array.length-1)]
qw = (string) -> return string.split(' ')

LINK = (url,note) -> 
  return [
    -> return url
    note + ' [[b;;;][opens in a new tab or window]]'
  ]
NYI  = (note) ->
  return [
    -> 'not yet implemented'
    "[not yet implemented] #{note}"
  ]

wordlist = [
 "sense cents scents since",
 "then than",
 "their there they're"
]

ben_actions =
  tdone  : NYI 'todo list manager'
  suggest: LINK 'https://github.com/notbenh/next.notbenh.info/issues', 'suggest issues via github'
  resume : LINK 'http://resume.notbenh.info', 'my resume'
  about  : LINK 'http://about.notbenh.info' , 'about me'
  twitter: LINK 'http://twitter.com/notbenh', 'my twitter account'
  github : LINK 'https://github.com/notbenh', 'my github account'
  blog   : LINK 'http://blog.notbenh.info'  , 'the thing I call a blog'
  random : [
    (input) ->
      input = qw input
      min = input[0] || 1
      max = input[1] || 100
      return getRandomInt parseInt(min), parseInt(max)
    'pick a random int, can supply min and max though by default you are requesting 1-100'
    EXAMPLES: ['random', 'random 10 30']
  ]
  should : [
    (question) -> 'no'
    'ask the computer if you should be doing something'
    EXAMPLES: ['should I buy a new watch', 'should I get another car']
  ]
  could : [
    (question) -> 'yes'
    'ask the computer if you could be doing something, though I am guessing that you would want to ask if you should.'
    EXAMPLES: ['could I buy a new watch', 'could I get another car']
  ]
  pick : [
    (input) -> getRandomArrayValue qw input
    'pick a random instance from the supplied input'
    EXAMPLES: ['pick taco burger pasta']
    NOTE: 'Currently this verb will split the input on spaces, thus you might not get what you want. I mention this as it might change later.'
  ]
  word : [
    (word) -> 
      word = new RegExp word
      for wordset in wordlist
        return getRandomArrayValue qw wordset if wordset.match(word)
      return "#{word} is not a known word"
    'because I can not spell very well, it was once joked that I would have a better chance by randomly picking a word rather then thinking I know better'
    EXAMPLES: ['word then', 'word sense']
  ]
  wordlist : [
    () -> wordlist.join("\n")
    'see the wordlist that word uses'
  ]
  hack : [
    () -> 
      hack = [ getRandomArrayValue( hacklist.INTRO ), getRandomArrayValue( hacklist.SOCIOPOLITICAL ), getRandomArrayValue( hacklist.PHYSICAL ), getRandomArrayValue( hacklist.ITEM )].join(' ')
      reply  = getRandomArrayValue hacklist.RESPONSES
      return ['HACK: ' + hack, 'REPLY: ' + reply].join("\n")
    'blatant stolen from whatshallihack.com'
    EXAMPLES: ['hack']
    NOTE: 'hit up suggest if you have other ideas for words'
  ]
  roll : [
    (dice) ->
      throw 'roll requires input, see help roll for examples' if dice.length == 0 || dice == undefined
      results    = []
      parse_die  = /^(\d*)?d(\d+)/
      roll_total = 0
      for die in dice.split(' ')
        if die == 'barrel'
          results.push('[[;;;donkykong] ]')
        else
          parse   = parse_die.exec die
          count   = parse[1] ? 1
          die_max = parse[2] ? 2
          total   = 0
          min     = 1
          max     = 0
          for i in [1..count]
            roll    = getRandomInt 1,die_max
            total  += roll
            min     = roll if roll < min
            max     = roll if roll > max
            roll_total += roll
            results.push "d#{die_max}: #{roll}"
          if count > 1 
            results.push "  group total: #{total} average: #{total/count} min: #{min} max: #{max}" 
          else 
            results.push ' '
      results.push "\nroll total: #{roll_total}"
      return results.join "\n"
    'roll some dice'
    EXAMPLES: ['roll d20', 'roll 3d10', 'roll 5d2 d4 d13']
    SYNTAX: 'a die is defined by "d" followed by a digit. you can roll the same die multiple times by preceding the die with the number of times to roll'
  ]
  fate: [
    (fates) ->
      throw 'fate requires input, see help fate for examples' if fates.length == 0 || fates == undefined
      possible_fate = []
      for fate in fates.split(/;\s*/)
        # for example: 5 die in a fire
        # parse[1] will be the 5 from 5
        # parse[2] will be 'die in a fire'
        try
          parse = /(\d+)\s*(.*)/.exec fate
          # now duplicate parse[2] across possible_fate parse[1] times
          if parse[1] > 0
            possible_fate.push(parse[2]) for [1..parse[1]]
        catch
          throw "ERROR: '#{fate}' is not properly formated"
      pick = getRandomInt 1,possible_fate.length
      return "your fate is: #{possible_fate[pick-1]}"
    'determine your fate'
    EXAMPLES: [ 'fate 15 die in a fire; 15 eat a goat; 70 win at chess'
              , 'fate 1 heads; 1 tails'
              ]
    SYNTAX: "someInt instruction; someInt instruction; ...  someInt instruction"
    NOTE: "the total of someInt does not need to total 100 (as in 100%) rather the decision is based on random value between 1 and total."
  ]
  barrel: [
    (type) ->
      if type == 'roll'
        $('#terminal').addClass('barrel_roll')
        setTimeout("$('#terminal').removeClass('barrel_roll')",4200);
    # easter egg
  ]
  flip : [
    -> if getRandomInt(0,1) then 'heads' else 'tails'
    'flip a coin'
  ]
  yn : [
    -> if getRandomInt(0,1) then 'yes' else 'no'
    'random yes or no'
  ]
  reload : [
    ()-> 
      window.location.reload()
      ''
    'reload the term'
  ]
  repeat : [
    (image) -> 
      enc_img = encodeURIComponent(image)
      "http://notbenh.info/repeater.php?img=#{enc_img}"
    'take a URL and build single page with said URL repeated as a background [in a new tab]'
  ]
  color: [
    (colors) ->
      parsed_colors = []
      for color in colors.split(/\s+#?/)
        if html_color_names[color]? 
          parsed_colors.push html_color_names[color]
        else 
          parsed_colors.push color

      one   = parsed_colors[0]
      two   = parsed_colors[1]
      three = parsed_colors[2]

      throw "color requires at least two colors" if two == undefined
      swatch = (c) -> "[[;;##{c};swatch]##{c}     ]"
      unhex  = (c) ->
        if c.length == 3
          rgb = /(.)(.)(.)/.exec(c)
          return [
            parseInt(''.concat(rgb[1],rgb[1]),16)
            parseInt(''.concat(rgb[2],rgb[2]),16)
            parseInt(''.concat(rgb[3],rgb[3]),16)
          ]
        else
          rgb = /(..)(..)(..)/.exec(c)
          return [
            parseInt(rgb[1],16)
            parseInt(rgb[2],16)
            parseInt(rgb[3],16)
          ]
      rehex = (r,g,b) ->
        return ''.concat(
          ('00' + parseInt(r).toString(16)).substr(-2)
          ('00' + parseInt(g).toString(16)).substr(-2)
          ('00' + parseInt(b).toString(16)).substr(-2)
        )
      step    = 10 # TODO: at some point this should be an option
      a       = unhex one
      b       = unhex two
      r_diff  = (a[0]-b[0])/step
      g_diff  = (a[1]-b[1])/step
      b_diff  = (a[2]-b[2])/step
      results = []
      a2b     = []
      # resolve the first column one->two
      for i in [0..step]
        a2b.push([ a[0]-(i*r_diff), a[1]-(i*g_diff), a[2]-(i*b_diff) ])

      if three != undefined
        c = unhex three
        for row in [0..step]
          r_diff = (c[0]-a2b[row][0])/step
          g_diff = (c[1]-a2b[row][1])/step
          b_diff = (c[2]-a2b[row][2])/step
          row_swatches = []
          for i in [0..step]
            row_swatches.push( swatch(rehex(c[0]-(i*r_diff), c[1]-(i*g_diff), c[2]-(i*b_diff) )) )
          results.push(row_swatches.reverse().join(''))
      else
        # just doing a 2d so just push the swatches to results
        for i in [0..step]
          results.push(swatch(rehex(a2b[i][0], a2b[i][1], a2b[i][2])))
      return results.join("\n")
    'build a graident between two or three html/hex colors'
    EXAMPLES: ['color FFF 000', 'color 012345 FEDCBA', 'color 012345 FEDCBA CCC']
  ]

html_color_names = 
  "white":"FFFFFF"
  "snow":"FFFAFA"
  "ghost white":"F8F8FF"
  "mint cream":"F5FFFA"
  "floral white":"FFFAF0"
  "ivory":"FFFFF0"
  "alice blue":"F0F8FF"
  "azure":"F0FFFF"
  "lavender blush":"FFF0F5"
  "honeydew":"F0FFF0"
  "seashell":"FFF5EE"
  "white smoke":"F5F5F5"
  "old lace":"FDF5E6"
  "linen":"FAF0E6"
  "lavender":"E6E6FA"
  "misty rose":"FFE4E1"
  "light cyan":"E0FFFF"
  "light yellow":"FFFFE0"
  "cornsilk":"FFF8DC"
  "papaya whip":"FFEFD5"
  "beige":"F5F5DC"
  "antique white":"FAEBD7"
  "light goldenrod":"FAFAD2"
  "blanched almond":"FFEBCD"
  "lemon chiffon":"FFFACD"
  "bisque":"FFE4C4"
  "pink":"FFC0CB"
  "peach puff":"FFDAB9"
  "gainsboro":"DCDCDC"
  "light pink":"FFB6C1"
  "moccasin":"FFE4B5"
  "navajo white":"FFDEAD"
  "wheat":"F5DEB3"
  "light gray":"D3D3D3"
  "pale turquoise":"AFEEEE"
  "pale goldenrod":"EEE8AA"
  "thistle":"D8BFD8"
  "powder blue":"B0E0E6"
  "pale green":"98FB98"
  "light blue":"ADD8E6"
  "light steel blue":"B0C4DE"
  "light sky blue":"87CEFA"
  "silver":"C0C0C0"
  "aquamarine":"7FFFD4"
  "light green":"90EE90"
  "plum":"DDA0DD"
  "gray":"BEBEBE"
  "khaki":"F0E68C"
  "light salmon":"FFA07A"
  "sky blue":"87CEEB"
  "light coral":"F08080"
  "violet":"EE82EE"
  "salmon":"FA8072"
  "hot pink":"FF69B4"
  "burlywood":"DEB887"
  "dark salmon":"E9967A"
  "tan":"D2B48C"
  "medium slate blue":"7B68EE"
  "sandy brown":"F4A460"
  "laser lemon":"FFFF54"
  "dark gray":"A9A9A9"
  "cornflower":"6495ED"
  "coral":"FF7F50"
  "dark sea green":"8FBC8F"
  "pale violet red":"DB7093"
  "rosy brown":"BC8F8F"
  "medium purple":"9370DB"
  "orchid":"DA70D6"
  "pale violet red":"D87093"
  "medium purple":"9370D8"
  "tomato":"FF6347"
  "medium aquamarine":"66CDAA"
  "green yellow":"ADFF2F"
  "indian red":"CD5C5C"
  "dark khaki":"BDB76B"
  "medium orchid":"BA55D3"
  "slate blue":"6A5ACD"
  "royal blue":"4169E1"
  "turquoise":"40E0D0"
  "dodger blue":"1E90FF"
  "medium turquoise":"48D1CC"
  "deep pink":"FF1493"
  "light slate gray":"778899"
  "purple":"A020F0"
  "blue violet":"8A2BE2"
  "peru":"CD853F"
  "gray":"808080"
  "slate gray":"708090"
  "spring green":"00FF7F"
  "gold":"FFD700"
  "cadet blue":"5F9EA0"
  "lime green":"32CD32"
  "chartreuse":"7FFF00"
  "orange red":"FF4500"
  "orange":"FFA500"
  "blue":"0000FF"
  "dark orange":"FF8C00"
  "red":"FF0000"
  "magenta":"FF00FF"
  "deep sky blue":"00BFFF"
  "cyan":"00FFFF"
  "yellow green":"9ACD32"
  "yellow":"FFFF00"
  "lime":"00FF00"
  "green":"00FF00"
  "dark orchid":"9932CC"
  "lawn green":"7CFC00"
  "goldenrod":"DAA520"
  "steel blue":"4682B4"
  "medium spring green":"00FA9A"
  "crimson":"DC143C"
  "chocolate":"D2691E"
  "medium sea green":"3CB371"
  "maroon":"B03060"
  "medium violet red":"C71585"
  "firebrick":"B22222"
  "dark violet":"9400D3"
  "light sea green":"20B2AA"
  "dim gray":"696969"
  "dark turquoise":"00CED1"
  "brown":"A52A2A"
  "medium blue":"0000CD"
  "sienna":"A0522D"
  "dark slate blue":"483D8B"
  "dark goldenrod":"B8860B"
  "sea green":"2E8B57"
  "olive drab":"6B8E23"
  "forest green":"228B22"
  "saddle brown":"8B4513"
  "dark olive green":"556B2F"
  "dark blue":"00008B"
  "dark red":"8B0000"
  "dark cyan":"008B8B"
  "dark magenta":"8B008B"
  "midnight blue":"191970"
  "indigo":"4B0082"
  "green":"008000"
  "olive":"808000"
  "navy":"000080"
  "teal":"008080"
  "purple":"7F007F"
  "maroon":"7F0000"
  "dark slate gray":"2F4F4F"
  "dark green":"006400"
  "black":"000000"

