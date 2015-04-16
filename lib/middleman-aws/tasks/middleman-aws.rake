#------------------------------------------------------------------------
# Rakefile
#------------------------------------------------------------------------
require 'yaml'
require 'uri'

namespace :mm do

  desc 'Remove all files in the build directory'
  task :clobber do |t, args|
    # kill the old package dir
    rm_r 'build' rescue nil
  end

  desc 'Compile all files into the build directory'
  task :build do
    puts '## Compiling static pages'
    status = system 'bundle exec middleman build'
    puts status ? 'Build successful.' : 'Build failed.'
  end

  desc 'Deploy to S3 and invalidate Cloudfront after a Git commit/push'
  task :deploy do

    puts '## Deploy starting...'
    cd 'build' do
      # system 'git add .'
      system 'git add -u'
      message = "Site updated at #{Time.now}"
      puts "## Commiting: #{message}"
      system "git commit -m \"#{message}\""
      # puts "## Pushing generated website"
      # system "git push origin master"
      # puts "## Github Pages deploy complete"
    end

    puts '## Syncing to S3...'
    system "bundle exec middleman s3_sync"
    puts '## Invalidating cloudfront...'
    system "bundle exec middleman invalidate"
    puts '## Deploy complete.'
  end

  desc 'One step clobber, build, deploy'
  task :publish => [:clobber, :build, :deploy] do
  end


  desc 'Run the preview server at http://localhost:4567'
  task :preview do
    system 'middleman server'
  end

  def project
    File.basename(Rake.original_dir)
  end
end
