Feature: login to access the system

  Background:
    * url 'https://nodejs-qa-training.herokuapp.com'

    * def register = callonce read('classpath:nodejs/flows/register.feature')
    * def credentials =
    """
    {
      "email": "#(register.newUser.email)",
      "password": "#(register.newUser.password)"
    }
    """

  Scenario: login success
    Given path 'users', 'sessions'
    And request credentials
    When method post
    Then status 200

    * def token = responseHeaders['Authorization'][0]