'use strict';

class Ocupado.Views.RoomsView extends Backbone.View

  el: '#OcupadoApp'
  template: Ocupado.Templates['app/scripts/templates/rooms.hbs']

  initialize: ->
    @listenTo @collection, 'add', @addRoom
    @listenTo @collection, 'reset', @resetRooms

    Handlebars.registerPartial('occupied', Ocupado.Templates.occupied)
    Handlebars.registerPartial('upcoming', Ocupado.Templates.upcoming)
    Handlebars.registerPartial('vacant', Ocupado.Templates.vacant)

  addRoom: (room) ->
    roomView = new Ocupado.Views.RoomView
      model: room
      parentView: this
    @$el.append roomView.render().el

  resetRooms: (rooms) ->
    @$el.html('')
    @collection.each @addRoom, @

