ipc = require 'ipc'

module.exports = ({commandRegistry, commandInstaller, config}) ->
  commandRegistry.add 'atom-workspace',
    'pane:show-next-item': -> @getModel().getActivePane().activateNextItem()
    'pane:show-previous-item': -> @getModel().getActivePane().activatePreviousItem()
    'pane:show-item-1': -> @getModel().getActivePane().activateItemAtIndex(0)
    'pane:show-item-2': -> @getModel().getActivePane().activateItemAtIndex(1)
    'pane:show-item-3': -> @getModel().getActivePane().activateItemAtIndex(2)
    'pane:show-item-4': -> @getModel().getActivePane().activateItemAtIndex(3)
    'pane:show-item-5': -> @getModel().getActivePane().activateItemAtIndex(4)
    'pane:show-item-6': -> @getModel().getActivePane().activateItemAtIndex(5)
    'pane:show-item-7': -> @getModel().getActivePane().activateItemAtIndex(6)
    'pane:show-item-8': -> @getModel().getActivePane().activateItemAtIndex(7)
    'pane:show-item-9': -> @getModel().getActivePane().activateLastItem()
    'pane:move-item-right': -> @getModel().getActivePane().moveItemRight()
    'pane:move-item-left': -> @getModel().getActivePane().moveItemLeft()
    'window:increase-font-size': -> @getModel().increaseFontSize()
    'window:decrease-font-size': -> @getModel().decreaseFontSize()
    'window:reset-font-size': -> @getModel().resetFontSize()
    'application:about': -> ipc.send('command', 'application:about')
    'application:show-preferences': -> ipc.send('command', 'application:show-settings')
    'application:show-settings': -> ipc.send('command', 'application:show-settings')
    'application:quit': -> ipc.send('command', 'application:quit')
    'application:hide': -> ipc.send('command', 'application:hide')
    'application:hide-other-applications': -> ipc.send('command', 'application:hide-other-applications')
    'application:install-update': -> ipc.send('command', 'application:install-update')
    'application:unhide-all-applications': -> ipc.send('command', 'application:unhide-all-applications')
    'application:new-window': -> ipc.send('command', 'application:new-window')
    'application:new-file': -> ipc.send('command', 'application:new-file')
    'application:open': -> ipc.send('command', 'application:open')
    'application:open-file': -> ipc.send('command', 'application:open-file')
    'application:open-folder': -> ipc.send('command', 'application:open-folder')
    'application:open-dev': -> ipc.send('command', 'application:open-dev')
    'application:open-safe': -> ipc.send('command', 'application:open-safe')
    'application:add-project-folder': -> atom.addProjectFolder()
    'application:minimize': -> ipc.send('command', 'application:minimize')
    'application:zoom': -> ipc.send('command', 'application:zoom')
    'application:bring-all-windows-to-front': -> ipc.send('command', 'application:bring-all-windows-to-front')
    'application:open-your-config': -> ipc.send('command', 'application:open-your-config')
    'application:open-your-init-script': -> ipc.send('command', 'application:open-your-init-script')
    'application:open-your-keymap': -> ipc.send('command', 'application:open-your-keymap')
    'application:open-your-snippets': -> ipc.send('command', 'application:open-your-snippets')
    'application:open-your-stylesheet': -> ipc.send('command', 'application:open-your-stylesheet')
    'application:open-license': -> @getModel().openLicense()
    'window:run-package-specs': -> @runPackageSpecs()
    'window:focus-next-pane': -> @getModel().activateNextPane()
    'window:focus-previous-pane': -> @getModel().activatePreviousPane()
    'window:focus-pane-above': -> @focusPaneViewAbove()
    'window:focus-pane-below': -> @focusPaneViewBelow()
    'window:focus-pane-on-left': -> @focusPaneViewOnLeft()
    'window:focus-pane-on-right': -> @focusPaneViewOnRight()
    'window:save-all': -> @getModel().saveAll()
    'window:toggle-invisibles': -> config.set("editor.showInvisibles", not config.get("editor.showInvisibles"))
    'window:log-deprecation-warnings': -> Grim.logDeprecations()
    'window:toggle-auto-indent': -> config.set("editor.autoIndent", not config.get("editor.autoIndent"))
    'pane:reopen-closed-item': -> @getModel().reopenItem()
    'core:close': -> @getModel().closeActivePaneItemOrEmptyPaneOrWindow()
    'core:save': -> @getModel().saveActivePaneItem()
    'core:save-as': -> @getModel().saveActivePaneItemAs()

  if process.platform is 'darwin'
    commandRegistry.add 'atom-workspace', 'window:install-shell-commands', ->
      commandInstaller.installShellCommandsInteractively()

  commandRegistry.add 'atom-pane',
    'pane:save-items': -> @getModel().saveItems()
    'pane:split-left': -> @getModel().splitLeft(copyActiveItem: true)
    'pane:split-right': -> @getModel().splitRight(copyActiveItem: true)
    'pane:split-up': -> @getModel().splitUp(copyActiveItem: true)
    'pane:split-down': -> @getModel().splitDown(copyActiveItem: true)
    'pane:close': -> @getModel().close()
    'pane:close-other-items': -> @getModel().destroyInactiveItems()
    'pane:increase-size': -> @getModel().increaseSize()
    'pane:decrease-size': -> @getModel().decreaseSize()

  commandRegistry.add 'atom-text-editor', stopEventPropagation(
    'core:undo': -> @undo()
    'core:redo': -> @redo()
    'core:move-left': -> @moveLeft()
    'core:move-right': -> @moveRight()
    'core:select-left': -> @selectLeft()
    'core:select-right': -> @selectRight()
    'core:select-up': -> @selectUp()
    'core:select-down': -> @selectDown()
    'core:select-all': -> @selectAll()
    'editor:select-word': -> @selectWordsContainingCursors()
    'editor:consolidate-selections': (event) -> event.abortKeyBinding() unless @consolidateSelections()
    'editor:move-to-beginning-of-next-paragraph': -> @moveToBeginningOfNextParagraph()
    'editor:move-to-beginning-of-previous-paragraph': -> @moveToBeginningOfPreviousParagraph()
    'editor:move-to-beginning-of-screen-line': -> @moveToBeginningOfScreenLine()
    'editor:move-to-beginning-of-line': -> @moveToBeginningOfLine()
    'editor:move-to-end-of-screen-line': -> @moveToEndOfScreenLine()
    'editor:move-to-end-of-line': -> @moveToEndOfLine()
    'editor:move-to-first-character-of-line': -> @moveToFirstCharacterOfLine()
    'editor:move-to-beginning-of-word': -> @moveToBeginningOfWord()
    'editor:move-to-end-of-word': -> @moveToEndOfWord()
    'editor:move-to-beginning-of-next-word': -> @moveToBeginningOfNextWord()
    'editor:move-to-previous-word-boundary': -> @moveToPreviousWordBoundary()
    'editor:move-to-next-word-boundary': -> @moveToNextWordBoundary()
    'editor:move-to-previous-subword-boundary': -> @moveToPreviousSubwordBoundary()
    'editor:move-to-next-subword-boundary': -> @moveToNextSubwordBoundary()
    'editor:select-to-beginning-of-next-paragraph': -> @selectToBeginningOfNextParagraph()
    'editor:select-to-beginning-of-previous-paragraph': -> @selectToBeginningOfPreviousParagraph()
    'editor:select-to-end-of-line': -> @selectToEndOfLine()
    'editor:select-to-beginning-of-line': -> @selectToBeginningOfLine()
    'editor:select-to-end-of-word': -> @selectToEndOfWord()
    'editor:select-to-beginning-of-word': -> @selectToBeginningOfWord()
    'editor:select-to-beginning-of-next-word': -> @selectToBeginningOfNextWord()
    'editor:select-to-next-word-boundary': -> @selectToNextWordBoundary()
    'editor:select-to-previous-word-boundary': -> @selectToPreviousWordBoundary()
    'editor:select-to-next-subword-boundary': -> @selectToNextSubwordBoundary()
    'editor:select-to-previous-subword-boundary': -> @selectToPreviousSubwordBoundary()
    'editor:select-to-first-character-of-line': -> @selectToFirstCharacterOfLine()
    'editor:select-line': -> @selectLinesContainingCursors()
  )

  commandRegistry.add 'atom-text-editor', stopEventPropagationAndGroupUndo(config,
    'core:backspace': -> @backspace()
    'core:delete': -> @delete()
    'core:cut': -> @cutSelectedText()
    'core:copy': -> @copySelectedText()
    'core:paste': -> @pasteText()
    'editor:delete-to-previous-word-boundary': -> @deleteToPreviousWordBoundary()
    'editor:delete-to-next-word-boundary': -> @deleteToNextWordBoundary()
    'editor:delete-to-beginning-of-word': -> @deleteToBeginningOfWord()
    'editor:delete-to-beginning-of-line': -> @deleteToBeginningOfLine()
    'editor:delete-to-end-of-line': -> @deleteToEndOfLine()
    'editor:delete-to-end-of-word': -> @deleteToEndOfWord()
    'editor:delete-to-beginning-of-subword': -> @deleteToBeginningOfSubword()
    'editor:delete-to-end-of-subword': -> @deleteToEndOfSubword()
    'editor:delete-line': -> @deleteLine()
    'editor:cut-to-end-of-line': -> @cutToEndOfLine()
    'editor:cut-to-end-of-buffer-line': -> @cutToEndOfBufferLine()
    'editor:transpose': -> @transpose()
    'editor:upper-case': -> @upperCase()
    'editor:lower-case': -> @lowerCase()
    'editor:copy-selection': -> @copyOnlySelectedText()
  )

  commandRegistry.add 'atom-text-editor:not([mini])', stopEventPropagation(
    'core:move-up': -> @moveUp()
    'core:move-down': -> @moveDown()
    'core:move-to-top': -> @moveToTop()
    'core:move-to-bottom': -> @moveToBottom()
    'core:page-up': -> @pageUp()
    'core:page-down': -> @pageDown()
    'core:select-to-top': -> @selectToTop()
    'core:select-to-bottom': -> @selectToBottom()
    'core:select-page-up': -> @selectPageUp()
    'core:select-page-down': -> @selectPageDown()
    'editor:add-selection-below': -> @addSelectionBelow()
    'editor:add-selection-above': -> @addSelectionAbove()
    'editor:split-selections-into-lines': -> @splitSelectionsIntoLines()
    'editor:toggle-soft-tabs': -> @toggleSoftTabs()
    'editor:toggle-soft-wrap': -> @toggleSoftWrapped()
    'editor:fold-all': -> @foldAll()
    'editor:unfold-all': -> @unfoldAll()
    'editor:fold-current-row': -> @foldCurrentRow()
    'editor:unfold-current-row': -> @unfoldCurrentRow()
    'editor:fold-selection': -> @foldSelectedLines()
    'editor:fold-at-indent-level-1': -> @foldAllAtIndentLevel(0)
    'editor:fold-at-indent-level-2': -> @foldAllAtIndentLevel(1)
    'editor:fold-at-indent-level-3': -> @foldAllAtIndentLevel(2)
    'editor:fold-at-indent-level-4': -> @foldAllAtIndentLevel(3)
    'editor:fold-at-indent-level-5': -> @foldAllAtIndentLevel(4)
    'editor:fold-at-indent-level-6': -> @foldAllAtIndentLevel(5)
    'editor:fold-at-indent-level-7': -> @foldAllAtIndentLevel(6)
    'editor:fold-at-indent-level-8': -> @foldAllAtIndentLevel(7)
    'editor:fold-at-indent-level-9': -> @foldAllAtIndentLevel(8)
    'editor:log-cursor-scope': -> @logCursorScope()
    'editor:copy-path': -> @copyPathToClipboard(false)
    'editor:copy-project-path': -> @copyPathToClipboard(true)
    'editor:toggle-indent-guide': -> config.set('editor.showIndentGuide', not config.get('editor.showIndentGuide'))
    'editor:toggle-line-numbers': -> config.set('editor.showLineNumbers', not config.get('editor.showLineNumbers'))
    'editor:scroll-to-cursor': -> @scrollToCursorPosition()
  )

  commandRegistry.add 'atom-text-editor:not([mini])', stopEventPropagationAndGroupUndo(config,
    'editor:indent': -> @indent()
    'editor:auto-indent': -> @autoIndentSelectedRows()
    'editor:indent-selected-rows': -> @indentSelectedRows()
    'editor:outdent-selected-rows': -> @outdentSelectedRows()
    'editor:newline': -> @insertNewline()
    'editor:newline-below': -> @insertNewlineBelow()
    'editor:newline-above': -> @insertNewlineAbove()
    'editor:toggle-line-comments': -> @toggleLineCommentsInSelection()
    'editor:checkout-head-revision': -> @checkoutHeadRevision()
    'editor:move-line-up': -> @moveLineUp()
    'editor:move-line-down': -> @moveLineDown()
    'editor:duplicate-lines': -> @duplicateLines()
    'editor:join-lines': -> @joinLines()
  )

stopEventPropagation = (commandListeners) ->
  newCommandListeners = {}
  for commandName, commandListener of commandListeners
    do (commandListener) ->
      newCommandListeners[commandName] = (event) ->
        event.stopPropagation()
        commandListener.call(@getModel(), event)
  newCommandListeners

stopEventPropagationAndGroupUndo = (config, commandListeners) ->
  newCommandListeners = {}
  for commandName, commandListener of commandListeners
    do (commandListener) ->
      newCommandListeners[commandName] = (event) ->
        event.stopPropagation()
        model = @getModel()
        model.transact config.get('editor.undoGroupingInterval'), ->
          commandListener.call(model, event)
  newCommandListeners
