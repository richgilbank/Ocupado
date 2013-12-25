'use strict';

class Ocupado.Views.RoomView extends Backbone.View

  template: Ocupado.Templates['app/scripts/templates/room.hbs']

  tagName: 'section'

  initialize: ->
    @listenTo @model, 'update', @render
    @render()
    setInterval =>
      # @render()
      @partialRender()
    , 1000

  partialRender: ->
    @$el.find('.time-remaining').text(@timeRemaining())
    @renderPolarClock()

  render: ->
    @clearPolarClock()
    @$el.html @template(@templateData())
    @$el.prop('class', '')
    if @model.isOccupied()
      @$el.addClass('occupied')
    else if @model.isUpcoming()
      @$el.addClass('upcoming')
    else
      @$el.addClass('vacant')
    @renderPolarClock()
    @positionRoomStatus()
    @

  templateData: ->
    occupied: @model.isOccupied()
    upcoming: @model.isUpcoming()
    vacant: @model.isVacant()
    timeRemaining: do => @timeRemaining()
    name: @model.get('name')
    event: @model.get('events').sort().first().toJSON() if not @model.isVacant()

  timeRemaining: ->
    unless @model.isVacant()
      remaining = @model.get('events').sort().first().timeRemaining
      toReadableTime(remaining)
    else
      '00:00:00'

  initializeRaphael: ->
    if $("#canvas#{@model.get('name')}").length
      @canvasContainer = $("#canvas#{@model.get('name')}")
      @maxRadius = _.min([@canvasContainer.width(), @canvasContainer.height()])/2 - 7
      @arcPosX = @canvasContainer.width()/2
      @arcPosY = @maxRadius + 8
      @paper = Raphael(
        "canvas#{@model.get('name')}",
        @canvasContainer.width(),
        @canvasContainer.height()
      )
      @paper.customAttributes.arc = RaphaelArc

      bgColor = "#7e9c3d" if @model.isVacant()
      bgColor = "#d5b430" if @model.isUpcoming()
      bgColor = "#a03a3a" if @model.isOccupied()

      @bgarc = @paper.path().attr
        "stroke": bgColor
        "stroke-width": 15
        arc: [@arcPosX, @arcPosY, 100, 100, @maxRadius]

      # if @model.isOccupied()
      @arc = @paper.path().attr
        "stroke": "#fff"
        "stroke-width": 15
        arc: [@arcPosX, @arcPosY, 0, 100, @maxRadius]

  renderPolarClock: ->
    unless @paper?
      @initializeRaphael()

    if @paper? and @model.isOccupied()
      @arc.attr
        arc: [@arcPosX, @arcPosY, @model.percentComplete(), 100, @maxRadius]

  clearPolarClock: ->
    @paper = null

  positionRoomStatus: ->
    w = $("#canvas#{@model.get('name')}").width()
    @$el.find('.room-status-text').css
      top: (w / 2 + 40) + 'px'

