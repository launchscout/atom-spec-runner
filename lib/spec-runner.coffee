SpecRunnerView = require './spec-runner-view'

configUri = "atom://spec-runner"

module.exports =

  lastSpec: null

  activate: (state) ->
    atom.project.registerOpener (uri) =>
      @specRunnerView = new SpecRunnerView if uri is configUri

    atom.config.setDefaults "spec-runner",
      command: "rspec"

    atom.workspaceView.command "spec-runner:run-file", =>
      atom.workspaceView.open(configUri)
      editor = atom.workspace.activePaneItem
      @lastSpec = editor.getPath()
      @specRunnerView.runSpec(@lastSpec)

    atom.workspaceView.command "spec-runner:run-line", =>
      atom.workspaceView.open(configUri)
      editor = atom.workspace.activePaneItem
      line = editor.getCursorScreenRow()
      @lastSpec = "#{editor.getPath()}:#{line + 1}"
      @specRunnerView.runSpec(@lastSpec)

    atom.workspaceView.command "spec-runner:run-previous", =>
      return unless @lastSpec
      atom.workspaceView.open(configUri)
      @specRunnerView.runSpec(@lastSpec)

  # deactivate: ->
  #   @specRunnerView.destroy()
  #
  # serialize: ->
  #   specRunnerViewState: @specRunnerView.serialize()
