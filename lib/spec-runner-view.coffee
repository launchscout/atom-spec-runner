{ScrollView, BufferedProcess} = require 'atom'

module.exports =
class SpecRunnerView extends ScrollView

  getTitle: -> "Spec runner"

  @content: (params)->
    @div class: 'spec-runner editor editor-colors', =>
      @div class: 'lines'

  # Useful for escaping HTML entities in js
  h: (str) ->
    if typeof (str) is "number" or str is true or str is false
      return "" + str
    else return ""  if not str or not str.length
    i = undefined
    out = ""
    trans =
      "<": "&lt;"
      ">": "&gt;"
      "\"": "&quot;"
      "&": "&amp;"
      "'": "&#39;"

    c = undefined
    arr = str.split("")
    i = 0
    while i < arr.length
      c = arr[i]
      if trans.hasOwnProperty(c)
        out += trans[c]
      else
        out += c
      i += 1
    out

  addLine: (line)->
    console.log(line)
    @find("div.lines").append("<div class='line'>#{@h(line)}</div>")

  runCurrentLine: ->
    editor = atom.workspace.activePaneItem
    line = editor.getCursorScreenRow()
    @runSpec("#{editor.getPath()}:#{line + 1}")

  runCurrentFile: ->
    editor = atom.workspace.activePaneItem
    @runSpec(editor.getPath())

  runSpec: (spec)->
    specCommand = atom.config.get("spec-runner.command")
    command = 'bash'
    specArg = "#{specCommand} #{spec}"
    @addLine(specArg)
    args = ["-c", specArg]
    options =
      cwd: atom.project.getPath()
    stdout = (output) => @addLine(output)
    stderr = (output) => @addLine(output)
    exit = (code) -> console.log("pwd exited with #{code}")
    process = new BufferedProcess({command, args, options, stdout, stderr, exit})
