//
//  SearchedTracksViewModelTests.swift
//  TidalCodingChallengeTests
//
//  Created by Michael Aidoo on 2022-03-13.
//

import XCTest
import Combine
@testable import TidalCodingChallenge

class SearchedTracksViewModelTests: XCTestCase {
  
  private var sut: SearchedTracksViewModel!
  private var searchCloudStub: SearchCloudStub!
  private var searchCacheStub: SearchCacheStub!
  
  private var subscriptions: [AnyCancellable] = []
  
  @MainActor override func setUp() {
    super.setUp()
    searchCloudStub = SearchCloudStub()
    searchCacheStub = SearchCacheStub()
    sut = SearchedTracksViewModel(searchCloud: searchCloudStub, searchCache: searchCacheStub)
  }
  
  override func tearDown() {
    searchCloudStub = nil
    searchCacheStub = nil
    super.tearDown()
  }
  
  func testGetsTracksFromCloudWhenCacheEmpty() async {
    // Given
    let tracks = [Track.mock]
    searchCloudStub.tracks = tracks
    
    let expectation = XCTestExpectation(description: "tracks network data fetch")
    
    // When
    await sut.getTracks(using: "albumId", shouldCache: false)
    
    await sut.$tracks.sink { fetchedTracks in
      expectation.fulfill()
      
      // Then
      XCTAssertTrue(self.searchCacheStub.cachedTracks.isEmpty)
      XCTAssertTrue(!self.searchCloudStub.tracks.isEmpty)
      XCTAssertEqual(tracks, fetchedTracks)
    }.store(in: &subscriptions)
    
    wait(for: [expectation], timeout: .expectationsTimeout)
  }
  
  func testGetsTracksFromCacheWhenCacheNotEmpty() async {
    // Given
    let tracks = [Track.mock]
    searchCacheStub.cachedTracks = tracks
    
    let expectation = XCTestExpectation(description: "tracks network data fetch")
    
    // When
    await sut.getTracks(using: "albumId")
    
    await sut.$tracks.sink { fetchedTracks in
      expectation.fulfill()
      
      // Then
      XCTAssertTrue(self.searchCloudStub.tracks.isEmpty)
      XCTAssertTrue(!self.searchCacheStub.cachedTracks.isEmpty)
      XCTAssertEqual(tracks, fetchedTracks)
    }.store(in: &subscriptions)
    
    wait(for: [expectation], timeout: .expectationsTimeout)
  }
  
  func testGetsTracksFromCloudThenCaches() async {
    // Given
    let tracks = [Track.mock]
    searchCloudStub.tracks = tracks
    
    let expectation = XCTestExpectation(description: "track network data fetch")
    
    // When
    await sut.getTracks(using: "artistId", shouldCache: true)
    
    await sut.$tracks.sink { fetchedTracks in
      expectation.fulfill()
      
      // Then
      XCTAssertTrue(!self.searchCacheStub.cachedTracks.isEmpty)
      XCTAssertTrue(!self.searchCloudStub.tracks.isEmpty)
      XCTAssertEqual(tracks, fetchedTracks)
    }.store(in: &subscriptions)
    
    wait(for: [expectation], timeout: .expectationsTimeout)
  }
}
