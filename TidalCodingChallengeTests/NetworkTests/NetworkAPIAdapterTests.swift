//
//  NetworkAPIAdapterTests.swift
//  TidalCodingChallengeTests
//
//  Created by Michael Aidoo on 2022-03-12.
//

import XCTest
@testable import TidalCodingChallenge

class NetworkAPIAdapterTests: XCTestCase {
  
  var sut: NetworkAPIAdapter!
  
  func testBaseURLString() {
    sut = NetworkAPIAdapter.tracks("")
    XCTAssertEqual(sut.baseURL, "http://api.deezer.com")
  }
  
  func testAlbumsPath() {
    let artistId = "artistId123"
    sut = NetworkAPIAdapter.albums(artistId)
    
    XCTAssertEqual(sut.path, "/artist/\(artistId)/albums")
    XCTAssertNotNil(sut.urlComponents)
    XCTAssertNotNil(sut.urlComponents?.url)
  }
  
  func testTracksPath() {
    let albumId = "artistId123"
    sut = .tracks(albumId)
    
    XCTAssertEqual(sut.path, "/album/\(albumId)/tracks")
    XCTAssertNotNil(sut.urlComponents)
    XCTAssertNotNil(sut.urlComponents?.url)
  }
  
  func testArtistsPath() {
    sut = .artistSearch("")
    
    XCTAssertEqual(sut.path, "/search/artist")
    XCTAssertNotNil(sut.urlComponents)
    XCTAssertNotNil(sut.urlComponents?.url)
  }
  
  func testURLRequest() {
    sut = .artistSearch("test")
    XCTAssertNotNil(sut.request)
    XCTAssertNotNil(sut.request?.url)
  }
  
  func testArtistSearch() throws {
    let query = "artist"
    sut = .artistSearch(query)
    
    let queryItems = try XCTUnwrap(sut.urlComponents?.queryItems)
    
    XCTAssertEqual(queryItems.count, 1)
    XCTAssertEqual(queryItems[0].value, "artist")
    XCTAssertEqual(queryItems[0].name, "q")
    XCTAssertNotNil(sut.urlComponents)
    XCTAssertNotNil(sut.urlComponents?.url)
  }
  
}
