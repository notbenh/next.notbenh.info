ben_actions =
  roll : [
    (die) ->
      console.info('roll: ',die)
      return 'roll'
    'roll some die'
    {EXAMPLES: ['roll d20','roll 10d30 d6' ]}
  ]
  flip: [
    ->  'filp'
    'flip a coin'
    {EXAMPLES: 'flip'}
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
