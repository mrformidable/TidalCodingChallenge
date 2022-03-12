//
//  SearchedArtistTests.swift
//  TidalCodingChallengeTests
//
//  Created by Michael Aidoo on 2022-03-12.
//

import XCTest
@testable import TidalCodingChallenge

class SearchedArtistTests: XCTestCase {

  func testSearchedArtistModelDecoding() throws {
    let data = try XCTUnwrap(getTestData(filename: "testArtistSearch"))
    let searchResult = try XCTUnwrap(JSONDecoder().decode(SearchedArtistResult.self, from: data))
    
    let searchedArtist = searchResult.artists[0]
    
    XCTAssertEqual(searchedArtist.name, "Drake")
    XCTAssertEqual(searchedArtist.id, 246791)
    XCTAssertEqual(searchedArtist.imageURL?.absoluteString, "http://e-cdn-images.dzcdn.net/images/artist/5d2fa7f140a6bdc2c864c3465a61fc71/500x500-000000-80-0-0.jpg")
    XCTAssertEqual(searchedArtist.thumbnailURL?.absoluteString, "http://e-cdn-images.dzcdn.net/images/artist/5d2fa7f140a6bdc2c864c3465a61fc71/56x56-000000-80-0-0.jpg")
    
    XCTAssertEqual(searchResult.total, 300)
    XCTAssertEqual(searchResult.artists.count, 5)
  }
}
