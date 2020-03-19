Feature: get data from specific user

  Background:
    * url 'https://wbooks-api-stage.herokuapp.com/api/v1'

    * def login = callonce read('classpath:wbooks/login/login.feature@login')
    * def authToken = login.access_token

    * def userDataSchema =
    """
    {
      id: '#number',
      email: '#string',
      last_name: '#string',
      first_name: '#string',
      rents_counter: '#number',
      comments_counter: '#number',
      image_url: '##string'
    }
    """

  Scenario: get user data
    * def userId = 2
    Given path 'users/' + userId
    And header Authorization = authToken
    When method get
    Then status 200
    And match response == userDataSchema
    And match response.id == userId

  Scenario: user data not authorized
    * def fakeToken = 'eyFaKeToKen123'
    Given path 'users/1'
    And header Authorization = fakeToken
    When method get
    Then status 401

  Scenario: user data not found
    Given path 'users/0'
    And header Authorization = authToken
    When method get
    Then status 404
