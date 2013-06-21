class ActionSet
  constructor: (@name,actions) ->
    if actions != undefined
      for name,data of actions
        @add(name,data...)
  actions : {}
  do      : =>
    args = if arguments.length == 1 then arguments[0].split(' ') else Array.prototype.slice.call(arguments)
    verb = args.shift()
    args = args.join(' ') if arguments.length == 1
    throw "ActionSet #{@name} does not know how to #{verb}" if @actions[verb] == undefined
    result = @actions[verb].action(args)
    for c_action in @_custom_actions
      result = c_action(result)
    return result
  add     : (name,opts...) ->
    @actions[name] = new Action(name, opts...)
  _custom_actions: []
  rm      : () => # remove an action
  _merge  : () => # take a list of other AS objects and try and take there actions
  help    : (verb) =>
    buffer = ''
    # list all known actions if no verb has been asked for
    if verb == undefined
      buffer += "for more help with any of these actions, just ask for help action for even more information. \n"
      buffer += "here are a all the known actions: \n"
      names = (name for name of @actions).sort()
      for name in names
        action = @actions[name]
        buffer += "  [[b;;;]#{action.name}]: #{action.note}\n" if action.note.length > 0
      return buffer
    # report the docs for verb
    action = @actions[verb]
    if action.note.length > 0 || action.docs
      buffer += "#{action.name}:\n"
      buffer += "  #{action.note}\n" if action.note.length >= 0
      for title,content of action.docs
        if Array.isArray content
          buffer += "  #{title}:\n"
          for content_item in content
            buffer += "    #{content_item}\n"
        else
          buffer += "  #{title}: #{content}\n"
      return buffer

class Action
  constructor: (@name,@action,@note='',@docs={}) ->

class Terminal
  # for now assume that terminal has been loaded already
  constructor: (@id,@options,actions) ->
    @element = $(@id).terminal(@_preform_action, @options)
    @actions = if actions != undefined then new ActionSet('instance',actions) else new ActionSet('instance')
  _preform_action: (command,term) =>
    if /^\!/.test(command)
      find = /\!+(.*)/.exec(command)[1]
      term.history().data().pop() # do not store this request
      h = term.history().data()
      re = RegExp find
      command = term.history().data().reverse().filter( (i)-> re.exec(i) )[0] || command
      term.echo command

    if command == ''
      term.echo '' # no command, no output
    else if command == 'history'
      term.echo term.history().data().join("\n")
    else if /^help/.test(command)
      match = /^help\s*(\w+)?/.exec(command)
      term.echo @actions.help(match[1])
    else
      try
        term.echo @actions.do(command) ? ''
      catch e
        term.error e ? 'oops'
    return # seems that coffeescript always returns, so return nothing
  _add_action: (name,action,note,docs) ->
    if typeof name == 'object'
      for name,data of name
        @actions.add(name,data...)
    else
      @actions.add(name,action,note,docs)


