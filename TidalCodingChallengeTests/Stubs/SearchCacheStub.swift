//
//  SearchCacheStub.swift
//  TidalCodingChallengeTests
//
//  Created by Michael Aidoo on 2022-03-13.
//

import Foundation
@testable import TidalCodingChallenge

final class SearchCacheStub: SearchCacheStore {
  
  var cachedAlbums: [Album] = []
  var cachedTracks: [Track] = []

  func cacheAlbums(_ albums: [Album], key: String) {
    self.cachedAlbums = albums
  }
  
  func cacheTracks(_ tracks: [Track], key: String) {
    self.cachedTracks = tracks
  }
  
  func getAlbums(using id: String) -> [Album] {
    cachedAlbums
  }
  
  func getTracks(using id: String) -> [Track] {
    cachedTracks
  }
}
