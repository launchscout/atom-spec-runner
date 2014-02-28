{BufferedProcess} = require 'atom'
SpecRunnerView = require './spec-runner-view'

module.exports =
class SpecLauncher

  runCurrentLine: ->
    editor = atom.workspace.activePaneItem
    line = editor.getCursorScreenRow()
    @runSpec("#{editor.getPath()}:#{line}")

  runCurrentFile: ->
    editor = atom.workspace.activePaneItem
    @runSpec(editor.getPath())

  runSpec: (spec)->

    specRunnerView = new SpecRunnerView(spec: spec)
    atom.workspaceView.appendToRight(specRunnerView)

    specCommand = atom.config.get("spec-runner.command")
    command = 'bash'
    args = ["-c", "#{specCommand} #{spec}"]
    options =
      cwd: atom.project.getPath()
    stdout = (output) -> specRunnerView.addLine(output)
    stderr = (output) -> specRunnerView.addLine(output)
    exit = (code) -> console.log("pwd exited with #{code}")
    process = new BufferedProcess({command, args, options, stdout, stderr, exit})
