//
//  DateExtensionTests.swift
//  TidalCodingChallengeTests
//
//  Created by Michael Aidoo on 2022-03-13.
//

import XCTest
@testable import TidalCodingChallenge

class DateExtensionTests: XCTestCase {
  
  func testCorrectlyGetsAlbumReleaseYear() {
    let releaseDate = "2009-07-20".toAlbumReleaseDate()
    XCTAssertEqual(releaseDate.getAlbumReleaseYear(), "2009")
  }
}
