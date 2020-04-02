Feature: get all users data

  Background:
    * url urlNodeJS
    * def usersPageSchema = read('classpath:nodejs/schemas/users/usersPage.json')
    * def userSchema = read('classpath:nodejs/schemas/users/users.json')

  Scenario Outline: get user data as regular user
    * def auth = call read('classpath:nodejs/flows/auth/loginRole.feature@<role>')
    * def token = auth.token

    Given path 'users'
    And header Authorization = token
    When method get
    Then status 200
    And match response == usersPageSchema
    And match each response.page == userSchema

    Examples:
      | role    |
      | regular |
      | admin   |



