'use strict';

class Ocupado.Views.CalendarSelectionModalView extends Backbone.View

  template: Ocupado.Templates['app/scripts/templates/calendarSelectionModal.hbs']

  initialize: ->
    @render()
    @animateModalEntering()

    @$el.find('input[type="checkbox"]').on 'change', @onCheckboxChange
    # console.log @$el.find('.checkbox-group').get(0)
    cb = @updateSortOrder
    new Sortable @$el.find('.checkbox-group').get(0),
      handle: '.draggable-handle'
      onUpdate: (e) =>
        @updateSortOrder(e)
    @$el.on 'click', '.close-modal', @close

  render: ->
    @$el.html @template({cals:Ocupado.calendars.toJSON()})

    @overlay = @$el.find('.modal-overlay')
    @modal = @$el.find('.modal')

    @

  animateModalEntering: ->
    setTimeout =>
      @overlay.addClass 'active'
      @overlay.one 'webkitTransitionEnd transitionend', =>
        @modal.addClass 'active'
    , 10

  close: =>
    @modal.removeClass 'active'
    @modal.one 'webkitTransitionEnd transitionend', =>
      @overlay.removeClass 'active'
      @overlay.one 'webkitTransitionEnd transitionend', =>
        @parentView.modal = null
        @remove()
        @unbind()

  updateSortOrder: (e) ->
    sorted = _.map @$el.find('input[type="checkbox"]:checked'), (e) ->
      $(e).data('resourceid')
    Ocupado.calendars.setSelectedResources(sorted)
    Ocupado.roomsView.collection.reset()
    Ocupado.roomsView.collection.setupModels()

  onCheckboxChange: (e) =>
    selectedArray = []
    @$el.find('input[type="checkbox"]').each (ch) ->
      if $(this).is(':checked')
        selectedArray.push $(this).data('resourceid')
        $(this).closest('label').removeClass 'inactive'
      else
        $(this).closest('label').addClass 'inactive'
    Ocupado.calendars.setSelectedResources selectedArray
    Ocupado.roomsView.collection.reset()
    Ocupado.roomsView.collection.setupModels()

