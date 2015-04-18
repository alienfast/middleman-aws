# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'middleman-aws'
  s.version     = '1.0.1'
  s.platform    = Gem::Platform::RUBY

  s.authors = ['Kevin Ross']
  s.email = ['kevin.ross@alienfast.com']
  s.description = <<-TEXT
    Simple set of middleman rake tasks to build and deploy to AWS using s3_sync and cloudfront invalidation
  TEXT
  s.summary = <<-TEXT
    Simple set of middleman rake tasks to build and deploy to AWS using s3_sync and cloudfront invalidation
  TEXT
  s.homepage = 'https://github.com/alienfast/middleman-aws'
  s.license = 'MIT'

  s.files         = `git ls-files`.split($/).reject { |f| f =~ /^samples\// }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  
  # The version of middleman-core your extension depends on
  # s.add_runtime_dependency 'middleman-core', ['>= 3.3.3']

  s.add_dependency 'middleman-s3_sync'     # https://github.com/fredjean/middleman-s3_sync
  s.add_dependency 'middleman-cloudfront'  # https://github.com/andrusha/middleman-cloudfront

  s.add_dependency 'rake'
end
