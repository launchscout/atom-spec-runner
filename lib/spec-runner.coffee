SpecLauncher = require './spec-launcher'
SpecRunnerView = require './spec-runner-view'

configUri = "atom://spec-runner"

module.exports =

  activate: (state) ->
    atom.project.registerOpener (uri) =>
      @specRunnerView = new SpecRunnerView if uri is configUri

    atom.config.setDefaults "spec-runner",
      command: "rspec"

    atom.workspaceView.command "spec-runner:run-file", =>
      atom.workspaceView.open(configUri)
      @specRunnerView.runCurrentFile()

    atom.workspaceView.command "spec-runner:run-line", =>
      atom.workspaceView.open(configUri)
      @specRunnerView.runCurrentLine()

  # deactivate: ->
  #   @specRunnerView.destroy()
  #
  # serialize: ->
  #   specRunnerViewState: @specRunnerView.serialize()
