# RectangularAppearance //////////////////////////////////////////////////////////////

class RectangularAppearance extends Appearance
  # this is so we can create objects from the object class name 
  # (for the deserialization process)
  namedClasses[@name] = @prototype

  isTransparentAt: (aPoint) ->
    if @morph.boundingBoxTight().containsPoint aPoint
      return false
    if @morph.backgroundTransparency? and @morph.backgroundColor?
      if @morph.backgroundTransparency > 0
        if @morph.boundsContainPoint aPoint
          return false
    return true

  # paintHighlight can work in two patterns:
  #  * passing actual pixels, when used
  #    outside the effect of the scope of
  #    "scale pixelRatio, pixelRatio", or
  #  * passing logical pixels, when used
  #    inside the effect of the scope of
  #    "scale pixelRatio, pixelRatio", or
  # Mostly, the first pattern is used.
  #
  # useful for example when hovering over references
  # to morphs. Can only modify the rendering of a morph,
  # so any highlighting is only visible in the measure that
  # the morph is visible (as opposed to HighlighterMorph being
  # used to highlight a morph)
  paintHighlight: (aContext, al, at, w, h) ->
    return
    ###
    if !@morph.highlighted
      return

    # paintRectangle here is usually made to work with
    # al, at, w, h which are actual pixels
    # rather than logical pixels.
    @morph.paintRectangle \
      aContext,
      al, at, w, h,
      "orange",
      0.5,
      true # push and pop the context
    ###


  # This method only paints this very morph
  # i.e. it doesn't descend the children
  # recursively. The recursion mechanism is done by fullPaintIntoAreaOrBlitFromBackBuffer,
  # which eventually invokes paintIntoAreaOrBlitFromBackBuffer.
  # Note that this morph might paint something on the screen even if
  # it's not a "leaf".
  paintIntoAreaOrBlitFromBackBuffer: (aContext, clippingRectangle, appliedShadow) ->

    if @morph.preliminaryCheckNothingToDraw clippingRectangle, aContext
      return null

    [area,sl,st,al,at,w,h] = @morph.calculateKeyValues aContext, clippingRectangle
    if area.isNotEmpty()
      if w < 1 or h < 1
        return null

      @morph.justBeforeBeingPainted?()

      aContext.save()
      aContext.globalAlpha = (if appliedShadow? then appliedShadow.alpha else 1) * @morph.alpha
      aContext.fillStyle = @morph.color.toString()

      if !@morph.color?
        debugger


      # paintRectangle is usually made to work with
      # al, at, w, h which are actual pixels
      # rather than logical pixels, so it's generally used
      # outside the effect of the scaling because
      # of the pixelRatio

      # paint the background
      toBePainted = new Rectangle al, at, al + w, at + h
      if @morph.backgroundColor?

        color = @morph.backgroundColor
        if appliedShadow?
          color = "black"

        @morph.paintRectangle aContext, toBePainted.left(), toBePainted.top(), toBePainted.width(), toBePainted.height(), color

      # now paint the actual morph, which is a rectangle
      # (potentially inset because of the padding)
      toBePainted = toBePainted.intersect @morph.boundingBoxTight().scaleBy pixelRatio

      color = @morph.color
      if appliedShadow?
        color = "black"

      @morph.paintRectangle aContext, toBePainted.left(), toBePainted.top(), toBePainted.width(), toBePainted.height(), color


      if !appliedShadow?
        if @morph.strokeColor?
          aContext.beginPath()
          aContext.rect Math.round(toBePainted.left()),
            Math.round(toBePainted.top()),
            Math.round(toBePainted.width()),
            Math.round(toBePainted.height())
          aContext.clip()
          aContext.globalAlpha = 1
          aContext.lineWidth = 1
          aContext.strokeStyle = @morph.strokeColor
          aContext.strokeRect  Math.round(@morph.left())-0.5+1,
              Math.round(@morph.top())-0.5+1,
              Math.round(@morph.width()+0.5-2),
              Math.round(@morph.height()-0.5-1)

      

      aContext.restore()

      # paintHighlight is usually made to work with
      # al, at, w, h which are actual pixels
      # rather than logical pixels, so it's generally used
      # outside the effect of the scaling because
      # of the pixelRatio
      @paintHighlight aContext, al, at, w, h
