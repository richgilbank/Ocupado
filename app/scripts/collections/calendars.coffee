'use strict';

class Ocupado.Collections.CalendarCollection extends Backbone.Collection
  model: Ocupado.Models.CalendarModel

  initialize: ->
    @deferredFetch = $.Deferred()
    Ocupado.on 'ocupado:auth:calendarloaded', =>
      @fetch(@deferredFetch).then (filtered) =>
        _.each filtered, (cal) =>
          @add
            color: cal.backgroundColor
            resourceId: cal.id
            name: cal.summary
        @setSelectedResources(_.pluck(filtered, 'id')) unless @getSelectedResources().length

  comparator: (model) ->
    Ocupado.calendars.getSelectedResources().indexOf model.get('resourceId')

  fetch: (deferred) ->
    request = gapi.client.calendar.calendarList.list({})
    request.execute (calendars) =>
      filtered = _.filter calendars.items, (calendar) ->
        /@(resource|group)\.calendar\.google\.com$/.test calendar.id
      deferred.resolve(filtered)
    deferred.promise()

  getSelectedResources: ->
    if localStorage['ocupado.selectedResources']?
      JSON.parse(localStorage.getItem('ocupado.selectedResources'))
    else
      []

  setSelectedResources: (resources) ->
    localStorage.setItem('ocupado.selectedResources', JSON.stringify(resources))
    @each (cal) => cal.set('isSelected', cal.isSelected())

  getSelectedCalendars: ->
    @sort().filter (cal) =>
      cal.get('resourceId') in @getSelectedResources()

