Feature: import configuration from yaml
  Background:
    Given an yaml file with configuration below:
    """
    ---
    development:
      adapter: postgresql
      user: postgres
    """
    And an empty configuration

  Scenario: import configuration from yaml file
    When I read configuration from this yaml file:
    """
    ConfigMe(:yaml => @yaml)
    """
    Then setting "ConfigMe.development.adapter" should be equal to "postgresql"
    And setting "ConfigMe.development.user" should be equal to "postgres"