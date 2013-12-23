window.ISODateString= (d) ->
  pad= (n) ->
    if n < 10 then '0'+n else n
  retval = d.getUTCFullYear() + '-' + pad(d.getUTCMonth()+1)+'-' + pad(d.getUTCDate())+'T' + pad(d.getUTCHours())+':' + pad(d.getUTCMinutes())+':' + pad(d.getUTCSeconds())+'Z'
  retval

window.toReadableTime = (t) ->
  hours   = Math.floor t / 1000 / 60 / 60
  minutes = Math.floor t / 1000 / 60 - (hours * 60)
  seconds = Math.floor (t / 1000) - (minutes * 60) - (hours * 60 * 60)
  hours   = "0" + hours if hours < 10
  minutes = "0" + minutes if minutes < 10
  seconds = "0" + seconds if seconds < 10
  if hours >= 0 and minutes >= 0 and seconds >= 0
    "#{hours}:#{minutes}:#{seconds}"
  else
    "00:00:00"

Date.prototype.addHours= (h) ->
  @setHours this.getHours() + h
  this

