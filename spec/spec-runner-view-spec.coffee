SpecRunnerView = require '../lib/spec-runner-view'
{WorkspaceView} = require 'atom'

describe "SpecRunnerView", ->
  it "has one valid test", ->
    expect("life").toBe "easy"
