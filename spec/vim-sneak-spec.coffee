{WorkspaceView} = require 'atom'
VimSneak = require '../lib/vim-sneak'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "VimSneak", ->
  [workspaceElement] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    jasmine.attachToDOM(workspaceElement)

    waitsForPromise -> atom.workspaceView.open('sample.js')

    runs ->
      editor = atom.workspace.getActiveTextEditor()
      editor.setText("This is the file content")

    waitsForPromise ->
      atom.packages.activatePackage('minimap')

    waitsForPromise ->
      atom.packages.activatePackage('vim-sneak')

  describe "with an open editor that have a minimap", ->
    it "lives", ->
      expect('life').toBe('easy')
