
guard :shell do
  watch(/(.*).*/) {|m|
    `ssh airfont.com "rm ~/www/icert/db/migrate/*"`
    `rsync -avzhPR --delete -e ssh Gemfile config app lib db db/migrate public --exclude public/uploads airfont.com:~/www/icert/`

  }
end
