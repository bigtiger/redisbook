require 'nanoc3/tasks'

task :copy_assets do
  sh "rsync -gprt --partial --exclude='.svn' assets/ output"
end

task :compile do
  sh "nanoc3 co"
end

task :github do
  sh "git push origin master"
end

task :upload do
  sh "rake deploy:rsync"
end

task :build => [ :clean, :compile, :copy_assets ]

task :deploy => [ :build, :github, :upload ]

task :default => :build
