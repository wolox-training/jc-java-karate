Feature: get data from specific user

  Background:
    * url 'https://wbooks-api-stage.herokuapp.com/api/v1'

    * def login = call read('classpath:wbooks/login/login.feature@login')
    * def authToken = login.access_token

    * def userDataSchema =
    """
    {
      id: '#present',
      email: '#present',
      last_name: '#present',
      first_name: '#present',
      rents_counter: '#present',
      comments_counter: '#present',
      unread_notifications: '##present',
      image_url: '##present',
    }
    """

  Scenario: get user data
    Given path 'users/1'
    And header Authorization = authToken
    When method get
    Then status 200
    And match response == userDataSchema

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
    Then status 400
