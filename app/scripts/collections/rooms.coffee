'use strict';

class Ocupado.Collections.RoomsCollection extends Backbone.Collection
  model: Ocupado.Models.RoomModel

  initialize: ->
    Ocupado.on 'ocupado:auth:calendarloaded', =>
      @initCalendarResources() unless @get('unAuthenticated')
    Ocupado.fetch = => @fetchAll()

  comparator: (model) ->
    Ocupado.calendars.getSelectedResources().indexOf model.get('calendarId')

  initCalendarResources: ->
    $.when(Ocupado.calendars.deferredFetch).then =>
      @setupModels()

  setupModels: ->
    _.each Ocupado.calendars.getSelectedCalendars().sort(), (calendar) =>
      @add
        calendarId: calendar.get('resourceId')

  fetchAll: ->
    @trigger 'fetchAll'

