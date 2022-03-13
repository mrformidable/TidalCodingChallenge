//
//  SearchedTracksViewModel.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-13.
//

import Foundation
import Combine

@MainActor
final class SearchedTracksViewModel: ObservableObject {
  
  @Published var tracks: [Track] = []
  
  private var subscriptions: [AnyCancellable] = []
  private let searchCloud: SearchCloudStore
  private let searchCache: SearchCacheStore

  init(searchCloud: SearchCloudStore = SearchCloudService(), searchCache: SearchCacheStore = SearchCacheService.shared) {
    self.searchCloud = searchCloud
    self.searchCache = searchCache
  }
  
  func getTracks(using albumId: String, shouldCache: Bool = true) async {
    let cachedTracks = searchCache.getTracks(using: albumId)
    if !cachedTracks.isEmpty {
      tracks = cachedTracks
    } else {
      do {
        try await getCloudTracks(using: albumId, shouldCache: shouldCache)
      } catch let error {
        print(error)
      }
    }
  }
  
  private func getCloudTracks(using albumId: String, shouldCache: Bool) async throws {
    let result = try await searchCloud.getTracks(using: albumId)
    switch result {
    case .success(let result):
      tracks = result.tracks
      if shouldCache {
        cachedTracks(tracks, key: albumId)
      }
    case .failure(let error):
      print(error)
    }
  }
  
  private func cachedTracks(_ tracks: [Track], key: String)  {
    searchCache.cacheTracks(tracks, key: key)
  }
}
