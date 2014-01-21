'use strict';

class Ocupado.Models.RoomModel extends Backbone.RelationalModel

  defaults:
    state: 'vacant'
    current: false
    upcoming: false
    calendarId: false
    name: false

  relations: [
    type: Backbone.HasMany
    key: 'events'
    relatedModel: 'Ocupado.Models.EventModel'
    collectionType: 'Ocupado.Collections.EventsCollection'
    includeInJSON: true
    reverseRelation:
      key: 'room'
  ]

  initialize: ->
    unless @get('unAuthenticated')
      @fetch()
      @collection.on 'fetchAll', @fetch, @

    # Refetch every 2 minutes
    setInterval =>
      @fetch.call(this)
    , 2 * 60 * 1000
    @

  fetch: (options) ->
    maxTime     = (new Date()).addHours(3)
    minTime     = new Date()
    request = gapi.client.calendar.events.list
      calendarId  : @get 'calendarId'
      timeMax     : ISODateString(maxTime)
      timeMin     : ISODateString(minTime)
      orderBy     : 'startTime'
      singleEvents: true
      timeZone    : 'America/Toronto'

    request.execute @fetchResponse

  fetchResponse: (resp) =>
    @get('events').each (e) =>
      @get('events').remove(e)
    @set 'name', resp.summary unless @get('name').length

    if resp.items?.length > 0
      @createEventModelFromEvent(resp.items[0])
      if resp.items.length > 1
        @createEventModelFromEvent(resp.items[1])

    @trigger 'update'

  createEventModelFromEvent: (event) ->
    new Ocupado.Models.EventModel
      startDate: Date.parse(event.start.dateTime)
      endDate: Date.parse(event.end.dateTime)
      creatorName: event.creator.displayName
      creatorEmail: event.creator.email
      name: event.summary
      room: this

  isOccupied: ->
    return false unless @hasEvents()
    @get('events').isOccupied()

  isUpcoming: ->
    return false unless @hasEvents()
    @get('events').isUpcoming() and !@isOccupied()

  isVacant: ->
    return true unless @hasEvents()
    @get('events').isVacant() and !@isOccupied() and !@isUpcoming()

  hasEvents: ->
    !!@get('events').length

  percentComplete: ->
    if @isOccupied()
      e = @get('events').sort().first()
      ((Date.now() - e.get('startDate')) / (e.get('endDate') - e.get('startDate'))) * 100
    else
      100

