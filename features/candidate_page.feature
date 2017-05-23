@omniauth_test
Feature: Candidate page

  Scenario: Search for the website
    Given I am on the Tweetable login homepage
    Then I should see "Tweetable"
    Then As a candidate user I click on login with Facebook
    Then I should see "Open" passages
    Then I should see "Attempted" passages
    Then I should see "Missed" passages
