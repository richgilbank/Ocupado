'use strict';

class Ocupado.Views.RoomView extends Backbone.View

  template: Ocupado.Templates['app/scripts/templates/room.hbs']

  initialize: ->
    @listenTo @model, 'change', @render
    @render()

  render: ->
    @$el.html @template(@model.toJSON())
    @$el.prop('class', '')
    if @model.get 'current'
      @$el.addClass('occupied')
    else if @model.get 'upcoming'
      @$el.addClass('upcoming')
    @

