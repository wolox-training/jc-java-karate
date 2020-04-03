@ignore
Feature: login to access the system

  Background:
    * url urlNodeJS
    * def loginSchema = read('classpath:nodejs/schemas/auth/login.json')

  Scenario: login success
    Given path 'users', 'sessions'
    And request credentials
    When method post
    Then status 200
    And match response == loginSchema

    * def token = responseHeaders['Authorization'][0]
