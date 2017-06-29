### Development and Contributions

Contributing to Tweetable doesn’t only mean to add new features. Helping new users and improving documentation are also welcome. In fact, proposing significant feature changes usually requires understanding of the ecosystem and purpose of the product.Being familiar with the features and having sense on that why a feature is needed it helps to gain confidence with the codebase.


## Contributing Documentation Changes
Changes in the user Manual to add more specific point which improves understandability for a new user.A document includes all the manuals, developer guide and README's. Also new mechanism to make document easy are welcomed.


## Contributing with Bug Files
Report every single bug to us.This will make both product and your life simple. If you have an alternative suggestions on solving those bugs, those are welcomed as well.

## Contribute with New Features
If you have new features in the mind.First share it with team and users get feedback about it. Once you are sure about feature then refine it to make it simple and elegant.It will help to estimate the stories and in development of that feature.

## Pre-requisite for coding
It is developed using ruby-rails and postgres as database.
The setup information can be found in the README.md and Mingle.
There is a dev-box setup using vagrant and ansible-playbook. But you can build it without it as well.

## Building on Top of Tweetable
<!-- uncompleted -->

## Feature Proposed
- User Groups
  This is the most useful and required feature which needs to be build.This will allow admin to group users in batches.So eventually a exercise can be given to a group rather than giving to everyone. This also changes some of the core models which requires lot of time to introduce this feature.For example Passages will be independent of the commence and conclude time.This will also allow that same passages can be given to a group multiple time.
- Expose API's
  The minimal version feature is the ability to give data to user on API calls where consumer can build their own visualiations on the data.It could be extended as well where as an app we expose api's which can be consumed by any one and they can build their own app.
- Badges
  A very simple feature where an admin can give badges to those people who have done excellence in something. For example if a person gets a tag grammar multiple times as an admin I wish to give him Shakespeare as bade.
  Which could be shown on user profile and leader board.
- Tweet Limit Configure
  Very Simple Feature.Right now the tweet limit is 140.We want give an ability to configure that as well.   
- Make User Management Easy
  In admin user management view, we don't have search and sort in the users table.Also it could be improved in other ways.
- Introduce New Type of the Exercises  
  Right now every exercise is to give a passage and summarize it.It could be another type of question. For example short story writing, comics writing.
