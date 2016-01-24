# FloraIconMorph //////////////////////////////////////////////////////


class FloraIconMorph extends Morph
  # this is so we can create objects from the object class name 
  # (for the deserialization process)
  namedClasses[@name] = @prototype

  #constructor: ->
  #  super()
  #  @setColor new Color 0, 0, 0


  # This method only paints this very morph's "image",
  # it doesn't descend the children
  # recursively. The recursion mechanism is done by fullPaintIntoAreaOrBlitFromBackBuffer, which
  # eventually invokes paintIntoAreaOrBlitFromBackBuffer.
  # Note that this morph might paint something on the screen even if
  # it's not a "leaf".
  paintIntoAreaOrBlitFromBackBuffer: (aContext, clippingRectangle) ->

    if @preliminaryCheckNothingToDraw false, clippingRectangle, aContext
      return

    [area,sl,st,al,at,w,h] = @calculateKeyValues aContext, clippingRectangle
    if area.isNotEmpty()
      if w < 1 or h < 1
        return null

      aContext.save()

      # clip out the dirty rectangle as we are
      # going to paint the whole of the box
      aContext.clipToRectangle al,at,w,h

      aContext.globalAlpha = @alpha

      aContext.scale pixelRatio, pixelRatio

      #@paintRectangle aContext, al, at, w, h

      morphPosition = @position()
      aContext.translate morphPosition.x, morphPosition.y

      height = @height()
      width = @width()

      squareDim = Math.min width, height

      if width > height
        aContext.translate (width-squareDim)/2,0
      else
        aContext.translate 0,(height-squareDim)/2

      squareSize = 200
      aContext.scale squareDim/squareSize, squareDim/squareSize

      ## at this point, you draw in a squareSize x squareSize
      ## canvas, and it gets painted in a square that fits
      ## the morph, right in the middle.
      @drawingIconInSquare aContext

      aContext.restore()
      @paintHighlight aContext, al, at, w, h

  oval = (context, x, y, w, h) ->
    context.save()
    context.beginPath()
    context.translate x, y
    context.scale w / 2, h / 2
    context.arc 1, 1, 1, 0, 2 * Math.PI, false
    context.closePath()
    context.restore()
    return

  arc = (context, x, y, w, h, startAngle, endAngle, isClosed) ->
    context.save()
    context.beginPath()
    context.translate x, y
    context.scale w / 2, h / 2
    context.arc 1, 1, 1, Math.PI / 180 * startAngle, Math.PI / 180 * endAngle, false
    if isClosed
      context.lineTo 1, 1
      context.closePath()
    context.restore()
    return

  drawingIconInSquare: (context) ->
      #// Color Declarations
      color2 = 'rgba(0, 0, 0, 1)'
      #// Oval Drawing
      arc context, 101.5, 46.5, 77, 77, 193, 259, false
      context.strokeStyle = color2
      context.lineWidth = 3
      context.stroke()
      #// Oval 2 Drawing
      arc context, 25.5, 46.5, 77, 77, 281, 347, false
      context.strokeStyle = color2
      context.lineWidth = 3
      context.stroke()
      #// Oval 3 Drawing
      arc context, 71.5, 16.5, 62, 62, 357, 183, false
      context.strokeStyle = color2
      context.lineWidth = 3
      context.stroke()
      #// Bezier Drawing
      context.beginPath()
      context.moveTo 101.5, 73.5
      context.lineTo 101.5, 110.5
      context.strokeStyle = color2
      context.lineWidth = 3
      context.stroke()
      #// Bezier 2 Drawing
      context.beginPath()
      context.moveTo 48.5, 108.5
      context.lineTo 154.5, 108.5
      context.lineCap = 'round'
      context.strokeStyle = color2
      context.lineWidth = 4
      context.stroke()
      #// Bezier 3 Drawing
      context.beginPath()
      context.moveTo 47.5, 108.5
      context.lineTo 54.5, 133.5
      context.lineTo 150.5, 133.5
      context.lineTo 154.5, 109.5
      context.lineCap = 'round'
      context.strokeStyle = color2
      context.lineWidth = 4
      context.stroke()
      #// Bezier 4 Drawing
      context.beginPath()
      context.moveTo 57, 134
      context.lineTo 74, 192
      context.lineTo 132, 192
      context.lineTo 147, 133
      context.strokeStyle = color2
      context.lineWidth = 4
      context.stroke()
      #// Oval 4 Drawing
      oval context, 99, 7, 4, 4
      context.fillStyle = color2
      context.fill()
      #// Oval 5 Drawing
      oval context, 86, 19, 4, 4
      context.fillStyle = color2
      context.fill()
      #// Oval 6 Drawing
      oval context, 86, 32, 4, 4
      context.fillStyle = color2
      context.fill()
      #// Oval 7 Drawing
      oval context, 99, 19, 4, 4
      context.fillStyle = color2
      context.fill()
      #// Oval 8 Drawing
      oval context, 112, 19, 4, 4
      context.fillStyle = color2
      context.fill()
      #// Oval 9 Drawing
      oval context, 99, 32, 4, 4
      context.fillStyle = color2
      context.fill()
      #// Oval 10 Drawing
      oval context, 112, 32, 4, 4
      context.fillStyle = color2
      context.fill()
      #// Oval 11 Drawing
      oval context, 99, 44, 4, 4
      context.fillStyle = color2
      context.fill()