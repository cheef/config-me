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
    ConfigMe(:path_to_yaml => @yaml_filepath)
    """
    Then setting "ConfigMe.development.adapter" should be equal to "postgresql"
    And setting "ConfigMe.development.user" should be equal to "postgres"

  Scenario: import configuration from yaml string
    When I read configuration from this yaml string:
    """
    ConfigMe(:yaml => @yaml_string)
    """
    Then setting "ConfigMe.development.adapter" should be equal to "postgresql"
    And setting "ConfigMe.development.user" should be equal to "postgres"