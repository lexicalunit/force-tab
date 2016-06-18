{CompositeDisposable} = require 'atom'

module.exports =
  config:
    honorSoftTabs:
      type: 'boolean'
      default: true

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'force-tab:insert': => @forceTabInsert()
      'force-tab:insert-actual-tab': => @forceTabInsertActualTab()

  deactivate: ->
    @subscriptions?.dispose()

  forceTabInsert: ->
    editor = atom.workspace.getActiveTextEditor()
    if editor?
      if editor.getSoftTabs() and atom.config.get 'force-tab.honorSoftTabs'
        pos = editor.getCursorBufferPosition()
        tabLength = editor.getTabLength()
        spacesCount = tabLength - (pos.column % tabLength) + 1
        editor.insertText(Array(spacesCount).join(' '))
      else
        editor.insertText '\t'

  forceTabInsertActualTab: ->
    editor = atom.workspace.getActiveTextEditor()
    if editor?
      editor.insertText '\t'
