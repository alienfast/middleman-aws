#------------------------------------------------------------------------
# config.rb
#------------------------------------------------------------------------

# Configuration variables specific to each project
#------------------------------------------------------------------------
SITE_NAME                       = 'AlienFast Acme'
URL_ROOT                        = 'http://acme.alienfast.com'
AWS_BUCKET                      = 'acme.alienfast.com'
AWS_CLOUDFRONT_DISTRIBUTION_ID  = 'xxxxxxxxxxxx'
GOOGLE_ANALYTICS_ID             = 'UA-XXXXXXX-X'



# Common configuration below here, should not need to be changed.
#------------------------------------------------------------------------


# Sent in on CLI by rake task
#------------------------------------------------------------------------
AWS_ACCESS_KEY                  = ENV['AWS_ACCESS_KEY']
AWS_SECRET                      = ENV['AWS_SECRET']

# LiveReload and pretty URLs
activate :livereload
activate :directory_indexes

# Use relative paths
activate :relative_assets
set :relative_links, true

# Default layout
page '/*', layout: 'application'

# Asset paths
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

# Haml config
set :haml, { :attr_wrapper => '"' }

# Ignore files (e.g. keeps livereload from watching these)
config[:file_watcher_ignore] += [ /.idea\// ]

# https://github.com/jcypret/middleman-title
activate :title, site: SITE_NAME, separator: ' | '

# https://github.com/Aupajo/middleman-search_engine_sitemap
set :url_root, URL_ROOT
activate :search_engine_sitemap

# https://github.com/danielbayerlein/middleman-google-analytics
activate :google_analytics do |ga|
  ga.tracking_id = GOOGLE_ANALYTICS_ID # Replace with your property ID.
end

# https://github.com/fredjean/middleman-s3_sync
activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = AWS_BUCKET # The name of the S3 bucket you are targeting. This is globally unique.
  # s3_sync.region                     = 'us-east-1'     # The AWS region for your bucket. (S3 no longer requires this, dummy input?)
  s3_sync.aws_access_key_id          = AWS_ACCESS_KEY
  s3_sync.aws_secret_access_key      = AWS_SECRET
  s3_sync.delete                     = false # We delete stray files by default.
  # s3_sync.after_build                = false # We do not chain after the build step by default.
  # s3_sync.prefer_gzip                = true
  # s3_sync.path_style                 = true
  # s3_sync.reduced_redundancy_storage = false
  # s3_sync.acl                        = 'public-read'
  # s3_sync.encryption                 = false
  # s3_sync.prefix                     = ''
  # s3_sync.version_bucket             = false
end

# https://github.com/andrusha/middleman-cloudfront
activate :cloudfront do |cf|
  cf.access_key_id                    = AWS_ACCESS_KEY
  cf.secret_access_key                = AWS_SECRET
  cf.distribution_id                  = AWS_CLOUDFRONT_DISTRIBUTION_ID
  # cf.filter = /\.html$/i
end

# Build config
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end

# Custom helpers
helpers do


end
