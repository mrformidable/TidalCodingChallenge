//
//  SearchedTrackTests.swift
//  TidalCodingChallengeTests
//
//  Created by Michael Aidoo on 2022-03-12.
//

import XCTest
@testable import TidalCodingChallenge

class SearchedTrackTests: XCTestCase {

  func testSearchedTrackModelDecoding() throws {
    let data = try XCTUnwrap(getTestData(filename: "testTrackSearch"))
    let searchResult = try XCTUnwrap(JSONDecoder().decode(SearchedTrackResult.self, from: data))
    
    let searchedTrack = searchResult.tracks[0]
    
    XCTAssertEqual(searchedTrack.title, "Champagne Poetry")
    XCTAssertEqual(searchedTrack.id, 1484144802)
    XCTAssertEqual(searchResult.total, 21)
    XCTAssertEqual(searchResult.tracks.count, 3)
  }
}
