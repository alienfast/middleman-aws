#require 'rake'

puts '***********************'

if defined?(Rake)
  rakeLib = File.expand_path('../middleman-aws/tasks', __FILE__)
  puts "trying to load rakeLib: #{rakeLib}"
  Rake.add_rakelib(rakeLib)
else
  puts "No rake!"
end