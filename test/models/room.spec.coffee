# global describe, beforeEach, assert, it
"use strict"

describe 'Room Model', ->

  beforeEach ->
    @RoomModel = new Ocupado.Models.RoomModel(Fixtures.Room)

  it 'should create a relation to an events collection', ->
    assert.equal @RoomModel.getRelation('events').key, 'events', 'Has a relation to an events collection'
    assert.equal @RoomModel.getRelation('events').collectionType, Ocupado.Collections.EventsCollection, 'Collection is an instance of Ocupado.Collections.EventsCollection'

  it 'should have child models with relations back to this room', ->
    assert.deepEqual @RoomModel.get('events').room, @RoomModel, 'has child models with relations to this room'

  it "should match it's collection's isOccupied/isUpcoming/isVacant methods", ->
    assert.isTrue @RoomModel.isVacant(), 'room is vacant when no events exist'
    assert.isFalse @RoomModel.hasEvents(), 'room has no events'

    @upcomingCollection = new Ocupado.Collections.EventsCollection([Fixtures.UpcomingEvent(@RoomModel)])
    assert.isTrue @RoomModel.isUpcoming(), 'room is upcoming when it has upcoming events'
    assert.isFalse @RoomModel.isVacant(), 'room is not vacant when there are upcoming events'

    @occupiedCollection = new Ocupado.Collections.EventsCollection([Fixtures.OccurringEvent(@RoomModel)])
    assert.isTrue @RoomModel.isOccupied(), 'room is occupied when it has occurring events'
    assert.isFalse @RoomModel.isVacant(), 'room is not vacant when there are occurring events'
    assert.isFalse @RoomModel.isUpcoming(), 'room is not upcoming when there are occurring events'

  it 'should calculate the correct percentage complete of the occurring event', ->
    new Ocupado.Collections.EventsCollection([Fixtures.OccurringEvent(@RoomModel)])
    event = @RoomModel.get('events').first()

    event.set('startDate', Date.now())
    event.set('endDate', (new Date()).addHours(1))
    assert.equal Math.round(@RoomModel.percentComplete()), 0

    event.set('startDate', (new Date()).subtractHours(1))
    event.set('endDate', Date.now())
    assert.equal Math.round(@RoomModel.percentComplete()), 100

