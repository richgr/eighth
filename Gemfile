source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'pg'
gem 'heroku'
gem 'gravatar_image_tag'


# Gems used only for assets and not required
# in production environments by default.
# Before deploying to production, assets need to be precompiled using 
# >> rake assets:precompile
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

gem 'jquery-rails'

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
  gem 'rspec-rails'
  gem 'webrat'
  gem 'factory_girl_rails'
end

group :development do
  gem 'rspec-rails'
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
end

group :production do
  gem 'thin'
end
