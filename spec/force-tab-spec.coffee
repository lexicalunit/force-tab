ForceTab = require '../lib/force-tab'

describe 'ForceTab', ->
  [activationPromise, workspaceElement] = []

  executeInsert = (callback) ->
    atom.commands.dispatch(workspaceElement, 'force-tab:insert')
    waitsForPromise -> activationPromise
    runs(callback)

  executeInsertActualTab = (callback) ->
    atom.commands.dispatch(workspaceElement, 'force-tab:insert-actual-tab')
    waitsForPromise -> activationPromise
    runs(callback)

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('force-tab')

  it 'when force-tab:insert is triggered at 0, 0 in words.txt', ->
    waitsForPromise -> atom.workspace.open('words.txt').then (editor) ->
      editor.setCursorBufferPosition [0, 0]
      executeInsert ->
        expect(editor.getText()).toBe """  0123456

"""

  it 'when force-tab:insert is triggered at 0, 1 in words.txt', ->
    waitsForPromise -> atom.workspace.open('words.txt').then (editor) ->
      editor.setCursorBufferPosition [0, 1]
      executeInsert ->
        expect(editor.getText()).toBe """0 123456

"""

  it 'when force-tab:insert is triggered at 0, 2 in words.txt', ->
    waitsForPromise -> atom.workspace.open('words.txt').then (editor) ->
      editor.setCursorBufferPosition [0, 2]
      executeInsert ->
        expect(editor.getText()).toBe """01  23456

"""

  it 'when force-tab:insert-actual-tab is triggered at 0, 0 in words.txt', ->
    waitsForPromise -> atom.workspace.open('words.txt').then (editor) ->
      editor.setCursorBufferPosition [0, 0]
      executeInsertActualTab ->
        expect(editor.getText()).toBe """	0123456

"""

  it 'when force-tab:insert-actual-tab is triggered at 0, 1 in words.txt', ->
    waitsForPromise -> atom.workspace.open('words.txt').then (editor) ->
      editor.setCursorBufferPosition [0, 1]
      executeInsertActualTab ->
        expect(editor.getText()).toBe """0	123456

"""

  it 'when force-tab:insert-actual-tab is triggered at 0, 2 in words.txt', ->
    waitsForPromise -> atom.workspace.open('words.txt').then (editor) ->
      editor.setCursorBufferPosition [0, 2]
      executeInsertActualTab ->
        expect(editor.getText()).toBe """01	23456

"""
