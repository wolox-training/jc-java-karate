Feature: get all users data

  Background:
    * url urlNodeJS
    * def usersPageSchema = read('classpath:nodejs/schemas/users/usersPage.json')
    * def userSchema = read('classpath:nodejs/schemas/users/users.json')
    * set usersPageSchema.page = usersPageSchema.page + ' userSchema'

  Scenario Outline: get user data as regular user
    * def auth = call read('classpath:nodejs/flows/auth/loginRole.feature@<role>')
    * def token = auth.token

    Given path 'users'
    And header Authorization = token
    When method get
    Then status 200
    And match response == usersPageSchema

    Examples:
      | role    |
      | regular |
      | admin   |
