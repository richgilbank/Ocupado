'use strict';

class Ocupado.Views.RoomsView extends Backbone.View

    el: '#OcupadoApp'
    template: JST['app/scripts/templates/rooms.hbs']

    initialize: ->
      @render()

    render: ->
      @$el.html @template
        foo: 'bar'
      @
