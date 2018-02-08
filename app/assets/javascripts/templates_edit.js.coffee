selectedClass = 'selected'

selected = undefined
window.fonts = gon.fonts.names
$(document).ready ->

  bindSetTemplate()
  bindSaveBtn()
  bindClearBtn()

  window.draw = SVG('editor').size(800, 800)
  window.preview = SVG('preview').size(800, 800)

  reloadSVG draw, gon.template.data

  bindColumnAdd()
  bindExportBtn()

  bindFontsClick()


bindExportBtn = ->
  $('#exportBtn').click ->
    previewSVG()
    return false

reloadSVG = (draw, data) ->
  draw.svg data
  enableTextable draw.select('.text')
  previewSVG()

enableTextable = (texts) ->
  texts.addClass 'draggable'
  texts.draggable()
  # texts.select().resize()
  texts
  .on 'dragend', ->
    previewSVG()
  .on 'dblclick', ->
    log 'dblclick'
    return false
  .on 'click', (e) ->
    return if e.detail == 2
    deselectAll()
    selected = this
    selected.addClass selectedClass
    selected.selectize().resize()

    currentfont = selected.font().family
    log currentfont, 'currentfont'
    index = fonts.indexOf(currentfont)
    selectFont index

    # previewSVG()
    # this.select({deepSelect: true})
    # this.resize()
  .on 'resizedone', (e) ->
    previewSVG()

selectFont = (index) ->
  $('.font').removeClass selectedClass
  $($('.font')[index]).addClass selectedClass

bindFontsClick = ->
  $('#fonts li').click ->
    log 'font'
    index = $(this).index()
    log index, 'index'
    selectFont index

    if selected
      currentfont = selected.font().family
      log currentfont, 'currentfont'
      # nextfont = nextFont(currentfont)
      # log nextfont, 'nextfont'
      nextfont = fonts[index]
      log nextfont, 'nextfont'
      selected.attr 'family', nextfont
      selected.attr 'font-family', nextfont
      previewSVG()

# nextFont = (font) ->
#   index = fonts.indexOf(font)
#   num = fonts.length
#   if index == num - 1
#     index = 0
#   else
#     index += 1
#   font = fonts[index]
#   return font

deselectAll = ->
  draw.select('.draggable')
    .removeClass selectedClass
    .selectize false

previewSVG = ->
  deselectAll()
  svg = draw.svg()
  preview.svg svg
  ts = preview.select('.text')
  _.each ts.members, (text, index) ->
    express = text.text()
    _.each gon.cert_detail, (value, key) ->
      find = '#{' + key + '}'
      reg = new RegExp(find, 'g')
      express = express.replace reg, value
      # text.text express
    text.text express.match(/.{1,30}/g).join('\n')
  canvg 'canvas', preview.svg()
  canvas = document.getElementById('canvas')
  canvas.toDataURL('image/jpeg')
  # saveTemplate()
  false

bindSetTemplate = ->
  $('#img-templates img').click ->
    bg = $(this).attr('src')
    toDataURL bg, (dataUrl) ->
    #   bg = dataUrl
      class_name = 'template'
      images = draw.select("." + class_name)
      if image = images.members[0]
        image.load bg
      else
        image = draw.image(bg)
        image.addClass class_name

first = true
bindColumnAdd = ->
  $('.column').bind 'click', ->
    content = $(this).html()
    if $(this).hasClass 'label'
      size = 50
    else
      size = 18
      if first
        content = "\#{STUD_NAME} \#{BIRTH} 生，在本校 \#{CLAS_NAME} 修習 \#{ITEM_POINT} 學分成績及格。特發給學分證明書。(修習及格科目及學分列表如後)"
        first = false
      else
        content = "\#{#{content}}"
    text = draw.text content
    text.attr
      class: 'text'
    .font
      family: fonts[0]
      size: size
      # align: "justify"
      # anchor 'middle'
      # contentEditable: true
    # text.selectize()
    enableTextable text
    saveTemplate()
    false

bindSaveBtn = ->
  $("#saveBtn").click ->
    saveTemplate()
    false

bindClearBtn = ->
  $('#clearBtn').click ->
    draw.clear()
    previewSVG()
    first = true
    $('.template')[0].click()
    $('#saveBtn').click()
    false

saveTemplate = ->
  $.delay ->
    deselectAll()
    url = "/api/templates/#{gon.template.id}"
    log url, 'url'
    svg = draw.svg()
    log svg, 'svg'
    $.ajax
      type: 'PUT'
      url: url
      data:
        template:
          data: draw.svg()
      success: (data) ->
          log data, 'data'
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
    canvas.height = @naturalHeight
    canvas.width = @naturalWidth
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
