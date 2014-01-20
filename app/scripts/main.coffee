window.deviceReady = $.Deferred()

document.addEventListener 'deviceready', ->
  deviceReady.resolve()

window.Ocupado = _.extend
  env: if _ENV? then _ENV else 'development'
  config:
    clientId: '65475530667-fliq4pdj73bdk1tenuq59dak5v2isic5.apps.googleusercontent.com'
    clientSecret: 'RUHUSETB3IONIzns_zGwCNVf'
    redirectUri: 'http://localhost'
    webClientId: '65475530667.apps.googleusercontent.com'
    webApiKey: 'AIzaSyDlo7Z2IJ7Ilbo0PoerU6b0dMNLEsyS-DA'
    scope: 'https://www.googleapis.com/auth/calendar'

  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    'use strict'
    Ocupado.calendars = new Ocupado.Collections.CalendarCollection()
    Ocupado.roomsView = new Ocupado.Views.RoomsView
      collection: new Ocupado.Collections.RoomsCollection()
    Ocupado.chromeView = new Ocupado.Views.ChromeView()
    window.addEventListener 'load', ->
      FastClick.attach(document.body)

, Backbone.Events


if Ocupado.env is 'production'
  $ ->
    $.when(clientLoaded.promise(), deviceReady.promise(), calendarApiLoaded.promise()).then(Ocupado.init)
else
  $ ->
    $.when(clientLoaded.promise()).then ->
    $.when(calendarApiLoaded.promise()).then ->
    $.when(clientLoaded.promise(), calendarApiLoaded.promise()).then(Ocupado.init)

