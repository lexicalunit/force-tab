ForceTab = require '../lib/force-tab'

describe 'ForceTab', ->
  [activationPromise, workspaceElement] = []

  executeCommand = (callback) ->
    atom.commands.dispatch(workspaceElement, 'force-tab:insert')
    waitsForPromise -> activationPromise
    runs(callback)

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('force-tab')

  it 'when force-tab:insert is triggered at 0, 0 in words.txt', ->
    waitsForPromise -> atom.workspace.open('words.txt').then (editor) ->
      editor.setCursorBufferPosition [0, 0]
      executeCommand ->
        expect(editor.getText()).toBe """  0123456

"""

  it 'when force-tab:insert is triggered at 0, 1 in words.txt', ->
    waitsForPromise -> atom.workspace.open('words.txt').then (editor) ->
      editor.setCursorBufferPosition [0, 1]
      executeCommand ->
        expect(editor.getText()).toBe """0 123456

"""

  it 'when force-tab:insert is triggered at 0, 2 in words.txt', ->
    waitsForPromise -> atom.workspace.open('words.txt').then (editor) ->
      editor.setCursorBufferPosition [0, 2]
      executeCommand ->
        expect(editor.getText()).toBe """01  23456

"""
