ParentStainerMixin =
  # class properties here:
  # none

  # instance properties to follow:
  onceAddedClassProperties: (fromClass) ->
    @addInstanceProperties fromClass,

      setColor: (theColor, ignored, connectionsCalculationToken, superCall) ->
        if !superCall and connectionsCalculationToken == @connectionsCalculationToken then return else if !connectionsCalculationToken? then @connectionsCalculationToken = world.makeNewConnectionsCalculationToken() else @connectionsCalculationToken = connectionsCalculationToken
        super theColor, ignored, connectionsCalculationToken, true
        @parent?.setColor theColor, ignored, connectionsCalculationToken
