'use strict';

class Ocupado.Models.EventModel extends Backbone.RelationalModel

  timeRemaining: false
  intervalRef: false

  isOccurring: ->
    @get('startDate') <= Date.now() <= @get('endDate')

  isUpcoming: ->
    @get('startDate') <= (new Date()).addHours(1).getTime()

  initialize: ->
    @on 'event:start', @eventStart, this
    @on 'event:end', @eventEnd, this

    if @isOccurring()
      @trigger 'event:start'
    else if @isUpcoming()
      setTimeout =>
        @trigger 'event:start'
      , @get('startDate') - Date.now()

  eventStart: ->
    # Fire the event:end event once the time remaining ends
    remaining = @get('endDate') - Date.now()
    setTimeout =>
      @trigger 'event:end'
    , remaining

    # Set interval to update time remaining
    @intervalRef = setInterval =>
      @timeRemaining = @get('endDate') - Date.now()
    , 50
    @get('room').trigger('change')

  eventEnd: ->
    clearInterval @intervalRef
    thisRoom = @get('room')
    @collection.remove(this)
    thisRoom.trigger('change')

