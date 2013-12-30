# global describe, beforeEach, assert, it
"use strict"

describe 'Event Model', ->

  beforeEach ->
    @Room = new Ocupado.Models.RoomModel(Fixtures.Room)

  it 'should not appear as upcoming if it starts in > 1hr', ->
    event = new Ocupado.Models.EventModel Fixtures.FutureEvent(@Room)
    assert.isFalse event.isUpcoming(), 'event is not upcoming because it starts in 2 hrs'

  it 'should appear as occurring if it is occurring', ->
    event = new Ocupado.Models.EventModel Fixtures.OccurringEvent(@Room)
    assert.isTrue event.isOccurring(), 'event is occurring'

  it 'should appear as upcoming if it is upcoming', ->
    event = new Ocupado.Models.EventModel Fixtures.UpcomingEvent(@Room)
    assert.isTrue event.isUpcoming(), 'event is upcoming'

  it 'should trigger event:end when complete', (done) ->
    endingSoonAttrs = _.extend Fixtures.OccurringEvent(@Room),
     endDate: (new Date()).addMilliseconds(20)
    event = new Ocupado.Models.EventModel endingSoonAttrs
    event.on 'event:end', ->
      assert.isTrue true, 'event fired'
      done()

  it 'should trigger event:start when it begins', (done) ->
    upcomingAttrs = _.extend Fixtures.UpcomingEvent(@Room),
      startDate: (new Date()).addMilliseconds(20)
    event = new Ocupado.Models.EventModel upcomingAttrs
    event.on 'event:start', ->
      assert.isTrue true, 'event fired'
      done()

