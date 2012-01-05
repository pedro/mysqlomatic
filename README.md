# MySQL-o-Matic #

This app is an example <a href="http://addons.heroku.com">Heroku Add-On</a>.

MySQL-o-matic is a multitenant MySQL cloud service similar to Amazon RDS or FathomDB. Users can use ActiveRecord or other Ruby ORM to connect to their provisioned database. The web portion of the cloud service is written in Rails, and new databases are configured by a shell command to mysqladmin.

There is also [an example consumer](blob/master/test/heroku/integration.rb). 

# Installation

    $ gem install -v=2.3.5 rails
    $ gem install mysql
    $ gem install foreman
    $ cp config/database.yml.example config/database.yml
    $ rake gems:install
    $ rake db:setup
    $ cp .env.sample .env
    $ foreman start -p 3000
