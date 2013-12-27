'use strict';

class Ocupado.Models.CalendarModel extends Backbone.Model

  initialize: ->
    @set 'isSelected', @get('resourceId') in @collection.getSelectedResources()

  isSelected: ->
    @get('resourceId') in @collection.getSelectedResources()

