# README

#### System dependencies
Things you need to run or develop this Rails application:

* [Ruby version 2.4.0](https://www.ruby-lang.org/en/documentation/installation/)
* [Bundler version 1.14.6](https://bundler.io/)
* [Postgres > 9.5.0](https://www.postgresql.org/download/)          


Once you have cloned the repo and installed the above dependencies.
Do a bundle install to install all the gems.

        bundle install


Create a test and dev databases.


        createdb tweetable_development
        createdb tweetable_test

Alternatively you can run rake tasks

        rake db:create
        rake db:migrate
        rake db:seed

How to run a test(using rspec framework)

        rspec => will run all of your project test
        rspec path_to_specific_test_file:[line_number]

Auth for the App

We are using Google Authentication
Set app specific secrets in config/auth_config.yml.
You can find a template file named as config/auth_config.yml.template
* Do not source control your app specific secrets

How to start the app server

        rails server
