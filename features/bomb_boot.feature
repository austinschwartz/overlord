Feature: Activation and Deactivation
  In order to activate and deactivate the bomb
  As an evil genius
  I want to be able to get and set codes

  Scenario: Boot up
    Given I visit the bomb page
    And I set the codes to 7676 and 3632
    And I boot the bomb
    Then the bomb should be not active

  Scenario: Activate the bomb with the correct code
    Given I visit the bomb page
    When I set the activation code to 7676
    And I activate the bomb
    Then the bomb should be active

  Scenario: Deactivate the bomb with the incorrect code
    Given I visit the bomb page
    When I set the deactivation code to 3632
    And I deactivate the bomb
    Then the bomb should be not active

  Scenario: Bomb detonation
    Given I visit the bomb page
    When I set the activation code to 7676
    And I activate the bomb
    And I deactivate the bomb
    And I deactivate the bomb
    And I deactivate the bomb
    Then the bomb should be exploded
