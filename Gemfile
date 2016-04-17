# If you have OpenSSL installed, we recommend updating
# the following line to use "https"
source 'http://rubygems.org'

# Specify your gem's dependencies in middleman-aws.gemspec
gemspec

# FIXME: temporary branch - move back to spec when PR is accepted
gem 'middleman-cloudfront',
    #'>=4.0.0' waiting for release of PR https://github.com/andrusha/middleman-cloudfront/pull/23
    github: 'rosskevin/middleman-cloudfront', branch: 'middleman-4'
    #:path => '~/projects/middleman-cloudfront'

group :development do
  gem 'rake'
  gem 'rdoc'
  gem 'yard'
end

group :test do
  gem 'cucumber'
  gem 'fivemat'
  gem 'aruba'
  gem 'rspec'
end
