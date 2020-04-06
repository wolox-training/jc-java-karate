@ignore
Feature: working with albums

  Background:
    * url urlNodeJS

    * def schema = read('classpath:nodejs/schemas/albums/album.json')
    * def photosSchema = read('classpath:nodejs/schemas/albums/albumPhoto.json')

    @all
  Scenario: get all albums
    Given path 'albums'
    And header Authorization = token
    When method get
    Then status 200
    And match response == '#[] schema'
    * def randomAlbumId = response[Math.floor(Math.random() * response.length)].id

    @photos
  Scenario: get all photos of an album
    * set photosSchema.id = albumId
    Given path 'albums', albumId, 'photos'
    And header Authorization = token
    When method get
    Then status 200
    And match response == '#[] photosSchema'

    @buy
  Scenario: buy an album
    Given path 'albums', albumId
    And header Authorization = token
    And request ''
    When method post
    Then status 201
