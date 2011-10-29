source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'pg', '0.11.0'
gem 'heroku', '2.11.0'
gem 'gravatar_image_tag', '1.0.0'
gem 'will_paginate', '3.0.2'

# Gems used only for assets and not required
# in production environments by default.
# Before deploying to production, assets need to be precompiled using 
# >> rake assets:precompile
group :assets do
  gem 'sass-rails', '3.1.4'
  gem 'coffee-rails', '3.1.1'
  gem 'uglifier', '1.0.4'
end

gem 'jquery-rails', '1.0.16'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'rspec-rails', '2.7.0'
  gem 'webrat', '0.7.3'
  gem 'factory_girl_rails', '1.3.0'
end

group :development do
  gem 'rspec-rails', '2.7.0'
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
  gem 'faker', '1.0.1'
end

group :production do
  gem 'thin', '1.2.11'
end
