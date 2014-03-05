{ScrollView, BufferedProcess} = require 'atom'

module.exports =
class SpecRunnerView extends ScrollView

  getTitle: -> "Spec runner"

  @content: (params)->
    @div class: 'spec-runner editor editor-colors', =>
      @div class: 'lines'

  addLine: (line)->
    console.log(line)
    @find("div.lines").append("<div class='line'>#{line}</div>")

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
