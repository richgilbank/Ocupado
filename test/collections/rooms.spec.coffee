# global describe, beforeEach, assert, it
"use strict"

describe 'Rooms Collection', ->

  beforeEach ->
    @Rooms = new Ocupado.Collections.RoomsCollection [],
      unAuthenticated: true
    # Stub out localstorage accessor
    Ocupado.calendars = {}
    Ocupado.calendars.getSelectedResources = ->
      [Fixtures.Calendars.ca, Fixtures.Calendars.us]

  it 'should sort calendars by the order in localstorage', ->
    # Add rooms in reverse order to what localstorage would serve
    @Rooms.add [
        calendarId: Fixtures.Calendars.us
        unAuthenticated: true
      ,
        calendarId: Fixtures.Calendars.ca
        unAuthenticated: true
      ]
    assert.deepEqual @Rooms.pluck('calendarId'), [
      Fixtures.Calendars.ca
      Fixtures.Calendars.us
    ], 'comparator sorted calendars correctly'

