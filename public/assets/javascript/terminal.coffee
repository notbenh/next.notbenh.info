class Terminal
  # for now assume that terminal has been loaded already
  constructor: (@id,@options) ->
    @element = $(@id).terminal(@_preform_action, @options)
  _preform_action: (command,term) =>
    args = command.split(' ')
    verb = args.shift()
    if command == ''
      term.echo('') # no command, no output
    else if @actions[verb] == undefined
      term.error("I do not know how to #{verb}")
    else
      try
        result = @actions[verb](args)
        console.info(verb,args,@actions[verb],result)
        if result != undefined
          result_url_match = /https?:\/\/(?:(?!&[^;]+;)[^\s:"'<>)])+/g.exec(result)
          if result_url_match != null && result_url_match[0] == result
            # action returned just a URL, kick open a new tab
            window.open(result)
            result += ' [opened in new tab]'

          term.echo new String(result)
      catch e
        term.error( new String(e))
    return # seems that coffeescript always returns, so return nothing
  actions: {}
  docs: {}
  _add_action: (name,action,docs) ->
    @actions[name] = action
    @docs[name] = docs

