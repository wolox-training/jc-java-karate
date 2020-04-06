Feature: get album photos

  Background:
    * def auth = callonce read('classpath:nodejs/flows/auth/loginRole.feature@regular')
    * def token = auth.token

  Scenario: get a random album photos
    * def albums = call read('classpath:nodejs/flows/albums/albums.feature@all')
    * call read('classpath:nodejs/flows/albums/albums.feature@photos') { albumId: #(albums.randomAlbumId) }
