//
//  SearchArtistViewModel.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation
import Combine

@MainActor
final class SearchArtistViewModel: ObservableObject {
  
  enum SearchViewState {
    case emptyQuery
    case emptySearchedResults(String)
    case searchFailure
    case fetchedResults(artists: [Artist])
  }
  
  @Published var searchQuery = ""  
  @Published var state: SearchViewState = .emptyQuery
  
  private let minimumQueryAmount = 3
  private let queryMillisecondDelay = 500
  private var subscriptions: [AnyCancellable] = []
  private let searchCloud: SearchCloudStore
  
  init(searchCloud: SearchCloudStore = SearchCloudService()) {
    self.searchCloud = searchCloud
    
    observeSearchQuery()
  }
  
  private func observeSearchQuery() {
    $searchQuery
      .debounce(for: .milliseconds(queryMillisecondDelay), scheduler: DispatchQueue.main)
      .asyncMap { [weak self] query in
        guard let self = self else {
          return
        }
        guard !query.isEmpty else {
          self.state = .emptyQuery
          return
        }
        guard query.count >= self.minimumQueryAmount else {
          return
        }
        try? await self.searchArtist(matching: query)
      }
      .sink {}
      .store(in: &subscriptions)
  }
  
  private func searchArtist(matching query: String) async throws {
    let searchResult = try await searchCloud.searchArtist(matching: query)
    switch searchResult {
    case .success(let result):
      let artists = result.artists
      state = artists.isEmpty ? .emptySearchedResults(query) : .fetchedResults(artists: artists)
    case .failure:
      self.state = .searchFailure
    }
  }
}
