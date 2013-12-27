'use strict';

class Ocupado.Views.ChromeView extends Backbone.View

  el: '#OcupadoChrome'
  template: Ocupado.Templates['app/scripts/templates/chrome.hbs']

  initialize: ->
    @render()
    Ocupado.on 'ocupado:auth:success', =>
      @$el.show()
      @$el.on 'click', '#calendarMenuBtn', @onMenuClick

  render: ->
    @$el.html @template()

  onMenuClick: (e) =>
    e.preventDefault()
    if !@modal?
      @modal = new Ocupado.Views.CalendarSelectionModalView()
      @modal.parentView = this
      @$el.append @modal.el
    else
      @modal.close()

