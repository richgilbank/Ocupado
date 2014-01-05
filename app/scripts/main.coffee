window.Ocupado = _.extend
  env: if _ENV? then _ENV else 'development'
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
    Ocupado.calendars = new @Collections.CalendarCollection()
    Ocupado.roomsView = new @Views.RoomsView
      collection: new @Collections.RoomsCollection()
    Ocupado.chromeView = new @Views.ChromeView()

, Backbone.Events


$ ->
  'use strict'
  Ocupado.init();
  window.addEventListener 'load', ->
    FastClick.attach(document.body)
