'use strict';

class Ocupado.Views.RoomsView extends Backbone.View

  el: '#OcupadoApp'

  initialize: ->
    @listenTo @collection, 'add', @addRoom
    @listenTo @collection, 'reset', @resetRooms
    @render()

  addRoom: (room) ->
    roomView = new Ocupado.Views.RoomView
      model: room
    @$el.append roomView.render().el

  resetRooms: (rooms) ->
    @collection.each @addRoom, @

