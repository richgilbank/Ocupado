'use strict';

class Ocupado.Collections.RoomsCollection extends Backbone.Collection
  model: Ocupado.Models.RoomModel

  initialize: ->
    Ocupado.on 'ocupado:auth:calendarloaded', =>
      @initCalendarResources()

  initCalendarResources: ->
    if not getCalendarResources().length
      @fetchCalendarResources().then (calendars) =>
        setCalendarResources _.pluck(calendars, 'id')
        @setupModels()
    else
      @setupModels()

  setupModels: ->
    _.each getCalendarResources(), (calendar) =>
      @add
        calendarId: calendar

  fetchCalendarResources: () ->
    deferred = $.Deferred()
    request = gapi.client.calendar.calendarList.list({})
    request.execute (calendars) ->
      filtered = _.filter calendars.items, (calendar) ->
        /resource\.calendar\.google\.com/.test calendar.id
      deferred.resolve(filtered)
    deferred.promise()

