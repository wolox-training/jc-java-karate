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