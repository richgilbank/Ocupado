'use strict';

class Ocupado.Views.RoomView extends Backbone.View

  template: Ocupado.Templates['app/scripts/templates/room.hbs']

  initialize: ->
    @listenTo @model, 'change', @render
    @listenTo @model, 'event:end', @render
    @render()

  render: ->
    @$el.html @template(@model.toJSON())
    @$el.prop('class', '')
    if @model.isOccupied()
      @$el.addClass('occupied')
    else if @model.isUpcoming()
      @$el.addClass('upcoming')
    else
      @$el.addClass('vacant')
    @

