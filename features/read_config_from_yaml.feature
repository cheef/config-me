Feature: read configuration from yaml file

  Scenario: read configuration from yaml
    Given an yaml file with configuration below:
    """
    ---
    development:
      adapter: postgresql
      user: postgres
    """
    And an empty configuration
    When I read configuration from this yaml file
    Then setting "ConfigMe.development.adapter" should be equal to "postgresql"
    And setting "ConfigMe.development.user" should be equal to "postgres"