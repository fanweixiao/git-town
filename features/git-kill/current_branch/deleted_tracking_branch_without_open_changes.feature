Feature: git kill: killing the current feature branch with a deleted tracking branch (without open changes)

  Background:
    Given I have feature branches named "good-feature" and "dead-feature"
    And the following commits exist in my repository
      | BRANCH       | LOCATION         | MESSAGE         | FILE NAME        |
      | good-feature | local and remote | good commit     | good_file        |
      | dead-feature | local and remote | dead-end commit | unfortunate_file |
    And the "dead-feature" branch gets deleted on the remote
    And I am on the "dead-feature" branch
    When I run `git kill`


  Scenario: result
    Then I end up on the "main" branch
    And the existing branches are
      | REPOSITORY | BRANCHES           |
      | local      | main, good-feature |
      | remote     | main, good-feature |
    And I have the following commits
      | branch       | location         | message     | files     |
      | good-feature | local and remote | good commit | good_file |


  Scenario: undoing the kill
    When I run `git kill --undo`
    Then I end up on the "dead-feature" branch
    And the existing branches are
      | REPOSITORY | BRANCHES                         |
      | local      | main, dead-feature, good-feature |
      | remote     | main, good-feature               |
    And I have the following commits
      | BRANCH       | LOCATION         | MESSAGE         | FILES            |
      | good-feature | local and remote | good commit     | good_file        |
      | dead-feature | local            | dead-end commit | unfortunate_file |