Feature: login to access the system

  Background:
    * url 'https://nodejs-qa-training.herokuapp.com'

    * def loginSchema = read('classpath:nodejs/schemas/auth/login.json')

    * def register = callonce read('classpath:nodejs/flows/auth/register.feature')
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
    And match response == loginSchema

    * def token = responseHeaders['Authorization'][0]