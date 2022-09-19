require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: %i[spec]

task :bench do
  cmd = %w[bundle exec ruby benchmark/bench.rb]
  exit system(*cmd)
end

task :bench_memory do
  cmd = %w[bundle exec ruby benchmark/memory.rb]
  exit system(*cmd)
end
