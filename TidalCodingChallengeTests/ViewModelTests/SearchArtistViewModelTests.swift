//
//  SearchArtistViewModelTests.swift
//  TidalCodingChallengeTests
//
//  Created by Michael Aidoo on 2022-03-12.
//

import XCTest
import Combine
@testable import TidalCodingChallenge

@MainActor class SearchArtistViewModelTests: XCTestCase {
  
  private var sut: SearchArtistViewModel!
  private var searchCloudStub: SearchCloudStub!
  
  private var subscriptions: [AnyCancellable] = []
  
  @MainActor override func setUp() {
    super.setUp()
    searchCloudStub = SearchCloudStub()
    sut = SearchArtistViewModel(searchCloud: searchCloudStub)
  }
  
  func testArtistSearch() async {
    //Given
    sut.searchQuery = "artist"
    searchCloudStub.artists = [Artist.mock]
    let searchExpectation = XCTestExpectation(description: "observe query searching")
    
    // When
    sut.$searchQuery
      .asyncMap { _ in }.sink {}
    .store(in: &subscriptions)
    
    // Then
    sut.$state.sink { state in
      searchExpectation.fulfill()
      
      switch state {
      case .fetchedResults(artists: let artists):
        XCTAssertTrue(!artists.isEmpty)
        XCTAssertEqual(artists, [Artist.mock])
      default:
        break
      }
    }.store(in: &subscriptions)
    
    wait(for: [searchExpectation], timeout: 2.5)
  }
}
