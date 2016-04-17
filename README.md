middleman-aws
=============

Simple set of [middleman](http://middlemanapp.com/) rake tasks to build and deploy to AWS using s3_sync and cloudfront invalidation.

# Installation and Configuration

### Step 1: Add gems to the Gemfile

See the [sample Gemfile](samples/Gemfile) for full configuration.

```ruby
gem 'middleman-aws', '>=4.0.0'
gem 'middleman-s3_sync', '>=4.0.0'
gem 'middleman-cloudfront',
  #'>=4.0.0' waiting for release of PR https://github.com/andrusha/middleman-cloudfront/pull/23
  github: 'rosskevin/middleman-cloudfront', branch: 'middleman-4'
```

### Step 2: Require this gem in the Rakefile

    require 'middleman-aws'

### Step 3: AWS credentials

#### Option 1 - secrets file
e.g. `~/.aws/acme.yml`

This should contain the access and secret keys generated from the selected IAM user.  This is the only file that will need to reside outside the repository.  `acme` is equivalent to the directory name for your project.
Don't worry, validation will make sure you have the path right.

```ruby
access_key_id: XXXXXX
secret_access_key: XXXXXX
```

#### Option 2 - ENV variables
If you don't create secrets file, then environment variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` will be used. 

#### Option 3 - IAM
If a secrets file is not present (option 1), there are no ENV variables (option 2), then request to AWS will fail (unless middleman-aws is used on EC2 instance with correct IAM role, then AWS will take care of authorising requests).

### Step 4: Add the necessary s3_sync and Cloudfront sections to your config
See the [sample config.rb](samples/config.rb) for full configuration. Be sure to set the following variables:

```ruby
#------------------------------------------------------------------------
# Configuration variables specific to each project
#------------------------------------------------------------------------
SITE_NAME                       = 'AlienFast Acme'
URL_ROOT                        = 'http://acme.alienfast.com'
AWS_BUCKET                      = 'acme.alienfast.com'
AWS_CLOUDFRONT_DISTRIBUTION_ID  = 'xxxxxxxxxxxx'
```

# Usage
Run the desired rake task.  It's as simple as `rake mm:publish` in one step, or you can choose to do things one step at a time.
See the available rake tasks below or run `rake -T`

# Available Rake Tasks

    rake mm:build        # Compile all files in the build directory
    rake mm:clobber      # Remove all files in the build direcory
    rake mm:deploy       # Deploy to S3 and invalidate Cloudfront after a Git commit/push
    rake mm:serve        # Run the preview server at http://localhost:4567
    rake mm:publish      # One step clobber, build, deploy
    rake mm:show_config  # Show config

# Real World Sample
If you are just getting started with middleman and want to get a quick jumpstart on your `Gemfile` and `congfig.rb`,
check out the source in the `samples` directory.

## Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2016 AlienFast, LLC. See MIT LICENSE.txt for further details.
