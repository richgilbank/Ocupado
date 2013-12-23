'use strict';

class Ocupado.Collections.RoomsCollection extends Backbone.Collection
  model: Ocupado.Models.RoomModel

  initialize: ->
    Ocupado.on 'ocupado:auth:calendarloaded', =>
      @setupModels()

  setupModels: ->
    _.each Ocupado.config.calendars, (calendar) =>
      @add
        calendarId: calendar

