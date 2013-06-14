auto_url_open = (result) ->
  result_url_match = /https?:\/\/(?:(?!&[^;]+;)[^\s:"'<>)])+/g.exec(result)
  if result_url_match != null && result_url_match[0] == result
    # action returned just a URL, kick open a new tab
    window.open(result)
    result += ' [opened in new tab]'
  return result

getRandomInt = (min, max) -> return Math.floor(Math.random() * (max - min + 1)) + min

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

ben_actions =
  tdone  : NYI 'todo list manager'
  suggest: LINK 'https://github.com/notbenh/next.notbenh.info/issues', 'suggest issues via github'
  resume : LINK 'http://resume.notbenh.info', 'my resume'
  about  : LINK 'http://about.notbenh.info' , 'about me'
  twitter: LINK 'http://twitter.com/notbenh', 'my twitter account'
  github : LINK 'https://github.com/notbenh', 'my github account'
  blog   : LINK 'http://notbenh.github.io'  , 'the thing I call a blog'
  roll : [
    (dice) ->
      return this.help('roll') if dice.length == 0 || dice == undefined
      results    = []
      parse_die  = /^(\d*)?d(\d+)/
      roll_total = 0
      console.info(dice)
      for die in dice.split(' ')
        console.info "DIE #{die}"
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
    SYNTAX: 'a die is defined by "d" followed by a digit. you can roll the same die multipe times by preceeding the die with the number of times to roll'
    TODO: 'currently roll with out any arguments blows up, should give you the help text or at least tell you why you got nothing'
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
    -> window.location.reload()
    'reload the term'
  ]
  repeat : [
    (url) -> ' just go to http://notbenh.info/repeater.php as this is not yet done'
    'take a URL and build single page with said URL repeated as a background'
  ]
  color: [
    (colors) ->
      parsed_colors = colors.split(/\s+/)
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
