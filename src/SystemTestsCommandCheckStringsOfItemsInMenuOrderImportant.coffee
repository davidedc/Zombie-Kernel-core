# 


class SystemTestsCommandCheckStringsOfItemsInMenuOrderImportant extends SystemTestsCommand
  stringOfItemsInMenuInOriginalOrder: []

  @replayFunction: (systemTestsRecorderAndPlayer, commandBeingPlayed) ->
    systemTestsRecorderAndPlayer.checkStringsOfItemsInMenuOrderImportant(commandBeingPlayed.stringOfItemsInMenuInOriginalOrder)

  constructor: (@stringOfItemsInMenuInOriginalOrder, systemTestsRecorderAndPlayer) ->
    super(systemTestsRecorderAndPlayer)
    # it's important that this is the same name of
    # the class cause we need to use the static method
    # replayFunction to replay the command
    @testCommandName = "SystemTestsCommandCheckStringsOfItemsInMenuOrderImportant"
