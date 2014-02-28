SpecLauncher = require './spec-launcher'

module.exports =

  specRunnerView: null

  activate: (state) ->
    atom.config.setDefaults "spec-runner",
      command: "rspec"
    @specLauncher = new SpecLauncher()
    atom.workspaceView.command "spec-runner:run-file", =>
      @specLauncher.runCurrentFile()
    atom.workspaceView.command "spec-runner:run-line", =>
      @specLauncher.runCurrentLine()

  # deactivate: ->
  #   @specRunnerView.destroy()
  #
  # serialize: ->
  #   specRunnerViewState: @specRunnerView.serialize()
