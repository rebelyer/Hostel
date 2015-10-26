ready = ->
   $('#curent-language').addClass("flag-" + lang)
   $("#" + lang).toggle()

$(document).ready(ready)
$(document).on('page:load', ready)
