require 'nanoc3/tasks'

task :copy_assets do
  sh "rsync -gprt --partial --exclude='.svn' assets/ output"
end

task :compile do
  sh "nanoc3 co"
end

task :build => [ :compile, :copy_assets ]

task :default => :build
