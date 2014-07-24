namespace :assets do
  desc 'Precompile assets'
  task :precompile do
    sh "bundle exec jekyll build"
  end
  task :devcompile do
    sh "bundle exec jekyll build"
  end
end

task :default => ["assets:precompile"]
