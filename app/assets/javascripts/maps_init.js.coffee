jQuery ($) ->
  mapEl = $ '#googlemap'
  mapEl.height mapEl.width()
  map = new google.maps.Map mapEl[0],
    zoom: 16
    navigationControl: true
    navigationControlOptions:
      position: google.maps.ControlPosition.RIGHT
    center: new google.maps.LatLng 51.19, 6.795
    mapTypeId: google.maps.MapTypeId.ROADMAP
    draggableCursor: 'crosshair'
    draggingCursor: 'crosshair'
