{BufferedProcess} = require 'atom'
SpecRunnerView = require './spec-runner-view'

module.exports =
class SpecLauncher

  runCurrentLine: ->
    editor = atom.workspace.getActiveEditor()
    line = editor.getCursorScreenRow()
    @runSpec("#{editor.getPath()}:#{line}")

  runCurrentFile: ->
    editor = atom.workspace.getActiveEditor()
    @runSpec(editor.getPath())

  runSpec: (spec)->
    editor = null
    promise = atom.workspace.open('rspec.output', {split: 'right'})

    stdout = (output) ->
      editor.insertText(output)
    stderr = (output) ->
      editor.insertText(output)
    exit = (code) -> console.log("exit: #{code}\n")
    specCommand = atom.config.get("spec-runner.command")
    command = 'bash'
    args = ["-c", "#{specCommand} #{spec}"]

    promise.then(
      ->
        editor = promise.valueOf()
        editor.insertText("#{command} #{args.join(' ')}\n")
      , -> console.log "Oops, failed")

    options =
      cwd: atom.project.getPath()
    process = new BufferedProcess({command, args, options, stdout, stderr, exit})
