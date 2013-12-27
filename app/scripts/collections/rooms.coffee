'use strict';

class Ocupado.Collections.RoomsCollection extends Backbone.Collection
  model: Ocupado.Models.RoomModel

  initialize: ->
    Ocupado.on 'ocupado:auth:calendarloaded', =>
      @initCalendarResources()

  initCalendarResources: ->
    $.when(Ocupado.calendars.deferredFetch).then =>
      @setupModels()

  setupModels: ->
    _.each Ocupado.calendars.getSelectedCalendars(), (calendar) =>
      @add
        calendarId: calendar.get('resourceId')

