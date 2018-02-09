selectedClass = 'selected'

selected = undefined
window.fonts = gon.fonts.names

$input = undefined

posX = 100
posY = 100
previewScale = 0.5

$('html').keydown (e) ->
  if (e.keyCode == 8 || e.keyCode == 46) && e.target.nodeName != "TEXTAREA"
    el = draw.select(".selected").first()
    deselectAll()
    el.remove()
    $input.val ""
    previewSVG()
    return false

$(document).ready ->

  bindSetTemplate()
  bindSaveBtn()
  bindClearBtn()

  w = 710
  h = 1000
  $('#input').css 'width', w - 10
  window.draw = SVG('editor').size(w, h)
  window.preview = SVG('preview').size(w / 2, h).scale(previewScale)

  reloadSVG draw, gon.template.data

  bindColumnAdd()
  bindExportBtn()

  bindFontsClick()
  # bindCustomColumn()

  $input = $('#input')
  bindInputChange()

bindInputChange = ->
  $input.keydown (e) ->
    return if !selected
    $.delay ->
      el = selected
      # log el, 'el'
      deselectAll()
      if selected.text != $input.val()
        selected.text $input.val()
        previewSVG()
        textSelected el

bindExportBtn = ->
  $('#exportBtn').click ->
    previewSVG()
    return false

reloadSVG = (draw, data) ->
  draw.svg data
  enableTextable draw.select('.text')
  previewSVG()

setPOS = (x, y) ->
  return
  if x < 100
    posX = x + 100
  else
    posX = x - 100
  if y < 100
    posY = y + 50
  else
    posY = y - 50

enableTextable = (texts) ->
  texts.addClass 'draggable'
  texts.draggable()
  texts.on 'dragend', (e) ->
    setPOS(e.detail.p.x, e.detail.p.y)
  # texts.select().resize()
  texts
  .on 'dragend', ->
    previewSVG()
  # .on 'dblclick', ->
  #   # log 'dblclick'
  #   return false
  .on 'click', (e) ->
    # return if e.detail == 2
    textSelected this
    e.stopPropagation()
  .on 'resizedone', (e) ->
    previewSVG()

textSelected = (text) ->
  deselectAll()
  selected = text
  selected.addClass selectedClass
  selected.selectize().resize()

  currentfont = selected.font().family
  # log currentfont, 'currentfont'
  index = fonts.indexOf(currentfont)
  selectFont index

  $input.val selected.text()
  # $input.focus()
  # log selected, 'selected'
  # previewSVG()
  # text.select({deepSelect: true})
  # text.resize()

selectFont = (index) ->
  $('.font').removeClass selectedClass
  $($('.font')[index]).addClass selectedClass

bindFontsClick = ->
  $('#fonts li').click ->
    index = $(this).index()
    # log index, 'index'
    selectFont index

    if selected
      currentfont = selected.font().family
      # log currentfont, 'currentfont'
      # nextfont = nextFont(currentfont)
      # log nextfont, 'nextfont'
      nextfont = fonts[index]
      # log nextfont, 'nextfont'
      selected.attr 'family', nextfont
      selected.attr 'font-family', nextfont
      previewSVG()
      textSelected selected

deselectAll = ->
  draw.select('.draggable')
    .removeClass selectedClass
    .selectize false
  # $('#input').val ""

window.previewSVG = ->
  deselectAll()
  svg = draw.svg()
  # log svg, 'svg'
  preview.svg svg
  ts = preview.select('.text')
  _.each ts.members, (text, index) ->
    express = text.text()
    _.each gon.cert_detail, (value, key) ->
      find = '#{' + key + '}'
      reg = new RegExp(find, 'g')
      express = express.replace reg, value
    if express.match(/.{1,22}/g)
      text.text express.match(/.{1,22}/g).join('\n')
    else
      text.text express

  canvas = document.getElementById('canvas')
  canvas.toDataURL('image/jpeg')
  canvg canvas, preview.svg()
  false

bindSetTemplate = ->
  $('#img-templates img').click ->
    bg = $(this).attr('src')
    toDataURL bg, (dataUrl) ->
      class_name = 'template'
      images = draw.select("." + class_name)
      if image = images.members[0]
        image.load bg
        previewSVG()
      else
        image = draw.image(bg)
        image.addClass class_name
        $.delay ->
          previewSVG()
        , 100, true


# bindCustomColumn = ->
#   $('#addCustomColumn').unbind().click ->
#     column = $('#input').val()
#     log column, 'column'
#     $('#fields').append "<li class='label column clickable'>#{column}</li>"
#     bindColumnAdd()
#     false

bindColumnAdd = ->
  # $('#editor').click ->
  #   deselectAll()

  $('.column').unbind().click ->
    content = $(this).html()
    if $(this).hasClass 'label'
      size = 50
    else
      size = 18
      content = "\#{#{content}}"
    text = draw.text content
    text.attr
      class: 'text'
    .font
      family: fonts[0]
      size: size
      x: posX
      y: posY
    setPOS(posX, posY)
    enableTextable text
    previewSVG()
    textSelected text
    # saveTemplate()
    false
  # .click (e) ->
  #   return if e.detail == 2
  #   content = $(this).html()
  #   if $(this).hasClass 'label'
  #   else
  #     content = "\#{#{content}}"
  #   $('#input').val $('#input').val() + content

bindSaveBtn = ->
  $("#saveBtn").click ->
    saveTemplate()
    false

bindClearBtn = ->
  $('#clearBtn').click ->
    draw.clear()
    previewSVG()
    # first = true
    $('.template')[0].click()
    $('#saveBtn').click()
    false

saveTemplate = ->
  $.delay ->
    deselectAll()
    url = "/api/templates/#{gon.template.id}"
    # log url, 'url'
    svg = draw.svg()
    # log svg, 'svg'
    $.ajax
      type: 'PUT'
      url: url
      data:
        template:
          data: draw.svg()
      success: (data) ->
          # log data, 'data'
  , 1000
  false

window.randomBool = ->
  Math.floor((Math.random() * 10) + 1) % 3 == 0

toDataURL = (src, callback, outputFormat) ->
  img = new Image
  img.crossOrigin = 'Anonymous'
  img.onload = ->
    canvas = document.createElement('CANVAS')
    ctx = canvas.getContext('2d')
    dataURL = undefined
    canvas.height = @naturalHeight * previewScale
    canvas.width = @naturalWidth * previewScale
    ctx.drawImage this, 0, 0
    dataURL = canvas.toDataURL(outputFormat)
    callback dataURL
    return

  img.src = src
  if img.complete or img.complete == undefined
    img.src = 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw=='
    img.src = src
  return

$.delay = (->
  timer = 0
  (callback, ms, must) ->
    must ||= false
    clearTimeout timer
    if must
      setTimeout(callback, ms)
    else
      timer = setTimeout(callback, ms)
)()


svgToImage = (svg) ->
  # svgString = (new XMLSerializer).serializeToString(document.querySelector('svg'))
  svgString = svg
  canvas = document.getElementById('canvas')
  ctx = canvas.getContext('2d')
  DOMURL = self.URL or self.webkitURL or self
  img = new Image
  svg = new Blob([ svgString ], type: 'image/svg+xml;charset=utf-8')
  url = DOMURL.createObjectURL(svg)

  img.onload = ->
    ctx.drawImage img, 0, 0
    png = canvas.toDataURL('image/png')
    document.querySelector('#canvas').innerHTML = '<img src="' + png + '"/>'
    DOMURL.revokeObjectURL png
    return
  img.src = url