Feature: Project
  As a person who dreams of seeing all green builds
  I want to see all my projects and their latest build status
  In order to be happy and drive Robin Masters' Ferrari 308 GTS around Hawaii
  
  Scenario: View project index page ---> root path
    Given a project exists with name: "Dude"
    And another project exists with name: "Walter"
    When I am on the home page
    Then a project should exist with name: "Dude"
    And a project should exist with name: "Walter"
    And I should see "Dude"
    And I should see "Walter"
    And I remove the "Dude" build directory
    And I remove the "Walter" build directory
       
  Scenario: New project action
    Given I am on the home page
    When I follow "New Project"
    Then I should be on the new project page
    
  Scenario: Create a new project
    Given I am on the new project page
    When I fill in "Project" with "Dude"
    And I fill in "Repository Location" with "git://example.com:dude.git"
    And I fill in "Branch" with "master"
    And I fill in "Script" with "rake test"
    And I fill in "Number of builds to keep?" with "15"
    And I press "Save Changes"
    Then I should be on the project show page for "Dude"
    And I should see "Dude"
    And I remove the "Dude" build directory
