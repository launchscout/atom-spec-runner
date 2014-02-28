{BufferedProcess} = require 'atom'
SpecRunnerView = require './spec-runner-view'

module.exports =
class SpecLauncher

  runCurrentLine: ->
    editor = atom.workspace.activePaneItem
    console.log(editor.getPath())
    line = editor.getCursorScreenRow()
    command = 'bash'
    args = ["-c", "rspec #{editor.getPath()}:#{line + 1}"]
    options =
      cwd: atom.project.getPath()
    stdout = (output) -> console.log(output)
    stderr = (output) -> console.log(output)
    exit = (code) -> console.log("pwd exited with #{code}")
    process = new BufferedProcess({command, args, options, stdout, stderr, exit})

  runCurrentFile: ->
    editor = atom.workspace.activePaneItem
    specRunnerView = new SpecRunnerView(spec: editor.getPath())
    atom.workspaceView.appendToRight(specRunnerView)

    console.log(editor.getPath())
    command = 'bash'
    # args = ["-c", "rspec #{editor.getPath()}"]
    args = ["-c", "rspec_runner.sh #{editor.getPath()}"]
    options =
      cwd: atom.project.getPath()
    stdout = (output) -> specRunnerView.addLine(output)
    stderr = (output) -> console.log(output)
    exit = (code) -> console.log("pwd exited with #{code}")
    process = new BufferedProcess({command, args, options, stdout, stderr, exit})
