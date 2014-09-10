$:.unshift(File.join('lib'))

require 'rake/testtask'
require 'cy_data'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

desc "Run tests"
task :default => :test

desc "Run the script"
task :cy_data do
  CyData.process
end