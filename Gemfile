source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem "recaptcha", require: "recaptcha/rails"
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'bootstrap-sass'
gem 'kaminari'

gem 'ransack'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
# gem 'pg', '0.20.0'

# admin development
gem 'activeadmin'
gem 'cancan' # or cancancan
gem 'draper'
gem 'pundit'
gem 'devise'

# in-app message
gem 'mailboxer'
gem 'chosen-rails'
gem 'gravatar_image_tag'

# image upload
gem 'carrierwave', '~> 1.0'
gem 'mini_magick'
gem "fog-google"
gem "google-api-client", "> 0.8.5", "< 0.9"
gem "mime-types"

gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-turbolinks'

group :test do
  gem 'pg', '0.20.0'
  gem 'rspec'
  gem 'factory_bot_rails'
end

group :development, :test do
  gem 'pg', '0.20.0'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.7'
  gem 'faker'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  gem 'pg', '0.20.0'
  gem 'rails_12factor'
end