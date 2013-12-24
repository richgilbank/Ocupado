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
    relatedModel: Ocupado.Models.EventModel
    collectionType: Ocupado.Collections.EventsCollection
    includeInJSON: true
    reverseRelation:
      key: 'room'
  ]

  initialize: ->
    @fetch()

    # Refetch every 10 minutes
    setInterval =>
      @fetch()
    , 10 * 60 * 1000
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
    # Sets the room name
    @set 'name', resp.summary

    if resp.items?.length > 0
      @createEventModelFromEvent(resp.items[0])
      if resp.items.length > 1
        @createEventModelFromEvent(resp.items[1])

    @trigger 'change'

  createEventModelFromEvent: (event) ->
    new Ocupado.Models.EventModel
      startDate: Date.parse(event.start.dateTime)
      endDate: Date.parse(event.end.dateTime)
      creatorName: event.creator.displayName
      creatorEmail: event.creator.email
      name: event.summary
      room: this

  isOccupied: ->
    @get('events').isOccupied()

  isUpcoming: ->
    @get('events').isUpcoming()

  isVacant: ->
    @get('events').isVacant()

