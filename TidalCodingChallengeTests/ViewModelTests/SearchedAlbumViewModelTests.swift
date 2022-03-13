//
//  SearchedAlbumViewModelTests.swift
//  TidalCodingChallengeTests
//
//  Created by Michael Aidoo on 2022-03-13.
//

import XCTest
import Combine
@testable import TidalCodingChallenge

class SearchedAlbumViewModelTests: XCTestCase {
  
  private var sut: SearchedAlbumViewModel!
  private var searchCloudStub: SearchCloudStub!
  private var searchCacheStub: SearchCacheStub!
  
  private var subscriptions: [AnyCancellable] = []
  
  @MainActor override func setUp() {
    super.setUp()
    searchCloudStub = SearchCloudStub()
    searchCacheStub = SearchCacheStub()
    sut = SearchedAlbumViewModel(searchCloud: searchCloudStub, searchCache: searchCacheStub)
  }
  
  override func tearDown() {
    searchCloudStub = nil
    searchCacheStub = nil
    super.tearDown()
  }
  
  func testGetsAlbumFromCloudWhenCacheEmpty() async {
    // Given
    let albums = [Album.mock]
    searchCloudStub.albums = albums
    
    let expectation = XCTestExpectation(description: "album network data fetch")
    
    // When
    await sut.getAlbums(using: "artistId", shouldCache: false)
    
    await sut.$albums.sink { fetchedAlbums in
      expectation.fulfill()
      
      // Then
      XCTAssertTrue(self.searchCacheStub.cachedAlbums.isEmpty)
      XCTAssertTrue(!self.searchCloudStub.albums.isEmpty)
      XCTAssertEqual(albums, fetchedAlbums)
    }.store(in: &subscriptions)
    
    wait(for: [expectation], timeout: .expectationsTimeout)
  }
  
  func testGetsAlbumFromCacheWhenCacheNotEmpty() async {
    // Given
    let albums = [Album.mock]
    searchCacheStub.cachedAlbums = albums
    
    let expectation = XCTestExpectation(description: "album network data fetch")
    
    // When
    await sut.getAlbums(using: "artistId")
    
    await sut.$albums.sink { fetchedAlbums in
      expectation.fulfill()
      
      // Then
      XCTAssertTrue(self.searchCloudStub.albums.isEmpty)
      XCTAssertTrue(!self.searchCacheStub.cachedAlbums.isEmpty)
      XCTAssertEqual(albums, fetchedAlbums)
    }.store(in: &subscriptions)
    
    wait(for: [expectation], timeout: .expectationsTimeout)
  }
  
  func testGetsAlbumFromCloudThenCaches() async {
    // Given
    let albums = [Album.mock]
    searchCloudStub.albums = albums
    
    let expectation = XCTestExpectation(description: "album network data fetch")
    
    // When
    await sut.getAlbums(using: "artistId", shouldCache: true)
    
    await sut.$albums.sink { fetchedAlbums in
      expectation.fulfill()
      
      // Then
      XCTAssertTrue(!self.searchCacheStub.cachedAlbums.isEmpty)
      XCTAssertTrue(!self.searchCloudStub.albums.isEmpty)
      XCTAssertEqual(albums, fetchedAlbums)
    }.store(in: &subscriptions)
    
    wait(for: [expectation], timeout: .expectationsTimeout)
  }
}
