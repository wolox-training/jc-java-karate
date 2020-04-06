Feature: buying albums

  Background:
    * url urlNodeJS

    * def errorSchema = read('classpath:nodejs/schemas/error.json')

    * def auth = callonce read('classpath:nodejs/flows/auth/loginRole.feature@regular')
    * def token = auth.token
    * def userId = auth.userId

    * def albums = call read('classpath:nodejs/flows/albums/albums.feature@all')
    * def albumId = albums.randomAlbumId

  Scenario: buy a random new album
    * call read('classpath:nodejs/flows/albums/albums.feature@buy')
    * call read('classpath:nodejs/flows/users/userAlbums.feature')
    * match userAlbums contains albumId

  Scenario: fail to buy a repeated album
    * call read('classpath:nodejs/flows/albums/albums.feature@buy')

    Given path 'albums', albumId
    And header Authorization = token
    And request ''
    When method post
    And status 422
    And match response == errorSchema
