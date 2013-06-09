// Generated by CoffeeScript 1.6.3
var ben_actions,
  __slice = [].slice;

ben_actions = {
  roll: [
    function() {
      var die;
      die = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return console.info(roll, die);
    }, 'roll some die', {
      EXAMPLES: ['roll d20', 'roll 10d30 d6']
    }
  ],
  flip: [
    function() {
      return console.info('flip');
    }, 'flip a coin', {
      EXAMPLES: 'flip'
    }
  ]
};

/*
        console.info(verb,args,@actions[verb],result)
        if result != undefined
          result_url_match = /https?:\/\/(?:(?!&[^;]+;)[^\s:"'<>)])+/g.exec(result)
          if result_url_match != null && result_url_match[0] == result
            # action returned just a URL, kick open a new tab
            window.open(result)
            result += ' [opened in new tab]'
*/
