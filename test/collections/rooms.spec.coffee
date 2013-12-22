# global describe, beforeEach, assert, it
"use strict"

describe 'Rooms Collection', ->
  beforeEach ->
    @Rooms = new Ocupado.Collections.RoomsCollection()
