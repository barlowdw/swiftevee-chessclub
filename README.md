# README

Simple Chess club application that allows users to capture members and matches. It also displays current ranking and number of matches played.

* Setup

This application was built using ruby 2.5.1. You can check your ruby version by running `ruby -v`. 
This application uses bundler to install gems. To install budler run `gem install bundler`. This application uses bundler version 2. To check your version of bundler run `bundle -v`.

This application uses sqlite v3 for development and testing instances. To check your version of sqlite run the following command `sqlite3 --version`. This application uses postgres for the production environment, which is beyond the scope of this readme.

The following commands should be run to make sure the application has all required gems and setup files:

`bundle install`\
`bundle exec rails webpacker:install`\
`bundle exec rake db:migrate`\

* Tests

Tests can be run by running the following commnad:

`bundle exec rake`

* Run

The server can started using the following command. Make sure that all steps in the Setup section have been followed.

`bundle exec rails s`

The server can then be access from your web browser at http://localhost:3000/.
