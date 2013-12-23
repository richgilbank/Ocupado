'use strict';

class Ocupado.Collections.EventsCollection extends Backbone.Collection
  model: Ocupado.Models.EventModel

  whereOccupied: ->
    @filter (event) ->
      event.isOccurring()

  whereUpcoming: ->
    @filter (event) ->
      event.isUpcoming()
