//
//  SearchCloudStub.swift
//  TidalCodingChallengeTests
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation
@testable import TidalCodingChallenge

final class SearchCloudStub: SearchCloudStore {
  
  var albums: [Album] = []
  var artists: [Artist] = []
  var tracks: [Track] = []

  func getAlbums(using albumId: String) async throws -> Result<SearchedAlbumResult, Error> {
    .success(SearchedAlbumResult(albums: albums, total: 10, next: ""))
  }
  
  func getTracks(using artistId: String) async throws -> Result<SearchedTrackResult, Error> {
    .success(SearchedTrackResult(tracks: tracks, total: 10))
  }
  
  func searchArtist(matching query: String) async throws -> Result<SearchedArtistResult, Error> {
    .success(SearchedArtistResult(artists: artists, total: 10, next: ""))
  }
  
}
