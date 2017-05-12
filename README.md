# README

#### System dependencies
Things you need to run or develop this Rails application:

* [Ruby version 2.4.0](https://www.ruby-lang.org/en/documentation/installation/)
* [Bundler version 1.14.6](https://bundler.io/)
* [Postgres > 9.5.0](https://www.postgresql.org/download/)          

        
Once you have installed every thing. Run following command inside your project directory
         
         bundle install
         createdb tweetable_development
         createdb tweetable_test
         
How to running test

        rspec => this will run all of your project test
        rspec path_to_specific_test_file
        
        
How to start server
        
        rails server
        ./scripts/server