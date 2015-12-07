# RectangleMorph /////////////////////////////////////////////////////////
# a plain rectangular Morph. Because it's so basic, it's the building
# block of many more complex constructions, for example containers
# , clipping windows, and clipping windows which allow content to be
# scrolled (clipping is particularly easy to do along a rectangular
# path and it allows many optimisations and it's a very common case)
# It's important that the basic unadulterated version of
# rectangle doesn't draw a border, to keep this basic
# and versatile, so for example there is no case where the children
# are painted over the border, which would look bad.


class RectangleMorph extends Morph
  # this is so we can create objects from the object class name 
  # (for the deserialization process)
  namedClasses[@name] = @prototype

  constructor: (extent, color) ->
    super()
    @silentRawSetExtent(extent) if extent?
    @color = color if color?