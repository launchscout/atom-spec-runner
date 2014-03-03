{ScrollView, BufferedProcess} = require 'atom'

module.exports =
class SpecRunnerView extends ScrollView

  getTitle: -> "Spec runner"

  @content: (params)->
    @div class: 'spec-runner editor editor-colors', =>
      @div class: 'lines'

  addLine: (line)->
    console.log(line)
    div = document.createElement('div')
    div.setAttribute('class', 'line')
    div.innerText = line
    @find("div.lines").append(div)

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
    exit = (returnCode) -> console.log("Exited with #{returnCode}")
    process = new BufferedProcess({command, args, options, stdout, stderr, exit})
