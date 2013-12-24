'use strict';

class Ocupado.Collections.EventsCollection extends Backbone.Collection
  model: Ocupado.Models.EventModel

  isOccupied: ->
    @whereOccupied().length

  isUpcoming: ->
    @whereUpcoming().length

  isVacant: ->
    !@isOccupied() and !@isUpcoming()

  whereOccupied: ->
    @filter (event) -> event.isOccurring()

  whereUpcoming: ->
    @filter (event) -> event.isUpcoming()
