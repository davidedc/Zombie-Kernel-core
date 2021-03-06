class ModifiedTextTriangleAnnotationWdgt extends Widget

  @augmentWith CornerInternalHaloMixin, @name
  positionWithinParent: "topLeft"

  constructor: (parent = nil, @layoutSpec_cornerInternal_proportionOfParent = 0, @layoutSpec_cornerInternal_fixedSize = 10) ->
    super()
    @appearance = new UpperRightTriangleAppearance @, @positionWithinParent

    # this morph has triangular shape and we want it
    # to only react to pointer events happening
    # within tha shape
    @noticesTransparentClick = false

    size = WorldMorph.preferencesAndSettings.handleSize
    @silentRawSetExtent new Point size, size
    parent?.add @, nil, LayoutSpec.ATTACHEDAS_CORNER_INTERNAL_TOPLEFT
