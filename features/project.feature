Feature: Project
  In order to view my coderunner projects
  As a person who dreams of seeing all green builds
  I want to see all my projects and their latest build status
  
  Scenario: View project index page ---> root path
    Given a project exists with name: "The Dude"
    And another project exists with name: "Walter"
    When I am on the home page
    Then a project should exist with name: "The Dude"
    And a project should exist with name: "Walter"
    And I should see "The Dude"
    And I should see "Walter"

  
  