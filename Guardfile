
guard :shell do
  watch(/(.*).*/) {|m|
    # `ssh airfont.com "rm ~/www/icert/db/migrate/*"`
   # `rsync -avzhPR --delete -e ssh Gemfile config app lib db db/migrate public --exclude public/uploads airfont.com:~/www/icert/`



  # `ssh 140.137.207.47 "rm ~/www/icert/db/migrate/*"`
  `rsync -avzhPR --delete -e ssh Gemfile config vendor app lib db db/migrate public --exclude public/uploads  ctslin@140.137.207.47:~/www/icert/`

    # `rsync -avzhPR --delete -e ssh * 140.137.207.47:~/www/icert/`
    # `rsync -avzhPR --delete -e ssh Gemfile config app lib db db/migrate public --exclude public/uploads 140.137.207.47:~/www/icert/`

  }
  # watch(%r{config/*}) { `ssh airfont.com "touch ~/www/icert/tmp/restart.txt"` }
  # watch(%r{Gemfile}) { `ssh airfont.com "cd ~/www/icert; bundle install"` }
  watch(%r{config/*}) { `ssh ctslin@140.137.207.47 "touch ~/www/icert/tmp/restart.txt"` }
  watch(%r{Gemfile}) { `ssh ctslin@140.137.207.47 "cd ~/www/icert; bundle install"` }

  watch(%r{app/models/*}) { `bundle exec erd; mv erd.svg public/schema.svg;`}# open http://140.137.207.47/schema.svg` }
  # watch(%r{app/models/test.*}) { reload!; Test.export(Cert.first, "#{Rails.root}/public/uploads/cert.png") }

  watch(%r{db/migrate/*}) { `rake db:migrate:reset; bundle exec erd; mv erd.svg public/schema.svg; open http://140.137.207.47/schema.svg; rake db:seed` }
end

guard 'livereload', :port => "35729" do
  extensions = {
    css: :css,
    scss: :css,
    sass: :css,
    js: :js,
    coffee: :js,
    html: :html,
    png: :png,
    gif: :gif,
    jpg: :jpg,
    jpeg: :jpeg,
    less: :less, # uncomment if you want LESS stylesheets done in browser
  }

  rails_view_exts = %w(erb haml slim)

  # file types LiveReload may optimize refresh for
  compiled_exts = extensions.values.uniq
  watch(%r{public/.+\.(#{compiled_exts * '|'})})

  extensions.each do |ext, type|
    watch(%r{
          (?:app|vendor)
          (?:/assets/\w+/(?<path>[^.]+) # path+base without extension
           (?<ext>\.#{ext})) # matching extension (must be first encountered)
          (?:\.\w+|$) # other extensions
          }x) do |m|
      path = m[1]
      "/assets/#{path}.#{type}"
    end
  end

  # file needing a full reload of the page anyway
  watch(%r{app/views/.+\.(#{rails_view_exts * '|'})$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{config/locales/.+\.yml})
end
