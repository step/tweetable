@omniauth_test
Feature: Login page

  Scenario: Tweetable homepage
    Given I am on the Tweetable login homepage
    Then I should see "Tweetable"
    Then I should see "Login with Facebook"
