# rake db:seed:dump MODELS=CertDetail LIMIT=100 FILE=db/seeds/cert_details_seeds.rb
# rake db:seed:dump MODELS=Template LIMIT=100 FILE=db/seeds/templates_seeds.rb

Dir[File.join(Rails.root, 'db', 'seeds', '*_seeds.rb')].sort.each { |seed| load seed }


Test.seeds