# README

#### System dependencies
Things you need to run or develop this Rails application:

* [Ruby version 2.4.0](https://www.ruby-lang.org/en/documentation/installation/)
* [Bundler version 1.14.6](https://bundler.io/)
* [Postgres > 9.5.0](https://www.postgresql.org/download/)          

        
Once you have installed every thing.
Do a bundle install to install all the gems.
Create a test and dev databases. 
         
         bundle install
         createdb tweetable_development
         createdb tweetable_test
         
How to run a test(using rspec framework)

        `rspec` => will run all of your project test
        `rspec path_to_specific_test_file:[line_number]`
        
Facebook auth

Set those params in config/facebook_config.yml
           
How to start the app server
        
        rails server