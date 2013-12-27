'use strict';

class Ocupado.Collections.CalendarCollection extends Backbone.Collection
  model: Ocupado.Models.CalendarModel

  initialize: ->
    @deferredFetch = $.Deferred()
    Ocupado.on 'ocupado:auth:calendarloaded', =>
      @fetch(@deferredFetch).then (filtered) =>
        @setSelectedResources _.map(filtered, (cal) -> cal.id)
        _.each filtered, (cal) =>
          @add
            color: cal.backgroundColor
            resourceId: cal.id
            name: cal.summary
        @getSelectedResources()

  comparator: (model) ->
    Ocupado.calendars.getSelectedResources().indexOf model.get('resourceId')

  fetch: (deferred) ->
    request = gapi.client.calendar.calendarList.list({})
    request.execute (calendars) =>
      filtered = _.filter calendars.items, (calendar) ->
        /resource\.calendar\.google\.com/.test calendar.id
      deferred.resolve(filtered)
    deferred.promise()

  getSelectedResources: ->
    if not localStorage.getItem('ocupado.selectedResources')?
      resourceIds = JSON.stringify(@pluck('resourceId'))
      localStorage.setItem('ocupado.selectedResources', resourceIds) if resourceIds.length
      resourceIds
    else if localStorage['ocupado.selectedResources']?
      JSON.parse(localStorage.getItem('ocupado.selectedResources'))

  setSelectedResources: (resources) ->
    localStorage.setItem('ocupado.selectedResources', JSON.stringify(resources))
    @each (cal) => cal.set('isSelected', cal.isSelected())

  getSelectedCalendars: ->
    @sort().filter (cal) =>
      cal.get('resourceId') in @getSelectedResources()

