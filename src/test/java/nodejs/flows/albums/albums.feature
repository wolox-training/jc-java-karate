Feature: get album data

  Background:
    * url urlNodeJS

    * def auth = callonce read('classpath:nodejs/flows/auth/loginRole.feature@regular')
    * def token = auth.token

    * def albumSchema = read('classpath:nodejs/schemas/albums/album.json')
    * def albumPhotoSchema = read('classpath:nodejs/schemas/albums/albumPhoto.json')

  Scenario: get album and photo data as regular user
    Given path 'albums'
    And header Authorization = token
    When method get
    Then status 200
    And match response == '#[] albumSchema'

    * def randomAlbumId = response[Math.floor(Math.random() * response.length)].id
    * set albumPhotoSchema.album_id = randomAlbumId

    Given path 'albums', randomAlbumId, 'photos'
    And header Authorization = token
    When method get
    Then status 200
    And match response == '#[] albumPhotoSchema'
