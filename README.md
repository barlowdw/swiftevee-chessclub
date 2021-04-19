# README

Simple Chess club application that allows users to capture members and matches. It also displays current ranking and number of matches played.

* Setup

This application was built using ruby 2.5.1. You can check your ruby version by running `ruby -v`. 
This application uses bundler to install gems. To install budler run `gem install bundler`

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
