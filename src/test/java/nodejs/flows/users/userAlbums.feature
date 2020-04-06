Feature: get albums by user

  Background:
    * url urlNodeJS
    * def schema = read('classpath:nodejs/schemas/users/userAlbums.json')

  Scenario: all user albums
    Given path 'users', userId, 'albums'
    And header Authorization = token
    When method get
    Then status 200
    And match response == '#[] schema'
    * def userAlbums = $response[*].album.id