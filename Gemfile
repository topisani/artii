source 'https://rubygems.org'
gem 'rails', '4.2.4'
gem 'rails-api'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]
gem 'mini_magick'
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'

group :development, :test do
  # Use debugger
  gem 'byebug'

  gem 'sqlite3'
end

#########################
# Grape stuff
#########################
gem 'active_model_serializers'
gem "grape"
gem "grape-active_model_serializers"
gem "grape-swagger-rails"
gem "rack-cors", require: "rack/cors"
gem 'hashie-forbidden_attributes'

group :production do
  gem 'pg'
  gem 'rails_12factor'
  #Remove this later
  gem 'informant-rails'
end
