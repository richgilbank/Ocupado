'use strict';

class Ocupado.Views.RoomView extends Backbone.View

  template: Ocupado.Templates['app/scripts/templates/room.hbs']

  tagName: 'section'

  initialize: ->
    @listenTo @model, 'update', @render
    @render()
    _.defer =>
      @roomArcView = new Ocupado.Views.RoomArcView
        parentView: this
        model: @model

    setInterval =>
      @partialRender()
    , 1000

  partialRender: ->
    @$el.find('.time-remaining').text(@timeRemaining())
    @roomArcView.render()

  render: ->
    @roomArcView.clearPolarClock() if @roomArcView?

    @$el.html @template(@templateData())
    @$el.prop('class', '')
    if @model.isOccupied()
      @$el.addClass('occupied')
    else if @model.isUpcoming()
      @$el.addClass('upcoming')
    else
      @$el.addClass('vacant')

    @positionRoomStatus()

    @roomArcView.render() if @roomArcView?

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

  positionRoomStatus: ->
    w = $("#canvas#{@model.get('name')}").width()
    @$el.find('.room-status-text').css
      top: (w / 2 + 40) + 'px'

