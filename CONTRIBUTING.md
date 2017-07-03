### Contributions
First of all thanks a lot for making this app better.

Contributing to Tweetable doesn’t only mean to add new features. Helping new users and improving documentation are also welcomed. In fact, proposing significant feature changes usually requires understanding of the codebase and purpose of the product. Being familiar with the features and having sense on that why a feature is needed helps to gain confidence with the codebase.


## Contributing to documentation changes
Changes in the user Manual and other docs to add more specific point which improves understandability for a new user. A document includes all the manuals, developer guide and README's. Also new mechanism to make document easy are welcomed.


## Contributing with bug files
Report every single bug to us.This will make both product and your life simple. If you have an alternative suggestions on solving those bugs, those are welcomed as well.Most preferably report it on the Github.

## Contribute with new feature
If you have new features in the mind. First share it with team and users to get feedback about it. Once you are sure about feature then refine it to make it simple and elegant. It will help you  estimate the time for development of that feature.

## Feature Proposed
- User Groups
  This is the most useful and required feature which needs to be build.This will allow admin to group users in batches.So eventually a exercise can be given to a group rather than giving to everyone. This also changes some of the core models which requires lot of time to introduce this feature.For example Passages will be independent of the commence and conclude time.This will also allow that same passages can be given to a group multiple time.
- Expose API's
  The minimal version feature is the ability to give data to user on API calls where consumer can build their own visualization on the data.It could be extended as well where as an app we expose api's which can be consumed by any one and they can build their own app.
- Badges
  A very simple feature where an admin can give badges to those people who have done excellence in something. For example if a person gets a tag grammar multiple times as an admin I wish to give him Shakespeare as bade.
  Which could be shown on user profile and leader board.
- Tweet Limit Configure
  Very Simple Feature.Right now the tweet limit is 140.We want give an ability to configure that as well.   
- Make User Management Easy
  In admin user management view, we don't have search and sort in the users table.Also it could be improved in other ways.
- Introduce New Type of the Exercises  
  Right now every exercise is to give a passage and summarize it.It could be another type of question. For example short story writing, comics writing.

---

## Pre-requisite for coding
It is suggested to read the user manual carefully to understand the features before touching the code. Knowledge of ruby and familiarity with the rails ecosystem will surely help. There is lot of JavaScript code as well in the codebase. So mostly these are the pre-requisite for development.

### Set the System dependencies
  Things you need to run or develop this rails application:

  * [Ruby version 2.4.0](https://www.ruby-lang.org/en/documentation/installation/)
  * [Bundler version 1.14.6](https://bundler.io/)
  * [Postgres > 9.5.0](https://www.postgresql.org/download/)          


  Once you have cloned the repo and installed the above dependencies.
  Do a `bundle install` to install all the gems.

  Create a test and dev databases.

          createdb tweetable_development
          createdb tweetable_test

  Alternatively you can use rake tasks

        rake db:create
        rake db:migrate
        rake db:seed
We are using rpsec as unit teasting framework.
To run a test using rspec.

        rspec [will run all of your project test]
        rspec path_to_specific_test_file:[line_number]

##### Auth for the App

  We are using Google Authentication.
  Set app specific secrets in config/auth_config.yml for the development.
  You can find a template file named as config/auth_config.yml.template

  <sub> Do not source control your app specific secrets

   Running the app server `rails server`


### Code convention
We use robocop to maintain the code convention. After cloning the repo please add the git commit pre hook by running the following command.

    chmod 400 setup-git-pre-hook.sh ;sh setup-git-pre-hook.sh
