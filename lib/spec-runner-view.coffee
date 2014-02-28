{ScrollView} = require 'atom'

module.exports =
class SpecRunnerView extends ScrollView

  @content: (params)->
    @div class: 'spec-runner editor editor-colors', =>
      @div class: "close-icon", click: "close", "Close"
      @div class: 'lines', =>
        @div class: "line", params.spec

  addLine: (line)->
    console.log(line)
    @find("div.lines").append("<div class='line'>#{line}</div>")

  close: ->
    console.log("Now closing...")
    @remove()
