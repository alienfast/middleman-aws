middleman-aws
=============

Simple set of [middleman](http://middlemanapp.com/) rake tasks to build and deploy to AWS using s3_sync and cloudfront invalidation.

# Installation and Configuration

### Step 1: Add this gem to the Gemfile

    gem 'middleman-aws'

### Step 2: Require this gem in the Rakefile

    require 'middleman-aws'
    
    # Even though already required by the middleman-aws gem, it appears middleman does not 
    #   pick up transitive dependency extensions early enough  to avoid the 
    #   "== Unknown Extension:" error.  Add these to your main project 
    #   (I wish this was unnecessary but don't know how to work around it)
    gem 'middleman-s3_sync'     
    gem 'middleman-cloudfront'


### Step 3: Add your aws credentials
e.g. `~/.aws/acme.yml`

This should contain the access and secret keys generated from the selected IAM user.  This is the only file that will need to reside 
outside the repository.  `acme` is equivalent to the directory name for your project.  
Don't worry, validation will make sure you have the path right.

    access_key_id: XXXXXX
    secret_access_key: XXXXXX

### Step 4: Add the necessary s3_sync and Cloudfront sections to your config
This is a sample of how a common config is setup with variables extracted:

    # Configuration variables specific to each project
    #------------------------------------------------------------------------
    AWS_BUCKET                      = 'acme.alienfast.com'
    AWS_CLOUDFRONT_DISTRIBUTION_ID  = 'xxxxxx'

    # Variables: Sent in on CLI by rake task via ENV
    #------------------------------------------------------------------------
    AWS_ACCESS_KEY                  = ENV['AWS_ACCESS_KEY']
    AWS_SECRET                      = ENV['AWS_SECRET']
    
    # https://github.com/fredjean/middleman-s3_sync
    activate :s3_sync do |s3_sync|
      s3_sync.bucket                     = AWS_BUCKET # The name of the S3 bucket you are targeting. This is globally unique.
      s3_sync.aws_access_key_id          = AWS_ACCESS_KEY
      s3_sync.aws_secret_access_key      = AWS_SECRET
      s3_sync.delete                     = false # We delete stray files by default.
    end
    
    # https://github.com/andrusha/middleman-cloudfront
    activate :cloudfront do |cf|
      cf.access_key_id                    = AWS_ACCESS_KEY
      cf.secret_access_key                = AWS_SECRET
      cf.distribution_id                  = AWS_CLOUDFRONT_DISTRIBUTION_ID
      # cf.filter = /\.html$/i
    end

# Usage
Run the desired rake task.  It's as simple as `rake mm:publish` in one step, or you can choose to do things one step at a time.  
See the available rake tasks below or run `rake -T`

# Available Rake Tasks

    rake mm:build        # Compile all files in the build directory
    rake mm:clobber      # Remove all files in the build direcory
    rake mm:deploy       # Deploy to S3 and invalidate Cloudfront after a Git commit/push
    rake mm:preview      # Run the preview server at http://localhost:4567
    rake mm:publish      # One step clobber, build, deploy
    rake mm:show_config  # Show config

## Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2014 AlienFast, LLC. See MIT LICENSE.txt for further details.