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

  attributes: ->
    class: if @model.isOccupied() then 'occupied' else if @model.isUpcoming() then 'upcoming' else 'vacant'

  partialRender: ->
    @$el.find('.time-remaining').text(@timeRemaining())
    @resizeContainers()
    @roomArcView.clearPolarClock() if @roomArcView?
    @roomArcView.render()

  render: ->
    @roomArcView.clearPolarClock() if @roomArcView?
    @$el.html @template(@templateData())
    @$el.attr _.extend({}, _.result(this, 'attributes'))

    @resizeContainers()
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

  resizeContainers: ->
    w = @$el.width()

    if w < 340
      @$el.addClass 'small'
      @roomArcView.strokeWidth = 5 if @roomArcView?
    else
      @$el.removeClass 'small'
      @roomArcView.strokeWidth = 15 if @roomArcView?

    st = @$el.find('.room-status-text')
    p = st.siblings('.polar-clock')
    center = Math.min(p.width(), p.height())/2 - st.height()/2
    @$el.find('.room-status-text').css('top', "#{center}px")

