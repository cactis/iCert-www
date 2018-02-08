//= require underscore

# () ->
#   $(document).foundation()

$(document).ready ->
  $('a').each ->
    if $(this).prop('href') == window.location.href
      $(this).addClass 'selected'
      return


window.log = (text, title) ->
  try
    console.log text
    console.log title if title
  catch
    window.console.log text
    window.console.log title if title