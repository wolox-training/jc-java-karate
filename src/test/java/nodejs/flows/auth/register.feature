Feature: create a new user in the system

  Background:
    * url 'https://nodejs-qa-training.herokuapp.com'

  Scenario: register success
    * def now = function(){ return java.lang.System.currentTimeMillis() }
    * def email = 'email' + now() + '@wolox.com.ar'
    * def newUser =
      """
      {
        "email": "#(email)",
        "password": "a12345678",
        "firstName": "name",
        "lastName": "surname"
      }
      """

    Given path 'users'
    And request newUser
    When method post
    Then status 201

    * def userId = response.user_id