{View} = require 'atom'

module.exports =
class SpecRunnerView extends View

  @content: (params)->
    @div class: 'spec-runner', =>
      @div class: "close-icon", click: "close", "Close"
      @h2 params.spec
      @ul class: 'output'

  addLine: (line)->
    @find("ul.output").append("<li>#{line}</li>")

  close: ->
    console.log("Now closing...")
    @remove()
