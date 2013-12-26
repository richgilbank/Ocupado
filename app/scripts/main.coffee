window.Ocupado = _.extend
  config:
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
