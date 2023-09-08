require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :deploy do |t|
  sh "git push origin master"
  sh "rake build"

  file = Dir.glob("pkg/*").max_by {|f| File.mtime(f)}

  sh "gem push #{file}"
end

task :default => :spec
