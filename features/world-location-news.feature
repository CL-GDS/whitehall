@design-system-only
Feature: Administering world location news information
  Background:
    Given I am a GDS admin
    And a world location news exists

  Scenario: Viewing the list presents no world location news message, when no news exists
    Given no world locations exist
    When I visit the world location news index page
    Then I should see the "No active world location news" message
    When I click the Inactive tab
    Then I should see the "No inactive world location news" message

  Scenario: Reordering currently featured documents
    Given the world location has a feature list with 2 featured documents
    When I visit the world location news page
    And I set the order of the featured documents to:
      | title      | order |
      | Document 2 | 0     |
      | Document 1 | 1     |
    Then the featured documents should be in the following order:
      | title      |
      | Document 2 |
      | Document 1 |
