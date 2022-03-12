//
//  SearchCloudServiceTests.swift
//  TidalCodingChallengeTests
//
//  Created by Michael Aidoo on 2022-03-12.
//

import XCTest
@testable import TidalCodingChallenge

class SearchCloudServiceTests: XCTestCase {
  
  var sut: SearchCloudService!
  fileprivate var sessionMock: URLSessionMock!
  
  override func setUp() {
    super.setUp()
    sessionMock = URLSessionMock()
    sut = SearchCloudService(session: sessionMock)
  }
  
  func testCorrectlyGetsDataWhenSearchingArtist() async throws {
    // Given
    let artist = Artist(id: 09123, name: "Test Artist", imageURL: URL(string: "www.testurl"), thumbnailURL: URL(string: "www.testurl"))
    let searchArtistResult = SearchedArtistResult(artists: [artist], total: 1, next: "")
    let searchArtistResultData = try XCTUnwrap(JSONEncoder().encode(searchArtistResult))
    
    sessionMock.data = searchArtistResultData
    
    // When
    let result = try await sut.searchArtist(matching: artist.name)
    
    // Then
    switch result {
    case .success(let retreivedResult):
      XCTAssertEqual(retreivedResult, searchArtistResult)
      XCTAssertEqual(retreivedResult.artists.count, 1)
      
      let retreivedArtist = retreivedResult.artists[0]
      XCTAssertEqual(retreivedArtist.id, artist.id)
      XCTAssertEqual(retreivedArtist.name, artist.name)
      XCTAssertEqual(retreivedArtist.imageURL, artist.imageURL)
      XCTAssertEqual(retreivedArtist.thumbnailURL, artist.thumbnailURL)
      
    case .failure(let error):
      XCTAssertNil(error)
    }
  }
  
  func testCorrectlyGetsDataWhenGettingAlbums() async throws {
    // Given
    let album = Album(id: 12312, title: "Test Album", imageURL: URL(string: "www.testurl"), thumbnailURL: URL(string: "www.testurl"), usesExplicitLyrics: false, releaseDate: Date())
    let searchedAlbumResult = SearchedAlbumResult(albums: [album], total: 1, next: "")
    let searchedAlbumResultData = try XCTUnwrap(JSONEncoder().encode(searchedAlbumResult))

    sessionMock.data = searchedAlbumResultData
    
    // When
    let result = try await sut.getAlbums(using: String(album.id))
    
    // Then
    switch result {
    case .success(let retreivedResult):
      XCTAssertEqual(retreivedResult, searchedAlbumResult)
      XCTAssertEqual(retreivedResult.albums.count, 1)
      
      let retreivedAlbum = retreivedResult.albums[0]
      XCTAssertEqual(retreivedAlbum.id, album.id)
      XCTAssertEqual(retreivedAlbum.title, album.title)
      XCTAssertEqual(retreivedAlbum.imageURL, album.imageURL)
      XCTAssertEqual(retreivedAlbum.thumbnailURL, album.thumbnailURL)
      
    case .failure(let error):
      XCTAssertNil(error)
    }
  }
  
  func testCorrectlyGetsDataWhenGettingTracks() async throws {
    // Given
    let track = Track(id: 00123, title: "Test Album", duration: 120, position: 1, usesExplicitLyrics: false)
    let searchedTrackResult = SearchedTrackResult(tracks: [track], total: 1)
    let searchedTrackResultData = try XCTUnwrap(JSONEncoder().encode(searchedTrackResult))

    sessionMock.data = searchedTrackResultData
    
    // When
    let result = try await sut.getTracks(using: String(track.id))
    
    // Then
    switch result {
    case .success(let retreivedResult):
      XCTAssertEqual(retreivedResult, searchedTrackResult)
      XCTAssertEqual(retreivedResult.tracks.count, 1)
      
      let retreivedTrack = retreivedResult.tracks[0]
      XCTAssertEqual(retreivedTrack.id, track.id)
      XCTAssertEqual(retreivedTrack.title, track.title)
    case .failure(let error):
      XCTAssertNil(error)
    }
  }
  
  func testErrorWhenDataIsInvalid() async throws {
    // Given
    sessionMock.error = NetworkError.invalidData
    
    do {
      // When
      _ = try await sut.getAlbums(using: "1231")
    } catch let error {
      // Then
      XCTAssertNotNil(error)
    }
  }
}

private extension SearchCloudServiceTests {
  class URLSessionMock: URLSessionProtocol {
    var data: Data?
    var error: Error?
    var response: URLResponse?
    
    func getData(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
      completionHandler(data, response, error)
    }
  }
}
