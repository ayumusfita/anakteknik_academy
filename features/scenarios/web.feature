@web-automation
Feature: Web Automation Testing 

  @login
  Scenario: Login to Sauce Demo Website
    Given user is on login page
    When user enter a valid credential
    Then website home page will have displayed
