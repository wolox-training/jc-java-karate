Feature: get data from specific user

  Background:
    * url 'https://wbooks-api-stage.herokuapp.com/api/v1'

    * def login = callonce read('classpath:wbooks/login/login.feature@login')
    * def authToken = login.access_token
    * def fakeToken = 'eyFaKeToKen123'

    * def userDataSchema = read('classpath:wbooks/userdata/userdata-schema.json')
    * def userId = 1

  Scenario: get user data
    Given path 'users', userId
    And header Authorization = authToken
    When method get
    Then status 200
    And match response == userDataSchema

  Scenario: user data not authorized
    Given path 'users', userId
    And header Authorization = fakeToken
    When method get
    Then status 401

  Scenario: user data not found
    Given path 'users', 0
    And header Authorization = authToken
    When method get
    Then status 404
