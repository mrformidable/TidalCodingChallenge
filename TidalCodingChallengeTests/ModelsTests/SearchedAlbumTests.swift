//
//  SearchedAlbumTests.swift
//  TidalCodingChallengeTests
//
//  Created by Michael Aidoo on 2022-03-12.
//

import XCTest
@testable import TidalCodingChallenge

class SearchedAlbumTests: XCTestCase {

  func testSearchedAlbumModelDecoding() throws {
    let data = try XCTUnwrap(getTestData(filename: "testAlbumSearch"))
    let searchResult = try XCTUnwrap(JSONDecoder().decode(SearchedAlbumResult.self, from: data))
    
    let searchedAlbum = searchResult.albums[0]
    
    XCTAssertEqual(searchedAlbum.title, "Certified Lover Boy")
    XCTAssertEqual(searchedAlbum.id, 256312232)
    XCTAssertEqual(searchedAlbum.imageURL?.absoluteString, "https://e-cdns-images.dzcdn.net/images/cover/ea8f80f2edb20885ac8aed8751716794/500x500-000000-80-0-0.jpg")
    XCTAssertEqual(searchedAlbum.thumbnailURL?.absoluteString, "https://e-cdns-images.dzcdn.net/images/cover/ea8f80f2edb20885ac8aed8751716794/56x56-000000-80-0-0.jpg")
    
    XCTAssertEqual(searchResult.total, 44)
    XCTAssertEqual(searchResult.albums.count, 5)
  }
}
