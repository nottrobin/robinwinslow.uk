rails heroku | ubuntu
===

We're going to create a rails

- name: railsapp
- database: postgresql
- database user: railsapp
- database password: railsapppass

``` bash
# Install heroku toolbelt
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# Install git, ruby, gems and postgres
sudo apt-get -y install git-core ruby-full postgresql libpq-dev

# Install rails
sudo gem install rails --version 4.0.0

# Setup a new rails app directory, change into it
rails new railsapp --database=postgresql --skip-bundle && cd railsapp

# Force Ruby version - for consistency
echo "ruby \"$(ruby -e 'print RUBY_VERSION')\"" >> Gemfile

# Use postgresql instead of sqlite
sed -i s/sqlite3/pg/ Gemfile

# Install the gemfile
bundle install

# Add the database config (http://pastebin.com/bsj5QgUK)
wget http://pastebin.com/raw.php?i=bsj5QgUK -O config/database.yml

# Create very basic index controller (http://pastebin.com/8TMFDEnu)
wget http://pastebin.com/raw.php?i=8TMFDEnu -O app/controllers/application_controller.rb

# Index controller route (http://pastebin.com/6vvTZ4FE)
wget http://pastebin.com/raw.php?i=6vvTZ4FE -O config/routes.rb

# Create a railsapp user, databases, and permissions
sudo su postgres -c "psql -c \"create database `whoami`; create database railsapp_dev; create database railsapp_test; create database railsapp_prod;\""
sudo su postgres -c "psql -c \"create user `whoami`;\""
sudo su postgres -c "psql -c \"grant all privileges on database railsapp_dev, railsapp_prod, railsapp_test to `whoami`;\""
```
