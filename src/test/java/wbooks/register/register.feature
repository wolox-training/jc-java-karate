Feature: enter the required fields to create a new user

  Background:
    * url 'https://wbooks-api-stage.herokuapp.com/api/v1'

    * def now = function(){ return java.lang.System.currentTimeMillis() }
    * def email = 'email' + now() + '@wolox.test.com'
    * def newUser =
      """
      {
        "user": {
          "first_name": "testing",
          "last_name": "register",
          "email": '#(email)',
          "password": "12345678",
          "locale": "en"
         }
      }
      """

  Scenario: register a new user

    Given path 'users'
    And request newUser
    When method post
    Then status 201
    And match response == { access_token: '#string', renew_id: '#string' }

    * def access_token = response.access_token
    * def renew_id = response.renew_id

  Scenario: register fails, user already exists

    Given path 'users'
    And request newUser
    When method post
    Then status 201

    Given path 'users'
    And request newUser
    When method post
    Then status 422
    And match response.error contains 'Email has already been taken'

  Scenario: register fails, password is too short

    * set newUser.user.password = '12345'

    Given path 'users'
    And request newUser
    When method post
    Then status 422
    And match response.error contains 'Password is too short (minimum is 6 characters)'

  Scenario: register fails, email format is invalid

    * set newUser.user.email = 'emailTest'

    Given path 'users'
    And request newUser
    When method post
    Then status 422
    And match response.error contains 'Email is invalid'

  Scenario Outline: register fails, schema is invalid

    * remove newUser.user.<requiredUserField>

    Given path 'users'
    And request newUser
    When method post
    Then status 422

    Examples:
      | requiredUserField |
      | first_name        |
      | last_name         |
      | email             |
      | password          |
      | locale            |

  # TODO scenario for user.locale data validation