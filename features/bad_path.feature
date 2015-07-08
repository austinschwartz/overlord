Feature: Faulty Bomb Code Detection (Bad Path)
  In order to test faulty inputs
  As an evil genius
  I don't want people entering faulty bomb codes 

  Scenario: Boot up with longer than 4 digit codes
    Given I visit the bomb page
    And I set the activation code to 919281
    Then the bomb should be not booted

  Scenario: Boot up with shorter than 4 digit codes
    Given I visit the bomb page
    And I set the deactivation code to 119281
    Then the bomb should be not booted

  Scenario: Boot up with non-numeric codes
    Given I visit the bomb page
    And I set the codes to abdc and edwe
    Then the bomb should be not booted
