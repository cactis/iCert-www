
guard :shell do
  watch(/(.*).*/) {|m|
    `ssh airfont.com "rm ~/www/icert/db/migrate/*"`
    `rsync -avzhPR --delete -e ssh Gemfile config app lib db db/migrate public --exclude public/uploads airfont.com:~/www/icert/`

  }
  watch(%r{config/*}) { `ssh airfont.com "touch ~/www/icert/tmp/restart.txt"` }
  watch(%r{Gemfile}) { `ssh airfont.com "cd ~/www/icert; bundle install"` }
end
