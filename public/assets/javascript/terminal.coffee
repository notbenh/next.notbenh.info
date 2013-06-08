class ActionSet
  constructor: (@name) ->
  actions : {}
  do      : =>
    args = if arguments.length == 1 then arguments[0].split(' ') else Array.prototype.slice.call(arguments)
    verb = args.shift()
    console.info "L #{arguments.length} VERB #{verb} args [" + args + "] action " + @actions[verb]
    throw new Error("ActionSet #{@name} does not know how to #{verb}") if @actions[verb] == undefined
    return @actions[verb].action(args...)
  #_custom_actions: []
  add     : (name,opts...) ->
    console.info('add',name,opts)
    @actions[name] = new Action(name, opts...)
  #rm      : () => # remove an action
  #_merge  : () => # take a list of other AS objects and try and take there actions
  #help    : (verb) =>

class Action
  constructor: (@name,@action,@note,@docs...) ->
    console.info('const',@name,@action,@note,@docs)

class Terminal
  # for now assume that terminal has been loaded already
  constructor: (@id,@options) ->
    @element = $(@id).terminal(@_preform_action, @options)
  _preform_action: (command,term) =>
    if command == ''
      term.echo('') # no command, no output
    else
      try
        term.echo @actions.do(command)
      catch e
        term.error( new String(e))
    return # seems that coffeescript always returns, so return nothing
  docs: {}
  actions : new ActionSet('instance')
  _add_action: (name,action,docs...) ->
    @actions.add(name,action,docs)


###

    function help (verbs){
  var buffer = ''
  if(verbs.length === 0){
    buffer += "for more help on any topic ask for help followed by topic. for example if you wanted to know more about 'roll' then say 'help roll'\n";
    buffer += "here are some of the helpful things you can do: \n"
    Object.keys(docs).sort().forEach(function(verb){
      buffer += "  " + verb + " : " + docs[verb]['GOAL'] + "\n"
    })
    // TODO: it would be nice if this was formated such that all the : are aligned
  }
  else {
    verbs.forEach(function(verb){
      //console.info('VERB IS ' + verb)
      if( docs[verb] !== undefined ) {
        //console.info('FOUND ONE: ', docs[verb]);
        buffer += "  " + verb + " : " + docs[verb]['GOAL'] + "\n"
        // SYNTAX
        if( docs[verb]['SYNTAX'] !== undefined) {
          buffer += "  SYNTAX: " + docs[verb]['SYNTAX'] + "\n"
        }
        // EXAMPLES
        if( docs[verb]['EXAMPLES'] !== undefined){
          buffer += "  EXAMPLES:\n"
          docs[verb]['EXAMPLES'].forEach(function(example){
            buffer += '    ' + example + "\n"
          })
        }
        // NOTE
        if( docs[verb]['NOTE'] !== undefined) {
          buffer += "  NOTE: " + docs[verb]['NOTE'] + "\n"
        }
        // TODO
        if( docs[verb]['TODO'] !== undefined) {
          buffer += "  TODO: " + docs[verb]['TODO'] + "\n"
        }
      }
      else{
        buffer += "  ERROR: I do not know how to " + verb
      }
    })
  }
  return buffer;
}
###


###
        console.info(verb,args,@actions[verb],result)
        if result != undefined
          result_url_match = /https?:\/\/(?:(?!&[^;]+;)[^\s:"'<>)])+/g.exec(result)
          if result_url_match != null && result_url_match[0] == result
            # action returned just a URL, kick open a new tab
            window.open(result)
            result += ' [opened in new tab]'
            ###
