#require 'rake'

if defined?(Rake)
  Rake.add_rakelib(File.expand_path('../tasks', __FILE__))
end