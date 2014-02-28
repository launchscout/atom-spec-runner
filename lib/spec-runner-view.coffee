{View} = require 'atom'

module.exports =
class SpecRunnerView extends View

  @content: (params)->
    @div class: 'spec-runner', =>
      @h2 params.spec
      @ul class: 'output'

  addLine: (line)->
    @find("ul.output").append("<li>#{line}</li>")

  toggle: ->
    console.log "SpecRunnerView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
