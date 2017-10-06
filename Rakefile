require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

task :default => :test

task :console do
  exec "irb -r golos_cloud -I ./lib"
end

task :build do
  exec 'gem build golos_cloud.gemspec'
end

task :push do
  exec "gem push golos_cloud-#{GolosCloud::VERSION}.gem"
end
