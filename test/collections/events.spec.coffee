# global describe, beforeEach, assert, it
"use strict"

describe 'Events Collection', ->

  beforeEach ->
    @RoomModel = new Ocupado.Models.RoomModel(Fixtures.Room)
    @occupiedCollection = new Ocupado.Collections.EventsCollection([Fixtures.OccurringEvent(@RoomModel)])
    @upcomingCollection = new Ocupado.Collections.EventsCollection([Fixtures.UpcomingEvent(@RoomModel)])
    @vacantCollection = new Ocupado.Collections.EventsCollection()
    @multipleCollection = new Ocupado.Collections.EventsCollection([Fixtures.UpcomingEvent(@RoomModel), Fixtures.OccurringEvent(@RoomModel)])


  it 'should return an array of events when occupied', ->
    assert.ok @occupiedCollection.whereOccupied().length, 'collection status is occupied'
    assert.notOk @occupiedCollection.whereUpcoming().length, 'collection status is not upcoming'
    assert.isArray @occupiedCollection.whereOccupied(), 'collection returns an array'

  it 'should return an array of upcoming events', ->
    assert.ok @upcomingCollection.whereUpcoming().length, 'collection status is upcoming'
    assert.notOk @upcomingCollection.whereOccupied().length, 'collection status is not Occupied'
    assert.isArray @upcomingCollection.whereUpcoming(), 'collection returns an array'

  it 'should return booleans for isOccupied/isUpcoming/isVacant', ->
    assert.isTrue @occupiedCollection.isOccupied(), 'bool:occupied collection is occupied'
    assert.isFalse @occupiedCollection.isUpcoming(), 'bool:occupied collection is not upcoming'

    assert.isTrue @upcomingCollection.isUpcoming(), 'bool:upcoming collection is upcoming'
    assert.isFalse @upcomingCollection.isOccupied(), 'bool:upcoming collection is not occupied'

    assert.isTrue @vacantCollection.isVacant(), 'bool:vacant collection is vacant'
    assert.isFalse @occupiedCollection.isVacant(), 'bool:occupied collection is not vacant'
    assert.isFalse @upcomingCollection.isVacant(), 'bool:upcoming collection is not vacant'

  it 'should sort by event startDate', ->
    assert.strictEqual @multipleCollection.first().get('name'), 'Event 01', 'the first date is first'

