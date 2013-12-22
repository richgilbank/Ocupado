window.Ocupado = _.extend
  config:
    calendars: [
      'jadedpixel.com_2d3634393534363336363336@resource.calendar.google.com'
      'jadedpixel.com_2d31303036393830392d323936@resource.calendar.google.com'
      'jadedpixel.com_3638353439323134363137@resource.calendar.google.com'
    ]
    clientId: '321483337091-g67inrrnnh8iogsmg47eqr0g1jn6ghn5.apps.googleusercontent.com'
    apiKey: 'AIzaSyANnPunTVZ0BIbN8LkTVRTF0meMcOqMY_g'
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
