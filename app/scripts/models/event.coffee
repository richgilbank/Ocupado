'use strict';

class Ocupado.Models.EventModel extends Backbone.RelationalModel

  isOccurring: ->
    if @get('startDate') <= (new Date()).getTime() <= @get('endDate') then true else false

  isUpcoming: ->
    if @get('startDate') <= (new Date()).addHours(1).getTime() <= @get('endDate') then true else false

  initialize: ->
    console.log @get('room').get('name'), @isOccurring(), @isUpcoming()
