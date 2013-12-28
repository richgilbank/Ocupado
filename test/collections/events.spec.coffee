# global describe, beforeEach, assert, it
"use strict"

describe 'Events Collection', ->
  beforeEach ->
    @Events = new Ocupado.Collections.EventsCollection()

  it 'Should be a first test for eventscollections', ->
    assert.equal 'foo', 'foo'
