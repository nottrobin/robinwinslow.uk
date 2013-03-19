namespace :assets do
  desc 'Precompile assets'
  task :precompile do
    sh "bundle exec sass --update _scss:_css --style compressed"
    sh "bundle exec jekyll"
  end
end
