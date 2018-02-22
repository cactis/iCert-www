(function() {
  var $input, bindClearBtn, bindColumnAdd, bindExportBtn, bindFontsClick, bindInputChange, bindSaveBtn, bindSetTemplate, deselectAll, enableTextable, posX, posY, previewScale, reloadSVG, saveTemplate, selectFont, selected, selectedClass, setPOS, svgToImage, textSelected, toDataURL;

  selectedClass = 'selected';

  selected = void 0;

  window.fonts = gon.fonts.names;

  $input = void 0;

  posX = 100;

  posY = 100;

  previewScale = 0.5;

  $('html').keydown(function(e) {
    var el;
    if ((e.keyCode === 8 || e.keyCode === 46) && e.target.nodeName !== "TEXTAREA") {
      el = draw.select(".selected").first();
      deselectAll();
      el.remove();
      $input.val("");
      previewSVG();
      return false;
    }
  });

  $(document).ready(function() {
    var h, w;
    bindSetTemplate();
    bindSaveBtn();
    bindClearBtn();
    w = 710;
    h = 1000;
    $('#input').css('width', w - 10);
    window.draw = SVG('editor').size(w, h);
    window.preview = SVG('preview').size(w / 2, h).scale(previewScale);
    reloadSVG(draw, gon.template.data);
    bindColumnAdd();
    bindExportBtn();
    bindFontsClick();
    $input = $('#input');
    return bindInputChange();
  });

  bindInputChange = function() {
    return $input.keydown(function(e) {
      if (!selected) {
        return;
      }
      return $.delay(function() {
        var el;
        el = selected;
        deselectAll();
        if (selected.text !== $input.val()) {
          selected.text($input.val());
          previewSVG();
          return textSelected(el);
        }
      });
    });
  };

  bindExportBtn = function() {
    return $('#exportBtn').click(function() {
      previewSVG();
      return false;
    });
  };

  reloadSVG = function(draw, data) {
    draw.svg(data);
    enableTextable(draw.select('.text'));
    return previewSVG();
  };

  setPOS = function(x, y) {
    return;
    if (x < 100) {
      posX = x + 100;
    } else {
      posX = x - 100;
    }
    if (y < 100) {
      return posY = y + 50;
    } else {
      return posY = y - 50;
    }
  };

  enableTextable = function(texts) {
    texts.addClass('draggable');
    texts.draggable();
    texts.on('dragend', function(e) {
      return setPOS(e.detail.p.x, e.detail.p.y);
    });
    return texts.on('dragend', function() {
      return previewSVG();
    }).on('click', function(e) {
      textSelected(this);
      return e.stopPropagation();
    }).on('resizedone', function(e) {
      return previewSVG();
    });
  };

  textSelected = function(text) {
    var currentfont, index;
    deselectAll();
    selected = text;
    selected.addClass(selectedClass);
    selected.selectize().resize();
    currentfont = selected.font().family;
    index = fonts.indexOf(currentfont);
    selectFont(index);
    return $input.val(selected.text());
  };

  selectFont = function(index) {
    $('.font').removeClass(selectedClass);
    return $($('.font')[index]).addClass(selectedClass);
  };

  bindFontsClick = function() {
    return $('#fonts li').click(function() {
      var currentfont, index, nextfont;
      index = $(this).index();
      selectFont(index);
      if (selected) {
        currentfont = selected.font().family;
        nextfont = fonts[index];
        selected.attr('family', nextfont);
        selected.attr('font-family', nextfont);
        previewSVG();
        return textSelected(selected);
      }
    });
  };

  deselectAll = function() {
    return draw.select('.draggable').removeClass(selectedClass).selectize(false);
  };

  window.previewSVG = function() {
    var canvas, svg, ts;
    deselectAll();
    svg = draw.svg();
    preview.svg(svg);
    ts = preview.select('.text');
    _.each(ts.members, function(text, index) {
      var express;
      express = text.text();
      _.each(gon.cert_detail, function(value, key) {
        var find, reg;
        find = '#{' + key + '}';
        reg = new RegExp(find, 'g');
        return express = express.replace(reg, value);
      });
      if (express.match(/.{1,22}/g)) {
        return text.text(express.match(/.{1,22}/g).join('\n'));
      } else {
        return text.text(express);
      }
    });
    canvas = document.getElementById('canvas');
    canvas.toDataURL('image/jpeg');
    canvg(canvas, preview.svg());
    return false;
  };

  bindSetTemplate = function() {
    return $('#img-templates img').click(function() {
      var bg;
      bg = $(this).attr('src');
      return toDataURL(bg, function(dataUrl) {
        var class_name, image, images;
        class_name = 'template';
        images = draw.select("." + class_name);
        if (image = images.members[0]) {
          image.load(bg);
          return previewSVG();
        } else {
          image = draw.image(bg);
          image.addClass(class_name);
          return $.delay(function() {
            return previewSVG();
          }, 100, true);
        }
      });
    });
  };

  bindColumnAdd = function() {
    return $('.column').unbind().click(function() {
      var content, size, text;
      content = $(this).html();
      if ($(this).hasClass('label')) {
        size = 50;
      } else {
        size = 18;
        content = "\#{" + content + "}";
      }
      text = draw.text(content);
      text.attr({
        "class": 'text'
      }).font({
        family: fonts[0],
        size: size,
        x: posX,
        y: posY
      });
      setPOS(posX, posY);
      enableTextable(text);
      previewSVG();
      textSelected(text);
      return false;
    });
  };

  bindSaveBtn = function() {
    return $("#saveBtn").click(function() {
      saveTemplate();
      return false;
    });
  };

  bindClearBtn = function() {
    return $('#clearBtn').click(function() {
      draw.clear();
      previewSVG();
      $('.template')[0].click();
      $('#saveBtn').click();
      return false;
    });
  };

  saveTemplate = function() {
    console.log('1111')
    // $.delay(function() {
    //
      var svg, url;
      deselectAll();
      url = "/api/templates/" + gon.template.id;
      // 換成 dotnet 樣板存檔程式
      svg = draw.svg();
      console.log(svg);
      return $.ajax({
        type: 'PUT',
        url: url,
        data: {
          template: {
            data: svg
          }
        },
        success: function(data) {}
      });
    // }, 1000);
    // return false;
  };

  window.randomBool = function() {
    return Math.floor((Math.random() * 10) + 1) % 3 === 0;
  };

  toDataURL = function(src, callback, outputFormat) {
    var img;
    img = new Image;
    img.crossOrigin = 'Anonymous';
    img.onload = function() {
      var canvas, ctx, dataURL;
      canvas = document.createElement('CANVAS');
      ctx = canvas.getContext('2d');
      dataURL = void 0;
      canvas.height = this.naturalHeight * previewScale;
      canvas.width = this.naturalWidth * previewScale;
      ctx.drawImage(this, 0, 0);
      dataURL = canvas.toDataURL(outputFormat);
      callback(dataURL);
    };
    img.src = src;
    if (img.complete || img.complete === void 0) {
      img.src = 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==';
      img.src = src;
    }
  };

  $.delay = (function() {
    var timer;
    timer = 0;
    return function(callback, ms, must) {
      must || (must = false);
      clearTimeout(timer);
      if (must) {
        return setTimeout(callback, ms);
      } else {
        return timer = setTimeout(callback, ms);
      }
    };
  })();

  svgToImage = function(svg) {
    var DOMURL, canvas, ctx, img, svgString, url;
    svgString = svg;
    canvas = document.getElementById('canvas');
    ctx = canvas.getContext('2d');
    DOMURL = self.URL || self.webkitURL || self;
    img = new Image;
    svg = new Blob([svgString], {
      type: 'image/svg+xml;charset=utf-8'
    });
    url = DOMURL.createObjectURL(svg);
    img.onload = function() {
      var png;
      ctx.drawImage(img, 0, 0);
      png = canvas.toDataURL('image/png');
      document.querySelector('#canvas').innerHTML = '<img src="' + png + '"/>';
      DOMURL.revokeObjectURL(png);
    };
    return img.src = url;
  };

}).call(this);
