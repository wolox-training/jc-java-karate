Feature: enter the credentials to get a valid user token

  Background:
    * url 'https://wbooks-api-stage.herokuapp.com/api/v1'

  @login
  Scenario: login with valid credentials and get 200 with user token
    Given path 'users/sessions'
    And request
    """
    {
      "session": {
          "email": "wolox@test.com.ar",
          "password": "12345678"
      }
    }
    """
    When method post
    Then status 200
    And match response == { access_token: '#string', renew_id: '#string' }

    * def access_token = response.access_token
    * def renew_id = response.renew_id

  Scenario: login with invalid credentials and get 401
    Given path 'users/sessions'
    And request
      """
      {
        "session": {
            "email": "wolox@test.com.ar",
            "password": "wrong-password"
        }
      }
      """
    When method post
    Then status 401