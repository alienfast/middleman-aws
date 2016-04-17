#------------------------------------------------------------------------
# Typical custom configuration each project
#------------------------------------------------------------------------

# Build config
configure :build do
  # activate :minify_css
  # activate :minify_javascript
  # activate :asset_hash
end

# activate :external_pipeline,
#          name: :gulp,
#          command: build? ? './node_modules/gulp/bin/gulp.js' : './node_modules/gulp/bin/gulp.js default:watch',
#          source: 'dist'

# Custom helpers
# helpers do
#   def body_classes
#     "#{page_classes} #{data.page.bodyClasses}"
#   end
# end

#------------------------------------------------------------------------
# Configuration variables specific to each project
#------------------------------------------------------------------------
SITE_NAME                       = 'AlienFast Acme'
URL_ROOT                        = 'http://acme.alienfast.com'
AWS_BUCKET                      = 'acme.alienfast.com'
AWS_CLOUDFRONT_DISTRIBUTION_ID  = 'xxxxxxxxxxxx'


#------------------------------------------------------------------------
# Common configuration below here, should not need to be changed.
#------------------------------------------------------------------------


# Sent in on CLI by rake task
#------------------------------------------------------------------------
AWS_ACCESS_KEY                  = ENV['AWS_ACCESS_KEY']
AWS_SECRET                      = ENV['AWS_SECRET']

# Default layout
page '/*', layout: 'application'

# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload, ignore: [ /.idea\// ]
end

activate :directory_indexes

# # Use relative paths
# activate :relative_assets
# set :relative_links, true

# Haml config
set :haml, { :attr_wrapper => '"' }

# https://github.com/Aupajo/middleman-search_engine_sitemap
set :url_root, URL_ROOT
activate :search_engine_sitemap

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