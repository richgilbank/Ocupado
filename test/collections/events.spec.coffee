# global describe, beforeEach, assert, it
"use strict"

describe 'Events Collection', ->
  beforeEach ->
    @Events = new Ocupado.Collections.EventsCollection()
