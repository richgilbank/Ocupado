'use strict';

class Ocupado.Models.EventModel extends Backbone.RelationalModel

  timeRemaining: false
  intervalRef: false

  isOccurring: ->
    @get('startDate') <= Date.now() <= @get('endDate')

  isUpcoming: ->
    inOneHour = (new Date()).addHours(1).getTime()
    @get('startDate') <= inOneHour and @get('startDate') > Date.now()

  initialize: ->
    @on 'event:start', @eventStart, this
    @on 'event:end', @eventEnd, this

    @set 'creatorImage', @creatorImagePath()

    if @isOccurring()
      @trigger 'event:start'
    else if @isUpcoming()
      @eventUpcoming()

  eventStart: ->
    # Fire the event:end event once the time remaining ends
    remaining = @get('endDate') - Date.now()
    setTimeout =>
      @trigger 'event:end'
    , remaining

    # Set interval to update time remaining
    clearInterval(@intervalRef) if @intervalRef
    @intervalRef = setInterval =>
      @timeRemaining = @get('endDate') - Date.now()
    , 50
    @get('room').trigger('update')

  eventUpcoming: ->
    # Fire 'event:start' when the time comes
    setTimeout =>
      @trigger 'event:start'
    , @get('startDate') - Date.now()

    # Set interval to update time remaining
    @intervalRef = setInterval =>
      @timeRemaining = @get('startDate') - Date.now()
    , 50

  eventEnd: ->
    clearInterval @intervalRef
    thisRoom = @get('room')
    @collection.remove(this)
    thisRoom.trigger('update')

  creatorImagePath: ->
    "http://www.gravatar.com/avatar/#{md5(@get('creatorEmail'))}?s=220"

