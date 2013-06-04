getRandomInt = (min,max) -> return Math.floor(Math.random() * (max - min + 1)) + min

actions =
  roll:
    GOAL: 'roll some dice'
    EXAMPLES: ['roll d20', 'roll 3d10', 'roll 5d2 d4 d13']
    SYNTAX: 'a die is defined by "d" followed by a digit. you can roll the same die multiple times by preceding the die with the number of times to roll'
    TODO: 'currently roll with out any arguments does not do anything, should give you the help text or at least tell you why you got nothing'
    action: (dice)->
      console.info(dice)
      if dice? then return '!!! AKK HELP !!!'
      results = for die in dice
        if die == 'barrel' then 'link to rep'
        else
          parse = /^(\d*)?d(\d+)/.exec(die)
          count = parse[1] ? 1
          console.info(die,count,parse)
          "d#{parse[2]}: #{getRandomInt(1,parse[2])}\n" for [1..count]
      results.join("\n")
