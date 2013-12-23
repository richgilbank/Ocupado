window.Ocupado = _.extend
  config:
    calendars: [
      'jadedpixel.com_2d3634393534363336363336@resource.calendar.google.com'
      'jadedpixel.com_2d31303036393830392d323936@resource.calendar.google.com'
      'jadedpixel.com_3638353439323134363137@resource.calendar.google.com'
    ]
    clientId: '65475530667.apps.googleusercontent.com'
    apiKey: 'AIzaSyD8ZlE3oF6jOelOFr56heE8FC6Sk3UkiVo'
    scopes: [
      'https://www.googleapis.com/auth/calendar.readonly'
    ]

  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    'use strict'
    new @Views.RoomsView
      collection: new @Collections.RoomsCollection()

, Backbone.Events


$ ->
  'use strict'
  Ocupado.init();
