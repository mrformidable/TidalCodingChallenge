//
//  SearchedAlbumViewModel.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation
import Combine

@MainActor
final class SearchedAlbumViewModel: ObservableObject {
  enum SearchViewState {
    case loading
    case emptyFetchResults
    case fetchedResults(albums: [Album])
  }
  
  @Published var state: SearchViewState = .loading

  private var subscriptions: [AnyCancellable] = []
  private let searchCloud: SearchCloudStore
  private let searchCache: SearchCacheStore
  
  init(searchCloud: SearchCloudStore = SearchCloudService(), searchCache: SearchCacheStore = SearchCacheService.shared) {
    self.searchCloud = searchCloud
    self.searchCache = searchCache
  }
  
  func getAlbums(using artistId: String, shouldCache: Bool = true) async {
    let cachedAlbums = searchCache.getAlbums(using: artistId)
    if !cachedAlbums.isEmpty {
      state = .fetchedResults(albums: cachedAlbums)
    } else {
      do {
        try await getCloudAlbums(using: artistId, shouldCache: shouldCache)
      } catch let error {
        print("Debug error getAlbums \(#function)", error)
      }
    }
  }
  
  private func getCloudAlbums(using artistId: String, shouldCache: Bool) async throws {
    let result = try await searchCloud.getAlbums(using: artistId)
    switch result {
    case .success(let result):
      let albums = result.albums
      state = albums.isEmpty ? .emptyFetchResults : .fetchedResults(albums: albums)
      if shouldCache && !albums.isEmpty {
        cachedAlbums(albums, key: artistId)
      }
    case .failure(let error):
      print("Debug error getCloudAlbums \(#function)", error)
    }
  }
  
  private func cachedAlbums(_ albums: [Album], key: String)  {
    searchCache.cacheAlbums(albums, key: key)
  }
}
