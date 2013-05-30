class Terminal
  constructor: (@name, @id) ->
/*

jQuery ($)->
  $('#terminal').terminal -> (command,term)
    args = command.split(' ')
    verb = args.shift()
    if command?
      try
        result = window.eval( verb + '(args)')
        if result?
          term.echo(new String(result))
      catch(e)
          term.error(new String(e))
    else 
      term.echo('')

    greetings: 'welcome to notbenh.info... do something by typing'
    name: 'notbenh_shell'
    height: 200
    prompt: '> '

*/

class Actions
  contructor : (@name) ->
  roll = (dice) ->
    re      = /^(\d*)?d
    results = for die in dice


function roll (dice){
  var results = [];
  var re = /^(\d*)?d(\d+)/;
  dice.forEach(function(die){
      var parse = re.exec(die);
      var count = parse[1] === undefined ? 1 : parse[1];
      console.info("COUNT: ", count, typeof count)
      console.info("PARSE: ", parse)
      var max   = parse[2];
      for(i=0; i< count; i++){
        results.push('d' + max + ': ' + getRandomInt(1,max))
      }
    }
  )
  console.info("ROLL RESULT: ", results)
  return results.join("\n");
}

function flip (){ return getRandomInt(0,1)}

function reload () { window.location.reload() }

function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

