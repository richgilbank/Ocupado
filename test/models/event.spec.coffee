# global describe, beforeEach, assert, it
"use strict"

describe 'Event Model', ->
  beforeEach ->
    @Event = new Ocupado.Models.EventModel();
