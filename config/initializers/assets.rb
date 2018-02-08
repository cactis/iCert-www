Rails.application.config.assets.paths << Rails.root.join("vendor")

Rails.application.config.assets.precompile += %w( templates.css templates_edit.css templates_new.css )
Rails.application.config.assets.precompile += %w( templates.js templates_edit.js templates_new.js  canvg.js/canvg.js canvg.js/rgbcolor.js canvg.js/StackBlur.js)

precompiles = []
precompiles += %w(new edit show index).map{ |action|
  files = Dir.new('app/controllers').map{|i| f = i.split('_'); f.pop; f.join('_')}
  # p files, 'files'
  files.map{ |i| i.length > 2 ? i : nil}.compact.map{ |controller|

    cssfile = "app/assets/stylesheets/#{controller}.css.less"
    jsfile = "app/assets/javascripts/#{controller}.js.coffee"
    opalfile = "app/assets/javascripts/#{controller}.js.rb"

    # system "touch #{cssfile}" unless File.exists? cssfile
    # system "touch #{jsfile}" unless File.exists?(jsfile) || File.exists?(opalfile)

    cssfile = "app/assets/stylesheets/#{controller}_#{action}.css.less"
    jsfile = "app/assets/javascripts/#{controller}_#{action}.js.coffee"
    opalfile = "app/assets/javascripts/#{controller}_#{action}.js.rb"
    # system "touch #{cssfile}" unless File.exists? cssfile
    # system "touch #{jsfile}" unless File.exists?(jsfile) || File.exists?(opalfile)

    %w(css js).map{ |ext|
      ["#{controller}.#{ext}", "#{controller}_#{action}.#{ext}"]
    }
  }
}.flatten

# precompiles += Dir.new('app/assets/stylesheets').map{|i| i.split('.').first}.map{ |i| i && i.length > 2 ? i : nil}.compact.map{|i| "#{i}.css"}

# precompiles += Dir.new('app/assets/javascripts').map{|i| i.split('.').first}.map{ |i| i && i.length > 2 ? i : nil}.compact.map{|i| "#{i}.js"}
Rails.application.config.assets.precompile += precompiles.uniq