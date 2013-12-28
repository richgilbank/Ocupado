'use strict';

class Ocupado.Views.RoomArcView extends Backbone.View

  initialize: ->
    @parentView = @options.parentView
    @strokeWidth = 15

  initializeRaphael: ->
    @el = @parentView.$el.find('.polar-clock').get(0)
    @$el = $(@el)
    if @$el?
      @maxRadius = _.min([@$el.width(), @$el.height()])/2 - 7
      @arcPosX = @$el.width()/2
      @arcPosY = @maxRadius + 8
      @paper = Raphael(
        @el,
        @$el.width(),
        @$el.height()
      )
      @paper.customAttributes.arc = RaphaelArc

      bgColor = "#7e9c3d" if @model.isVacant()
      bgColor = "#d5b430" if @model.isUpcoming()
      bgColor = "#a03a3a" if @model.isOccupied()

      @bgarc = @paper.path().attr
        "stroke": bgColor
        "stroke-width": @strokeWidth
        arc: [@arcPosX, @arcPosY, 100, 100, @maxRadius]

      @arc = @paper.path().attr
        "stroke": "#fff"
        "stroke-width": @strokeWidth
        arc: [@arcPosX, @arcPosY, 0, 100, @maxRadius]

  render: ->
    unless @paper?
      @initializeRaphael()

    if @paper? and @model.isOccupied()
      @arc.attr
        arc: [@arcPosX, @arcPosY, @model.percentComplete(), 100, @maxRadius]

  clearPolarClock: ->
    @paper = null

