'use strict';

class Ocupado.Views.RoomView extends Backbone.View

  template: Ocupado.Templates['app/scripts/templates/room.hbs']

  tagName: 'section'

  initialize: ->
    @listenTo @model, 'change', @render
    @listenTo @model, 'change', @clearPolarClock
    @render()
    setInterval =>
      @partialRender()
      @renderPolarClock()
    , 1000

  partialRender: ->
    @$el.find('.time-remaining').text(@timeRemaining())
    @renderPolarClock()

  render: ->
    @$el.html @template(@templateData())
    @$el.prop('class', '')
    if @model.isOccupied()
      @$el.addClass('occupied')
    else if @model.isUpcoming()
      @$el.addClass('upcoming')
    else
      @$el.addClass('vacant')
    @

  templateData: ->
    occupied: @model.isOccupied()
    upcoming: @model.isUpcoming()
    vacant: @model.isVacant()
    timeRemaining: do => @timeRemaining()
    name: @model.get('name')
    event: @model.get('events').first().toJSON() if not @model.isVacant()

  timeRemaining: ->
    unless @model.isVacant()
      remaining = @model.get('events').first().timeRemaining
      toReadableTime(remaining)
    else
      '00:00:00'

  initializeRaphael: ->
    @canvasContainer = $("#canvas#{@model.get('name')}")
    @maxRadius = _.min([@canvasContainer.width(), @canvasContainer.height()])/2 - 7
    @arcPos = @maxRadius + 8
    @paper = Raphael(
      "canvas#{@model.get('name')}",
      @maxRadius*2 + 15,
      @maxRadius*2 + 15
    )
    @paper.customAttributes.arc = RaphaelArc

    bgColor = "#7e9c3d" if @model.isVacant()
    bgColor = "#d5b430" if @model.isUpcoming()
    bgColor = "#a03a3a" if @model.isOccupied()

    @bgarc = @paper.path().attr
      "stroke": bgColor
      "stroke-width": 15
      arc: [@arcPos, @arcPos, 100, 100, @maxRadius]

    if @model.isOccupied()
      @arc = @paper.path().attr
        "stroke": "#f00"
        "stroke-width": 15
        arc: [@arcPos, @arcPos, 0, 100, @maxRadius]

  renderPolarClock: ->
    if !@paper?
      @initializeRaphael()

    if @model.isOccupied()
      @arc.attr
        arc: [@arcPos, @arcPos, @model.percentComplete(), 100, @maxRadius]

  clearPolarClock: ->
    @paper = undefined

