require 'rspec/core/rake_task'
require "bundler/gem_tasks"


task :console do
  exec "irb -r kco_ruby -I ./lib"
end

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['--color']
end

task :default => :spec