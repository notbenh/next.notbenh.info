ben_actions =
  roll : [
    (die...) ->
      console.info(roll,die)
    'roll some die'
  ]
  flip: [
    -> console.info('flip')
    'flip a coin'
  ]




###
        console.info(verb,args,@actions[verb],result)
        if result != undefined
          result_url_match = /https?:\/\/(?:(?!&[^;]+;)[^\s:"'<>)])+/g.exec(result)
          if result_url_match != null && result_url_match[0] == result
            # action returned just a URL, kick open a new tab
            window.open(result)
            result += ' [opened in new tab]'
###
