//
//  SearchCacheServiceTests.swift
//  TidalCodingChallengeTests
//
//  Created by Michael Aidoo on 2022-03-12.
//

import XCTest
@testable import TidalCodingChallenge

class SearchCacheServiceTests: XCTestCase {
  
  let sut = SearchCacheService.shared
  
  func testCorrectlyGetsAlbumsWhenCached() {
    // Given
    let albumCacheKey = "album-cache-key"
    let albums = [Album(id: 98123, title: "Album 1", imageURL: nil, thumbnailURL: nil, usesExplicitLyrics: true, releaseDate: Date())]
    
    // When
    sut.cacheAlbums(albums, key: albumCacheKey)
    let cachedAlbums = sut.getAlbums(using: albumCacheKey)
    
    // Then
    XCTAssertTrue(!cachedAlbums.isEmpty)
    XCTAssertEqual(cachedAlbums.first?.id, 98123)
    XCTAssertEqual(cachedAlbums.first?.title, "Album 1")
  }
  
  func testCorrectlyGetsTracksWhenCached() {
    // Given
    let trackCachingKey = "track-cache-key"
    let tracks = [Track(id: 88123, title: "Track 1", duration: 300, position: 4, usesExplicitLyrics: true)]
    
    // When
    sut.cacheTracks(tracks, key: trackCachingKey)
    let cachedTracks = sut.getTracks(using: trackCachingKey)
    
    // Then
    XCTAssertTrue(!cachedTracks.isEmpty)
    
    let track = cachedTracks[0]
    XCTAssertEqual(track.id, 88123)
    XCTAssertEqual(track.title, "Track 1")
    XCTAssertEqual(track.duration, 300)
    XCTAssertEqual(track.position, 4)
  }
  
  func testReturnsEmptyAlbumsWhenNotCached() {
    let cachedAlbums = sut.getAlbums(using: "")
    XCTAssertTrue(cachedAlbums.isEmpty)
  }
  
  func testReturnsEmptyTrackssWhenNotCached() {
    let cachedAlbums = sut.getTracks(using: "")
    XCTAssertTrue(cachedAlbums.isEmpty)
  }
  
}
